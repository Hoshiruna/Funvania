; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/better_stair.asm for Funvania's Asar layout.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

cv3_stair_game_state             = r_gameState
cv3_stair_lower_prg_bank         = r_PrgBank_8000
cv3_stair_joy_pressed            = r_Joy1_t
cv3_stair_joy_held               = r_Joy1Held_t
cv3_stair_gameplay_substate      = r_gameTransition
cv3_stair_cinematic_controller   = r_autoPlay
cv3_stair_scroll_offset          = r_sceneScrollOffsetLo
cv3_stair_scroll_screen          = r_sceneScrollOffsetHi
cv3_stair_room_metadata          = r_roomOrientation
cv3_stair_room_stairs            = r_currRoomStairsDataAddr ; Pointer into PRG bank $0F at $A000-$BFFF.

cv3_stair_screen_y               = r_entity_YPos
cv3_stair_screen_x               = r_entity_XPos
cv3_stair_player_fraction_x      = r_entity_FractionalX
cv3_stair_player_fraction_y      = r_entity_FractionalY
cv3_stair_player_speed_x         = r_entity_Xspd
cv3_stair_player_subspeed_x      = r_entity_XsubSpd
cv3_stair_player_speed_y         = r_entity_Yspd
cv3_stair_player_subspeed_y      = r_entity_YsubSpd
cv3_stair_current_character      = r_entity_ID
cv3_stair_player_state           = r_Player_StateDoubled
cv3_stair_player_phase           = r_entity_AI_IDX
cv3_stair_player_stair_direction = r_entity_AI
cv3_stair_player_stair_alignment = $0606
cv3_stair_player_stair_step      = $061D

cv3_stair_PAD_A                  = $80
cv3_stair_PAD_B                  = $40
cv3_stair_PAD_UP                 = $08
cv3_stair_PAD_DOWN               = $04
cv3_stair_CHAR_GRANT             = $02
cv3_stair_STATE_IDLE             = $02
cv3_stair_STATE_WALK             = $04
cv3_stair_STATE_JUMP_START       = $06
cv3_stair_STATE_JUMP             = $08
cv3_stair_STATE_FALL             = $0C
cv3_stair_STATE_APPROACH_STAIRS  = $0E
cv3_stair_STATE_ENTER_STAIRS     = $10
cv3_stair_STATE_STAIR_IDLE       = $12
cv3_stair_STATE_STAIR_MOVE       = $14
cv3_stair_STAIRS_PRG_BANK        = $8E ; MMC5 16 KiB pair $0E/$0F.
cv3_stair_STAIR_CODE_PRG_BANK    = $A2 ; MMC5 16 KiB pair $22/$23.
cv3_stair_ATTACH_TOLERANCE       = $01
cv3_stair_STAIR_POSITION_CHECKED = $80 ; Cached only while idle on a staircase.

cv3_stair_set_lower_prg_bank     = swapPRGbankStore
cv3_stair_start_stair_ascent     = updateWeaponFacingSpeed_00 ; Sets animation, facing, X/Y speed and state $14.

; Scratch bytes live only during the stair tick, before state dispatch.
; The original state handlers reuse this same temporary zero-page area.
cv3_stair_player_x         = $00 ; 16-bit world coordinates.
cv3_stair_player_y         = $02
cv3_stair_endpoint_x       = $04
cv3_stair_endpoint_y       = $06
cv3_stair_delta_x          = $08 ; Signed player X minus endpoint X.
cv3_stair_projected_y      = $0A
cv3_stair_best_distance    = $0C ; Absolute horizontal distance to nearest endpoint.
cv3_stair_best_correction  = $0E ; Signed screen-Y correction, within tolerance.
cv3_stair_best_flags       = $0F
cv3_stair_bounds           = $10 ; Bits 0/1 mark lower/upper bounds, bit 7 an outside nearest endpoint.
cv3_stair_endpoint_flags   = $11
cv3_stair_distance         = $12 ; 16-bit absolute displacement.
cv3_stair_correction       = $14
cv3_stair_slope            = $15 ; $00 ascends right, $40 ascends left.

