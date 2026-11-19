  
  
    !clearOrginalScreens = 1
    !patchEditedCompressed = 1
    


    endDecompressStream = $FF







if !clearOrginalScreens == 1    ; clearCompressedScreens                      

;   org $079a6          ;0FEC8F|        |01B9A6; 18  name 79a6      !! free space bank 1    
;   base $b9a6                                                                         
;   pad $07c8c

;   org $0b570          ;0FEC77|        |0FEC9D; 00 title b570        !! free space in misc.asm                                             
;   base $b570                    
;   pad $b6ca                                        

; org $13ad4          ;0FEC8D|        |04BAD4; 16  prayer 13ad4   !! free space bank_04
; base $bad4                                                                         
; pad $13de9

org $17839          ;0FEC93|        |05B839; map 1c 17839
base $B839                                                                         
pad $179f9

org $179fa          ;0FEC87|        |05B9FA; 10 map 1 179fa
base $b9fa                                                              
pad $17a5b

org $17a5c          ;0FEC89|        |05BA5C; 12 map 2 17a5c
base $ba5c                                                                         
pad $17a67

org $17a68          ;0FEC85|        |05BA68; 0e map 0 17a68 
base $ba68                                                                           
pad $17bbb

org $17bbc          ;0FEC8B|        |05BBBC; 14 map 3 17bbc
base $bbbc                                                                           
pad $17bc0  

; org $2ba9a          ;0FEC9B|        |0ABA9A; 24 ending 2ba9a    !! free space ending text 
; base $BA9A                                                                         
; pad $2babf
; org $2bdfa          ;0FEC97|        |0ABDFA; 20 ending 2bdfa
; base $BDFA                                                                         
; pad $2bff3

; org $32ba8      ;0FEC83|        |0CABA8; 0c  map 32ba8      !! free space boss.asm
; base $aba8             
; pad $32d7b  
; org $32d7c          ;0FEC95|        |0CAD7C; 1e castle intro 32d7c
; base $AD7C                                                                         
; pad $32fae
; org $33327          ;0FEC91|        |0cB327; 1a PW 33327
; base $b327                                                                         
; pad $33674

; org $3d772          ;0FEC99|        |0FD772; 22 ending 3d772    !! free space used in text.asm 
; base $D772                                                                         
; pad $3d928

endif                                                                     

{   ; hijacks and bank managing                                   

org LAST_BANK+$3A         ; MMC5 init hijack and free space. 
base $E03A                          ;
    JSR.W initMMC5_settings     ;      
org LAST_BANK+$DF                   ;
base $E0DF                          ;
  goNewLoad_X_preserveAll:          
      PHA                            
      lda.w bank_80                        
      PHA                               
      LDA.B #$A0   
      JSR.W swapPRGbankStore            
      JSR.W newLoad_X_preserveAll                      
      PLA                               
      JSR.W swapPRGbankStore            
      PLA 
      RTS 

if !cv3ClimbCHR == 1
    assert pc() <= $E0F2            ; space for Trevor's CHR check
else
    assert pc() <= $E103
endif
pad LAST_BANK+$103                  


org $0214D
base $A14D  
  loadPointerScreenLoad:    ; fist map 
      dw RLE_tilemap_mapX1_07+2       ; loadMapJumk_00                    ;00A14D|        |05BA6A;
      dw RLE_tilemap_mapX4_0a+2       ; loadMapJumk_01                    ;00A14F|        |05BBBE;
      dw RLE_tilemap_mapX2_08+2       ; loadMapJumk_02                    ;00A151|        |05B9FC;
      dw RLE_tilemap_mapX3_09+2       ; loadMapJumk_03                    ;00A153|        |05BA5E;


org LAST_BANK+$C57
base $EC57
    jmp newStartRLE_decompLoad
org LAST_BANK+$BF7
base $EBF7  
    jsr newStartRLE_decompLoad

org LAST_BANK+$C04  
base $EC04    
  newScreenLoad:  
    lda.w correntBankIDX
    pha 
    lda #$A6          
    jsr swapPRGbank 
    jsr loadScreen_decomp
    pla 
    jmp swapPRGbank
  
  newStartRLE_decompLoad:     
    lda #$A6
    jsr swapPRGbank
    jsr start_RLE_decompLoad
    rts 


    initMMC5_settings: 
    LDA.B #$00                       
        STA.W $5010                      
        STA.W $5104                      
        LDA.B #$44                       
        STA.B r_updateNametable          
        STA.W $5105                      
        LDA.B #$00                       
        STA.W $5200                      
        STA.W $5106                      
        STA.W $5107                      
        LDY.B #$02                       
        STY.W $5100                      
        INY                              
        STY.W $5101                      
 
    lda #$02      ;enable write to RAM
    sta $5102
    
    lda #$01      ;enable write to RAM
    sta $5103

    lda #$00      ; swap sram banks ?? losing Page ??
    sta $5113

    RTS                          
 
 


if !cv3PlayerControls == 1
    incsrc "code/custom/player_controls_fixed.asm"
endif

if !cv3ClimbCHR == 1
    incsrc "code/custom/trevor_climb_chr.asm"
endif

assert pc() <= $ECDC    
pad LAST_BANK+$CDC    ; mark free space gained 


{  ; -- hijacks and moved routines all banks 

; org $0b6CA    ; hijack moved 2 data_misc.asm 
; base $b6CA  
;     cpx #$02
;     beq +
;     ldx #$22
;   + jmp newScreenLoad     ; loadScreen_decompress
;                   ; dw RLE_tilemap_01_titleScreen  !!screens loaded 
;                   ; dw RLE_tilemap_10_ending01      
; pad $B7E1

}

  
}

{   ; bank A6 screen decompress routine 
org $4c000
base $8000
db $A6 
      loadScreen_decomp: 
            LDA.W compressScreenTilemapPointerLo,X
            STA.B $00                           
            LDA.W compressScreenTilemapPointerLo+1,X
            STA.B $01                           
            JSR.W setPPU2_Load                  
            LDA.B #$00                          
            STA.B r_ScrollX                     
            STA.B r_ScrollY                     
  
      RLE_7f_setNewPointer: 
            LDA.W $2002                         
            LDY.B #$01                          
            LDA.B ($00),Y                       
            STA.W $2006                         
            DEY                                 
            LDA.B ($00),Y                       
            STA.W $2006                         
            LDX.B #$00                          
            LDA.B #$02                          
            JSR.W increasePointerOffset00_withA        
  
      start_RLE_decompLoad: 
            LDY.B #$00                        
            LDA.B ($00),Y                       
            CMP.B #$FF                          
            BEQ endRLE_decomp                   
            CMP.B #$7F                          
            BEQ RLE_7f_unrole                   
            TAY                                 
            BPL RLE_unrole_Plus                 
            AND.B #$7F                        
            STA.B $02                           
            LDY.B #$01                          
  
      RLE_unrol_Loop: 
            LDA.B ($00),Y                       
            STA.W $2007                         
            CPY.B $02                           
            BEQ CODE_0FEC4F                     
            INY                                 
            BNE RLE_unrol_Loop                  
  
      CODE_0FEC4F: 
            LDA.B #$01                         
            CLC                                 
            ADC.B $02                           
  
      CODE_0FEC54: 
            JSR.W increasePointerOffset00_withA       
            JMP.W start_RLE_decompLoad          
  
  
      RLE_unrole_Plus: 
            LDY.B #$01                         
            STA.B $02                           
            LDA.B ($00),Y                       
            LDY.B $02                           
  
      CODE_0FEC62: 
            STA.W $2007                        
            DEY                                 
            BNE CODE_0FEC62                     
            LDA.B #$02                          
            BNE CODE_0FEC54                     
  
      RLE_7f_unrole: 
            LDA.B #$01                       
            JSR.W increasePointerOffset00_withA        
            JMP.W RLE_7f_setNewPointer          
  
  
      endRLE_decomp: 
            JMP.W end_RLE_decompRoutine          
  
  
      compressScreenTilemapPointerLo: 
            dw RLE_tilemap_00_clearScreen        ;0FEC77|        |0FEC9D; 00
            dw RLE_tilemap_01_titleScreen        ;0FEC79|        |02B570; 02
            dw RLE_tilemap_00_clearScreen        ;0FEC7B|        |0FEC9D; 04
            dw RLE_tilemap_00_clearScreen        ;0FEC7D|        |0FEC9D; 06
            dw RLE_tilemap_00_clearScreen        ;0FEC7F|        |0FEC9D; 08
            dw RLE_tilemap_00_clearScreen        ;0FEC81|        |0FEC9D; 0A
            dw RLE_tilemap_map00_06              ;0FEC83|        |0CABA8; 0C
            dw RLE_tilemap_mapX1_07              ;0FEC85|        |05BA68; 0E
            dw RLE_tilemap_mapX2_08              ;0FEC87|        |05B9FA; 10
            dw RLE_tilemap_mapX3_09              ;0FEC89|        |05BA5C; 12
            dw RLE_tilemap_mapX4_0a              ;0FEC8B|        |05BBBC; 14
            dw RLE_tilemap_0b_prayerScreen       ;0FEC8D|        |04BAD4; 16
            dw RLE_tilemap_0c_nameScreen         ;0FEC8F|        |01B9A6; 18            
            dw RLE_tilemap_0d_PWscreen           ;0FEC91|        |0CB327; 1A            
            dw RLE_tilemap_mapX0_0e        ;0FEC93|        |05B839; 1C      
            dw RLE_tilemap_0f_castleIntro        ;0FEC95|        |0CAD7C; 1E            
            dw RLE_tilemap_10_ending00           ;0FEC97|        |0ABDFA; 20            
            dw RLE_tilemap_10_ending01           ;0FEC99|        |0FD772; 22 
            dw RLE_tilemap_10_ending02           ;0FEC9B|        |0ABA9A; 24

}

