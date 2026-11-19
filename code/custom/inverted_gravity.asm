; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/inverted_gravity_7_01.asm for Funvania Asar.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

cv3_gravity_game_state                 = $18
cv3_gravity_stage_index                = $32
cv3_gravity_block_index                = $33
cv3_gravity_room_index                 = $34
cv3_gravity_scroll_offset              = $56
cv3_gravity_scroll_screen              = $57
cv3_gravity_room_metadata              = $68

cv3_gravity_player_y                   = $041C
cv3_gravity_player_x                   = $0438
cv3_gravity_player_fraction_y          = $04DB
cv3_gravity_player_speed_y             = $0520
cv3_gravity_player_subspeed_y          = $0537
cv3_gravity_current_character          = $054E
cv3_gravity_player_state               = $0565
cv3_gravity_player_phase               = $05C1
cv3_gravity_player_jump_timer          = $05D8
cv3_gravity_player_stair_alignment     = $0606

cv3_gravity_grant_jump_flag            = $9D
cv3_gravity_player_landing_timer       = $B9

cv3_gravity_current_oam_offset         = $04
cv3_gravity_current_entity_index       = $05
cv3_gravity_frame_oam_offset           = $20
cv3_gravity_oam_buffer                 = $0200

cv3_gravity_GAME_STATE_PLAYING         = $04
cv3_gravity_CHAR_GRANT                 = $02
cv3_gravity_STATE_IDLE                 = $02
cv3_gravity_STATE_WALK                 = $04
cv3_gravity_STATE_FALL                 = $0C
cv3_gravity_STATE_DUCK                 = $0A

cv3_gravity_GRAVITY_ACTIVE             = $80



cv3_gravity_player_tick:
    LDA.W cv3_gravity_player_stair_alignment
    BPL cv3_gravity_player_check_zone
    JSR.W cv3_gravity_normalize_speed

cv3_gravity_player_check_zone:
    JSR.W cv3_gravity_zone_active
    BEQ cv3_gravity_player_disable
    LDA.W cv3_gravity_player_stair_alignment
    BMI cv3_gravity_player_done
    ORA.B #cv3_gravity_GRAVITY_ACTIVE
    STA.W cv3_gravity_player_stair_alignment
    JSR.W cv3_gravity_begin_fall
cv3_gravity_player_done:
    RTS

cv3_gravity_player_disable:
    LDA.W cv3_gravity_player_stair_alignment
    BPL cv3_gravity_player_done
    AND.B #($FF^cv3_gravity_GRAVITY_ACTIVE)
    STA.W cv3_gravity_player_stair_alignment
    JSR.W cv3_gravity_begin_fall
    RTS

; Seven-byte records select horizontal world-X strips.
; Native stair and rope states keep their own movement while attached.
cv3_gravity_zone_active:
    LDA.B cv3_gravity_game_state
    CMP.B #cv3_gravity_GAME_STATE_PLAYING
    BEQ cv3_gravity_zone_check_room
    JMP.W cv3_gravity_zone_inactive
cv3_gravity_zone_check_room:
    LDA.B cv3_gravity_room_metadata
    BPL cv3_gravity_zone_check_state
    JMP.W cv3_gravity_zone_inactive
cv3_gravity_zone_check_state:
    LDA.W cv3_gravity_player_state
    CMP.B #$0E
    BCC cv3_gravity_zone_check_rope
    CMP.B #$16
    BCS cv3_gravity_zone_check_rope
    JMP.W cv3_gravity_zone_inactive
cv3_gravity_zone_check_rope:
if !cv3ClimbableRope == 1
    CMP.B #cv3_rope_STATE_ROPE
    BNE cv3_gravity_zone_position
    JMP.W cv3_gravity_zone_inactive
endif
cv3_gravity_zone_position:
    CLC
    LDA.W cv3_gravity_player_x
    ADC.B cv3_gravity_scroll_offset
    STA.B cv3_gravity_world_x
    LDA.B cv3_gravity_scroll_screen
    ADC.B #$00
    STA.B cv3_gravity_world_x+1
    LDY.B #$00