; Expanded PRG pair $22/$23, mapped at $8000-$BFFF.
assert HEADER_PRG >= $12
org $44000
base $8000
    DB cv3_stair_STAIR_CODE_PRG_BANK

cv3_stair_controls_tick_update:
    ; Idle and in-progress stair steps need no repeated room-table search.
    LDA.B cv3_stair_joy_pressed
    AND.B #cv3_stair_PAD_A
    BNE cv3_stair_controls_call
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_STAIR_MOVE
    BEQ cv3_stair_controls_step
    CMP.B #cv3_stair_STATE_STAIR_IDLE
    BEQ cv3_stair_controls_idle
    CMP.B #cv3_stair_STATE_APPROACH_STAIRS
    BEQ cv3_stair_controls_restore
    CMP.B #cv3_stair_STATE_ENTER_STAIRS
    BEQ cv3_stair_controls_restore
    LDA.B cv3_stair_joy_held
    AND.B #(cv3_stair_PAD_UP | cv3_stair_PAD_DOWN)
    CMP.B #cv3_stair_PAD_UP
    BNE cv3_stair_controls_restore
    BEQ cv3_stair_controls_call
cv3_stair_controls_step:
    LDA.W cv3_stair_player_stair_step
    BNE cv3_stair_controls_restore
    BEQ cv3_stair_controls_call
cv3_stair_controls_idle:
    LDA.B cv3_stair_joy_held
    AND.B #$0F
    BNE cv3_stair_controls_call
    LDA.W cv3_stair_player_phase
    BMI cv3_stair_controls_restore
cv3_stair_controls_call:
    JMP.W cv3_stair_controls_update
cv3_stair_controls_restore:
    CLC
    RTS

; C=1 requests ascent after the player bank has been restored.
cv3_stair_controls_update:
    LDA.B cv3_stair_game_state
    CMP.B #$04
    BEQ cv3_stair_controls_check_cinematic
    CLC
    RTS
cv3_stair_controls_check_cinematic:
    LDA.B cv3_stair_cinematic_controller
    BEQ cv3_stair_controls_check_substate
    CLC
    RTS
cv3_stair_controls_check_substate:
    LDA.B cv3_stair_gameplay_substate
    CMP.B #$03
    BEQ cv3_stair_controls_gameplay
    CMP.B #$05
    BEQ cv3_stair_controls_gameplay
    CMP.B #$0A
    BEQ cv3_stair_controls_gameplay
    CLC
    RTS

cv3_stair_controls_gameplay:
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_APPROACH_STAIRS
    BEQ cv3_stair_controls_on_stairs
    CMP.B #cv3_stair_STATE_ENTER_STAIRS
    BEQ cv3_stair_controls_on_stairs
    CMP.B #cv3_stair_STATE_STAIR_IDLE
    BEQ cv3_stair_controls_validate
    CMP.B #cv3_stair_STATE_STAIR_MOVE
    BEQ cv3_stair_controls_validate

; Keep jump and attack button presses ahead of staircase attachment.
    LDA.B cv3_stair_joy_pressed
    AND.B #(cv3_stair_PAD_A | cv3_stair_PAD_B)
    BNE cv3_stair_controls_return
    LDA.B cv3_stair_joy_held
    AND.B #(cv3_stair_PAD_UP | cv3_stair_PAD_DOWN)
    CMP.B #cv3_stair_PAD_UP
    BNE cv3_stair_controls_return
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_IDLE
    BEQ cv3_stair_controls_find
    CMP.B #cv3_stair_STATE_WALK
    BEQ cv3_stair_controls_find
    CMP.B #cv3_stair_STATE_JUMP
    BEQ cv3_stair_controls_airborne
    CMP.B #cv3_stair_STATE_FALL
    BNE cv3_stair_controls_return

cv3_stair_controls_airborne:
; Allow a descending catch. A jump leaving the stairs keeps its ascent.
; Phase zero includes the jump's stationary preparation frames.
    LDA.W cv3_stair_player_phase
    BEQ cv3_stair_controls_return
    LDA.W cv3_stair_player_speed_y
    BMI cv3_stair_controls_return