{     ; bank A6 screen RLE data 

  
  RLE_tilemap_00_clearScreen: 
if !patchEditedCompressed == 1      ; FIXME 
;     incbin "gfx/screens/ending/compressed/00_clearScreen.nam" 

            dw $2000                             ;0FEC9D|        |      ;
            db $78,$00,$78,$00,$78,$00,$78,$00   ;0FEC9F|        |      ;
            db $78,$00,$78,$00,$78,$00,$78,$00   ;0FECA7|        |      ;
            db $40,$00,$7F,$00,$24,$78,$00,$78   ;0FECAF|        |      ;
            db $00,$78,$00,$78,$00,$78,$00,$78   ;0FECB7|        |      ;
            db $00,$78,$00,$78,$00,$40,$00,$7F   ;0FECBF|        |      ;
            db $00,$28,$78,$00,$78,$00,$78,$00   ;0FECC7|        |      ;
            db $78,$00,$78,$00,$78,$00,$78,$00   ;0FECCF|        |      ;
            db $78,$00,$40,$00,$FF               ;0FECD7|        |      ;
            db endDecompressStream

else 

            dw $2000                             ;0FEC9D|        |      ;
            db $78,$00,$78,$00,$78,$00,$78,$00   ;0FEC9F|        |      ;
            db $78,$00,$78,$00,$78,$00,$78,$00   ;0FECA7|        |      ;
            db $40,$00,$7F,$00,$24,$78,$00,$78   ;0FECAF|        |      ;
            db $00,$78,$00,$78,$00,$78,$00,$78   ;0FECB7|        |      ;
            db $00,$78,$00,$78,$00,$40,$00,$7F   ;0FECBF|        |      ;
            db $00,$28,$78,$00,$78,$00,$78,$00   ;0FECC7|        |      ;
            db $78,$00,$78,$00,$78,$00,$78,$00   ;0FECCF|        |      ;
            db $78,$00,$40,$00,$FF               ;0FECD7|        |      ;
            db endDecompressStream

endif 
  
  RLE_tilemap_01_titleScreen:
      
if !patchEditedCompressed == 1      
      incbin "gfx/screens/title/compressed/01_titleScreen.nam"
else 

            dw $2000                             ;02B570|        |      ;
            db $6A,$00,$8B,$DE,$DF,$40,$41,$42   ;02B572|        |      ;
            db $43,$44,$45,$E0,$E1,$E2,$14,$00   ;02B57A|        |      ;
            db $8D,$ED,$EE,$EF,$50,$51,$52,$53   ;02B582|        |      ;
            db $54,$55,$F0,$F1,$F2,$DD,$13,$00   ;02B58A|        |      ;
            db $82,$FD,$FE,$20,$00,$82,$68,$69   ;02B592|        |      ;
            db $1E,$00,$8A,$46,$47,$48,$49,$4A   ;02B59A|        |      ;
            db $4B,$4C,$4D,$4E,$4F,$16,$00,$8A   ;02B5A2|        |      ;
            db $56,$57,$58,$59,$5A,$5B,$5C,$5D   ;02B5AA|        |      ;
            db $5E,$5F,$16,$00,$8A,$66,$67,$00   ;02B5B2|        |      ;
            db $00,$6A,$00,$00,$6D,$6E,$6F,$17   ;02B5BA|        |      ;
            db $00,$81,$61,$1B,$00,$90,$70,$71   ;02B5C2|        |      ;
            db $72,$73,$74,$75,$76,$77,$78,$79   ;02B5CA|        |      ;
            db $7A,$7B,$7C,$7D,$7E,$7F,$10,$00   ;02B5D2|        |      ;
            db $90,$80,$81,$82,$83,$84,$85,$86   ;02B5DA|        |      ;
            db $87,$88,$89,$8A,$8B,$8C,$8D,$8E   ;02B5E2|        |      ;
            db $8F,$10,$00,$90,$90,$91,$92,$93   ;02B5EA|        |      ;
            db $94,$95,$96,$97,$98,$99,$9A,$9B   ;02B5F2|        |      ;
            db $9C,$9D,$9E,$9F,$10,$00,$90,$A0   ;02B5FA|        |      ;
            db $A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8   ;02B602|        |      ;
            db $A9,$AA,$AB,$AC,$AD,$AE,$AF,$10   ;02B60A|        |      ;
            db $00,$8E,$B0,$B1,$00,$B3,$B4,$B5   ;02B612|        |      ;
            db $B6,$B7,$B8,$B9,$BA,$BB,$BC,$FC   ;02B61A|        |      ;
            db $15,$00,$8A,$C3,$C4,$C5,$C6,$C7   ;02B622|        |      ;
            db $C8,$C9,$CA,$CB,$CC,$16,$00,$8A   ;02B62A|        |      ;
            db $D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA   ;02B632|        |      ;
            db $DB,$DC,$16,$00,$8A,$E3,$E4,$E5   ;02B63A|        |      ;
            db $E6,$E7,$E8,$E9,$EA,$EB,$EC,$16   ;02B642|        |      ;
            db $00,$83,$F3,$F4,$F5,$1B,$00,$8D   ;02B64A|        |      ;
            db $23,$1C,$00,$10,$1D,$13,$00,$37   ;02B652|        |      ;
            db $00,$02,$0A,$0A,$01,$0E,$00,$98   ;02B65A|        |      ;
            db $1A,$1E,$1D,$10,$1C,$18,$00,$18   ;02B662|        |      ;
            db $1D,$13,$24,$22,$23,$21,$28,$00   ;02B66A|        |      ;
            db $12,$1E,$0B,$38,$1B,$23,$13,$0B   ;02B672|        |      ;
            db $0E,$00,$8B,$1B,$18,$12,$14,$1D   ;02B67A|        |      ;
            db $22,$14,$13,$00,$11,$28,$0F,$00   ;02B682|        |      ;
            db $98,$1D,$18,$1D,$23,$14,$1D,$13   ;02B68A|        |      ;
            db $1E,$00,$1E,$15,$00,$10,$1C,$14   ;02B692|        |      ;
            db $21,$18,$12,$10,$00,$18,$1D,$12   ;02B69A|        |      ;
            db $0B,$7E,$00,$48,$00,$03,$F0,$81   ;02B6A2|        |      ;
            db $30,$04,$00,$84,$0F,$4F,$9F,$23   ;02B6AA|        |      ;
            db $04,$00,$84,$50,$04,$89,$52,$04   ;02B6B2|        |      ;
            db $00,$84,$55,$22,$88,$55,$04,$00   ;02B6BA|        |      ;
            db $84,$44,$22,$88,$11,$1A,$00,$FF   ;02B6C2|        |      ;
            db endDecompressStream
endif 

    
  RLE_tilemap_map00_06:

if !patchEditedCompressed == 1  
      incbin "gfx/screens/map/compressed/06_map00.nam"  
else

            dw $2000                             ;0CABA8|        |      ;
            db $7E,$00,$05,$00,$99,$F0,$01,$02   ;0CABAA|        |      ;
            db $03,$04,$05,$06,$07,$08,$46,$0A   ;0CABB2|        |      ;
            db $0B,$0C,$0D,$0E,$0F,$09,$0A,$29   ;0CABBA|        |      ;
            db $05,$06,$06,$19,$07,$1A,$07,$00   ;0CABC2|        |      ;
            db $99,$10,$11,$12,$13,$14,$15,$16   ;0CABCA|        |      ;
            db $17,$18,$AC,$CB,$1B,$1C,$1D,$1E   ;0CABD2|        |      ;
            db $1F,$9B,$CC,$CC,$9B,$9B,$CB,$CB   ;0CABDA|        |      ;
            db $8B,$2A,$07,$00,$93,$20,$21,$22   ;0CABE2|        |      ;
            db $23,$24,$25,$26,$27,$28,$9B,$9B   ;0CABEA|        |      ;
            db $2B,$2C,$2D,$2E,$2F,$9B,$9B,$AC   ;0CABF2|        |      ;
            db $04,$CB,$82,$7B,$CF,$07,$00,$92   ;0CABFA|        |      ;
            db $30,$31,$32,$33,$34,$35,$36,$37   ;0CAC02|        |      ;
            db $AC,$9B,$9B,$3B,$3C,$3D,$3E,$3F   ;0CAC0A|        |      ;
            db $9B,$CC,$03,$9B,$84,$CC,$9B,$8B   ;0CAC12|        |      ;
            db $8C,$07,$00,$91,$40,$41,$42,$43   ;0CAC1A|        |      ;
            db $44,$45,$46,$47,$48,$49,$4A,$4B   ;0CAC22|        |      ;
            db $4C,$4D,$4E,$4F,$AC,$03,$CB,$85   ;0CAC2A|        |      ;
            db $AC,$CB,$9B,$8B,$9C,$07,$00,$99   ;0CAC32|        |      ;
            db $50,$51,$52,$53,$54,$28,$D1,$57   ;0CAC3A|        |      ;
            db $58,$59,$5A,$5B,$5C,$5D,$5E,$5F   ;0CAC42|        |      ;
            db $85,$86,$CC,$88,$89,$9B,$CB,$CC   ;0CAC4A|        |      ;
            db $DF,$07,$00,$9A,$60,$51,$62,$63   ;0CAC52|        |      ;
            db $64,$65,$66,$67,$68,$69,$6A,$6B   ;0CAC5A|        |      ;
            db $6C,$6D,$6E,$6F,$95,$96,$97,$98   ;0CAC62|        |      ;
            db $99,$CB,$9B,$8B,$00,$9D,$06,$00   ;0CAC6A|        |      ;
            db $99,$70,$51,$60,$73,$5A,$74,$5A   ;0CAC72|        |      ;
            db $77,$78,$79,$7A,$B1,$7C,$7D,$7E   ;0CAC7A|        |      ;
            db $7F,$A5,$A6,$A7,$A8,$B9,$CB,$9B   ;0CAC82|        |      ;
            db $7B,$AD,$07,$00,$99,$51,$62,$72   ;0CAC8A|        |      ;
            db $62,$51,$84,$69,$6A,$00,$00,$8A   ;0CAC92|        |      ;
            db $AC,$CB,$8D,$8E,$8F,$B5,$B6,$B7   ;0CAC9A|        |      ;
            db $B8,$B9,$9B,$8B,$EF,$9C,$07,$00   ;0CACA2|        |      ;
            db $8F,$59,$81,$82,$83,$61,$00,$80   ;0CACAA|        |      ;
            db $B5,$B1,$7C,$9A,$CC,$9B,$AC,$9B   ;0CACB2|        |      ;
            db $03,$CC,$88,$B1,$D9,$DA,$7B,$DF   ;0CACBA|        |      ;
            db $AB,$EF,$CF,$06,$00,$99,$51,$51   ;0CACC2|        |      ;
            db $60,$5A,$81,$90,$51,$94,$CB,$CB   ;0CACCA|        |      ;
            db $CC,$9B,$CB,$9B,$CB,$9B,$9B,$8B   ;0CACD2|        |      ;
            db $A9,$AA,$AB,$AB,$EF,$EF,$9E,$07   ;0CACDA|        |      ;
            db $00,$99,$61,$90,$81,$69,$51,$60   ;0CACE2|        |      ;
            db $81,$60,$94,$CB,$CC,$CC,$9B,$CC   ;0CACEA|        |      ;
            db $CB,$7B,$DF,$EF,$AB,$BA,$BB,$BC   ;0CACF2|        |      ;
            db $BD,$EF,$AE,$07,$00,$9A,$8E,$91   ;0CACFA|        |      ;
            db $92,$93,$83,$81,$51,$60,$3C,$D0   ;0CAD02|        |      ;
            db $CC,$9B,$AC,$9B,$9B,$C6,$C7,$C8   ;0CAD0A|        |      ;
            db $C9,$CA,$E4,$7E,$CD,$CE,$AB,$CF   ;0CAD12|        |      ;
            db $06,$00,$9A,$A0,$A1,$A2,$A3,$A4   ;0CAD1A|        |      ;
            db $A6,$90,$71,$71,$7D,$D1,$CC,$9B   ;0CAD22|        |      ;
            db $CC,$7B,$D6,$D7,$D8,$EF,$AB,$DB   ;0CAD2A|        |      ;
            db $DC,$DD,$DE,$AB,$9F,$06,$00,$9A   ;0CAD32|        |      ;
            db $B0,$CC,$CB,$9B,$B4,$B3,$18,$18   ;0CAD3A|        |      ;
            db $36,$E0,$E1,$E2,$E3,$E4,$E5,$E6   ;0CAD42|        |      ;
            db $E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE   ;0CAD4A|        |      ;
            db $DF,$AF,$06,$00,$9A,$C0,$C1,$C2   ;0CAD52|        |      ;
            db $C3,$B3,$18,$B5,$E0,$7B,$F6,$F1   ;0CAD5A|        |      ;
            db $E5,$F3,$F4,$F5,$F6,$F7,$F8,$F9   ;0CAD62|        |      ;
            db $FA,$FB,$FC,$FD,$FE,$BE,$BF,$7E   ;0CAD6A|        |      ;
            db $00,$7E,$00,$47,$00,$38,$55,$08   ;0CAD72|        |      ;
            db $05,$FF                           ;0CAD7A|        |      ;
            db endDecompressStream

endif 


  RLE_tilemap_mapX1_07:   

if !patchEditedCompressed == 1      
      incbin "gfx/screens/mapCastle/compressed/07_mapCastleTop.nam"   
else    
            dw $2240                             ;05BA68|        |      ;
      loadMapJumk_00:       
            db $03,$00,$9A,$10,$B0,$B1,$B2,$B0   ;05BA6A|        |      ;
            db $B3,$B1,$B4,$B3,$B1,$B1,$B3,$B1   ;05BA72|        |      ;
            db $B4,$07,$08,$09,$B0,$02,$B1,$B3   ;05BA7A|        |      ;
            db $B2,$B1,$B4,$B3,$0E,$06,$00,$82   ;05BA82|        |      ;
            db $20,$B0,$06,$02,$92,$82,$83,$84   ;05BA8A|        |      ;
            db $87,$02,$16,$17,$18,$19,$82,$83   ;05BA92|        |      ;
            db $84,$02,$02,$0B,$0C,$0D,$1E,$06   ;05BA9A|        |      ;
            db $00,$81,$91,$07,$02,$92,$92,$C0   ;05BAA2|        |      ;
            db $C1,$C2,$95,$26,$27,$A9,$C4,$C5   ;05BAAA|        |      ;
            db $C6,$C7,$8D,$1A,$1B,$00,$1D,$2E   ;05BAB2|        |      ;
            db $06,$00,$81,$81,$03,$02,$81,$FA   ;05BABA|        |      ;
            db $03,$02,$92,$A2,$D0,$D6,$D2,$D4   ;05BAC2|        |      ;
            db $36,$37,$00,$D4,$D5,$D6,$D7,$E9   ;05BACA|        |      ;
            db $EA,$00,$2C,$2D,$3E,$06,$00,$9A   ;05BAD2|        |      ;
            db $80,$95,$FA,$FB,$00,$28,$1C,$02   ;05BADA|        |      ;
            db $02,$93,$94,$00,$F8,$E9,$E9,$00   ;05BAE2|        |      ;
            db $D4,$A4,$00,$E6,$E6,$F8,$EA,$2C   ;05BAEA|        |      ;
            db $2D,$3E,$06,$00,$9A,$90,$8F,$12   ;05BAF2|        |      ;
            db $1F,$7D,$2B,$A7,$39,$02,$02,$A3   ;05BAFA|        |      ;
            db $A4,$A5,$D3,$F8,$E9,$D4,$02,$38   ;05BB02|        |      ;
            db $00,$2A,$38,$F0,$00,$2D,$1E,$06   ;05BB0A|        |      ;
            db $00,$8A,$A0,$02,$8E,$40,$39,$39   ;05BB12|        |      ;
            db $87,$8E,$39,$1C,$03,$02,$8D,$93   ;05BB1A|        |      ;
            db $00,$00,$2A,$02,$88,$00,$3A,$3B   ;05BB22|        |      ;
            db $F0,$00,$3D,$2E,$06,$00,$81,$A1   ;05BB2A|        |      ;
            db $04,$02,$86,$B6,$02,$86,$87,$12   ;05BB32|        |      ;
            db $39,$03,$02,$8C,$00,$00,$8D,$06   ;05BB3A|        |      ;
            db $AB,$8A,$00,$00,$ED,$F8,$A8,$0F   ;05BB42|        |      ;
            db $06,$00,$89,$30,$02,$02,$FB,$11   ;05BB4A|        |      ;
            db $B5,$B7,$96,$97,$05,$02,$86,$3C   ;05BB52|        |      ;
            db $00,$00,$8A,$00,$00,$03,$CE,$83   ;05BB5A|        |      ;
            db $DE,$00,$0F,$06,$00,$8A,$30,$02   ;05BB62|        |      ;
            db $06,$BF,$21,$89,$00,$A6,$00,$98   ;05BB6A|        |      ;
            db $03,$02,$82,$8B,$8C,$05,$00,$81   ;05BB72|        |      ;
            db $DE,$04,$00,$81,$90,$06,$00,$90   ;05BB7A|        |      ;
            db $A1,$99,$0A,$00,$31,$E9,$E9,$DC   ;05BB82|        |      ;
            db $DD,$A8,$8E,$99,$9A,$9B,$9C,$9D   ;05BB8A|        |      ;
            db $03,$00,$83,$E1,$C6,$C7,$03,$00   ;05BB92|        |      ;
            db $81,$90,$06,$00,$96,$80,$AB,$A9   ;05BB9A|        |      ;
            db $E8,$EA,$EB,$EB,$EC,$ED,$00,$36   ;05BBA2|        |      ;
            db $A9,$AA,$AB,$AC,$00,$E9,$F5,$F5   ;05BBAA|        |      ;
            db $F1,$D6,$D7,$03,$00,$81,$80,$03   ;05BBB2|        |      ;
            db $00,$FF                           ;05BBBA|        |      ;
            db endDecompressStream

endif 

  
  RLE_tilemap_mapX2_08: 

if !patchEditedCompressed == 1      
      incbin "gfx/screens/mapCastle/compressed/08_mapCastleMid.nam"   
else 
            dw $2C00                             ;05B9FA|        |      ;
      loadMapJumk_02:       
            db $03,$00,$85,$90,$F7,$F5,$E6,$F8   ;05B9FC|        |      ;
            db $03,$00,$8D,$ED,$EE,$C6,$C7,$8A   ;05BA04|        |      ;
            db $A9,$00,$00,$E9,$EA,$00,$00,$08   ;05BA0C|        |      ;
            db $04,$00,$81,$90,$06,$00,$81,$A0   ;05BA14|        |      ;
            db $07,$00,$8A,$FD,$FE,$D6,$D7,$00   ;05BA1C|        |      ;
            db $00,$E8,$EA,$E6,$F8,$07,$00,$81   ;05BA24|        |      ;
            db $90,$06,$00,$82,$30,$93,$0A,$00   ;05BA2C|        |      ;
            db $04,$E6,$04,$00,$86,$85,$12,$00   ;05BA34|        |      ;
            db $DB,$00,$90,$06,$00,$86,$91,$02   ;05BA3C|        |      ;
            db $12,$03,$07,$94,$03,$00,$83,$E1   ;05BA44|        |      ;
            db $C6,$C7,$06,$00,$88,$A5,$00,$75   ;05BA4C|        |      ;
            db $66,$62,$CD,$A4,$80,$03,$00,$FF   ;05BA54|        |      ;
            db endDecompressStream

endif 
  

  RLE_tilemap_mapX3_09: 

if !patchEditedCompressed == 0      ; attrib
      incbin "gfx/screens/mapCastle/compressed/09_mapX3.nam" 
else 
            dw $2FC0                             ;05BA5C|        |      ;
    loadMapJumk_03:       
            db $88,$80,$A0,$20,$00,$00,$A0,$A0   ;05BA5E|        |      ;
            db $AA,$FF                           ;05BA66|        |      ;
            db endDecompressStream
endif 


  RLE_tilemap_mapX4_0a: 

if !patchEditedCompressed == 1      ; attrib
        incbin "gfx/screens/mapCastle/compressed/0a_mapX4.nam" 
else 
            dw $23C0                             ;05BBBC|        |      ;
    loadMapJumk_01:       
            db $18,$00,$FF                       ;05BBBE|        |      ;
            db endDecompressStream  
endif 

    
  RLE_tilemap_0b_prayerScreen:

if !patchEditedCompressed == 1  
      incbin "gfx/screens/prayer/compressed/0b_prayerScreen.nam" 
else 
            dw $2000                             ;04BAD4|        |      ;
            db $40,$00,$06,$3D,$81,$54,$07,$00   ;04BAD6|        |      ;
            db $84,$47,$6B,$68,$6D,$09,$00,$0B   ;04BADE|        |      ;
            db $3D,$84,$00,$00,$47,$67,$04,$00   ;04BAE6|        |      ;
            db $8E,$42,$43,$44,$45,$60,$00,$47   ;04BAEE|        |      ;
            db $89,$44,$6D,$00,$00,$00,$B5,$06   ;04BAF6|        |      ;
            db $3D,$96,$54,$00,$64,$63,$00,$00   ;04BAFE|        |      ;
            db $67,$68,$A8,$AB,$00,$A8,$52,$53   ;04BB06|        |      ;
            db $53,$55,$56,$60,$6A,$6B,$6A,$2A   ;04BB0E|        |      ;
            db $04,$00,$04,$3D,$04,$00,$9E,$3D   ;04BB16|        |      ;
            db $54,$60,$47,$6A,$AF,$AA,$A8,$26   ;04BB1E|        |      ;
            db $61,$62,$00,$00,$65,$66,$3D,$68   ;04BB26|        |      ;
            db $6A,$68,$6C,$60,$00,$00,$00,$B5   ;04BB2E|        |      ;
            db $3D,$3D,$3D,$63,$64,$04,$00,$88   ;04BB36|        |      ;
            db $3D,$68,$6B,$6D,$AA,$AB,$A8,$71   ;04BB3E|        |      ;
            db $04,$00,$88,$76,$3D,$3D,$2A,$3D   ;04BB46|        |      ;
            db $6B,$68,$6D,$06,$00,$82,$3D,$70   ;04BB4E|        |      ;
            db $04,$00,$88,$42,$43,$44,$45,$AB   ;04BB56|        |      ;
            db $77,$AB,$48,$04,$00,$D4,$49,$3D   ;04BB5E|        |      ;
            db $6C,$8A,$42,$43,$44,$45,$00,$00   ;04BB66|        |      ;
            db $63,$64,$63,$64,$3D,$70,$00,$00   ;04BB6E|        |      ;
            db $00,$A8,$52,$53,$53,$55,$56,$60   ;04BB76|        |      ;
            db $3D,$71,$01,$02,$03,$00,$69,$3D   ;04BB7E|        |      ;
            db $00,$A8,$52,$53,$53,$55,$56,$60   ;04BB86|        |      ;
            db $3D,$70,$3D,$70,$3D,$70,$00,$00   ;04BB8E|        |      ;
            db $26,$61,$62,$00,$00,$65,$66,$3D   ;04BB96|        |      ;
            db $3D,$10,$11,$12,$13,$14,$15,$3D   ;04BB9E|        |      ;
            db $26,$61,$62,$00,$00,$65,$66,$3D   ;04BBA6|        |      ;
            db $B5,$70,$3D,$70,$B5,$70,$00,$00   ;04BBAE|        |      ;
            db $A8,$71,$04,$00,$8C,$76,$3D,$3D   ;04BBB6|        |      ;
            db $20,$21,$22,$23,$24,$25,$3D,$A8   ;04BBBE|        |      ;
            db $71,$04,$00,$83,$76,$3D,$60,$06   ;04BBC6|        |      ;
            db $00,$83,$26,$AA,$48,$04,$00,$8C   ;04BBCE|        |      ;
            db $49,$3D,$3D,$30,$31,$32,$33,$34   ;04BBD6|        |      ;
            db $35,$3D,$AA,$48,$04,$00,$84,$49   ;04BBDE|        |      ;
            db $3D,$6C,$6D,$06,$00,$82,$A9,$58   ;04BBE6|        |      ;
            db $04,$00,$8C,$59,$67,$3D,$06,$07   ;04BBEE|        |      ;
            db $08,$09,$0A,$0B,$3D,$A9,$58,$04   ;04BBF6|        |      ;
            db $00,$85,$59,$67,$6B,$8A,$60,$04   ;04BBFE|        |      ;
            db $00,$83,$26,$3D,$71,$04,$00,$8C   ;04BC06|        |      ;
            db $69,$59,$3D,$16,$17,$18,$19,$1A   ;04BC0E|        |      ;
            db $1B,$3D,$3D,$71,$04,$00,$8C,$69   ;04BC16|        |      ;
            db $59,$68,$6A,$6C,$6D,$00,$00,$00   ;04BC1E|        |      ;
            db $47,$3D,$58,$04,$00,$8C,$49,$3D   ;04BC26|        |      ;
            db $3D,$71,$27,$28,$29,$00,$49,$3D   ;04BC2E|        |      ;
            db $3D,$58,$04,$00,$FE,$49,$3D,$6D   ;04BC36|        |      ;
            db $68,$6B,$8A,$00,$00,$64,$77,$AA   ;04BC3E|        |      ;
            db $36,$AF,$A9,$AF,$A8,$79,$59,$6C   ;04BC46|        |      ;
            db $36,$37,$38,$39,$37,$79,$3D,$AA   ;04BC4E|        |      ;
            db $36,$AF,$A9,$AF,$A9,$79,$59,$69   ;04BC56|        |      ;
            db $6B,$68,$6A,$AB,$6D,$2A,$6C,$A9   ;04BC5E|        |      ;
            db $6C,$6C,$3D,$AB,$6C,$6C,$3D,$2A   ;04BC66|        |      ;
            db $3D,$3D,$1C,$1D,$7A,$78,$3D,$AB   ;04BC6E|        |      ;
            db $6D,$2A,$77,$AB,$3D,$3D,$89,$2A   ;04BC76|        |      ;
            db $6C,$6C,$68,$67,$6B,$6A,$6B,$6C   ;04BC7E|        |      ;
            db $00,$00,$00,$6C,$77,$6D,$67,$6C   ;04BC86|        |      ;
            db $2C,$2D,$2E,$2E,$2F,$B5,$89,$67   ;04BC8E|        |      ;
            db $6B,$6A,$6B,$8A,$78,$3D,$3D,$6C   ;04BC96|        |      ;
            db $2A,$77,$2A,$75,$A9,$A9,$A8,$AF   ;04BC9E|        |      ;
            db $A8,$AF,$A8,$A8,$A9,$75,$75,$73   ;04BCA6|        |      ;
            db $74,$73,$74,$75,$73,$73,$74,$75   ;04BCAE|        |      ;
            db $75,$73,$74,$92,$75,$73,$A9,$AA   ;04BCB6|        |      ;
            db $AF,$A8,$AF,$A8,$B1,$72,$72,$AF   ;04BCBE|        |      ;
            db $AA,$AA,$AA,$72,$AF,$B1,$09,$72   ;04BCC6|        |      ;
            db $81,$B1,$05,$72,$8F,$B1,$72,$B1   ;04BCCE|        |      ;
            db $AF,$AA,$AA,$AF,$67,$77,$3D,$3D   ;04BCD6|        |      ;
            db $AB,$AF,$AB,$89,$05,$3D,$83,$78   ;04BCDE|        |      ;
            db $77,$77,$04,$3D,$84,$77,$77,$7A   ;04BCE6|        |      ;
            db $78,$04,$3D,$FE,$77,$A9,$AB,$78   ;04BCEE|        |      ;
            db $68,$6B,$8A,$6C,$89,$91,$92,$3D   ;04BCF6|        |      ;
            db $3D,$91,$92,$77,$7A,$7A,$77,$7A   ;04BCFE|        |      ;
            db $77,$78,$89,$3D,$3D,$91,$92,$3D   ;04BD06|        |      ;
            db $3D,$91,$92,$77,$89,$91,$92,$77   ;04BD0E|        |      ;
            db $4E,$4B,$4E,$4F,$3D,$00,$00,$3D   ;04BD16|        |      ;
            db $3D,$00,$00,$59,$0C,$0E,$0E,$0F   ;04BD1E|        |      ;
            db $0E,$0E,$0F,$0D,$3D,$00,$00,$3D   ;04BD26|        |      ;
            db $3D,$00,$00,$67,$4A,$4E,$4B,$4B   ;04BD2E|        |      ;
            db $5B,$8D,$5E,$5F,$3D,$8E,$8E,$3D   ;04BD36|        |      ;
            db $3D,$8E,$8E,$7A,$8C,$1E,$78,$78   ;04BD3E|        |      ;
            db $77,$7A,$1F,$00,$77,$8E,$8E,$3D   ;04BD46|        |      ;
            db $3D,$8E,$8E,$77,$5A,$6F,$5B,$5E   ;04BD4E|        |      ;
            db $4B,$4B,$4E,$4B,$4E,$4F,$AA,$A9   ;04BD56|        |      ;
            db $AF,$AA,$77,$8C,$3B,$3C,$3B,$3C   ;04BD5E|        |      ;
            db $3B,$3C,$3B,$3C,$6C,$78,$A9,$6C   ;04BD66|        |      ;
            db $4A,$4E,$C6,$4B,$4E,$4B,$4B,$4E   ;04BD6E|        |      ;
            db $4E,$5B,$5E,$6F,$5E,$5E,$5F,$AB   ;04BD76|        |      ;
            db $78,$77,$AB,$6C,$3C,$3C,$3B,$3C   ;04BD7E|        |      ;
            db $3C,$3C,$3B,$3C,$3C,$3B,$B5,$6C   ;04BD86|        |      ;
            db $00,$5A,$6F,$5B,$6F,$5B,$5E,$8D   ;04BD8E|        |      ;
            db $5B,$7E,$7F,$7E,$7F,$7E,$7F,$7E   ;04BD96|        |      ;
            db $7F,$7E,$7F,$7E,$7F,$7E,$7F,$7E   ;04BD9E|        |      ;
            db $7F,$7E,$7F,$7E,$7F,$7E,$7F,$7E   ;04BDA6|        |      ;
            db $7F,$7E,$7F,$7E,$7F,$7E,$7F,$7E   ;04BDAE|        |      ;
            db $7F,$60,$00,$82,$FF,$FF,$04,$5F   ;04BDB6|        |      ;
            db $84,$DF,$FF,$FF,$57,$04,$55,$8F   ;04BDBE|        |      ;
            db $5D,$FF,$7F,$55,$55,$AA,$AA,$55   ;04BDC6|        |      ;
            db $55,$5F,$55,$55,$55,$9A,$6A,$06   ;04BDCE|        |      ;
            db $55,$82,$59,$56,$06,$55,$8B,$A5   ;04BDD6|        |      ;
            db $A5,$55,$55,$55,$05,$05,$09,$0A   ;04BDDE|        |      ;
            db $0A,$06,$0A,$05                   ;04BDE6|        |      ;
            db endDecompressStream

endif 


  RLE_tilemap_0c_nameScreen: 

if !patchEditedCompressed == 1  
      incbin "gfx/screens/name/compressed/0c_nameScreen.nam"
else 
            dw $2000                             ;01B9A6|        |      ;
            db $8E,$F6,$F7,$F6,$F7,$F6,$F7,$F6   ;01B9A8|        |      ;
            db $F7,$F6,$F7,$F6,$F7,$F6,$F7,$06   ;01B9B0|        |      ;
            db $00,$99,$F6,$F7,$F6,$F7,$F6,$F7   ;01B9B8|        |      ;
            db $F6,$F7,$F6,$F7,$F6,$ED,$F6,$F6   ;01B9C0|        |      ;
            db $F7,$F6,$F7,$F6,$F7,$F6,$F7,$F6   ;01B9C8|        |      ;
            db $F7,$F6,$F7,$08,$00,$93,$F6,$F7   ;01B9D0|        |      ;
            db $F6,$F7,$F6,$F7,$EB,$EC,$F6,$F7   ;01B9D8|        |      ;
            db $F6,$F6,$F7,$F6,$F7,$F6,$F7,$F6   ;01B9E0|        |      ;
            db $F7,$14,$00,$8B,$FC,$F7,$F6,$F7   ;01B9E8|        |      ;
            db $F7,$F6,$F7,$F6,$F7,$F6,$F7,$14   ;01B9F0|        |      ;
            db $00,$9C,$F6,$F7,$FD,$F7,$F6,$F6   ;01B9F8|        |      ;
            db $F7,$F6,$F7,$FD,$F7,$00,$00,$54   ;01BA00|        |      ;
            db $5D,$63,$54,$61,$00,$68,$5E,$64   ;01BA08|        |      ;
            db $61,$00,$5D,$50,$5C,$54,$05,$00   ;01BA10|        |      ;
            db $89,$F6,$F7,$F6,$F7,$F7,$F6,$F7   ;01BA18|        |      ;
            db $F6,$F7,$16,$00,$8D,$F6,$F7,$F6   ;01BA20|        |      ;
            db $F7,$FD,$F6,$F7,$FD,$ED,$F6,$F7   ;01BA28|        |      ;
            db $F6,$F7,$03,$00,$81,$80,$08,$81   ;01BA30|        |      ;
            db $81,$82,$03,$00,$8F,$F6,$F7,$F6   ;01BA38|        |      ;
            db $F7,$FD,$F7,$F6,$F7,$ED,$F6,$ED   ;01BA40|        |      ;
            db $F6,$F7,$F6,$F7,$04,$00,$81,$90   ;01BA48|        |      ;
            db $08,$00,$81,$92,$04,$00,$8F,$F6   ;01BA50|        |      ;
            db $F7,$F6,$F7,$FD,$F7,$FD,$F6,$ED   ;01BA58|        |      ;
            db $F6,$ED,$F6,$F7,$FD,$F7,$03,$00   ;01BA60|        |      ;
            db $81,$A0,$08,$A1,$81,$A2,$07,$00   ;01BA68|        |      ;
            db $8B,$F6,$F7,$EB,$ED,$ED,$F6       ;01BA70|        |      ;
            db $F7,$F6,$ED,$F6,$F7               ;01BA77|        |      ;
            db $14,$00,$8B,$F6,$F7,$F6,$FB,$FC   ;01BA7C|        |      ;
            db $F6,$F7,$FD,$F7,$FD,$F7,$16,$00   ;01BA84|        |      ;
            db $89,$F6,$F7,$FD,$F7,$FB,$FD,$ED   ;01BA8C|        |      ;
            db $F6,$F7,$14,$00,$8D,$F6,$F7,$F6   ;01BA94|        |      ;
            db $ED,$F6,$F7,$FD,$F6,$ED,$EB,$EC   ;01BA9C|        |      ;
            db $FD,$F7,$12,$00,$8F,$F6,$ED,$F6   ;01BAA4|        |      ;
            db $ED,$FD,$F7,$EB,$EC,$F7,$FB,$FB   ;01BAAC|        |      ;
            db $FC,$F7,$F6,$F7,$10,$00,$84,$F6   ;01BAB4|        |      ;
            db $F7,$F6,$F7,$03,$F6,$C8,$FB,$FC   ;01BABC|        |      ;
            db $F6,$F7,$FD,$F7,$CB,$CC,$CD,$CE   ;01BAC4|        |      ;
            db $CD,$CE,$CD,$CE,$CD,$CE,$CD,$CE   ;01BACC|        |      ;
            db $CD,$CE,$CD,$CE,$CD,$CE,$CD,$CE   ;01BAD4|        |      ;
            db $CD                               ;01BADC|        |      ; 
            db $CE,$CB,$CC,$F6,$ED,$F6,$ED,$ED   ;01BADD|        |      ;
            db $F6,$ED,$FD,$DB,$DC,$DD,$DE,$DD   ;01BAE5|        |      ;
            db $DE,$DD,$DE,$DD,$DE,$DD,$DE,$DD   ;01BAED|        |      ;
            db $DE,$DD,$DE,$DD,$DE,$DD,$DE,$DD   ;01BAF5|        |      ;
            db $DE,$DB,$DC,$ED,$F6,$F7,$F6,$F6   ;01BAFD|        |      ;
            db $EC,$EB,$F7,$C0,$C1,$14,$00,$AC   ;01BB05|        |      ;
            db $C4,$C5,$F6,$F7,$EB,$EC,$FB,$FC   ;01BB0D|        |      ;
            db $FB,$FC,$D0,$D1,$00,$50,$00,$51   ;01BB15|        |      ;
            db $00,$52,$00,$53,$00,$54,$00,$55   ;01BB1D|        |      ;
            db $00,$56,$00,$57,$00,$58,$00,$00   ;01BB25|        |      ;
            db $D4,$D5,$F7,$EB,$FB,$FC,$EB,$EC   ;01BB2D|        |      ;
            db $EB,$FC,$E0,$E1,$14,$00,$AC,$E4   ;01BB35|        |      ;
            db $E5,$EB,$EC,$EB,$F7,$FB,$FC,$FB   ;01BB3D|        |      ;
            db $F7,$F0,$F1,$00,$59,$00,$5A,$00   ;01BB45|        |      ;
            db $5B,$00,$5C,$00,$5D,$00,$5E,$00   ;01BB4D|        |      ;
            db $5F,$00,$60,$00,$61,$00,$00,$F4   ;01BB55|        |      ;
            db $F5,$FB,$FC,$FB,$FC,$EB,$EC,$EB   ;01BB5D|        |      ;
            db $F6,$C2,$C3,$14,$00,$AC,$C6,$C7   ;01BB65|        |      ;
            db $EB,$ED,$F6,$EC,$FB,$FC,$ED,$F7   ;01BB6D|        |      ;
            db $D2,$D3,$00,$62,$00,$63,$00,$64   ;01BB75|        |      ;
            db $00,$65,$00,$66,$00,$67,$00,$68   ;01BB7D|        |      ;
            db $00,$69,$00,$FE,$00,$00,$D6,$D7   ;01BB85|        |      ;
            db $FB,$FC,$FB,$FC,$EB,$EC,$EB,$EC   ;01BB8D|        |      ;
            db $E2,$E3,$14,$00,$92,$E6,$E7,$FD   ;01BB95|        |      ;
            db $F7,$EB,$ED,$F7,$FC,$ED,$FC,$F2   ;01BB9D|        |      ;
            db $F3,$00,$6A,$00,$6B,$00,$4B,$05   ;01BBA5|        |      ;
            db $00,$95,$CF,$00,$DF,$00,$00,$EE   ;01BBAD|        |      ;
            db $EF,$00,$00,$F2,$F3,$F7,$FD,$FB   ;01BBB5|        |      ;
            db $FC,$EB,$ED,$EB,$F7,$CB,$CC,$14   ;01BBBD|        |      ;
            db $00,$CC,$CB,$CC,$EB,$ED,$EB,$EC   ;01BBC5|        |      ;
            db $FB,$FC,$FB,$FC,$DB,$DC,$CD,$CE   ;01BBCD|        |      ;
            db $CD,$CE,$CD,$CE,$CD,$CE,$CD,$CE   ;01BBD5|        |      ;
            db $CD,$CE,$CD,$CE,$CD,$CE,$CD,$CE   ;01BBDD|        |      ;
            db $CD,$CE,$DB,$DC,$FB,$FC,$FD,$FC   ;01BBE5|        |      ;
            db $F6,$EC,$EB,$F7,$CB,$CC,$DD,$DE   ;01BBED|        |      ;
            db $DD,$DE,$DD,$DE,$DD,$DE,$DD,$DE   ;01BBF5|        |      ;
            db $DD,$DE,$DD,$DE,$DD,$DE,$DD,$DE   ;01BBFD|        |      ;
            db $DD,$DE,$CB,$CC,$EB,$F7,$EB,$EC   ;01BC05|        |      ;
            db $FB,$FC,$FB,$FC,$DB,$DC,$14,$F3   ;01BC0D|        |      ;
            db $90,$DB,$DC,$FB,$FC,$FB,$FD,$EB   ;01BC15|        |      ;
            db $EC,$EB,$F7,$F2,$F2,$F3,$F2,$F2   ;01BC1D|        |      ;
            db $F3,$03,$F2,$82,$F3,$F2,$04,$F3   ;01BC25|        |      ;
            db $04,$F2,$B3,$F3,$F2,$F2,$F3,$F2   ;01BC2D|        |      ;
            db $EB,$EC,$EB,$EC,$FB,$FC,$FB,$FD   ;01BC35|        |      ;
            db $D4,$EB,$EC,$EB,$EC,$EB,$F7,$EB   ;01BC3D|        |      ;
            db $F7,$FD,$ED,$F6,$F7,$FD,$F7,$F6   ;01BC45|        |      ;
            db $F7,$FB,$FC,$EC,$FB,$FC,$ED,$EB   ;01BC4D|        |      ;
            db $FB,$FC,$FB,$FC,$FF,$FF,$0F,$03   ;01BC55|        |      ;
            db $00,$0F,$CF,$FF,$FF,$F3,$04,$00   ;01BC5D|        |      ;
            db $84,$FC,$FF,$FF,$3F,$04,$00,$84   ;01BC65|        |      ;
            db $FC,$FF,$FF,$0F,$03,$00,$85,$0C   ;01BC6D|        |      ;
            db $0F,$FF,$FF,$22,$04,$00,$84,$88   ;01BC75|        |      ;
            db $FF,$FF,$22,$04,$00,$83,$88,$FF   ;01BC7D|        |      ; 
            db $FF,$06,$00,$81,$FF,$08,$0F,$FF   ;01BC85|        |      ; 
            db endDecompressStream

endif 

  RLE_tilemap_0d_PWscreen: 

if !patchEditedCompressed == 1  
      incbin "gfx/screens/password/compressed/0d_password.nam"   
else 
            db $00                               ;0CB327|        |      ;
            dw $C620                             ;0CB328|        |      ;
            db $CD,$CE,$CD,$CE,$CB,$CC,$CD,$CE   ;0CB32A|        |      ;
            db $CD,$CE,$CD,$CE,$CD,$CE,$CD,$CE   ;0CB332|        |      ;
            db $CD,$CE,$CD,$CE,$CD,$CE,$CD,$CE   ;0CB33A|        |      ;
            db $CD,$CE,$CB,$CC,$CD,$CE,$CD,$CE   ;0CB342|        |      ;
            db $DD,$DE,$DD,$DE,$DB,$DC,$DD,$DE   ;0CB34A|        |      ;
            db $DD,$DE,$DD,$DE,$DD,$DE,$DD,$DE   ;0CB352|        |      ;
            db $DD,$DE,$DD,$DE,$DD,$DE,$DD,$DE   ;0CB35A|        |      ;
            db $DD,$DE,$DB,$DC,$DD,$DE,$DD,$DE   ;0CB362|        |      ;
            db $CA,$C8,$C9,$FA,$C0,$C1,$14,$00   ;0CB36A|        |      ;
            db $8C,$C4,$C5,$C8,$C9,$CA,$C8,$DA   ;0CB372|        |      ;
            db $D8,$D9,$DA,$D0,$D1,$14,$00,$8C   ;0CB37A|        |      ;
            db $D4,$D5,$D8,$D9,$DA,$D8,$EA,$E8   ;0CB382|        |      ;
            db $E9,$EA,$E0,$E1,$05,$00,$81,$80   ;0CB38A|        |      ;
            db $08,$81,$81,$82,$05,$00,$8C,$E4   ;0CB392|        |      ;
            db $E5,$E8,$E9,$EA,$E8,$FA,$F8,$F9   ;0CB39A|        |      ;
            db $FA,$F0,$F1,$05,$00,$81,$90,$08   ;0CB3A2|        |      ;
            db $00,$81,$92,$05,$00,$8C,$F4,$F5   ;0CB3AA|        |      ;
            db $F8,$F9,$DA,$F8,$CA,$C8,$C9,$FA   ;0CB3B2|        |      ;
            db $C2,$C3,$05,$00,$81,$A0,$08,$A1   ;0CB3BA|        |      ;
            db $81,$A2,$05,$00,$8C,$C6,$C7,$E8   ;0CB3C2|        |      ;
            db $E9,$EA,$C8,$DA,$D8,$D9,$DA,$D2   ;0CB3CA|        |      ;
            db $D3,$14,$00,$FE,$D6,$D7,$F8,$F9   ;0CB3D2|        |      ;
            db $FA,$D8,$EA,$E8,$E9,$EA,$E2,$E3   ;0CB3DA|        |      ;
            db $00,$00,$80,$81,$81,$82,$80,$81   ;0CB3E2|        |      ;
            db $81,$82,$80,$81,$81,$82,$80,$81   ;0CB3EA|        |      ;
            db $81,$82,$00,$00,$E6,$E7,$C8,$C9   ;0CB3F2|        |      ;
            db $CA,$C8,$FA,$F8,$F9,$FA,$F2,$F3   ;0CB3FA|        |      ;
            db $00,$00,$90,$00,$00,$92,$90,$00   ;0CB402|        |      ;
            db $00,$92,$90,$00,$00,$92,$90,$00   ;0CB40A|        |      ;
            db $00,$92,$00,$00,$F2,$F3,$D8,$D9   ;0CB412|        |      ;
            db $DA,$D8,$CD,$CE,$CD,$CE,$CB,$CC   ;0CB41A|        |      ;
            db $00,$00,$90,$00,$00,$92,$90,$00   ;0CB422|        |      ;
            db $00,$92,$90,$00,$00,$92,$90,$00   ;0CB42A|        |      ;
            db $00,$92,$00,$00,$CB,$CC,$CD,$CE   ;0CB432|        |      ;
            db $CD,$CE,$DD,$DE,$DD,$DE,$DB,$DC   ;0CB43A|        |      ;
            db $00,$00,$A0,$A1,$A1,$A2,$A0,$A1   ;0CB442|        |      ;
            db $A1,$A2,$A0,$A1,$A1,$A2,$A0,$A1   ;0CB44A|        |      ;
            db $A1,$A2,$8E,$00,$00,$DB,$DC,$DD   ;0CB452|        |      ;
            db $DE,$DD,$DE,$E8,$E9,$E9,$EA,$C4   ;0CB45A|        |      ;
            db $C5,$14,$00,$8C,$C0,$C1,$E8,$E9   ;0CB462|        |      ;
            db $CA,$E8,$F8,$F9,$F9,$FA,$D4,$D5   ;0CB46A|        |      ;
            db $14,$00,$8C,$D0,$D1,$F8,$F9,$FA   ;0CB472|        |      ;
            db $F8,$E0,$C8,$C9,$CA,$E4,$E5,$04   ;0CB47A|        |      ;
            db $00,$8C,$80,$81,$82,$80,$81,$82   ;0CB482|        |      ;
            db $80,$81,$82,$80,$81,$82,$04,$00   ;0CB48A|        |      ;
            db $8C,$E0,$E1,$C8,$C9,$CA,$C8,$E8   ;0CB492|        |      ;
            db $D8,$D9,$DA,$F4,$F5,$04,$00,$8C   ;0CB49A|        |      ;
            db $90,$00,$92,$90,$00,$92,$90,$00   ;0CB4A2|        |      ;
            db $92,$90,$00,$92,$04,$00,$8C,$F0   ;0CB4AA|        |      ;
            db $F1,$D8,$D9,$DA,$D8,$C8,$C9,$E9   ;0CB4B2|        |      ;
            db $EA,$C6,$C7,$04,$00,$8C,$A0,$A1   ;0CB4BA|        |      ;
            db $A2,$A0,$A1,$A2,$A0,$A1,$A2,$A0   ;0CB4C2|        |      ;
            db $A1,$A2,$04,$00,$8C,$C2,$C3,$E8   ;0CB4CA|        |      ;
            db $E9,$EA,$E8,$D8,$D9,$F9,$FA,$D6   ;0CB4D2|        |      ;
            db $D7,$04,$00,$8C,$80,$81,$82,$80   ;0CB4DA|        |      ;
            db $81,$82,$80,$81,$82,$80,$81,$82   ;0CB4E2|        |      ;
            db $04,$00,$8C,$D2,$D3,$F8,$C8,$C9   ;0CB4EA|        |      ;
            db $F8,$E8,$C8,$E9,$EA,$E6,$E7,$04   ;0CB4F2|        |      ;
            db $00,$8C,$90,$00,$92,$90,$00,$92   ;0CB4FA|        |      ;
            db $90,$00,$92,$90,$00,$92,$04,$00   ;0CB502|        |      ;
            db $8C,$E2,$E3,$C8,$D8,$D9,$C8,$F8   ;0CB50A|        |      ;
            db $D8,$F9,$FA,$F2,$F3,$04,$00,$8C   ;0CB512|        |      ;
            db $A0,$A1,$A2,$A0,$A1,$A2,$A0,$A1   ;0CB51A|        |      ;
            db $A2,$A0,$A1,$A2,$04,$00,$8C,$F2   ;0CB522|        |      ;
            db $F3,$D8,$D9,$DA,$D8,$CD,$CE,$CD   ;0CB52A|        |      ;
            db $CE,$CB,$CC,$04,$00,$8C,$80,$81   ;0CB532|        |      ;
            db $82,$80,$81,$82,$80,$81,$82,$80   ;0CB53A|        |      ;
            db $81,$82,$04,$00,$8C,$CB,$CC,$CD   ;0CB542|        |      ;
            db $CE,$CD,$CE,$DD,$DE,$DD,$DE,$DB   ;0CB54A|        |      ;
            db $DC,$04,$00,$8C,$90,$00,$92,$90   ;0CB552|        |      ;
            db $00,$92,$90,$00,$92,$90,$00,$92   ;0CB55A|        |      ;
            db $04,$00,$8C,$DB,$DC,$DD,$DE,$DD   ;0CB562|        |      ;
            db $DE,$C8,$E8,$E9,$CA,$C0,$C1,$04   ;0CB56A|        |      ;
            db $00,$8C,$A0,$A1,$A2,$A0,$A1,$A2   ;0CB572|        |      ;
            db $A0,$A1,$A2,$A0,$A1,$A2,$04,$00   ;0CB57A|        |      ;
            db $8C,$C4,$C5,$E8,$E9,$EA,$E8,$D8   ;0CB582|        |      ;
            db $F8,$F9,$DA,$D0,$D1,$04,$00,$8C   ;0CB58A|        |      ;
            db $80,$81,$82,$80,$81,$82,$80,$81   ;0CB592|        |      ;
            db $82,$80,$81,$82,$04,$00,$8C,$D4   ;0CB59A|        |      ;
            db $D5,$F8,$F9,$FA,$F8,$C8,$C9,$C8   ;0CB5A2|        |      ;
            db $C9,$E0,$E1,$04,$00,$8C,$90,$00   ;0CB5AA|        |      ;
            db $92,$90,$00,$92,$90,$00,$92,$90   ;0CB5B2|        |      ;
            db $00,$92,$04,$00,$8C,$E4,$E5,$C8   ;0CB5BA|        |      ;
            db $C9,$CA,$C8,$D8,$D9,$D8,$D9,$F0   ;0CB5C2|        |      ;
            db $F1,$04,$00,$8C,$A0,$A1,$A2,$A0   ;0CB5CA|        |      ;
            db $A1,$A2,$A0,$A1,$A2,$A0,$A1,$A2   ;0CB5D2|        |      ;
            db $04,$00,$8C,$F4,$F5,$D8,$D9,$DA   ;0CB5DA|        |      ;
            db $D8,$E8,$C8,$E9,$EA,$C2,$C3,$14   ;0CB5E2|        |      ;
            db $00,$8C,$C6,$C7,$E8,$E9,$EA,$C8   ;0CB5EA|        |      ;
            db $F8,$D8,$F9,$FA,$D2,$D3,$14,$00   ;0CB5F2|        |      ;
            db $C8,$D6,$D7,$F8,$F9,$FA,$D8,$E8   ;0CB5FA|        |      ;
            db $C8,$C9,$EA,$E2,$E3,$CD,$CE,$CD   ;0CB602|        |      ;
            db $CE,$CD,$CE,$CD,$CE,$CD,$CE,$CD   ;0CB60A|        |      ;
            db $CE,$CD,$CE,$CD,$CE,$CD,$CE,$CD   ;0CB612|        |      ;
            db $CE,$E6,$E7,$C8,$C9,$CA,$C8,$F8   ;0CB61A|        |      ;
            db $D8,$D9,$FA,$F2,$F3,$DD,$DE,$DD   ;0CB622|        |      ;
            db $DE,$DD,$DE,$DD,$DE,$DD,$DE,$DD   ;0CB62A|        |      ;
            db $DE,$DD,$DE,$DD,$DE,$DD,$DE,$DD   ;0CB632|        |      ;
            db $DE,$F2,$F3,$D8,$D9,$DA,$D8,$0A   ;0CB63A|        |      ;
            db $69,$04,$5A,$84,$96,$0A,$00,$66   ;0CB642|        |      ;
            db $04,$55,$84,$99,$00,$A0,$56,$04   ;0CB64A|        |      ;
            db $55,$84,$59,$A0,$00,$66,$04,$55   ;0CB652|        |      ;
            db $84,$99,$00,$00,$66,$04,$55,$84   ;0CB65A|        |      ;
            db $99,$00,$0A,$65,$04,$55,$84,$95   ;0CB662|        |      ;
            db $0A,$00,$66,$04,$55,$83,$99,$00   ;0CB66A|        |      ;
            db $00,$06,$0A                       ;0CB672|        |      ;
            db endDecompressStream

endif  

  RLE_tilemap_mapX0_0e: 
      
if !patchEditedCompressed == 1          
      incbin "gfx/screens/mapCastle/compressed/0e_mapCastleBottom.nam"
else 
            dw $2C80                             ;05B839|        |      ;
            db $03,$00,$9A,$30,$02,$04,$05,$4C   ;05B83B|        |      ;
            db $AB,$94,$00,$ED,$FC,$D6,$D7,$8F   ;05B843|        |      ;
            db $C9,$85,$CD,$12,$DB,$D1,$57,$AA   ;05B84B|        |      ;
            db $67,$56,$41,$02,$2E,$06,$00,$9A   ;05B853|        |      ;
            db $A1,$13,$14,$15,$B8,$C9,$52,$00   ;05B85B|        |      ;
            db $F0,$00,$CD,$66,$67,$F9,$75,$66   ;05B863|        |      ;
            db $62,$CD,$66,$62,$70,$50,$77,$29   ;05B86B|        |      ;
            db $02,$1E,$06,$00,$89,$22,$23,$24   ;05B873|        |      ;
            db $25,$02,$4C,$00,$00,$F0,$03,$00   ;05B87B|        |      ;
            db $89,$42,$51,$D1,$57,$56,$67,$F9   ;05B883|        |      ;
            db $DB,$41,$03,$02,$82,$FA,$2E,$06   ;05B88B|        |      ;
            db $00,$9A,$30,$33,$34,$35,$02,$1F   ;05B893|        |      ;
            db $00,$00,$ED,$E8,$E9,$E9,$00,$00   ;05B89B|        |      ;
            db $75,$66,$67,$50,$93,$70,$29,$02   ;05B8A3|        |      ;
            db $FA,$FB,$00,$90,$06,$00,$96,$32   ;05B8AB|        |      ;
            db $76,$78,$03,$02,$4B,$1F,$00,$00   ;05B8B3|        |      ;
            db $E6,$E6,$F8,$E9,$E9,$00,$D1,$26   ;05B8BB|        |      ;
            db $02,$02,$29,$FA,$FB,$03,$00,$81   ;05B8C3|        |      ;
            db $0F,$06,$00,$87,$A1,$78,$40,$B8   ;05B8CB|        |      ;
            db $7D,$3F,$8F,$05,$00,$8E,$ED,$F3   ;05B8D3|        |      ;
            db $00,$EF,$E2,$E3,$E3,$E2,$E3,$E2   ;05B8DB|        |      ;
            db $E4,$F2,$E0,$0F,$06,$00,$81,$91   ;05B8E3|        |      ;
            db $03,$02,$84,$A7,$7D,$00,$1F,$04   ;05B8EB|        |      ;
            db $00,$8E,$ED,$00,$00,$CF,$E4,$F2   ;05B8F3|        |      ;
            db $E4,$E4,$F2,$01,$E0,$E0,$C3,$1E   ;05B8FB|        |      ;
            db $06,$00,$93,$20,$8E,$B8,$4B,$3F   ;05B903|        |      ;
            db $7D,$00,$8F,$C9,$00,$E8,$E9,$EA   ;05B90B|        |      ;
            db $00,$00,$E7,$DF,$CF,$E0,$03,$C3   ;05B913|        |      ;
            db $84,$02,$02,$DB,$2E,$06,$00,$9A   ;05B91B|        |      ;
            db $A1,$02,$4B,$A7,$3F,$60,$00,$CC   ;05B923|        |      ;
            db $51,$00,$E5,$E6,$F4,$F6,$F5,$F6   ;05B92B|        |      ;
            db $CE,$00,$A7,$02,$02,$BC,$A7,$99   ;05B933|        |      ;
            db $CB,$3E,$06,$00,$88,$30,$02,$B8   ;05B93B|        |      ;
            db $C9,$00,$1F,$8F,$51,$08,$00,$85   ;05B943|        |      ;
            db $E5,$00,$36,$99,$CB,$04,$00,$81   ;05B94B|        |      ;
            db $90,$06,$00,$03,$02,$83,$7D,$CC   ;05B953|        |      ;
            db $52,$07,$00,$84,$E8,$C8,$01,$CA   ;05B95B|        |      ;
            db $08,$00,$81,$2E,$06,$00,$91,$02   ;05B963|        |      ;
            db $02,$B8,$7D,$2F,$00,$CC,$CC,$00   ;05B96B|        |      ;
            db $00,$E9,$E9,$F5,$E6,$D8,$D9,$DA   ;05B973|        |      ;
            db $07,$00,$82,$12,$3E,$06,$00,$8F   ;05B97B|        |      ;
            db $A1,$02,$8E,$4C,$7D,$00,$00,$2F   ;05B983|        |      ;
            db $1F,$00,$E6,$F4,$F5,$F5,$E9,$06   ;05B98B|        |      ;
            db $00,$85,$CC,$00,$12,$82,$0F,$06   ;05B993|        |      ;
            db $00,$89,$91,$02,$02,$8E,$03,$68   ;05B99B|        |      ;
            db $C9,$00,$7D,$04,$00,$83,$E5,$F5   ;05B9A3|        |      ;
            db $F8,$03,$00,$87,$CC,$8F,$12,$03   ;05B9AB|        |      ;
            db $02,$9E,$9F,$06,$00,$08,$02,$83   ;05B9B3|        |      ;
            db $68,$7D,$46,$03,$00,$86,$46,$46   ;05B9BB|        |      ;
            db $00,$46,$12,$03,$03,$02,$83,$AD   ;05B9C3|        |      ;
            db $AE,$BE,$06,$00,$99,$BB,$BC,$B9   ;05B9CB|        |      ;
            db $BB,$BC,$B9,$BA,$BC,$BC,$BB,$BC   ;05B9D3|        |      ;
            db $B9,$BC,$BA,$BA,$BB,$BC,$BC,$B9   ;05B9DB|        |      ;
            db $BB,$B9,$BA,$BB,$BD,$BE,$04,$00   ;05B9E3|        |      ;
            db $7F,$C8,$2F,$0C,$AA,$84,$EE,$FF   ;05B9EB|        |      ;
            db $FF,$BB,$20,$AA,$08,$0A,$FF       ;05B9F3|        |      ;
            db endDecompressStream

endif 
 
  RLE_tilemap_0f_castleIntro: 
        
if !patchEditedCompressed == 1                  
      incbin "gfx/screens/intro/compressed/0f_castleIntro.nam" 
else 
            dw $2000                             ;0CAD7C|        |      ;
            db $44,$00,$14,$3E,$81,$67,$07,$3D   ;0CAD7E|        |      ;
            db $04,$00,$13,$3E,$82,$76,$77,$07   ;0CAD86|        |      ;
            db $3D,$04,$00,$15,$3E,$82,$76,$77   ;0CAD8E|        |      ;
            db $05,$3D,$04,$00,$16,$3E,$81,$67   ;0CAD96|        |      ;
            db $05,$3D,$04,$00,$83,$3E,$3E,$45   ;0CAD9E|        |      ;
            db $12,$3E,$82,$76,$77,$05,$3D,$04   ;0CADA6|        |      ;
            db $00,$8A,$3E,$45,$3E,$45,$45,$3E   ;0CADAE|        |      ;
            db $3E,$45,$45,$3E,$03,$45,$8B,$3E   ;0CADB6|        |      ;
            db $3E,$45,$3E,$45,$3E,$3E,$45,$3E   ;0CADBE|        |      ;
            db $3E,$67,$04,$3D,$04,$00,$8A,$45   ;0CADC6|        |      ;
            db $55,$45,$55,$45,$55,$45,$55,$45   ;0CADCE|        |      ;
            db $45,$04,$55,$04,$45,$86,$55,$55   ;0CADD6|        |      ;
            db $45,$45,$76,$77,$04,$3D,$04,$00   ;0CADDE|        |      ;
            db $84,$55,$55,$00,$00,$05,$55,$06   ;0CADE6|        |      ;
            db $00,$82,$55,$55,$03,$00,$84,$55   ;0CADEE|        |      ;
            db $45,$45,$55,$04,$3D,$03,$00,$81   ;0CADF6|        |      ;
            db $6D,$04,$00,$82,$5A,$4A,$05,$00   ;0CADFE|        |      ;
            db $81,$40,$06,$00,$82,$5A,$4A,$03   ;0CAE06|        |      ;
            db $00,$81,$6D,$07,$00,$89,$6D,$00   ;0CAE0E|        |      ;
            db $49,$4A,$69,$6A,$7A,$49,$4A,$03   ;0CAE16|        |      ;
            db $00,$81,$50,$03,$00,$89,$49,$4A   ;0CAE1E|        |      ;
            db $69,$6A,$7A,$4A,$00,$00,$6D,$07   ;0CAE26|        |      ;
            db $00,$81,$6D,$03,$00,$95,$55,$5A   ;0CAE2E|        |      ;
            db $4A,$00,$00,$40,$00,$00,$60,$62   ;0CAE36|        |      ;
            db $41,$00,$00,$7B,$79,$55,$7A,$5A   ;0CAE3E|        |      ;
            db $4A,$00,$6D,$07,$00,$99,$6D,$00   ;0CAE46|        |      ;
            db $49,$4A,$69,$6A,$7A,$4A,$00,$50   ;0CAE4E|        |      ;
            db $00,$00,$41,$62,$51,$40,$00,$00   ;0CAE56|        |      ;
            db $5A,$4A,$69,$6A,$7A,$4A,$6D,$07   ;0CAE5E|        |      ;
            db $00,$99,$6D,$00,$46,$49,$46,$45   ;0CAE66|        |      ;
            db $56,$56,$00,$60,$62,$41,$51,$74   ;0CAE6E|        |      ;
            db $62,$50,$00,$69,$7A,$78,$7B,$46   ;0CAE76|        |      ;
            db $7B,$7A,$6D,$07,$00,$84,$6D,$00   ;0CAE7E|        |      ;
            db $69,$7B,$05,$00,$8A,$42,$70,$63   ;0CAE86|        |      ;
            db $42,$51,$64,$60,$64,$00,$66,$03   ;0CAE8E|        |      ;
            db $00,$83,$79,$00,$6D,$07,$00,$81   ;0CAE96|        |      ;
            db $6D,$08,$00,$8C,$52,$70,$61,$75   ;0CAE9E|        |      ;
            db $71,$74,$7B,$74,$00,$00,$43,$44   ;0CAEA6|        |      ;
            db $03,$00,$81,$6D,$07,$00,$81,$6D   ;0CAEAE|        |      ;
            db $09,$00,$8B,$51,$71,$51,$00,$75   ;0CAEB6|        |      ;
            db $71,$51,$00,$00,$53,$54,$03,$00   ;0CAEBE|        |      ;
            db $81,$6D,$07,$00,$81,$6D,$04,$00   ;0CAEC6|        |      ;
            db $81,$40,$03,$00,$8C,$68,$58,$4B   ;0CAECE|        |      ;
            db $73,$63,$51,$5B,$58,$70,$70,$42   ;0CAED6|        |      ;
            db $54,$03,$00,$81,$6D,$07,$00,$81   ;0CAEDE|        |      ;
            db $6D,$04,$00,$81,$50,$03,$00,$8C   ;0CAEE6|        |      ;
            db $73,$59,$66,$73,$71,$00,$4B,$7A   ;0CAEEE|        |      ;
            db $70,$70,$61,$62,$03,$00,$81,$6D   ;0CAEF6|        |      ;
            db $07,$00,$81,$6D,$04,$00,$90,$60   ;0CAEFE|        |      ;
            db $00,$00,$4B,$58,$73,$59,$65,$4B   ;0CAF06|        |      ;
            db $5B,$65,$00,$73,$5B,$61,$62,$03   ;0CAF0E|        |      ;
            db $00,$81,$6D,$07,$00,$81,$6D,$04   ;0CAF16|        |      ;
            db $00,$90,$42,$70,$66,$66,$73,$66   ;0CAF1E|        |      ;
            db $59,$66,$59,$4B,$73,$5B,$00,$4B   ;0CAF26|        |      ;
            db $5B,$4B,$03,$00,$81,$6D,$07,$00   ;0CAF2E|        |      ;
            db $87,$6D,$00,$46,$46,$47,$47,$48   ;0CAF36|        |      ;
            db $05,$00,$83,$59,$00,$5B,$05,$00   ;0CAF3E|        |      ;
            db $85,$46,$57,$57,$56,$6D,$07,$00   ;0CAF46|        |      ;
            db $83,$6D,$00,$00,$03,$46,$83,$47   ;0CAF4E|        |      ;
            db $47,$57,$08,$00,$88,$46,$47,$47   ;0CAF56|        |      ;
            db $48,$56,$00,$00,$6D,$07,$00,$81   ;0CAF5E|        |      ;
            db $6D,$05,$00,$84,$46,$46,$47,$57   ;0CAF66|        |      ;
            db $06,$00,$81,$46,$04,$56,$03,$00   ;0CAF6E|        |      ;
            db $81,$6D,$07,$00,$85,$6D,$00,$00   ;0CAF76|        |      ;
            db $46,$56,$03,$00,$03,$46,$85,$56   ;0CAF7E|        |      ;
            db $00,$00,$46,$56,$08,$00,$81,$6D   ;0CAF86|        |      ;
            db $07,$00,$81,$6D,$06,$00,$82,$46   ;0CAF8E|        |      ;
            db $56,$0A,$00,$86,$46,$56,$56,$00   ;0CAF96|        |      ;
            db $00,$6D,$07,$00,$81,$6D,$17,$6E   ;0CAF9E|        |      ;
            db $81,$6F,$44,$00,$10,$FF,$84,$3F   ;0CAFA6|        |      ;
            db $FF,$FF,$BF,$04,$FF,$85,$33,$FF   ;0CAFAE|        |      ;
            db $FF,$56,$9A,$03,$FF,$97,$33,$FF   ;0CAFB6|        |      ;
            db $EF,$A5,$A9,$22,$00,$0F,$FF,$FF   ;0CAFBE|        |      ;
            db $FA,$BA,$AA,$F2,$FF,$00,$03,$0F   ;0CAFC6|        |      ;
            db $CF,$0F,$0F,$CF,$33,$06,$00,$83   ;0CAFCE|        |      ;
            db $0F,$0F,$00,$FF                   ;0CAFD6|        |      ; 
            db endDecompressStream  

endif 

  RLE_tilemap_10_ending00: 

if !patchEditedCompressed == 1        
      incbin "gfx/screens/ending/compressed/10_ending00.nam"  
else 
            dw $2000                             ;0ABDFA|        |      ;
            db $7E,$7D,$82,$7D,$7D,$10,$7F,$84   ;0ABDFC|        |      ;
            db $64,$66,$67,$67,$06,$7E,$83,$67   ;0ABE04|        |      ;
            db $66,$66,$05,$7F,$03,$65,$0A,$7F   ;0ABE0C|        |      ;
            db $92,$65,$67,$7E,$67,$7E,$7E,$77   ;0ABE14|        |      ;
            db $74,$75,$77,$77,$76,$7E,$7E,$67   ;0ABE1C|        |      ;
            db $67,$65,$64,$04,$67,$9B,$66,$65   ;0ABE24|        |      ;
            db $64,$65,$67,$66,$7F,$7F,$7F,$65   ;0ABE2C|        |      ;
            db $65,$67,$7E,$7E,$7E,$74,$00,$77   ;0ABE34|        |      ;
            db $00,$00,$00,$76,$7E,$67,$7E,$7E   ;0ABE3C|        |      ;
            db $67,$06,$7E,$89,$67,$7E,$7E,$7E   ;0ABE44|        |      ;
            db $67,$66,$65,$67,$67,$04,$7E,$81   ;0ABE4C|        |      ;
            db $77,$07,$00,$93,$76,$75,$75,$7E   ;0ABE54|        |      ;
            db $7E,$7E,$74,$75,$75,$76,$7E,$77   ;0ABE5C|        |      ;
            db $76,$7E,$75,$7E,$7E,$67,$67,$04   ;0ABE64|        |      ;
            db $7E,$82,$75,$77,$07,$00,$03,$77   ;0ABE6C|        |      ;
            db $86,$76,$75,$77,$77,$77,$00,$06   ;0ABE74|        |      ;
            db $77,$88,$75,$7E,$7E,$74,$76,$7E   ;0ABE7C|        |      ;
            db $7E,$74,$0C,$00,$84,$77,$77,$41   ;0ABE84|        |      ;
            db $42,$08,$00,$87,$77,$76,$75,$75   ;0ABE8C|        |      ;
            db $77,$75,$75,$0F,$00,$8C,$51,$52   ;0ABE94|        |      ;
            db $42,$56,$57,$41,$42,$00,$41,$42   ;0ABE9C|        |      ;
            db $00,$77,$08,$00,$81,$40,$09,$00   ;0ABEA4|        |      ;
            db $D8,$41,$42,$60,$62,$63,$54,$46   ;0ABEAC|        |      ;
            db $51,$52,$42,$51,$52,$42,$00,$41   ;0ABEB4|        |      ;
            db $42,$00,$00,$00,$41,$42,$00,$43   ;0ABEBC|        |      ;
            db $78,$4F,$00,$7A,$5F,$00,$56,$57   ;0ABEC4|        |      ;
            db $50,$51,$52,$7D,$46,$71,$46,$51   ;0ABECC|        |      ;
            db $52,$52,$7D,$47,$73,$7D,$53,$51   ;0ABED4|        |      ;
            db $52,$57,$00,$41,$51,$52,$42,$43   ;0ABEDC|        |      ;
            db $7D,$7D,$4F,$79,$7D,$4F,$7D,$63   ;0ABEE4|        |      ;
            db $44,$45,$7D,$55,$52,$63,$51,$60   ;0ABEEC|        |      ;
            db $45,$62,$7D,$7D,$7D,$55,$44,$45   ;0ABEF4|        |      ;
            db $72,$73,$53,$51,$54,$7D,$4C,$4D   ;0ABEFC|        |      ;
            db $4E,$0B,$7D,$95,$55,$44,$60,$7D   ;0ABF04|        |      ;
            db $61,$7D,$7D,$7D,$63,$44,$62,$7D   ;0ABF0C|        |      ;
            db $62,$63,$60,$62,$72,$7D,$5C,$7D   ;0ABF14|        |      ;
            db $5E,$13,$7D,$83,$60,$61,$62,$06   ;0ABF1C|        |      ;
            db $7D,$85,$6B,$6C,$6B,$5D,$4E,$1A   ;0ABF24|        |      ;
            db $7D,$86,$4E,$7B,$7C,$7B,$7D,$5E   ;0ABF2C|        |      ;
            db $1A,$7D,$84,$5E,$6C,$6E,$6F,$0D   ;0ABF34|        |      ;
            db $7D,$81,$5B,$06,$7D,$85,$5B,$7D   ;0ABF3C|        |      ;
            db $7D,$7D,$5B,$04,$7D,$82,$6F,$5A   ;0ABF44|        |      ;
            db $09,$7D,$03,$68,$0C,$7D,$84,$4A   ;0ABF4C|        |      ;
            db $48,$48,$68,$09,$7D,$87,$5B,$7D   ;0ABF54|        |      ;
            db $7D,$68,$48,$68,$68,$09,$7D,$88   ;0ABF5C|        |      ;
            db $49,$48,$4A,$7E,$58,$58,$7E,$49   ;0ABF64|        |      ;
            db $0C,$7D,$83,$68,$48,$4A,$09,$7D   ;0ABF6C|        |      ;
            db $04,$7E,$04,$58,$81,$48,$0B,$7D   ;0ABF74|        |      ;
            db $83,$68,$4A,$69,$09,$7D,$8C,$58   ;0ABF7C|        |      ;
            db $7E,$7E,$6A,$7E,$58,$7E,$58,$58   ;0ABF84|        |      ;
            db $48,$48,$49,$04,$7D,$87,$68,$5B   ;0ABF8C|        |      ;
            db $5B,$48,$48,$48,$4A,$08,$7D,$98   ;0ABF94|        |      ;
            db $4B,$4B,$58,$4B,$4B,$69,$69,$4B   ;0ABF9C|        |      ;
            db $4B,$7E,$4B,$6A,$7E,$49,$48,$68   ;0ABFA4|        |      ;
            db $7D,$4A,$48,$4A,$58,$69,$6A,$7E   ;0ABFAC|        |      ;
            db $08,$7D,$98,$4B,$58,$7E,$58,$7E   ;0ABFB4|        |      ;
            db $58,$7E,$7E,$7E,$6A,$4B,$7E,$6A   ;0ABFBC|        |      ;
            db $7E,$7E,$49,$4A,$49,$4A,$7E,$4B   ;0ABFC4|        |      ;
            db $7E,$4B,$58,$7E,$7D,$82,$7D,$7D   ;0ABFCC|        |      ;
            db $08,$AA,$08,$00,$96,$E0,$F0,$20   ;0ABFD4|        |      ;
            db $00,$00,$EF,$F3,$E0,$FF,$FF,$FE   ;0ABFDC|        |      ;
            db $FF,$7F,$9A,$AA,$AF,$AA,$AA,$AF   ;0ABFE4|        |      ;
            db $AA,$55,$95,$12,$AA,$08,$0A,$FF   ;0ABFEC|        |      ;
            db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ;0ABFF4|        |      ;
            db $FF,$FF,$FF,$FF                   ;0ABFFC|        |      ;
            db endDecompressStream

endif 

  RLE_tilemap_10_ending01: 

if !patchEditedCompressed == 1  
      incbin "gfx/screens/ending/compressed/10_ending01.nam" 
else 
            dw $2800                             ;0FD772|        |      ;
            db $24,$00,$18,$2E,$07,$00,$81,$2D   ;0FD774|        |      ;
            db $18,$00,$81,$2C,$06,$00,$81,$2D   ;0FD77C|        |      ;
            db $18,$00,$81,$2C,$06,$00,$81,$2D   ;0FD784|        |      ;
            db $18,$00,$81,$2C,$06,$00,$81,$2D   ;0FD78C|        |      ;
            db $18,$00,$81,$2C,$06,$00,$81,$2D   ;0FD794|        |      ;
            db $18,$00,$81,$2C,$06,$00,$81,$2D   ;0FD79C|        |      ;
            db $07,$00,$82,$68,$69,$0F,$00,$81   ;0FD7A4|        |      ;
            db $2C,$06,$00,$81,$2D,$07,$00,$8A   ;0FD7AC|        |      ;
            db $46,$47,$48,$49,$4A,$4B,$4C,$4D   ;0FD7B4|        |      ;
            db $4E,$4F,$07,$00,$81,$2C,$06,$00   ;0FD7BC|        |      ;
            db $81,$2D,$07,$00,$8A,$56,$57,$58   ;0FD7C4|        |      ;
            db $59,$5A,$5B,$5C,$5D,$5E,$5F,$07   ;0FD7CC|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$07   ;0FD7D4|        |      ;
            db $00,$8A,$66,$67,$00,$00,$6A,$00   ;0FD7DC|        |      ;
            db $00,$6D,$6E,$6F,$07,$00,$81,$2C   ;0FD7E4|        |      ;
            db $06,$00,$81,$2D,$04,$00,$85,$60   ;0FD7EC|        |      ;
            db $00,$00,$00,$61,$0F,$00,$81,$2C   ;0FD7F4|        |      ;
            db $06,$00,$81,$2D,$04,$00,$90,$70   ;0FD7FC|        |      ;
            db $71,$72,$73,$74,$75,$76,$77,$78   ;0FD804|        |      ;
            db $79,$7A,$7B,$7C,$7D,$7E,$7F,$04   ;0FD80C|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$04   ;0FD814|        |      ;
            db $00,$90,$80,$81,$82,$83,$84,$85   ;0FD81C|        |      ;
            db $86,$87,$88,$89,$8A,$8B,$8C,$8D   ;0FD824|        |      ;
            db $8E,$8F,$04,$00,$81,$2C,$06,$00   ;0FD82C|        |      ;
            db $81,$2D,$04,$00,$90,$90,$91,$92   ;0FD834|        |      ;
            db $93,$94,$95,$96,$97,$98,$99,$9A   ;0FD83C|        |      ;
            db $9B,$9C,$9D,$9E,$9F,$04,$00,$81   ;0FD844|        |      ;
            db $2C,$06,$00,$81,$2D,$04,$00,$90   ;0FD84C|        |      ;
            db $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7   ;0FD854|        |      ;
            db $A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF   ;0FD85C|        |      ;
            db $04,$00,$81,$2C,$06,$00,$81,$2D   ;0FD864|        |      ;
            db $04,$00,$8F,$B0,$B1,$00,$B3,$B4   ;0FD86C|        |      ;
            db $B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC   ;0FD874|        |      ;
            db $00,$FC,$05,$00,$81,$2C,$06,$00   ;0FD87C|        |      ;
            db $81,$2D,$07,$00,$8A,$C3,$C4,$C5   ;0FD884|        |      ;
            db $C6,$C7,$C8,$C9,$CA,$CB,$CC,$07   ;0FD88C|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$07   ;0FD894|        |      ;
            db $00,$8A,$D3,$D4,$D5,$D6,$D7,$D8   ;0FD89C|        |      ;
            db $D9,$DA,$DB,$DC,$07,$00,$81,$2C   ;0FD8A4|        |      ;
            db $06,$00,$81,$2D,$07,$00,$8A,$E3   ;0FD8AC|        |      ;
            db $E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB   ;0FD8B4|        |      ;
            db $EC,$07,$00,$81,$2C,$06,$00,$81   ;0FD8BC|        |      ;
            db $2D,$07,$00,$83,$F3,$F4,$F5,$0E   ;0FD8C4|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8CC|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8D4|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8DC|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8E4|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8EC|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8F4|        |      ;
            db $00,$81,$2C,$06,$00,$81,$2D,$18   ;0FD8FC|        |      ;
            db $2E,$81,$2C,$4D,$00,$82,$80,$20   ;0FD904|        |      ;
            db $06,$00,$84,$98,$AA,$EE,$33,$04   ;0FD90C|        |      ;
            db $00,$84,$55,$99,$EE,$FF,$04,$00   ;0FD914|        |      ;
            db $84,$55,$59,$EE,$FF,$04,$00,$82   ;0FD91C|        |      ;
            db $05,$05,$14,$00,$FF               ;0FD924|        |      ;
            db endDecompressStream

endif 


  RLE_tilemap_10_ending02: 
  
if !patchEditedCompressed == 1      ; attrib  
      incbin "gfx/screens/ending/compressed/10_ending02.nam"    
else 
            dw $2BC0                             ;0ABA9A|        |      ;
            db $0A,$FF,$82,$3F,$CF,$06,$FF,$84   ;0ABA9C|        |      ;
            db $13,$44,$99,$AA,$04,$FF,$84,$55   ;0ABAA4|        |      ;
            db $22,$88,$55,$04,$FF,$84,$55,$22   ;0ABAAC|        |      ;
            db $88,$55,$04,$FF,$82,$F5,$F5,$0C   ;0ABAB4|        |      ;
            db $FF,$08,$0F,$FF                   ;0ABABC|        |      ;
            db endDecompressStream
endif 
}







