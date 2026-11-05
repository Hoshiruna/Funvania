; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/horizontal_autoscroll.asm for Asar.
; Included in the current $C000-$DFFF allocator, after text and SRAM setup.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

cv3_scroll_game_state                 = r_gameState
cv3_scroll_lower_prg_bank             = r_PrgBank_8000
cv3_scroll_gameplay_substate          = r_gameTransition
cv3_scroll_cinematic_controller       = r_autoPlay
cv3_scroll_stage_index                = r_stage
cv3_scroll_block_index                = r_blockLevel
cv3_scroll_room_index                 = r_roomIdx
cv3_scroll_scroll_direction           = r_scrollDirection
cv3_scroll_room_metadata              = r_roomOrientation
cv3_scroll_scroll_delta               = r_scrollSpd ; Signed horizontal camera displacement this frame.
cv3_scroll_boss_active                = r_bossActiveFlag
cv3_scroll_player_collision_shape     = r_currPartnerID ; Character index, +4 crouched, $08 in bat form.
cv3_scroll_player_x                   = r_entity_XPos
cv3_scroll_player_speed_x             = r_entity_Xspd
cv3_scroll_player_subspeed_x          = r_entity_XsubSpd

cv3_scroll_SCROLL_LEFT                = $00
cv3_scroll_SCROLL_RIGHT               = $01
cv3_scroll_SCROLL_DISABLED            = $FF
cv3_scroll_SCREEN_LEFT                = $18
cv3_scroll_SCREEN_RIGHT               = $E8

; Unsigned 8.8 pixels per frame, from $0001 through $0100 (one pixel).
; The native column renderer needs several frames to prepare each column.
cv3_scroll_HORIZONTAL_SCROLL_SPEED    = !cv3HorizontalScrollSpeed

assert cv3_scroll_HORIZONTAL_SCROLL_SPEED >= $0001
assert cv3_scroll_HORIZONTAL_SCROLL_SPEED <= $0100

cv3_scroll_native_player_scroll_check = cv3_horizontal_native_player_scroll_check
cv3_scroll_native_player_move = stopScroll_if_boss_87
cv3_scroll_native_scroll_continue = $D179
cv3_scroll_native_player_wall_check = CODE_0E915E ; A = signed X probe, carry set when blocked.
cv3_scroll_native_player_death = initPlayerDeath
cv3_scroll_set_lower_prg_bank = swapPRGbankStore
cv3_scroll_native_tile_collision = playerCollusionCheck ; A = signed X offset, X = signed Y offset.
cv3_scroll_PLAYER_PRG_BANK = $9C ; MMC5 16 KiB pair $1C/$1D.

cv3_horizontal_probe_x = $00 ; Scratch used by the native wall probes.

; Keep the native camera/column renderer at its existing CPU address.
pushPC
org $3D175
base $D175
    JMP.W cv3_horizontal_scroll_tick
    NOP
pullPC

; Player movement must update screen X even when crossing the center.
; The camera tick applies its own displacement after player processing.
cv3_horizontal_player_camera:
    LDA.B cv3_scroll_room_metadata
    BMI cv3_horizontal_player_move
    JSR.W cv3_horizontal_scroll_room
    CMP.B #cv3_scroll_SCROLL_DISABLED
    BNE cv3_horizontal_player_move
    JMP.W cv3_scroll_native_player_scroll_check
cv3_horizontal_player_move:
    JMP.W cv3_scroll_native_player_move

cv3_horizontal_scroll_tick:
    JSR.W cv3_horizontal_scroll_room
    CMP.B #cv3_scroll_SCROLL_DISABLED
    BNE cv3_horizontal_scroll_forced
    JMP.W cv3_horizontal_scroll_native

cv3_horizontal_scroll_forced:
    STA.B cv3_scroll_scroll_direction
    TAY
; The native camera integrates the player's speed. Lend it the forced
; speed for this call, then restore both bytes before entity processing.
    LDA.W cv3_scroll_player_speed_x
    PHA
    LDA.W cv3_scroll_player_subspeed_x
    PHA
    LDA.W cv3_horizontal_speed_fraction,Y
    STA.W cv3_scroll_player_subspeed_x
    LDA.W cv3_horizontal_speed_integer,Y
    STA.W cv3_scroll_player_speed_x
    JSR.W cv3_horizontal_scroll_native
    PLA
    STA.W cv3_scroll_player_subspeed_x
    PLA
    STA.W cv3_scroll_player_speed_x

; Use the actual displacement, including room-end clamping and the
; fractional accumulator. Other entities already consume scroll_delta.
    LDA.B cv3_scroll_scroll_delta
    BEQ cv3_horizontal_scroll_done
    BMI cv3_horizontal_scroll_camera_left
    SEC
    LDA.W cv3_scroll_player_x
    SBC.B cv3_scroll_scroll_delta
    BCC cv3_horizontal_scroll_clamp_left
    CMP.B #cv3_scroll_SCREEN_LEFT
    BCS cv3_horizontal_scroll_store_x
cv3_horizontal_scroll_clamp_left:
    LDA.B #cv3_scroll_SCREEN_LEFT
    STA.W cv3_scroll_player_x
    JMP.W cv3_horizontal_scroll_check_crush

cv3_horizontal_scroll_camera_left:
    SEC
    LDA.W cv3_scroll_player_x
    SBC.B cv3_scroll_scroll_delta
    BCS cv3_horizontal_scroll_clamp_right
    CMP.B #(cv3_scroll_SCREEN_RIGHT + 1)
    BCC cv3_horizontal_scroll_store_x