cv3_stair_controls_find:
    JSR.W cv3_stair_find_attachment
    BCC cv3_stair_controls_return
    JMP.W cv3_stair_attach

cv3_stair_controls_on_stairs:
    LDA.B cv3_stair_joy_pressed
    AND.B #cv3_stair_PAD_A
    BEQ cv3_stair_controls_return
; The character dispatcher runs its own jump-start handler this frame.
    LDA.B #cv3_stair_STATE_JUMP_START
    STA.W cv3_stair_player_state

cv3_stair_controls_return:
    CLC
    RTS

cv3_stair_controls_validate:
    LDA.B cv3_stair_joy_pressed
    AND.B #cv3_stair_PAD_A
    BNE cv3_stair_controls_on_stairs
    JSR.W cv3_stair_find_attachment
    BCC cv3_stair_controls_fall
    LDA.B cv3_stair_best_distance
    ORA.B cv3_stair_best_distance+1
    BNE cv3_stair_controls_valid
; An endpoint permits movement back into the flight, not past its end.
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_STAIR_MOVE
    BEQ cv3_stair_controls_moving_direction
    LDA.B cv3_stair_joy_held
    LSR A
    BCS cv3_stair_controls_right
    LSR A
    BCS cv3_stair_controls_left
    LSR A
    BCS cv3_stair_controls_down
    LSR A
    BCC cv3_stair_controls_valid
    LDA.B #$80
    BNE cv3_stair_controls_endpoint_direction
cv3_stair_controls_right:
    LDA.W cv3_stair_player_stair_direction
    EOR.B #$01
    BEQ cv3_stair_controls_down
    BNE cv3_stair_controls_up
cv3_stair_controls_left:
    LDA.W cv3_stair_player_stair_direction
    BEQ cv3_stair_controls_down
cv3_stair_controls_up:
    LDA.B #$80
    BNE cv3_stair_controls_endpoint_direction
cv3_stair_controls_down:
    LDA.B #$00
    BEQ cv3_stair_controls_endpoint_direction
cv3_stair_controls_moving_direction:
    LDA.W cv3_stair_player_speed_y
cv3_stair_controls_endpoint_direction:
    EOR.B cv3_stair_best_flags
    BPL cv3_stair_controls_fall
cv3_stair_controls_valid:
    LDA.W cv3_stair_player_phase
    ORA.B #cv3_stair_STAIR_POSITION_CHECKED
    STA.W cv3_stair_player_phase
    JMP.W cv3_stair_controls_return

cv3_stair_controls_fall:
    LDA.B #cv3_stair_STATE_FALL
    STA.W cv3_stair_player_state
    STA.W $05D8 ; Original falling-state animation timer.
    LDA.B #$01
    STA.W cv3_stair_player_phase
    LDA.B #$00
    STA.W cv3_stair_player_speed_x
    STA.W cv3_stair_player_subspeed_x
    STA.W cv3_stair_player_speed_y
    STA.W cv3_stair_player_subspeed_y
    STA.W cv3_stair_player_fraction_x
    STA.W cv3_stair_player_fraction_y
    JMP.W cv3_stair_controls_return

; C=1 means a staircase intersects the player's feet.
; Search slopes independently at staircase crossings.
cv3_stair_find_attachment:
    JSR.W cv3_stair_get_player_position
    BCS cv3_stair_find_begin
    RTS
cv3_stair_find_begin:
    LDA.B #$00
    STA.B cv3_stair_slope
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_STAIR_IDLE
    BCC cv3_stair_find_slope
    LDA.W cv3_stair_player_stair_direction
    LSR A
    ROR A
    ROR A
    STA.B cv3_stair_slope

cv3_stair_find_slope:
    LDA.B #$FF
    STA.B cv3_stair_best_distance
    STA.B cv3_stair_best_distance+1
    LDA.B #$00
    STA.B cv3_stair_bounds
    LDY.B #$00