cv3_gravity_zone_record:
    LDA.W cv3_gravity_zones,Y
    CMP.B #$FF
    BEQ cv3_gravity_zone_inactive
    CMP.B cv3_gravity_stage_index
    BNE cv3_gravity_zone_next
    LDA.W cv3_gravity_zones+1,Y
    CMP.B cv3_gravity_block_index
    BNE cv3_gravity_zone_next
    LDA.W cv3_gravity_zones+2,Y
    CMP.B cv3_gravity_room_index
    BNE cv3_gravity_zone_next
    LDA.B cv3_gravity_world_x+1
    CMP.W cv3_gravity_zones+4,Y
    BCC cv3_gravity_zone_next
    BNE cv3_gravity_zone_right
    LDA.B cv3_gravity_world_x
    CMP.W cv3_gravity_zones+3,Y
    BCC cv3_gravity_zone_next
cv3_gravity_zone_right:
    LDA.B cv3_gravity_world_x+1
    CMP.W cv3_gravity_zones+6,Y
    BCC cv3_gravity_zone_found
    BNE cv3_gravity_zone_next
    LDA.B cv3_gravity_world_x
    CMP.W cv3_gravity_zones+5,Y
    BCC cv3_gravity_zone_found
cv3_gravity_zone_next:
    TYA
    CLC
    ADC.B #$07
    TAY
    JMP.W cv3_gravity_zone_record
cv3_gravity_zone_inactive:
    LDA.B #$00
    RTS
cv3_gravity_zone_found:
    LDA.B #cv3_gravity_GRAVITY_ACTIVE
    RTS

; Each record is stage, block, room, then 16-bit little-endian left and
; exclusive right world-X bounds. Add records before the $FF terminator.
cv3_gravity_world_x = $00
cv3_gravity_zones:
    DB $FF
cv3_gravity_zones_end:
; Entering from the floor or leaving from the ceiling starts a clean fall.
; Airborne transitions keep their current jump phase and mirror immediately.
cv3_gravity_begin_fall:
    LDA.W cv3_gravity_player_state
    CMP.B #cv3_gravity_STATE_IDLE
    BEQ cv3_gravity_begin_fall_grounded
    CMP.B #cv3_gravity_STATE_WALK
    BEQ cv3_gravity_begin_fall_grounded
    CMP.B #cv3_gravity_STATE_DUCK
    BNE cv3_gravity_begin_fall_done
cv3_gravity_begin_fall_grounded:
    LDA.B #$00
    STA.W cv3_gravity_player_fraction_y
    STA.W cv3_gravity_player_speed_y
    STA.W cv3_gravity_player_subspeed_y
    STA.B cv3_gravity_grant_jump_flag
    STA.B cv3_gravity_player_landing_timer
    LDA.B #$01
    STA.W cv3_gravity_player_phase
    LDA.B #cv3_gravity_STATE_FALL
    STA.W cv3_gravity_player_state
    STA.W cv3_gravity_player_jump_timer
    LDA.W cv3_gravity_current_character
    CMP.B #cv3_gravity_CHAR_GRANT
    BNE cv3_gravity_begin_fall_done
    LDA.B #$38
    STA.W cv3_gravity_player_jump_timer
cv3_gravity_begin_fall_done:
    RTS

; The movement hook leaves the stored speed mirrored. Convert it back before
; the next state update so native jump and damage code sees its usual sign.
cv3_gravity_normalize_speed:
    SEC
    LDA.B #$00
    SBC.W cv3_gravity_player_subspeed_y
    STA.W cv3_gravity_player_subspeed_y
    LDA.B #$00
    SBC.W cv3_gravity_player_speed_y
    STA.W cv3_gravity_player_speed_y
    RTS

assert (cv3_gravity_zones_end-cv3_gravity_zones) <= $FD
assert ((cv3_gravity_zones_end-cv3_gravity_zones-1)%7) == 0