cv3_horizontal_scroll_clamp_right:
    LDA.B #cv3_scroll_SCREEN_RIGHT
    STA.W cv3_scroll_player_x
    JMP.W cv3_horizontal_scroll_check_crush
cv3_horizontal_scroll_store_x:
    STA.W cv3_scroll_player_x
cv3_horizontal_scroll_done:
    RTS

; Clamping the trailing edge pushes the player through world space. Check
; the pushed side using the native character-height probes before it can
; enter a wall. Open ground at the screen edge still permits movement.
cv3_horizontal_scroll_check_crush:
    LDA.B cv3_scroll_lower_prg_bank
    PHA
    LDA.B #cv3_scroll_PLAYER_PRG_BANK
    JSR.W cv3_scroll_set_lower_prg_bank
    LDA.B cv3_scroll_scroll_delta
    BMI cv3_horizontal_scroll_probe_left
    LDA.B #$08
    BNE cv3_horizontal_scroll_probe_wall
cv3_horizontal_scroll_probe_left:
    LDA.B #$F8
cv3_horizontal_scroll_probe_wall:
    LDY.B cv3_scroll_player_collision_shape
    CPY.B #$08
    BEQ cv3_horizontal_scroll_probe_bat
    JSR.W cv3_scroll_native_player_wall_check
    BCC cv3_horizontal_scroll_restore_bank
cv3_horizontal_scroll_crushed:
    JSR.W cv3_scroll_native_player_death
cv3_horizontal_scroll_restore_bank:
    PLA
    JMP.W cv3_scroll_set_lower_prg_bank

; Bat form uses the same +/-6-pixel vertical probes as its native movement.
cv3_horizontal_scroll_probe_bat:
    STA.B cv3_horizontal_probe_x
    LDX.B #$FA
    JSR.W cv3_scroll_native_tile_collision
    BNE cv3_horizontal_scroll_crushed
    LDA.B cv3_horizontal_probe_x
    LDX.B #$06
    JSR.W cv3_scroll_native_tile_collision
    BNE cv3_horizontal_scroll_crushed
    BEQ cv3_horizontal_scroll_restore_bank

; Reproduce the displaced instructions and resume at the original BNE.
; JMP preserves the comparison flags used by the native direction history.
cv3_horizontal_scroll_native:
    LDA.B cv3_scroll_scroll_direction
    CMP.B #$02
    JMP.W cv3_scroll_native_scroll_continue

; A = configured direction or $FF. X and Y are preserved using the stack.
; Gameplay substates $03/$0A use the horizontal camera (ordinary/water rooms).
cv3_horizontal_scroll_room:
    LDA.B cv3_scroll_game_state
    CMP.B #$04
    BNE cv3_horizontal_scroll_disabled
    LDA.B cv3_scroll_cinematic_controller
    ORA.B cv3_scroll_boss_active
    BNE cv3_horizontal_scroll_disabled
    LDA.B cv3_scroll_room_metadata
    BMI cv3_horizontal_scroll_disabled
    LDA.B cv3_scroll_gameplay_substate
    CMP.B #$03
    BEQ cv3_horizontal_scroll_find
    CMP.B #$0A
    BNE cv3_horizontal_scroll_disabled

cv3_horizontal_scroll_find:
    TYA
    PHA
    LDY.B #$00
cv3_horizontal_scroll_find_room:
    LDA.W cv3_horizontal_scroll_rooms,Y
    CMP.B #$FF
    BEQ cv3_horizontal_scroll_not_found
    CMP.B cv3_scroll_stage_index
    BNE cv3_horizontal_scroll_next_room
    LDA.W cv3_horizontal_scroll_rooms+1,Y
    CMP.B cv3_scroll_block_index
    BNE cv3_horizontal_scroll_next_room
    LDA.W cv3_horizontal_scroll_rooms+2,Y
    CMP.B cv3_scroll_room_index
    BNE cv3_horizontal_scroll_next_room
    LDA.W cv3_horizontal_scroll_rooms+3,Y
    CMP.B #cv3_scroll_SCROLL_RIGHT
    BEQ cv3_horizontal_scroll_found_right
    PLA
    TAY
    LDA.B #cv3_scroll_SCROLL_LEFT
    RTS
cv3_horizontal_scroll_found_right:
    PLA
    TAY
    LDA.B #cv3_scroll_SCROLL_RIGHT
    RTS
cv3_horizontal_scroll_next_room:
    INY
    INY
    INY
    INY
    BNE cv3_horizontal_scroll_find_room
cv3_horizontal_scroll_not_found:
    PLA
    TAY
cv3_horizontal_scroll_disabled:
    LDA.B #cv3_scroll_SCROLL_DISABLED
    RTS

cv3_horizontal_speed_fraction:
    DB ((-cv3_scroll_HORIZONTAL_SCROLL_SPEED) & $FF), (cv3_scroll_HORIZONTAL_SCROLL_SPEED & $FF)
cv3_horizontal_speed_integer:
    DB (((-cv3_scroll_HORIZONTAL_SCROLL_SPEED) >> 8) & $FF), (cv3_scroll_HORIZONTAL_SCROLL_SPEED >> 8)

; Each record is stage ($32), block ($33), room ($34), direction.
; These are internal zero-based IDs. The table is intentionally empty until
; rooms are selected. Insert records before the $FF terminator, for example
;     DB $00, $00, $00, cv3_scroll_SCROLL_RIGHT
;     DB $00, $00, $01, cv3_scroll_SCROLL_LEFT
; Leftward scrolling starts from the room's existing camera position.
cv3_horizontal_scroll_rooms:
    DB $FF
cv3_horizontal_scroll_rooms_end:

assert (cv3_horizontal_scroll_rooms_end - cv3_horizontal_scroll_rooms) <= $FD