cv3_stair_find_endpoint:
    JSR.W cv3_stair_read_record
    LDA.B cv3_stair_endpoint_flags
    CMP.B #$FF
    BNE cv3_stair_find_record
    JMP.W cv3_stair_find_evaluate
cv3_stair_find_record:
    AND.B #$40
    CMP.B cv3_stair_slope
    BEQ cv3_stair_find_decode
    JMP.W cv3_stair_find_endpoint

cv3_stair_find_decode:
    JSR.W cv3_stair_decode_endpoint
    SEC
    LDA.B cv3_stair_player_x
    SBC.B cv3_stair_endpoint_x
    STA.B cv3_stair_delta_x
    LDA.B cv3_stair_player_x+1
    SBC.B cv3_stair_endpoint_x+1
    STA.B cv3_stair_delta_x+1

; At the player's X, an ascending-right line has Y = endpoint Y - dx.
    LDA.B cv3_stair_slope
    BNE cv3_stair_project_left
    SEC
    LDA.B cv3_stair_endpoint_y
    SBC.B cv3_stair_delta_x
    STA.B cv3_stair_projected_y
    LDA.B cv3_stair_endpoint_y+1
    SBC.B cv3_stair_delta_x+1
    JMP.W cv3_stair_project_compare

cv3_stair_project_left:
    CLC
    LDA.B cv3_stair_endpoint_y
    ADC.B cv3_stair_delta_x
    STA.B cv3_stair_projected_y
    LDA.B cv3_stair_endpoint_y+1
    ADC.B cv3_stair_delta_x+1

cv3_stair_project_compare:
    STA.B cv3_stair_projected_y+1
    SEC
    LDA.B cv3_stair_projected_y
    SBC.B cv3_stair_player_y
    STA.B cv3_stair_correction
    LDA.B cv3_stair_projected_y+1
    SBC.B cv3_stair_player_y+1
    BEQ cv3_stair_correction_positive
    CMP.B #$FF
    BEQ cv3_stair_correction_negative
    JMP.W cv3_stair_find_next
cv3_stair_correction_negative:
    LDA.B cv3_stair_correction
    CMP.B #($100 - cv3_stair_ATTACH_TOLERANCE)
    BCS cv3_stair_find_bound
; Falling can cross the whole contact band between two frames.
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_JUMP
    BEQ cv3_stair_check_crossing
    CMP.B #cv3_stair_STATE_FALL
    BEQ cv3_stair_check_crossing
    JMP.W cv3_stair_find_next
cv3_stair_check_crossing:
    JSR.W cv3_stair_relative_fall_speed
    LDA.B cv3_stair_distance+1
    BMI cv3_stair_find_next
    BEQ cv3_stair_find_next
    LDA.B #$00
    SEC
    SBC.B cv3_stair_correction
    CMP.B cv3_stair_distance+1
    BCC cv3_stair_find_bound
    BEQ cv3_stair_find_bound
    JMP.W cv3_stair_find_next

cv3_stair_correction_positive:
    LDA.B cv3_stair_correction
    CMP.B #(cv3_stair_ATTACH_TOLERANCE + 1)
    BCS cv3_stair_find_next

cv3_stair_find_bound:
    LDA.B cv3_stair_delta_x
    ORA.B cv3_stair_delta_x+1
    BEQ cv3_stair_find_bound_inside
    LDA.B cv3_stair_endpoint_flags
    ASL A
    EOR.B cv3_stair_endpoint_flags
    EOR.B cv3_stair_delta_x+1
    BMI cv3_stair_measure_distance
cv3_stair_find_bound_inside:
    LDA.B cv3_stair_endpoint_flags
    BMI cv3_stair_find_upper_bound
    LDA.B #$01
    BNE cv3_stair_find_save_bound
cv3_stair_find_upper_bound:
    LDA.B #$02
cv3_stair_find_save_bound:
    ORA.B cv3_stair_bounds
    STA.B cv3_stair_bounds

