; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/better_stair.asm and climbable_rope.asm for Funvania Asar.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

; PRG pair $22/$23 holds the shared player features.
assert HEADER_PRG >= $12
org $44000
base $8000
    db $A2

cv3_player_controls_update:
if !cv3InvertedGravity == 1
    JSR.W cv3_gravity_player_tick
    LDA.W cv3_gravity_player_stair_alignment
    BMI cv3_player_controls_done
endif
if !cv3ClimbableRope == 1
    JSR.W cv3_rope_controls_update
    BCS cv3_player_controls_done
endif
if !cv3BetterStairs == 1
    JMP.W cv3_stair_controls_tick_update
endif
cv3_player_controls_done:
    CLC
    RTS

if !cv3BetterStairs == 1 || !cv3ClimbableRope == 1
    incsrc "code/custom/better_stair.asm"
endif
if !cv3ClimbableRope == 1
    incsrc "code/custom/climbable_rope.asm"
endif
if !cv3InvertedGravity == 1
    incsrc "code/custom/inverted_gravity.asm"
endif
assert pc() <= $C000

org LAST_BANK+$1FCA
base $FFCA
; The setter preserves carry, including the request for native stair ascent.
cv3_player_call_controls:
    LDA.B r_PrgBank_8000
    PHA
    LDA.B #$A2
    JSR.W swapPRGbankStore
    JSR.W cv3_player_controls_update
    PLA
    JSR.W swapPRGbankStore
    RTS

if !cv3BetterStairs == 1 || !cv3ClimbableRope == 1
cv3_stair_read_record:
    LDA.B #$8E
    JSR.W swapPRGbankStore
    JSR.W cv3_stair_read_record_data
    LDA.B #$A2
    JMP.W swapPRGbankStore
endif
assert pc() <= $FFFA
