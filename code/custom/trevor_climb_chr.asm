; SPDX-License-Identifier: MIT
; See LICENSE in this directory.

; CHR animation reserves $80-$93.
cv3_trevor_stair_chr_page = $94
cv3_trevor_rope_chr_page  = $95

pushPC
org LAST_BANK+$359
base $E359
    JMP.W cv3_trevor_climb_chr          ;0FE359|4CF2E0  |0FE0F2;

org LAST_BANK+$F2
base $E0F2
cv3_trevor_climb_chr:
    LDA.B r_gameState
    EOR.B #GS_IN_GAME
    ORA.W r_entity_spriteGroup          ; Trevor uses sprite group $00.
    BEQ cv3_trevor_climb_chr_playing
    JMP.W cv3_trevor_climb_chr_default
cv3_trevor_climb_chr_playing:
    JMP.W cv3_trevor_climb_chr_pose
assert pc() <= $E103
pullPC

cv3_trevor_climb_chr_pose:
    LDA.W r_entity_spriteID
if !cv3BetterStairs == 1
    EOR.B #$0A                          ; trevorSpr_stairDown_0A
    BEQ cv3_trevor_climb_chr_stair
    EOR.B #($0A^$0C)                    ; trevorSpr_stairUp_0C
    if !cv3ClimbableRope == 1
    BEQ cv3_trevor_climb_chr_stair
    else
    BNE cv3_trevor_climb_chr_default
    endif
endif
if !cv3ClimbableRope == 1
    AND.B #$FD                          ; Rope poses $70 and $72 differ by bit 1.
    if !cv3BetterStairs == 1
    EOR.B #($70^$0C)                    ; A already holds sprite ID XOR $0C.
    else
    EOR.B #$70
    endif
    BNE cv3_trevor_climb_chr_default
    LDA.B #cv3_trevor_rope_chr_page
    BNE cv3_trevor_climb_chr_write
endif
if !cv3BetterStairs == 1
cv3_trevor_climb_chr_stair:
    LDA.B r_CHR_BankSpr_0000
    BNE cv3_trevor_climb_chr_default
    LDA.B #cv3_trevor_stair_chr_page
    STA.W CHR_BANK_0000
endif
cv3_trevor_climb_chr_default:
    LDA.B r_CHR_BankSpr_0400
cv3_trevor_climb_chr_write:
    STA.W CHR_BANK_0400
    LDA.B r_CHR_BankSpr_0400            ; Keep the native return value and flags.
    RTS

pushPC
if !cv3BetterStairs == 1
    assert (cv3_trevor_stair_chr_page+1)*$400 <= ROM_CHRsize
    org ROM_CHRstart+(cv3_trevor_stair_chr_page*$400)
    incbin "rom/Castlevania_3.nes":$40010..$400F0
    incbin "rom/Castlevania_3.nes":$400F0..$401B0 ; Stair pose tiles $0E-$19.
    incbin "rom/Castlevania_3.nes":$401B0..$40410
endif
if !cv3ClimbableRope == 1
    assert (cv3_trevor_rope_chr_page+1)*$400 <= ROM_CHRsize
    cv3_trevor_rope_chr_start = ROM_CHRstart+(cv3_trevor_rope_chr_page*$400)
    ; Start with page $01 and replace the eight rope pairs in the copy.
    org cv3_trevor_rope_chr_start
    incbin "rom/Castlevania_3.nes":$40410..$40810
    org cv3_trevor_rope_chr_start+$0A0
    incbin "gfx/CHR/trevor_climb.chr":$00..$20
    org cv3_trevor_rope_chr_start+$300
    incbin "gfx/CHR/trevor_climb.chr":$20..$40
    org cv3_trevor_rope_chr_start+$320
    incbin "gfx/CHR/trevor_climb.chr":$40..$60
    org cv3_trevor_rope_chr_start+$200
    incbin "gfx/CHR/trevor_climb.chr":$60..$80
    org cv3_trevor_rope_chr_start+$240
    incbin "gfx/CHR/trevor_climb.chr":$80..$A0
    org cv3_trevor_rope_chr_start+$2A0
    incbin "gfx/CHR/trevor_climb.chr":$A0..$C0
    org cv3_trevor_rope_chr_start+$2C0
    incbin "gfx/CHR/trevor_climb.chr":$C0..$E0
    org cv3_trevor_rope_chr_start+$2E0
    incbin "gfx/CHR/trevor_climb.chr":$E0..$100
endif
pullPC
