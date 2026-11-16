; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/inverted_gravity_7_01.asm for Funvania Asar.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

pushPC
org $3403D
base $803D
    JMP.W cv3_gravity_oam_next        ;0D803D|4C      |      ;
    NOP                              ;0D8040|EA      |      ;
pullPC

cv3_gravity_oam_next:
    LDA.B cv3_gravity_current_entity_index
    BNE cv3_gravity_oam_advance
    LDA.B cv3_gravity_game_state
    CMP.B #cv3_gravity_GAME_STATE_PLAYING
    BNE cv3_gravity_oam_advance
    LDA.W cv3_gravity_player_stair_alignment
    BPL cv3_gravity_oam_advance
    LDX.B cv3_gravity_frame_oam_offset
cv3_gravity_oam_loop:
    CPX.B cv3_gravity_current_oam_offset
    BEQ cv3_gravity_oam_advance
    LDA.W cv3_gravity_oam_buffer,X
    CMP.B #$F4
    BEQ cv3_gravity_oam_piece_done
    LDA.W cv3_gravity_player_y
    ASL A
    SEC
    SBC.W cv3_gravity_oam_buffer,X
    LDY.W cv3_gravity_current_character
    CPY.B #cv3_gravity_CHAR_GRANT
    BEQ cv3_gravity_oam_grant
    SEC
    SBC.B #$18
    JMP.W cv3_gravity_oam_store_y
cv3_gravity_oam_grant:
    SEC
    SBC.B #$14
cv3_gravity_oam_store_y:
    STA.W cv3_gravity_oam_buffer,X
    LDA.W cv3_gravity_oam_buffer+2,X
    EOR.B #$80
    STA.W cv3_gravity_oam_buffer+2,X
cv3_gravity_oam_piece_done:
    TXA
    CLC
    ADC.B #$C4
    TAX
    JMP.W cv3_gravity_oam_loop

cv3_gravity_oam_advance:
    INC.B cv3_gravity_current_entity_index
    JMP.W $801B