cv3_stair_measure_distance:
    LDA.B cv3_stair_delta_x
    STA.B cv3_stair_distance
    LDA.B cv3_stair_delta_x+1
    STA.B cv3_stair_distance+1
    BPL cv3_stair_compare_distance
    SEC
    LDA.B #$00
    SBC.B cv3_stair_distance
    STA.B cv3_stair_distance
    LDA.B #$00
    SBC.B cv3_stair_distance+1
    STA.B cv3_stair_distance+1

cv3_stair_compare_distance:
; Both paths leave the distance high byte in A.
    CMP.B cv3_stair_best_distance+1
    BCC cv3_stair_remember_endpoint
    BNE cv3_stair_find_next
    LDA.B cv3_stair_distance
    CMP.B cv3_stair_best_distance
    BCS cv3_stair_find_next

cv3_stair_remember_endpoint:
    LDA.B cv3_stair_distance
    STA.B cv3_stair_best_distance
    LDA.B cv3_stair_distance+1
    STA.B cv3_stair_best_distance+1
    LDA.B cv3_stair_correction
    STA.B cv3_stair_best_correction
    LDA.B cv3_stair_endpoint_flags
    STA.B cv3_stair_best_flags
    LDA.B cv3_stair_endpoint_flags
    ASL A
    EOR.B cv3_stair_endpoint_flags
    EOR.B cv3_stair_delta_x+1
    AND.B #$80
    STA.B cv3_stair_distance
    LDA.B cv3_stair_bounds
    AND.B #$03
    ORA.B cv3_stair_distance
    STA.B cv3_stair_bounds

cv3_stair_find_next:
    JMP.W cv3_stair_find_endpoint

cv3_stair_find_evaluate:
    LDA.B cv3_stair_best_distance+1
    CMP.B #$FF
    BEQ cv3_stair_find_other_slope
    ORA.B cv3_stair_best_distance
    BEQ cv3_stair_find_inside
; A lower endpoint points into the ascending half-line, an upper one
; into the descending half-line. The nearest collinear endpoint bounds
; a flight, including gaps between flights on the same diagonal.
    LDA.B cv3_stair_bounds
    BMI cv3_stair_find_other_slope

cv3_stair_find_inside:
; Native room-edge stair transitions can have a single endpoint.
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_STAIR_IDLE
    BCS cv3_stair_find_success
; Room-edge flights may have only one endpoint. The nearest endpoint's
; inward-facing half-line also bounds those flights and rejects gaps.
; An upward catch needs room for the first eight-pixel stair step.
    LDA.B cv3_stair_best_flags
    BPL cv3_stair_find_check_grounded
    LDA.B cv3_stair_best_distance+1
    BNE cv3_stair_find_check_grounded
    LDA.B cv3_stair_best_distance
    CMP.B #$08
    BCC cv3_stair_find_other_slope
cv3_stair_find_check_grounded:
; Grounded endpoint entry retains the original alignment animation.
; Only idle, walk, jump and fall states reach this search.
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_JUMP
    BCS cv3_stair_find_success

    LDA.B cv3_stair_best_distance+1
    BNE cv3_stair_find_success
    LDA.B cv3_stair_best_distance
    CMP.B #$08
    BCC cv3_stair_find_other_slope

cv3_stair_find_success:
    SEC
    RTS

cv3_stair_find_other_slope:
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_STAIR_IDLE
    BCS cv3_stair_find_failure
    LDA.B cv3_stair_slope
    BNE cv3_stair_find_failure
    LDA.B #$40
    STA.B cv3_stair_slope
    JMP.W cv3_stair_find_slope

cv3_stair_find_failure:
    CLC
    RTS

; Relative downward travel across the diagonal, rounded up to whole pixels.
; Right-rising stairs use vy + vx, left-rising stairs use vy - vx.
cv3_stair_relative_fall_speed:
    LDA.B cv3_stair_slope
    BNE cv3_stair_relative_fall_left
    CLC
    LDA.W cv3_stair_player_subspeed_y
    ADC.W cv3_stair_player_subspeed_x
    STA.B cv3_stair_distance
    LDA.W cv3_stair_player_speed_y
    ADC.W cv3_stair_player_speed_x
    JMP.W cv3_stair_relative_fall_round
