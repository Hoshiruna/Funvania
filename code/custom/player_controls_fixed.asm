; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/better_stair.asm and inverted_gravity_7_01.asm for Funvania Asar.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

; Included in the fixed-bank allocator before its $ECDC bound.
cv3_player_dispatch:
    PHP
    PHA
    TXA
    PHA
    JSR.W cv3_player_call_controls
if !cv3BetterStairs == 1
    BCC cv3_player_dispatch_state
    JSR.W updateWeaponFacingSpeed_00
endif
cv3_player_dispatch_state:
if !cv3ClimbableRope == 1
    LDA.W r_Player_StateDoubled
    CMP.B #cv3_rope_STATE_ROPE
    BEQ cv3_player_rope_move
endif
    PLA
    TAX
    PLA
    PLP
    LDY.W r_entity_ID
    JMP.W cv3_player_native_dispatch
if !cv3ClimbableRope == 1
cv3_player_rope_move:
    PLA
    TAX
    PLA
    PLP
    JSR.W updateSpeed2Pos
    JMP.W generalPlayerRoutines
endif

if !cv3InvertedGravity == 1
pushPC
org LAST_BANK+$1CDD
base $FCDD
    JMP.W cv3_gravity_collision       ;0FFCDD|4C      |      ;
pullPC

; This helper stays fixed even when rope probes run from PRG pair $A2.
cv3_gravity_collision:
    PHA
    LDA.W cv3_gravity_player_stair_alignment
    BPL cv3_gravity_collision_resume
    TXA
    EOR.B #$FF
    SEC
    LDY.W cv3_gravity_current_character
    CPY.B #cv3_gravity_CHAR_GRANT
    BEQ cv3_gravity_collision_grant
    SBC.B #$07 ; Mirror around Y=-4: transformed probe = -8 - original.
    JMP.W cv3_gravity_collision_store
cv3_gravity_collision_grant:
    SBC.B #$03 ; Grant is shorter: transformed probe = -4 - original.
cv3_gravity_collision_store:
    TAX
cv3_gravity_collision_resume:
    LDA.B cv3_gravity_room_metadata
    BMI cv3_gravity_collision_vertical
    JMP.W $FCE2
cv3_gravity_collision_vertical:
    JMP.W $FC7F


; Return the displaced LDA result to the native CLC/ADC integrator.
cv3_gravity_prepare_move_y:
    LDA.W cv3_gravity_player_stair_alignment
    BPL cv3_gravity_move_y_ready
    SEC
    LDA.B #$00
    SBC.W r_entity_YsubSpd
    STA.W r_entity_YsubSpd
    LDA.B #$00
    SBC.W r_entity_Yspd
    STA.W r_entity_Yspd
cv3_gravity_move_y_ready:
    LDA.W r_entity_FractionalY
    RTS
endif
