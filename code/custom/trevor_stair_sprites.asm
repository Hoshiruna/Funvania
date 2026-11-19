; SPDX-License-Identifier: MIT
; See LICENSE in this directory.

cv3_trevor_stair_chr_page = $94 ; CHR animation reserves $80-$93.

pushPC
org LAST_BANK+$354
base $E354
    JSR.W cv3_trevor_stair_chr           ;0FE354|20      |      ; replaces STA $5120
pullPC

; Use Trevor's alternate $0000 page for the two stair poses.
cv3_trevor_stair_chr:
    BNE cv3_trevor_stair_chr_write       ; A and Z come from LDA r_CHR_BankSpr_0000.
    PHP
    LDA.B r_gameState
    CMP.B #GS_IN_GAME
    BNE cv3_trevor_stair_chr_default
    LDA.W r_entity_spriteGroup
    BNE cv3_trevor_stair_chr_default
    LDA.W r_entity_spriteID
    CMP.B #$0A                          ; trevorSpr_stairDown_0A
    BEQ cv3_trevor_stair_chr_select
    CMP.B #$0C                          ; trevorSpr_stairUp_0C
    BNE cv3_trevor_stair_chr_default
cv3_trevor_stair_chr_select:
    LDA.B #cv3_trevor_stair_chr_page
    BNE cv3_trevor_stair_chr_restore
cv3_trevor_stair_chr_default:
    LDA.B r_CHR_BankSpr_0000
cv3_trevor_stair_chr_restore:
    PLP
cv3_trevor_stair_chr_write:
    STA.W CHR_BANK_0000
    RTS

pushPC
assert (cv3_trevor_stair_chr_page+1)*$400 <= ROM_CHRsize
org ROM_CHRstart+(cv3_trevor_stair_chr_page*$400)
    incbin "rom/Castlevania_3.nes":$40010..$400F0
    incbin "rom/Castlevania_3.nes":$400F0..$401B0 ; Stair pose tiles $0E-$19.
    incbin "rom/Castlevania_3.nes":$401B0..$40410
pullPC