cv3_stair_relative_fall_left:
    SEC
    LDA.W cv3_stair_player_subspeed_y
    SBC.W cv3_stair_player_subspeed_x
    STA.B cv3_stair_distance
    LDA.W cv3_stair_player_speed_y
    SBC.W cv3_stair_player_speed_x
cv3_stair_relative_fall_round:
    STA.B cv3_stair_distance+1
    LDA.B cv3_stair_distance
    BEQ cv3_stair_relative_fall_done
    INC.B cv3_stair_distance+1
cv3_stair_relative_fall_done:
    RTS

; Vertical room pages are 240 pixels tall.
cv3_stair_get_player_position:
    LDA.W cv3_stair_screen_x
    STA.B cv3_stair_player_x
    LDA.W cv3_stair_screen_y
    STA.B cv3_stair_player_y
    LDA.B #$00
    STA.B cv3_stair_player_x+1
    STA.B cv3_stair_player_y+1
    LDA.B cv3_stair_room_metadata
    BMI cv3_stair_player_vertical
    CLC
    LDA.W cv3_stair_screen_x
    ADC.B cv3_stair_scroll_offset
    STA.B cv3_stair_player_x
    LDA.B cv3_stair_scroll_screen
    ADC.B #$00
    STA.B cv3_stair_player_x+1
    JMP.W cv3_stair_player_character_offset

cv3_stair_player_vertical:
    LDA.W cv3_stair_screen_y
    SEC
    SBC.B #$33
    BCC cv3_stair_find_failure
    CLC
    ADC.B cv3_stair_scroll_offset
    STA.B cv3_stair_player_y
    LDA.B #$00
    ADC.B #$00
    STA.B cv3_stair_player_y+1
    LDA.B cv3_stair_scroll_screen
    JSR.W cv3_stair_scale_vertical_page
    CLC
    LDA.B cv3_stair_player_y
    ADC.B cv3_stair_endpoint_y
    STA.B cv3_stair_player_y
    LDA.B cv3_stair_player_y+1
    ADC.B cv3_stair_endpoint_y+1
    STA.B cv3_stair_player_y+1

cv3_stair_player_character_offset:
    LDA.W cv3_stair_current_character
    CMP.B #cv3_stair_CHAR_GRANT
    BNE cv3_stair_player_ready
; Grant's shorter sprite places its origin four pixels below the others.
    SEC
    LDA.B cv3_stair_player_y
    SBC.B #$04
    STA.B cv3_stair_player_y
    LDA.B cv3_stair_player_y+1
    SBC.B #$00
    STA.B cv3_stair_player_y+1
cv3_stair_player_ready:
    SEC
    RTS

; Decode the record fetched by stair_read_record. Y is preserved.
; Horizontal layout = flags|Y/16, X low, X page.
; Vertical layout   = flags|Y page, Y within page, X.
cv3_stair_decode_endpoint:
    LDA.B cv3_stair_room_metadata
    BMI cv3_stair_decode_vertical
    LDA.B cv3_stair_endpoint_flags
    ASL A
    ASL A
    ASL A
    ASL A
    STA.B cv3_stair_endpoint_y
    LDA.B #$00
    STA.B cv3_stair_endpoint_y+1
    RTS

cv3_stair_decode_vertical:
    LDA.B cv3_stair_endpoint_flags
    AND.B #$0F
    JSR.W cv3_stair_scale_vertical_page
    CLC
    LDA.B cv3_stair_endpoint_x
    ADC.B cv3_stair_endpoint_y
    STA.B cv3_stair_endpoint_y
    LDA.B cv3_stair_endpoint_y+1
    ADC.B #$00
    STA.B cv3_stair_endpoint_y+1
    LDA.B cv3_stair_endpoint_x+1
    STA.B cv3_stair_endpoint_x
    LDA.B #$00
    STA.B cv3_stair_endpoint_x+1
    RTS

; A = page, endpoint Y = page * 240 = page * 256 - page * 16.
; Page values fit in a nibble. X is temporary, Y is preserved.
cv3_stair_scale_vertical_page:
    TAX
    ASL A
    ASL A
    ASL A
    ASL A
    STA.B cv3_stair_endpoint_y
    SEC
    LDA.B #$00
    SBC.B cv3_stair_endpoint_y
    STA.B cv3_stair_endpoint_y
    TXA
    SBC.B #$00
    STA.B cv3_stair_endpoint_y+1
    RTS

; Prepare the player, then request ascent in the restored player bank.
cv3_stair_attach:
    CLC
    LDA.W cv3_stair_screen_y
    ADC.B cv3_stair_best_correction
    STA.W cv3_stair_screen_y
; Match the eight-pixel step lattice used by the original stair handler.
; Move X and Y together to remain on the selected 45-degree flight.
    LDA.B cv3_stair_player_x
    AND.B #$07
    STA.B cv3_stair_distance
    SEC
    LDA.W cv3_stair_screen_x
    SBC.B cv3_stair_distance
    STA.W cv3_stair_screen_x
    LDA.B cv3_stair_best_flags
    AND.B #$40
    BNE cv3_stair_attach_left
    CLC
    LDA.W cv3_stair_screen_y
    ADC.B cv3_stair_distance
    JMP.W cv3_stair_attach_y

cv3_stair_attach_left:
    SEC
    LDA.W cv3_stair_screen_y
    SBC.B cv3_stair_distance

cv3_stair_attach_y:
    STA.W cv3_stair_screen_y
    LDA.B cv3_stair_best_flags
    ASL A
    ASL A
    ROL A
    AND.B #$01
    STA.W cv3_stair_player_stair_direction
    LDA.B #$00
    STA.W cv3_stair_player_fraction_x
    STA.W cv3_stair_player_fraction_y
    STA.W cv3_stair_player_stair_alignment
    LDA.B #$01
    STA.W cv3_stair_player_phase
    SEC
    RTS

assert pc() <= $C000

org $1FFCB
base $BFCB
; Y advances to the next record. The terminator has no coordinate bytes.
cv3_stair_read_record_data:
    LDA.B (cv3_stair_room_stairs),Y
    STA.B cv3_stair_endpoint_flags
    CMP.B #$FF
    BEQ cv3_stair_read_record_done
    INY
    LDA.B (cv3_stair_room_stairs),Y
    STA.B cv3_stair_endpoint_x
    INY
    LDA.B (cv3_stair_room_stairs),Y
    STA.B cv3_stair_endpoint_x+1
    INY
cv3_stair_read_record_done:
    RTS

assert pc() <= $C000

; These trampolines execute in the permanently mapped final 8 KiB bank.
; The bank setter preserves carry so attachment survives the return switch.
org LAST_BANK+$1FCA
base $FFCA
cv3_stair_controls_tick:
    PHP
    PHA
    TXA
    PHA
    LDA.B cv3_stair_lower_prg_bank
    PHA
    LDA.B #cv3_stair_STAIR_CODE_PRG_BANK
    JSR.W cv3_stair_set_lower_prg_bank
    JSR.W cv3_stair_controls_tick_update
    PLA
    JSR.W cv3_stair_set_lower_prg_bank
    BCC cv3_stair_controls_tick_restore
    JSR.W cv3_stair_start_stair_ascent
cv3_stair_controls_tick_restore:
    PLA
    TAX
    PLA
    PLP
    LDY.W cv3_stair_current_character
    RTS

; Read one record while the room's original stair-data bank is mapped.
cv3_stair_read_record:
    LDA.B #cv3_stair_STAIRS_PRG_BANK
    JSR.W cv3_stair_set_lower_prg_bank
    JSR.W cv3_stair_read_record_data
    LDA.B #cv3_stair_STAIR_CODE_PRG_BANK
    JMP.W cv3_stair_set_lower_prg_bank
assert pc() <= $FFFA
