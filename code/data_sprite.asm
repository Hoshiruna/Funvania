!animationIDX = 1 
!moveCrumbleBlock = 1 


if !animationIDX == 1 

    crossAnimSpeed = $04    ; $06 default
    


org LAST_BANK+$FB4    
base $EFB4     
   spriteAnimIndex: 
    dw playerAnim_00                     ;0FEFB4|        |0FEFD2;
        dw playerAnim_00                     ;0FEFB6|        |0FEFD2;
        dw playerAnim_00                     ;0FEFB8|        |0FEFD2;
        dw playerAnim_00                     ;0FEFBA|        |0FEFD2;
        dw sprite_00_Anim_00                 ;0FEFBC|        |0FF0B9;
        dw sprite_01_Anim_00                 ;0FEFBE|        |0FF158;
        dw sprite_02_Anim_00                 ;0FEFC0|        |0FF002;
        dw sprite_03_Anim_00                 ;0FEFC2|        |0FF33E;
        dw sprite_04_Anim_00                 ;0FEFC4|        |0FF257;
        dw sprite_05_Anim_00                 ;0FEFC6|        |0FF131;
        dw sprite_06_Anim_00                 ;0FEFC8|        |0FF362;
        dw playerAnim_00                     ;0FEFCA|        |0FEFD2;
        dw playerAnim_00                     ;0FEFCC|        |0FEFD2;
        dw playerAnim_00                     ;0FEFCE|        |0FEFD2;
        dw playerAnim_00                     ;0FEFD0|        |0FEFD2;
 
;              +----------------------------  | start frame ID   |  
;                |   +------------------------  | wait frames      |
;                |   |   +--------------------  | number of frames |
;                |   |   |  
;              |   |   |  
    
    playerAnim_00:  db $02,$08,$08              ; 0FEFD2|     
            db $18,$08,$04              ; playerAnim_01:                
            db $1E,$08,$04                  ; playerAnim_02:     
            db $24,$08,$06                  ; playerAnim_03:     
            db $24,$04,$06                  ; playerAnim_04:     
            db $2A,$06,$0C                  ; playerAnim_05:     
            db $34,$06,$0C                  ; playerAnim_06:     
            db $40,(crossAnimSpeed),$06     ; playerAnim_07:                  
            db $46,$06,$08                  ; playerAnim_08:     
            db $46,$06,$08                  ; playerAnim_09:     
            db $4E,$06,$04                  ; playerAnim_0a:     
            db $40,$04,$04                  ; playerAnim_0b:    
            db $56,$04,$0C                  ; playerAnim_0c:     
            db $36,$08,$04                  ; playerAnim_0d:     
            db $66,$08,$06                  ; playerAnim_0e:     
            db $6C,$08,$04                  ; playerAnim_0f:     
    
  sprite_02_Anim_00:  db $02,$0A,$04                      
            db $04,$0A,$04          ; sprite_02_Anim_01:                   
            db $08,$08,$02                  ; sprite_02_Anim_02:    
            db $0A,$08,$02                  ; sprite_02_Anim_03:    
            db $0C,$08,$02                  ; sprite_02_Anim_04:    
            db $0E,$08,$02                  ; sprite_02_Anim_05:    
            db $10,$08,$02                  ; sprite_02_Anim_06:    
            db $12,$08,$02                  ; sprite_02_Anim_07:    
            db $14,$08,$02                  ; sprite_02_Anim_08:    
            db $16,$08,$02                  ; sprite_02_Anim_09:    
            db $18,$08,$02                  ; sprite_02_Anim_0a:    
            db $1A,$08,$02                  ; sprite_02_Anim_0b:    
            db $1C,$08,$02                  ; sprite_02_Anim_0c:    
            db $1E,$08,$02                  ; sprite_02_Anim_0d:    
            db $20,$08,$02                  ; sprite_02_Anim_0e:    
            db $22,$08,$02                  ; sprite_02_Anim_0f:    
            db $24,$08,$02                  ; sprite_02_Anim_10:    
            db $26,$08,$02                  ; sprite_02_Anim_11:    
            db $28,$08,$02                  ; sprite_02_Anim_12:    
            db $2A,$08,$02                  ; sprite_02_Anim_13:    
            db $2C,$08,$02                  ; sprite_02_Anim_14:    
            db $2E,$08,$02                  ; sprite_02_Anim_15:    
            db $30,$08,$02                  ; sprite_02_Anim_16:    
            db $32,$08,$02                  ; sprite_02_Anim_17:    
            db $24,$08,$02                  ; sprite_02_Anim_18:    
            db $36,$08,$02                  ; sprite_02_Anim_19:    
            db $38,$08,$02                  ; sprite_02_Anim_1a:    
            db $3A,$08,$02                  ; sprite_02_Anim_1b:    
            db $3C,$08,$02                  ; sprite_02_Anim_1c:    
            db $3E,$08,$02                  ; sprite_02_Anim_1d:    
            db $40,$08,$02                  ; sprite_02_Anim_1e:    
            db $42,$08,$02                  ; sprite_02_Anim_1f:    
            db $44,$08,$02                  ; sprite_02_Anim_20:    
            db $46,$08,$02                  ; sprite_02_Anim_21:    
            db $50,$08,$02                  ; sprite_02_Anim_22:    
            db $4E,$08,$02                  ; sprite_02_Anim_23:    
            db $4C,$08,$02                  ; sprite_02_Anim_24:    
            db $4A,$08,$02                  ; sprite_02_Anim_25:    
            db $48,$08,$02                  ; sprite_02_Anim_26:    
            db $52,$08,$02                  ; sprite_02_Anim_27:    
            db $54,$08,$02                  ; sprite_02_Anim_28:    
            db $56,$08,$02                  ; sprite_02_Anim_2a:    
            db $58,$08,$02                  ; sprite_02_Anim_2b:    
            db $5A,$08,$02                  ; sprite_02_Anim_2c:    
            db $5C,$08,$02                  ; sprite_02_Anim_2d:    
            db $5E,$08,$02                  ; sprite_02_Anim_2e:    
            db $60,$08,$02                  ; sprite_02_Anim_2f:    
            db $62,$08,$02                  ; sprite_02_Anim_30:    
            db $64,$08,$02                  ; sprite_02_Anim_31:    
            db $66,$08,$02                  ; sprite_02_Anim_32:    
            db $68,$08,$02                  ; sprite_02_Anim_33:    
            db $6A,$08,$02                  ; sprite_02_Anim_34:    
            db $6C,$08,$02                  ; sprite_02_Anim_35:    
            db $6E,$08,$02                  ; sprite_02_Anim_36:    
            db $BA,$08,$08                  ; sprite_02_Anim_37:    
            db $C2,$08,$08                  ; sprite_02_Anim_38:    
            db $CA,$08,$08                  ; sprite_02_Anim_39:    
            db $E0,$09,$08                  ; sprite_02_Anim_3a:    
            db $EC,$07,$04                  ; sprite_02_Anim_3b:    
            db $F0,$09,$04                  ; sprite_02_Anim_3c:    
            db $FE,$08,$02                  ; sprite_02_Anim_3d:    
   
    sprite_00_Anim_00:  db $02,$10,$04                      
            db $0A,$08,$08              ; sprite_00_Anim_01:              
            db $1A,$0A,$04                  ; sprite_00_Anim_02:    
            db $20,$0A,$08                  ; sprite_00_Anim_03:    
            db $28,$0A,$04                  ; sprite_00_Anim_04:    
            db $92,$10,$04                  ; sprite_00_Anim_05:    
            db $A8,$0A,$04                  ; sprite_00_Anim_06:    
            db $DE,$18,$04                  ; sprite_00_Anim_07:    
            db $8C,$0C,$04                  ; sprite_00_Anim_08:    
            db $4C,$0A,$04                  ; sprite_00_Anim_09:    
            db $62,$0A,$04                  ; sprite_00_Anim_0a:    
            db $34,$10,$04                  ; sprite_00_Anim_0b:    
            db $BC,$0C,$04                  ; sprite_00_Anim_0c:    
            db $2C,$0E,$04                  ; sprite_00_Anim_0d:    
            db $30,$0E,$04                  ; sprite_00_Anim_0e:    
            db $42,$10,$04                  ; sprite_00_Anim_0f:    
            db $58,$0A,$04                  ; sprite_00_Anim_10:    
            db $62,$0A,$04                  ; sprite_00_Anim_11:    
            db $68,$0C,$08                  ; sprite_00_Anim_12:    
            db $88,$0C,$04                  ; sprite_00_Anim_13:    
            db $74,$0C,$0A                  ; sprite_00_Anim_14:    
            db $AC,$0A,$06                  ; sprite_00_Anim_15:    
            db $A2,$0C,$06                  ; sprite_00_Anim_16:    
            db $96,$08,$06                  ; sprite_00_Anim_17:    
            db $B0,$0C,$04                  ; sprite_00_Anim_18:    
            db $70,$0A,$04                  ; sprite_00_Anim_19:    
            db $9C,$0C,$06                  ; sprite_00_Anim_1a:    
            db $B8,$0A,$04                  ; sprite_00_Anim_1b:    
            db $BC,$0C,$04                  ; sprite_00_Anim_1c:    
            db $CA,$18,$04                  ; sprite_00_Anim_1d:    
            db $DE,$0C,$08                  ; sprite_00_Anim_1e:    
            db $DA,$0C,$04                  ; sprite_00_Anim_1f:    
            db $E6,$18,$04                  ; sprite_00_Anim_20:    
            db $E6,$0C,$08                  ; sprite_00_Anim_21:    
            db $9C,$18,$06                  ; sprite_00_Anim_22:    
            db $14,$08,$06                  ; sprite_00_Anim_23:    
            db $D0,$0A,$08                  ; sprite_00_Anim_24:    
            db $14,$08,$04                  ; sprite_00_Anim_25:    
            db $92,$14,$04                  ; sprite_00_Anim_26:    
            db $7E,$0A,$04                  ; sprite_00_Anim_27:    
    
  sprite_05_Anim_00:  db $1A,$08,$06                      
            db $20,$14,$04            ; sprite_05_Anim_01:                  
            db $24,$0C,$04                ; sprite_05_Anim_02:        
            db $28,$10,$06                ; sprite_05_Anim_03:        
            db $2E,$06,$04                ; sprite_05_Anim_04:        
            db $34,$0A,$06                ; sprite_05_Anim_05:        
            db $0C,$08,$04                ; sprite_05_Anim_06:        
            db $56,$04,$04                ; sprite_05_Anim_07:        
            db $72,$0C,$04                ; sprite_05_Anim_08:        
            db $76,$0C,$04                ; sprite_05_Anim_09:        
            db $64,$04,$04                ; sprite_05_Anim_0a:        
            db $68,$08,$08                ; sprite_05_Anim_0b:        
            db $7A,$0A,$04                ; sprite_05_Anim_0c:        
    
  sprite_01_Anim_00:  db $02,$08,$06                      
            db $0A,$04,$02          ; sprite_01_Anim_01:                    
            db $0C,$18,$02                  ; sprite_01_Anim_02:    
            db $0E,$18,$02                  ; sprite_01_Anim_03:    
            db $10,$08,$02                  ; sprite_01_Anim_04:    
            db $12,$08,$06                  ; sprite_01_Anim_05:    
            db $18,$10,$08                  ; sprite_01_Anim_06:    
            db $18,$08,$08                  ; sprite_01_Anim_07:    
            db $20,$10,$02                  ; sprite_01_Anim_08:    
            db $22,$10,$02                  ; sprite_01_Anim_09:    
            db $26,$08,$02                  ; sprite_01_Anim_0a:    
            db $28,$08,$02                  ; sprite_01_Anim_0b:    
            db $2E,$08,$02                  ; sprite_01_Anim_0c:    
            db $02,$08,$02                  ; sprite_01_Anim_0d:    
            db $04,$08,$02                  ; sprite_01_Anim_0e:    
            db $06,$08,$02                  ; sprite_01_Anim_0f:    
            db $04,$08,$02                  ; sprite_01_Anim_10:    
            db $38,$08,$02                  ; sprite_01_Anim_11:    
            db $3A,$08,$04                  ; sprite_01_Anim_12:    
            db $3E,$08,$04                  ; sprite_01_Anim_13:    
            db $42,$08,$04                  ; sprite_01_Anim_14:    
            db $46,$08,$04                  ; sprite_01_Anim_15:    
            db $4E,$08,$08                  ; sprite_01_Anim_16:    
            db $4C,$08,$02                  ; sprite_01_Anim_17:    
            db $4A,$08,$02                  ; sprite_01_Anim_18:  
            db $3A,$08,$02                  ; sprite_01_Anim_19:  
            db $3C,$08,$02                  ; sprite_01_Anim_1a:    
            db $56,$08,$04                  ; sprite_01_Anim_1b:    
            db $5A,$08,$04                  ; sprite_01_Anim_1c:    
            db $5E,$08,$04                  ; sprite_01_Anim_1d:    
            db $62,$08,$04                  ; sprite_01_Anim_1e:    
            db $66,$08,$02                  ; sprite_01_Anim_1f:    
            db $66,$08,$06                  ; sprite_01_Anim_20:    
            db $74,$08,$02                  ; sprite_01_Anim_21:    
            db $76,$08,$02                  ; sprite_01_Anim_22:    
            db $78,$08,$02                  ; sprite_01_Anim_23:    
            db $7A,$08,$04                  ; sprite_01_Anim_24:    
            db $7E,$08,$04                  ; sprite_01_Anim_25:    
            db $80,$08,$04                  ; sprite_01_Anim_26:    
            db $82,$08,$04                  ; sprite_01_Anim_27:    
            db $72,$08,$02                  ; sprite_01_Anim_28:    
            db $70,$08,$02                  ; sprite_01_Anim_29:    
            db $6E,$08,$02                  ; sprite_01_Anim_2a:    
            db $6C,$08,$02                  ; sprite_01_Anim_2b:    
            db $6C,$08,$02                  ; sprite_01_Anim_2c:    
            db $6E,$08,$02                  ; sprite_01_Anim_2e:    
            db $70,$08,$02                  ; sprite_01_Anim_2f:    
            db $72,$08,$02                  ; sprite_01_Anim_30:    
            db $84,$08,$02                  ; sprite_01_Anim_31:    
            db $86,$08,$02                  ; sprite_01_Anim_32:    
            db $88,$08,$02                  ; sprite_01_Anim_33:    
            db $8A,$08,$0A                  ; sprite_01_Anim_34:    
            db $9A,$08,$02                  ; sprite_01_Anim_35:    
            db $9C,$08,$02                  ; sprite_01_Anim_36:    
            db $9E,$08,$02                  ; sprite_01_Anim_37:    
            db $A0,$08,$02                  ; sprite_01_Anim_38:    
            db $A2,$08,$02                  ; sprite_01_Anim_39:    
            db $A4,$08,$02                  ; sprite_01_Anim_3a:    
            db $A6,$08,$02                  ; sprite_01_Anim_3b:    
            db $A8,$08,$02                  ; sprite_01_Anim_3c:    
            db $AA,$08,$02                  ; sprite_01_Anim_3d:    
            db $AC,$08,$02                  ; sprite_01_Anim_3e:    
            db $AE,$08,$02                  ; sprite_01_Anim_3f:    
            db $B0,$08,$02                  ; sprite_01_Anim_40:    
            db $B2,$08,$02                  ; sprite_01_Anim_41:    
            db $B4,$08,$02                  ; sprite_01_Anim_42:    
            db $B6,$08,$02                  ; sprite_01_Anim_43:    
            db $B8,$08,$02                  ; sprite_01_Anim_44:    
            db $BA,$08,$02                  ; sprite_01_Anim_45:    
            db $BC,$08,$02                  ; sprite_01_Anim_46:    
            db $BE,$08,$02                  ; sprite_01_Anim_47:    
            db $C0,$08,$02                  ; sprite_01_Anim_48:    
            db $C2,$08,$02                  ; sprite_01_Anim_49:    
            db $C4,$08,$02                  ; sprite_01_Anim_4a:    
            db $C6,$08,$02                  ; sprite_01_Anim_4b:    
            db $C8,$08,$02                  ; sprite_01_Anim_4c:    
            db $CA,$08,$02                  ; sprite_01_Anim_4d:    
            db $CC,$08,$02                  ; sprite_01_Anim_4e:    
            db $CE,$08,$02                  ; sprite_01_Anim_4f:    
            db $D0,$08,$02                  ; sprite_01_Anim_50:    
            db $D2,$08,$02                  ; sprite_01_Anim_51:    
            db $D4,$08,$02                  ; sprite_01_Anim_52:    
            db $D6,$08,$02                  ; sprite_01_Anim_53:    
            db $D8,$08,$02                  ; sprite_01_Anim_54:    
            db $DA,$08,$02                  ; sprite_01_Anim_55:    
    
  sprite_04_Anim_00:  db $02,$08,$02                      
            db $04,$08,$02            ; sprite_04_Anim_01:                
            db $06,$08,$02                  ; sprite_04_Anim_02:    
            db $08,$08,$02                  ; sprite_04_Anim_03:    
            db $0A,$08,$02                  ; sprite_04_Anim_04:    
            db $0C,$08,$02                  ; sprite_04_Anim_05:    
            db $0E,$18,$02                  ; sprite_04_Anim_06:    
            db $10,$18,$02                  ; sprite_04_Anim_07:    
            db $12,$08,$02                  ; sprite_04_Anim_08:    
            db $14,$08,$02                  ; sprite_04_Anim_09:    
            db $16,$08,$02                  ; sprite_04_Anim_0a:    
            db $18,$08,$02                  ; sprite_04_Anim_0b:    
            db $1A,$08,$02                  ; sprite_04_Anim_0c:    
            db $1C,$08,$02                  ; sprite_04_Anim_0d:    
            db $1E,$08,$06                  ; sprite_04_Anim_0e:    
            db $24,$08,$02                  ; sprite_04_Anim_0f:    
            db $26,$08,$02                  ; sprite_04_Anim_10:    
            db $28,$08,$02                  ; sprite_04_Anim_11:    
            db $2A,$08,$02                  ; sprite_04_Anim_12:    
            db $2C,$08,$06                  ; sprite_04_Anim_13:    
            db $32,$08,$02                  ; sprite_04_Anim_14:    
            db $34,$08,$02                  ; sprite_04_Anim_15:    
            db $36,$08,$02                  ; sprite_04_Anim_16:    
            db $38,$08,$02                  ; sprite_04_Anim_17:    
            db $3A,$08,$02                  ; sprite_04_Anim_18:    
            db $3C,$08,$02                  ; sprite_04_Anim_19:    
            db $3E,$08,$02                  ; sprite_04_Anim_1a:    
            db $40,$08,$04                  ; sprite_04_Anim_1b:    
            db $42,$08,$02                  ; sprite_04_Anim_1c:    
            db $44,$08,$02                  ; sprite_04_Anim_1d:    
            db $46,$08,$02                  ; sprite_04_Anim_1e:    
            db $48,$08,$02                  ; sprite_04_Anim_1f:    
            db $2C,$08,$02                  ; sprite_04_Anim_20:    
            db $4A,$08,$02                  ; sprite_04_Anim_21:    
            db $4C,$08,$02                  ; sprite_04_Anim_22:    
            db $4E,$08,$02                  ; sprite_04_Anim_23:    
            db $50,$08,$02                  ; sprite_04_Anim_24:    
            db $52,$08,$02                  ; sprite_04_Anim_25:    
            db $54,$08,$02                  ; sprite_04_Anim_26:    
            db $56,$08,$02                  ; sprite_04_Anim_27:    
            db $58,$08,$02                  ; sprite_04_Anim_28:    
            db $5A,$08,$02                  ; sprite_04_Anim_29:    
            db $5C,$08,$02                  ; sprite_04_Anim_2a:    
            db $62,$08,$02                  ; sprite_04_Anim_2b:    
            db $64,$08,$02                  ; sprite_04_Anim_2c:    
            db $66,$08,$02                  ; sprite_04_Anim_2d:    
            db $70,$08,$02                  ; sprite_04_Anim_2e:    
            db $68,$08,$02                  ; sprite_04_Anim_2f:    
            db $68,$08,$08                  ; sprite_04_Anim_30:    
            db $68,$08,$02                  ; sprite_04_Anim_31:    
            db $70,$08,$02                  ; sprite_04_Anim_32:    
            db $6C,$08,$02                  ; sprite_04_Anim_33:    
            db $6A,$08,$02                  ; sprite_04_Anim_34:    
            db $68,$08,$02                  ; sprite_04_Anim_35:    
            db $6C,$08,$02                  ; sprite_04_Anim_36:    
            db $70,$08,$02                  ; sprite_04_Anim_37:    
            db $68,$08,$02                  ; sprite_04_Anim_38:    
            db $72,$08,$06                  ; sprite_04_Anim_39:    
            db $78,$08,$02                  ; sprite_04_Anim_3a:    
            db $7A,$08,$02                  ; sprite_04_Anim_3b:    
            db $7C,$08,$02                  ; sprite_04_Anim_3c:    
            db $7E,$08,$02                  ; sprite_04_Anim_3d:    
            db $7C,$08,$02                  ; sprite_04_Anim_3e:    
            db $80,$08,$02                  ; sprite_04_Anim_3f:    
            db $82,$08,$02                  ; sprite_04_Anim_40:    
            db $84,$08,$02                  ; sprite_04_Anim_41:    
            db $86,$08,$02                  ; sprite_04_Anim_42:    
            db $88,$08,$04                  ; sprite_04_Anim_43:    
            db $8C,$08,$02                  ; sprite_04_Anim_44:    
            db $6C,$08,$02                  ; sprite_04_Anim_45:    
            db $AA,$08,$02                  ; sprite_04_Anim_46:    
            db $AC,$08,$02                  ; sprite_04_Anim_47:    
            db $AE,$08,$06                  ; sprite_04_Anim_48:    
            db $B2,$14,$06                  ; sprite_04_Anim_49:    
            db $B8,$03,$08                  ; sprite_04_Anim_4a:    
            db $5E,$08,$02                  ; sprite_04_Anim_4b:    
            db $60,$08,$02                  ; sprite_04_Anim_4c:    
    
  sprite_03_Anim_00:  db $02,$08,$04                      
            db $60,$08,$08            ; sprite_03_Anim_01:               
            db $0A,$08,$04                  ; sprite_03_Anim_02:    
            db $36,$04,$08                  ; sprite_03_Anim_03:    
            db $3E,$06,$08                  ; sprite_03_Anim_04:    
            db $46,$04,$0A                  ; sprite_03_Anim_05:    
            db $48,$08,$02                  ; sprite_03_Anim_06:    
            db $4A,$08,$02                  ; sprite_03_Anim_07:    
            db $4C,$08,$04                  ; sprite_03_Anim_08:    
            db $50,$08,$02                  ; sprite_03_Anim_09:    
            db $18,$08,$02                  ; sprite_03_Anim_0a:    
            db $5C,$04,$04                  ; sprite_03_Anim_0b:    
    
  sprite_06_Anim_00:  db $1C,$0A,$06                      
            db $22,$0A,$06          ; sprite_06_Anim_01:                   
            db $28,$10,$06                  ; sprite_06_Anim_02:    
            db $2E,$08,$08                  ; sprite_06_Anim_03:    
            db $36,$0A,$08                  ; sprite_06_Anim_04:    
            db $3E,$60,$04                  ; sprite_06_Anim_05:    
            db $52,$0A,$08                  ; sprite_06_Anim_06:    
            db $5A,$04,$04                  ; sprite_06_Anim_07:    
            db $5E,$0C,$04                  ; sprite_06_Anim_08:    
            db $62,$0A,$06                  ; sprite_06_Anim_09:    
            db $68,$04,$04                  ; sprite_06_Anim_0a:    
endif 


org $3423E 
base $823E
 
      mainSpriteAssem:
            if !cv3ClimbableRope == 1
            dw cv3_trevor_rope_pose_table        ;0D823E|        |      ;
            else
            dw spriteList_trevor_00              ;0D823E|        |0D825C; 
            endif
            dw spriteList_sympha_01              ;0D8240|        |0D82CC;
            dw spriteList_grant_02               ;0D8242|        |0D8324;
            dw spriteList_alucard_03             ;0D8244|        |0D8378;
            
            dw spriteList_enemy_04               ;0D8246|        |0D8BE9;
            dw spriteList_boss_05                ;0D8248|        |0D96A2;
            dw spriteList_objects_06             ;0D824A|        |0DABE7;
            dw spriteList_objects_07             ;0D824C|        |0DAD53;
            dw spriteList_boss_08                ;0D824E|        |0D9FD6;
            dw spriteList_enemy_09               ;0D8250|        |0D8CE9;
            dw spriteList_enemy_0a               ;0D8252|        |0DACE7;
            
            if !cv3ClimbableRope == 1
            dw cv3_trevor_rope_pose_table        ;0D8254|        |      ;
            else
            dw spriteList_trevor_00              ;0D8254|        |0D825C; 
            endif
            dw spriteList_sympha_01              ;0D8256|        |0D82CC;
            dw spriteList_grant_02               ;0D8258|        |0D8324;
            dw spriteList_alucard_03             ;0D825A|        |0D8378;
  
      spriteList_trevor_00:
            dw sprite_00                         ;0D825C|        |0D83BE;
            dw trevorSpr_idle_02                 ;0D825E|        |0D8402;
            dw trevorSpr_walk_04                 ;0D8260|        |0D8410;
            dw trevorSpr_walk_06                 ;0D8262|        |0D841B;
            dw trevorSpr_walk_04                 ;0D8264|        |0D8410;
            dw trevorSpr_stairDown_0A            ;0D8266|        |0D8429;
            dw trevorSpr_stairUp_0C              ;0D8268|        |0D8437;
            dw trevorSpr_duck_0E                 ;0D826A|        |0D8453;
            dw trevorSpr_hurt_10                 ;0D826C|        |0D851E;
            dw trevorSpr_hurt_12                 ;0D826E|        |0D852C;
            dw trevorSpr_dead_14                 ;0D8270|        |0D853A;
            dw trevorSpr_jump_16                 ;0D8272|        |0D8445;
            dw trevorSpr_whipWindup_18           ;0D8274|        |0D8461;
            dw trevorSpr_whipWindup_1A           ;0D8276|        |0D846F;
            dw trevorSpr_whipWindup_1C           ;0D8278|        |0D847D;
            dw trevorSpr_whipWindupDuck_1E       ;0D827A|        |0D848E;
            dw trevorSpr_whipWindupDuck_20       ;0D827C|        |0D849F;
            dw trevorSpr_whipWindupDuck_22       ;0D827E|        |0D84AD;
            dw trevorSpr_whipWindup_24           ;0D8280|        |0D8548;
            dw trevorSpr_whipWindup_26           ;0D8282|        |0D8550;
            dw trevorSpr_whip_28                 ;0D8284|        |0D8558;
            dw trevorSpr_whipWindup_2A           ;0D8286|        |0D8563;
            dw trevorSpr_whipChainWindup_2C      ;0D8288|        |0D856B;
            dw trevorSpr_whipChainWindup_2E      ;0D828A|        |0D8573;
            dw trevorSpr_whipChainShort_30       ;0D828C|        |0D857B;
            dw trevorSpr_whipChainShort_32       ;0D828E|        |0D8586;
            dw trevorSpriteAssemb_34             ;0D8290|        |0D84BE;
            dw trevorSpr_whipWindupStairDown_36  ;0D8292|        |0D84CF;
            dw trevorSpr_whipWindupStairDown_38  ;0D8294|        |0D84DD;
            dw trevorSpr_whipWindupStairUp_3A    ;0D8296|        |0D84EE;
            dw trevorSpr_whipWindupStairUp_3C    ;0D8298|        |0D84FF;
            dw trevorSpr_whipWindupStairUp_3E    ;0D829A|        |0D850D;
            dw trevorSpr_cross_40                ;0D829C|        |0D8597;
            dw trevorSpr_cross_42                ;0D829E|        |0D85A0;
            dw trevorSpr_cross_44                ;0D82A0|        |0D85A8;
            dw trevorSpr_axe_46                  ;0D82A2|        |0D85B0;
            dw trevorSpr_axe_r_48                ;0D82A4|        |0D85B8;
            dw trevorSpr_axe_dr_4A               ;0D82A6|        |0D85C0;
            dw trevorSpr_axe_d_4C                ;0D82A8|        |0D85C8;
            dw trevorSpr_knife_4E                ;0D82AA|        |0D85D0;
            dw trevorSpr_holyWater_HUD_50        ;0D82AC|        |0D85DD;
            dw trevorSpriteAssemb_holyWater_52   ;0D82AE|        |0D85E5;
            dw trevorSpr_whipUpgrade_54          ;0D82B0|        |0D85EA;
            dw trevorSpr_flame_56                ;0D82B2|        |0D93CB;
            dw trevorSpr_flame_58                ;0D82B4|        |0D93D0;
            dw trevorSpr_flame_5A                ;0D82B6|        |0D93D5;
            dw trevorSpr_flame_58                ;0D82B8|        |0D93D0;
            dw trevorSpriteAssemb_5E             ;0D82BA|        |0D85F2;
            dw trevorSpr_flameFull_60            ;0D82BC|        |0D85FB;
            dw trevorSpriteAssemb_62             ;0D82BE|        |0D83F9;
            dw trevorSpriteAssemb_64             ;0D82C0|        |0D85D8;
            dw sprite_00                         ;0D82C2|        |0D83BE;
            dw trevor_boss_appear_68             ;0D82C4|        |0D83C7;
            dw trevor_boss_appear_6A             ;0D82C6|        |0D83D2;
            dw trevor_boss_appear_6C             ;0D82C8|        |0D83E0;
            dw trevor_boss_appear_6E             ;0D82CA|        |0D83EB;
  
      spriteList_sympha_01:
            dw sprite_00                         ;0D82CC|        |0D83BE;
            dw sympha_Spr_walk_02                ;0D82CE|        |0D8604;
            dw sympha_Spr_walk_04                ;0D82D0|        |0D8612;
            dw sympha_Spr_walk_06                ;0D82D2|        |0D8620;
            dw sympha_Spr_walk_04                ;0D82D4|        |0D8612;
            dw sympha_Spr_stairsDown_0A          ;0D82D6|        |0D862E;
            dw sympha_Spr_stairsUp_0C            ;0D82D8|        |0D863C;
            dw sympha_Spr_duck_0E                ;0D82DA|        |0D8658;
            dw sympha_Spr_hurt_10                ;0D82DC|        |0D8666;
            dw sympha_Spr_hurt_12                ;0D82DE|        |0D8674;
            dw sympha_Spr_dead_14                ;0D82E0|        |0D8682;
            dw sympha_Spr_jump_16                ;0D82E2|        |0D864A;
            dw sympha_Spr_attack_18              ;0D82E4|        |0D8690;
            dw sympha_Spr_attack_1A              ;0D82E6|        |0D869E;
            dw sympha_duckAttack_1C              ;0D82E8|        |0D86AC;
            dw sympha_Spr_duckAttack_1E          ;0D82EA|        |0D86BA;
            dw sympha_spr_canWindup_20           ;0D82EC|        |0D8700;
            dw sympha_Spr_canWindup_22           ;0D82EE|        |0D8705;
            dw sympha_Spr_stairDownAttack_24     ;0D82F0|        |0D86C8;
            dw sympha_Spr_stairDownAttack_26     ;0D82F2|        |0D86D6;
            dw sympha_Spr_stairUpAttack_28       ;0D82F4|        |0D86E4;
            dw sympha_Spr_stairUpAttack_2A       ;0D82F6|        |0D86F2;
            dw sympha_Spr_attackFull_2C          ;0D82F8|        |0D8737;
            dw sympha_Spr_attackFullDuck_2E      ;0D82FA|        |0D870D;
            dw sympha_Spr_attackFullStairDown_30 ;0D82FC|        |0D871B;
            dw sympha_Spr_attackFullStairUp_32   ;0D82FE|        |0D8729;
            dw sympha_Spr_handOut_34             ;0D8300|        |0D8745;
            dw sympha_Spr_handOutDuck_36         ;0D8302|        |0D8756;
            dw sympha_Spr_handPutStairDown_38    ;0D8304|        |0D8767;
            dw sympha_Spr_handOutStairUp_3A      ;0D8306|        |0D8778;
            dw sympha_Spr_flame_3C               ;0D8308|        |0D8789;
            dw sympha_Spr_flame_3E               ;0D830A|        |0D878E;
            dw sympha_Spr_flame_40               ;0D830C|        |0D8799;
            dw sympha_Spr_flame_42               ;0D830E|        |0D87AA;
            dw sympha_Spr_flame_44               ;0D8310|        |0D87B8;
            dw sympha_Spr_ice_46                 ;0D8312|        |0D87C8;
            dw sympha_Spr_ice_48                 ;0D8314|        |0D87CD;
            dw sympha_Spr_ice_4A                 ;0D8316|        |0D87D6;
            dw sympha_Spr_ice_4C                 ;0D8318|        |0D87DF;
            dw sympha_Spr_ball_4E                ;0D831A|        |0D87E8;
            dw sympha_Spr_ball_50                ;0D831C|        |0D87F1;
            dw sympha_SpriteAssemb_52            ;0D831E|        |0D87FA;
            dw sympha_IceHUD_54                  ;0D8320|        |0D8802;
            dw sympha_SpriteAssemb_56            ;0D8322|        |0D87C0;
  
      spriteList_grant_02:
            dw sprite_00                         ;0D8324|        |0D83BE;
            dw grant_spr_walk_02                 ;0D8326|        |0D880A;
            dw grant_spr_walk_04                 ;0D8328|        |0D8818;
            dw grant_spr_walk_06                 ;0D832A|        |0D8834;
            dw grant_spr_walk_04                 ;0D832C|        |0D8818;
            dw grant_spr_stairDown_0A            ;0D832E|        |0D8842;
            dw grant_spr_stairUp_0C              ;0D8330|        |0D8850;
            dw grant_spr_duck_0E                 ;0D8332|        |0D886C; 
            dw grant_spr_hurt_10                 ;0D8334|        |0D8874;
            dw grant_spr_hurtDuck_12             ;0D8336|        |0D8882; 
            dw grant_spr_dead_14                 ;0D8338|        |0D888A;
            dw grant_spr_jump_16                 ;0D833A|        |0D885E;
            dw grant_spr_climpWall_18            ;0D833C|        |0D8895;
            dw grant_spr_climpWall_1A            ;0D833E|        |0D889D;
            dw grant_spr_climpWall_attack_1C     ;0D8340|        |0D88AB;
            dw grant_spr_climpCeling_1E          ;0D8342|        |0D88B6;
            dw grant_spr_climpCeling_20          ;0D8344|        |0D88BE;
            dw grant_spr_climpCeling_attack_22   ;0D8346|        |0D88C9;
            dw grant_spr_attack_24               ;0D8348|        |0D88D4;
            dw grant_spr_attack_26               ;0D834A|        |0D88E2;
            dw grant_spr_attack_28               ;0D834C|        |0D899D;
            dw grant_spr_attackStairDown_2A      ;0D834E|        |0D88F3;
            dw grant_spr_attackStairDown_2C      ;0D8350|        |0D8901;
            dw grant_spr_attackStairUp_2E        ;0D8352|        |0D8912;
            dw grant_spr_attackStairUp_30        ;0D8354|        |0D8920;
            dw grant_spr_attackDuck_32           ;0D8356|        |0D8931;
            dw grant_spr_attackDuck_34           ;0D8358|        |0D893F;
            dw grant_spr_climpWallDown_36        ;0D835A|        |0D8950;
            dw grant_spr_climbWallDown_38        ;0D835C|        |0D8958;
            dw grant_spr_climbWallDown_attack_3A ;0D835E|        |0D8966;
            dw grant_spr_climbCornerUp_3C        ;0D8360|        |0D8971;
            dw grant_spr_climbCornerDown_3E      ;0D8362|        |0D897C;
            dw grant_spr_climbCornerUp_40        ;0D8364|        |0D8987;
            dw grant_spr_climbCornerDown_42      ;0D8366|        |0D8992;
            dw grant_spr_attack_knife_44         ;0D8368|        |0D89AB;
            dw grant_spr_attackDuck_46           ;0D836A|        |0D89C0;
            dw grant_spr_attack_48               ;0D836C|        |0D8826;
            dw grant_spr_attackDuck_4A           ;0D836E|        |0D89CE;
            dw grant_spr_attackStairUp_4C        ;0D8370|        |0D89E3;
            dw grant_spr_attackStairUp_4E        ;0D8372|        |0D89F1;
            dw grant_spr_attackStairDown_50      ;0D8374|        |0D8A06;
            dw grant_spr_attackStairDown_52      ;0D8376|        |0D8A14;
  
      spriteList_alucard_03:
            dw sprite_00                         ;0D8378|        |0D83BE;
            dw alucard_spr_Walk_02               ;0D837A|        |0D8A29;
            dw alucard_spr_Walk_04               ;0D837C|        |0D8A3A;
            dw alucard_spr_Walk_06               ;0D837E|        |0D8A4B;
            dw alucard_spr_Walk_04               ;0D8380|        |0D8A3A;
            dw alucard_spr_StairDown_0A          ;0D8382|        |0D8A5C; 
            dw alucard_spr_StairUp_0C            ;0D8384|        |0D8A6D;
            dw alucard_spr_duck_0E               ;0D8386|        |0D8ACE;
            dw alucard_spr_hurt_10               ;0D8388|        |0D8B15;
            dw alucard_spr_hurt_12               ;0D838A|        |0D8B23;
            dw alucard_spr_dead_14               ;0D838C|        |0D8B31;
            dw alucard_spr_duck_16               ;0D838E|        |0D8AC0;
            dw alucard_spr_attack_18             ;0D8390|        |0D8A7E;
            dw alucard_spr_attack_1A             ;0D8392|        |0D8A8F;
            dw alucard_spr_attack_1C             ;0D8394|        |0D8AA9;
            dw alucard_spr_attackDuck_1E         ;0D8396|        |0D8ADC; 
            dw alucard_spr_attackDuck_20         ;0D8398|        |0D8AEA;
            dw alucard_spr_attackDuck_22         ;0D839A|        |0D8B01;
            dw alucard_spr_bat_24                ;0D839C|        |0D8B3F;
            dw alucard_spr_bat_26                ;0D839E|        |0D8B47;
            dw alucard_spr_bat_28                ;0D83A0|        |0D8B4F;
            dw alucard_spr_batTransform_2A       ;0D83A2|        |0D8B57;
            dw alucard_spr_batTransform_2C       ;0D83A4|        |0D8B6B;
            dw alucard_spr_batTransform_2E       ;0D83A6|        |0D8B82;
            dw alucard_spr_batTransform_30       ;0D83A8|        |0D8B90;
            dw alucard_spr_batTransform_32       ;0D83AA|        |0D8B9E;
            dw alucard_spr_batTransform_34       ;0D83AC|        |0D8BBA;
            dw alucard_spr_batTransform_32       ;0D83AE|        |0D8B9E;
            dw alucard_spr_batTransform_30       ;0D83B0|        |0D8B90;
            dw alucard_spr_batTransform_2E       ;0D83B2|        |0D8B82;
            dw alucard_spr_batTransform_2C       ;0D83B4|        |0D8B6B;
            dw alucard_spr_batTransform_2A       ;0D83B6|        |0D8B57;
            dw alucard_shotRed_40                ;0D83B8|        |0D8BD6;
            dw alucard_shotBlue_42               ;0D83BA|        |0D8BDB; 
            dw alucard_spriteAssemb_44           ;0D83BC|        |0D8BE0;



            
  
;             +---------------------------  ; number of 8x16 segments 
;             |
        sprite_00:     
            db $02                               
;             +---------------------------- | Ypos    | if uneven, next attributes will be skipped
;               | +------------------------ | Tile ID   |
;               | | +-------------------- | Attribute | Mirr+Flip+Palette 
;               | | | +---------------- | Xpos      |
;             | | | |
            db $00,$E0,$02,$F8                  
            db $00,$E0,$42,$00                  
;             +---------------------------- if the first byte is $80 you can follow it with the a pointer to continue ?? It was in CV1.. 
  
{ ; spriteList_trevor_00    
  
  trevor_boss_appear_68:
            db $03                               
            db $00,$E2,$02,$F4                   
            db $01,$E4,$FC                     
            db $01,$E6,$04                       
  
  trevor_boss_appear_6A:
            db $04                               
            db $00,$E8,$02,$F0                   
            db $01,$EA,$F8                       
            db $01,$EC,$00                     
            db $01,$EE,$08                       
  
  trevor_boss_appear_6C:
            db $03                               
            db $00,$F0,$02,$F4                   
            db $01,$F2,$FC,$01                   
            db $F4,$04                           
  
  trevor_boss_appear_6E:
            db $04                               
            db $E0,$F6,$02,$F5                   
            db $E1,$F8,$FD,$01                   
            db $FA,$F8,$01,$FC                   
            db $00                               
  
  trevorSpriteAssemb_62:
            db $02                          
            db $F0,$5F,$01,$F8                   
            db $F0,$5F,$41,$00                   
  
    trevorSpr_idle_02:
            db $04                               
            db $E0,$00,$00,$F8                   
            db $E1,$02,$00,$01                   
            db $04,$F8,$01,$06                   
            db $00                               
  
    trevorSpr_walk_04:
            db $03                               
            db $E0,$08,$00,$F8                   
            db $E1,$0A,$00,$01                   
            db $0C,$FB                           
  
    trevorSpr_walk_06:
            db $04                               
            db $E0,$0E,$00,$F8                   
            db $E1,$10,$00,$01                   
            db $12,$F8,$01,$14                   
            db $00                               
  
  trevorSpr_stairDown_0A:
            db $04                               
            db $E0,$0E,$00,$F8                   
            db $E1,$10,$00,$01                   
            db $12,$F8,$01,$18                   
            db $00                               
  
  trevorSpr_stairUp_0C:
            db $04                               
            db $E0,$0E,$00,$F8                   
            db $E1,$10,$00,$01                   
            db $16,$F8,$01,$14                   
            db $00                               
  
    trevorSpr_jump_16:
            db $04                               
            db $E8,$00,$00,$F8                   
            db $E9,$02,$00,$09                   
            db $16,$F8,$09,$18                   
            db $00                               
  
    trevorSpr_duck_0E:
            db $04                               
            db $F0,$00,$00,$F8                   
            db $F1,$02,$00,$11                   
            db $16,$F8,$11,$18                   
            db $00                               
  
  trevorSpr_whipWindup_18:
            db $04                               
            db $E0,$1A,$00,$F9                   
            db $E1,$1C,$01,$E1                   
            db $1E,$09,$01,$0C                   
            db $FF                               
  
  trevorSpr_whipWindup_1A:
            db $04                               
            db $E0,$20,$00,$F8                   
            db $E1,$22,$00,$01                   
            db $12,$F8,$01,$14                   
            db $00                               
  
  trevorSpr_whipWindup_1C:
            db $05                               
            db $E0,$24,$00,$F0                   
            db $E1,$26,$F8,$E1                   
            db $28,$00,$01,$04                   
            db $F8,$01,$06,$00                   
  
  trevorSpr_whipWindupDuck_1E:
            db $05                               
            db $F0,$1A,$00,$F8                   
            db $F1,$1C,$00,$F1                   
            db $1E,$08,$11,$16                   
            db $F8,$11,$18,$00                   
  
  trevorSpr_whipWindupDuck_20:
            db $04                               
            db $F0,$20,$00,$F8                   
            db $F1,$22,$00,$11                   
            db $16,$F8,$11,$18                   
            db $00                               
  
  trevorSpr_whipWindupDuck_22:
            db $05                               
            db $F0,$24,$00,$F0                   
            db $F1,$26,$F8,$F1                   
            db $28,$00,$11,$16                   
            db $F8,$11,$18,$00                   
  
  trevorSpriteAssemb_34:
            db $05                               
            db $E0,$1A,$00,$F8                   
  
  trevorSpr_whipWindupStairDown_34:
            db $E1                               
            db $1C,$00,$E1,$1E                   
            db $08,$01,$12,$F8                   
            db $01,$18,$00                       
  
  trevorSpr_whipWindupStairDown_36:
            db $04                               
            db $E0,$20,$00,$F8                   
            db $E1,$22,$00,$01                   
            db $12,$F8,$01,$18                   
            db $00                               
  
  trevorSpr_whipWindupStairDown_38:
            db $05                               
            db $E0,$24,$00,$F0                   
            db $E1,$26,$F8,$E1                   
            db $28,$00,$01,$12                   
            db $F8,$01,$18,$00                   
  
  trevorSpr_whipWindupStairUp_3A:
            db $05                               
            db $E0,$1A,$00,$F8                   
            db $E1,$1C,$00,$E1                   
            db $1E,$08,$01,$16                   
            db $F8,$01,$14,$00                   
  
  trevorSpr_whipWindupStairUp_3C:
            db $04                               
            db $E0,$20,$00,$F8                   
            db $E1,$22,$00,$01                   
            db $16,$F8,$01,$14                   
            db $00                               
  
  trevorSpr_whipWindupStairUp_3E:
            db $05                               
            db $E0,$24,$00,$F0                   
            db $E1,$26,$F8,$E1                   
            db $28,$00,$01,$16                   
            db $F8,$01,$14,$00                   
  
    trevorSpr_hurt_10:
            db $04                               
            db $E0,$2A,$00,$FA                   
            db $E1,$2C,$02,$01                   
            db $2E,$F8,$01,$18                   
            db $00                               
  
    trevorSpr_hurt_12:
            db $04                               
            db $E0,$2A,$00,$F7                   
            db $E1,$2C,$FF,$01                   
            db $16,$F8,$01,$18                   
            db $00                               
  
    trevorSpr_dead_14:
            db $04                               
            db $00,$30,$00,$E8                   
            db $01,$32,$F0,$01                   
            db $34,$F8,$01,$36                   
            db $00                               
  
  trevorSpr_whipWindup_24:
            db $02                               
            db $E0,$38,$01,$10                   
            db $01,$3A,$10                       
  
  trevorSpr_whipWindup_26:
            db $02                               
            db $E0,$3E,$01,$08                   
            db $E5,$40,$10                       
  
    trevorSpr_whip_28:
            db $03                               
            db $F0,$42,$01,$D8                   
            db $F1,$44,$E0,$F1                   
            db $44,$E8                           
  
  trevorSpr_whipWindup_2A:
            db $02                               
            db $E0,$38,$01,$10                   
            db $01,$3C,$10                       
  
  trevorSpr_whipChainWindup_2C:
            db $02                               
            db $E0,$46,$00,$10                   
            db $01,$48,$10                       
  
  trevorSpr_whipChainWindup_2E:
            db $02                               
            db $E0,$4C,$00,$08                   
            db $E5,$4E,$10                       
  
  trevorSpr_whipChainShort_30:
            db $03                               
            db $F0,$50,$00,$D8                   
            db $F1,$52,$E0,$F1                   
            db $52,$E8                           
  
  trevorSpr_whipChainShort_32:
            db $05                               
            db $F0,$50,$00,$C8                   
            db $F1,$52,$D0,$F1                   
            db $52,$D8,$F1,$52                   
            db $E0,$F1,$52,$E8                   
  
  trevorSpr_cross_40:
            db $02                               
            db $F0,$54,$01,$F8                   
            db $F0,$54,$41,$00                   
  
  trevorSpr_cross_42:
            db $02                               
            db $F0,$56,$01,$F8                   
            db $F1,$58,$00                       
  
  trevorSpr_cross_44:
            db $02                               
            db $F0,$58,$41,$F8                   
            db $F1,$56,$00                       
  
    trevorSpr_axe_46:
            db $02                               
            db $F0,$78,$01,$F8                   
            db $F1,$7A,$00                       
  
  trevorSpr_axe_r_48:
            db $02                               
            db $F0,$7A,$41,$F8                   
            db $F1,$78,$00                       
  
  trevorSpr_axe_dr_4A:
            db $02                               
            db $F0,$7A,$C1,$F8                   
            db $F1,$78,$00                       
  
  trevorSpr_axe_d_4C:
            db $02                               
            db $F0,$78,$81,$F8                   
            db $F1,$7A,$00                       
  
  trevorSpr_knife_4E:
            db $02                               
            db $F0,$7C,$81,$F8                   
            db $F1,$7E,$00                       
  
  trevorSpriteAssemb_64:
            db $01                               
            db $F0,$62,$01,$FC                   
  
  trevorSpr_holyWater_HUD_50:
            db $02                               
            db $F0,$66,$01,$F8                   
            db $F1,$68,$00                       
  
  trevorSpriteAssemb_holyWater_52:
            db $01                               
            db $F0,$5A,$01,$FC                   
  
  trevorSpr_whipUpgrade_54:
            db $02                               
            db $F0,$21,$01,$F8                   
            db $F1,$23,$00                       
  
  trevorSpriteAssemb_5E:
            db $02                               
            db $F0,$15,$03,$F8                   
            db $F0,$15,$43,$00                   
  
  trevorSpr_flameFull_60:
            db $02                               
            db $F0,$17,$03,$F8                   
            db $F0,$17,$43,$00                   

}


{ ; spriteList_sympha_01  
  
  
  sympha_Spr_walk_02:
            db $04                            
            db $E0,$00,$00,$F8                
            db $E1,$02,$00,$01                
            db $04,$F8,$01,$06                
            db $00                            
  
  sympha_Spr_walk_04:
            db $04                            
            db $E0,$08,$00,$F8                
            db $E1,$0A,$00,$01                
            db $0C,$F8,$01,$0E                
            db $00                            
  
  sympha_Spr_walk_06:
            db $04                            
            db $E0,$10,$00,$F8                
            db $E1,$12,$00,$01                
            db $14,$F8,$01,$16                
            db $00                            
  
  sympha_Spr_stairsDown_0A:
            db $04                            
            db $E0,$10,$00,$F8                
            db $E1,$12,$00,$01                
            db $56,$F8,$01,$48                
            db $00                            
  
  sympha_Spr_stairsUp_0C:
            db $04                            
            db $E0,$10,$00,$F8                
            db $E1,$12,$00,$01                
            db $46,$F8,$01,$52                
            db $00                            
  
  sympha_Spr_jump_16:
            db $04                            
            db $E8,$10,$00,$F8                
            db $E9,$44,$00,$09                
            db $46,$F8,$09,$48                
            db $00                            
  
  sympha_Spr_duck_0E:
            db $04                            
            db $F0,$10,$00,$F8                
            db $F1,$44,$00,$11                
            db $46,$F8,$11,$48                
            db $00                            
  
  sympha_Spr_hurt_10:
            db $04                            
            db $E0,$5C,$00,$F7                
            db $E1,$5E,$FF,$01                
            db $46,$F8,$01,$48                
            db $00                            
  
  sympha_Spr_hurt_12:
            db $04                            
            db $E0,$5C,$00,$F7                
            db $E1,$5E,$FF,$01                
            db $46,$F8,$01,$48                
            db $00                            
  
  sympha_Spr_dead_14:
            db $04                            
            db $F0,$60,$00,$E8                
            db $F1,$62,$F0,$F1                
            db $64,$F8,$F1,$66                
            db $00                            
  
  sympha_Spr_attack_18:
            db $04                            
            db $E0,$1E,$00,$F8                
            db $E1,$0A,$00,$01                
            db $0C,$F8,$01,$0E                
            db $00                            
  
  sympha_Spr_attack_1A:
            db $04                            
            db $E0,$20,$00,$F7                
            db $E1,$12,$FF,$01                
            db $22,$F8,$01,$16                
            db $00                            
  
  sympha_duckAttack_1C:
            db $04                            
            db $F0,$4A,$00,$F9                
            db $F1,$12,$01,$11                
            db $46,$F8,$11,$48                
            db $00                            
  
  sympha_Spr_duckAttack_1E:
            db $04                            
            db $F0,$20,$00,$F7                
            db $F1,$12,$FF,$11                
            db $46,$F8,$11,$48                
            db $00                            
  
  sympha_Spr_stairDownAttack_24:
            db $04                            
            db $E0,$4A,$00,$F9                
            db $E1,$12,$01,$01                
            db $56,$F8,$01,$48                
            db $00                            
  
  sympha_Spr_stairDownAttack_26:
            db $04                            
            db $E0,$20,$00,$F7                
            db $E1,$12,$FF,$01                
            db $56,$F8,$01,$48                
            db $00                            
  
  sympha_Spr_stairUpAttack_28:
            db $04                            
            db $E0,$4A,$00,$F9                
            db $E1,$12,$01,$01                
            db $46,$F8,$01,$52                
            db $00                            
  
  sympha_Spr_stairUpAttack_2A:
            db $04                            
            db $E0,$20,$00,$F7                
            db $E1,$12,$FF,$01                
            db $46,$F8,$01,$52                
            db $00                            
  
  sympha_spr_canWindup_20:
            db $01                            
            db $D0,$18,$01,$F9                
  
  sympha_Spr_canWindup_22:
            db $02                            
            db $E0,$1A,$01,$E7                
            db $E5,$1C,$EF                    
  
  sympha_Spr_attackFullDuck_2E:
            db $04                            
            db $F0,$24,$00,$F8                
            db $F1,$26,$00,$11                
            db $46,$F8,$11,$4C                
            db $00                            
  
  sympha_Spr_attackFullStairDown_30:
            db $04                            
            db $E0,$24,$00,$F8                
            db $E1,$26,$00,$01                
            db $58,$F8,$01,$4C                
            db $00                            
  
  sympha_Spr_attackFullStairUp_32:
            db $04                            
            db $E0,$24,$00,$F8                
            db $E1,$26,$00,$01                
            db $46,$F8,$01,$54                
            db $00                            
  
  sympha_Spr_attackFull_2C:
            db $04                            
            db $E0,$24,$00,$F8                
            db $E1,$26,$00,$01                
            db $22,$F8,$01,$28                
            db $00                            
  
  sympha_Spr_handOut_34:
            db $05                            
            db $F0,$2A,$00,$F0                
            db $E1,$2C,$F8,$E1                
            db $02,$00,$01,$2E                
            db $F8,$01,$06,$00                
  
  sympha_Spr_handOutDuck_36:
            db $05                            
            db $F0,$2A,$00,$F0                
            db $E1,$2C,$F8,$E1                
            db $02,$00,$01,$4E                
            db $F8,$01,$50,$00                
  
  sympha_Spr_handPutStairDown_38:
            db $05                            
            db $F0,$2A,$00,$F0                
            db $E1,$2C,$F8,$E1                
            db $12,$00,$01,$5A                
            db $F8,$01,$50,$00                
  
  sympha_Spr_handOutStairUp_3A:
            db $05                            
            db $F0,$2A,$00,$F0                
            db $E1,$2C,$F8,$E1                
            db $12,$00,$01,$4E                
            db $F8,$01,$06,$00                
  
  sympha_Spr_flame_3C:
            db $01                            
            db $F0,$30,$00,$FC                
  
  sympha_Spr_flame_3E:
            db $03                            
            db $F0,$32,$03,$F4                
            db $F1,$34,$FC,$F1                
            db $36,$04                        
  
  sympha_Spr_flame_40:
            db $05                            
            db $F0,$32,$03,$EC                
            db $F1,$3A,$F4,$F1                
            db $3A,$FC,$F1,$3A                
            db $04,$F1,$36,$0C                
  
  sympha_Spr_flame_42:
            db $04                            
            db $F0,$38,$03,$F0                
            db $F1,$3A,$F8,$F1                
            db $3A,$00,$F1,$36                
            db $08                            
  
  sympha_Spr_flame_44:
            db $02                            
            db $F0,$3C,$03,$F8                
            db $F1,$3E,$00                    
  
  sympha_SpriteAssemb_56:
            db $02                            
            db $F0,$40,$03,$F8                
            db $F1,$42,$00                    
  
    sympha_Spr_ice_46:
            db $01                            
            db $F0,$6E,$00,$FC                
  
    sympha_Spr_ice_48:
            db $02                            
            db $F0,$68,$00,$F8                
            db $F0,$68,$C0,$00                
  
    sympha_Spr_ice_4A:
            db $02                            
            db $F0,$6A,$00,$F8                
            db $F0,$6A,$C0,$00                
  
    sympha_Spr_ice_4C:
            db $02                            
            db $F0,$6C,$00,$F8                
            db $F0,$6C,$C0,$00                
  
  sympha_Spr_ball_4E:
            db $02                            
            db $F0,$70,$00,$F8                
            db $F0,$70,$40,$00                
  
  sympha_Spr_ball_50:
            db $02                            
            db $F0,$72,$00,$F8                
            db $F0,$72,$40,$00                
  
  sympha_SpriteAssemb_52:
            db $02                            
            db $F0,$B1,$00,$F8                
            db $F1,$B3,$00                    
  
    sympha_IceHUD_54:
            db $02                            
            db $F0,$B5,$00,$F8                
            db $F1,$B7,$00                    


}


{ ; spriteList_grant_02
  
    grant_spr_walk_02:
            db $04                               
            db $E0,$00,$00,$F4                   
            db $E1,$02,$FC,$01                   
            db $04,$F8,$01,$06                   
            db $00                               
  
    grant_spr_walk_04:
            db $04                               
            db $E0,$08,$00,$F5                   
            db $E1,$0A,$FD,$01                   
            db $0C,$F8,$01,$0E                   
            db $00                               
  
    grant_spr_attack_48:
            db $04                               
            db $D8,$08,$00,$F5                   
            db $D9,$0A,$FD,$F9                   
            db $0C,$F8,$F9,$0E                   
            db $00                               
  
    grant_spr_walk_06:
            db $04                               
            db $E0,$10,$00,$F4                   
            db $E1,$12,$FC,$01                   
            db $14,$F8,$01,$16                   
            db $00                               
  
    grant_spr_stairDown_0A:
            db $04                               
            db $D8,$00,$00,$F8                   
            db $D9,$02,$00,$F9                   
            db $2A,$F8,$F9,$2C                   
            db $00                               
  
    grant_spr_stairUp_0C:
            db $04                               
            db $D8,$00,$00,$F6                   
            db $D9,$02,$FE,$F9                   
            db $26,$F8,$F9,$28                   
            db $00                               
  
    grant_spr_jump_16:
            db $04                               
            db $E0,$00,$00,$F6                   
            db $E1,$02,$FE,$01                   
            db $6C,$F8,$01,$6E                   
            db $00                               
  
    grant_spr_duck_0E:
            db $02                               
            db $F8,$40,$80,$F8                   
            db $F9,$42,$00                       
  
    grant_spr_hurt_10:
            db $04                               
            db $E2,$64,$00,$F8                   
            db $E3,$02,$00,$01                   
            db $2A,$F8,$01,$2C                   
            db $00                               
  
    grant_spr_hurtDuck_12:
            db $02                               
            db $F0,$40,$80,$F8                   
            db $F1,$42,$00                       
  
    grant_spr_dead_14:
            db $03                               
            db $F0,$66,$00,$F0                   
            db $F1,$68,$F8,$F1                   
            db $6A,$00                           
  
    grant_spr_climpWall_18:
            db $02                               
            db $F0,$2E,$00,$F8                   
            db $F1,$30,$00                       
  
    grant_spr_climpWall_1A:
            db $04                               
            db $F0,$32,$00,$F8                   
            db $F1,$34,$00,$11                   
            db $36,$F8,$11,$38                   
            db $00                               
  
    grant_spr_climpWall_attack_1C:
            db $03                               
            db $F0,$3A,$00,$F8                   
            db $F1,$3C,$00,$F1                   
            db $3E,$08                           
  
  grant_spr_climpCeling_1E:
            db $02                               
            db $F0,$40,$00,$F8                   
            db $F1,$42,$00                       
  
  grant_spr_climpCeling_20:
            db $03                               
            db $F0,$44,$00,$F0                   
            db $F1,$46,$F8,$F1                   
            db $48,$00                           
  
  grant_spr_climpCeling_attack_22:
            db $03                               
            db $F0,$4A,$00,$F8                   
            db $F1,$4E,$00,$11                   
            db $4C,$F8                           
  
  
  grant_spr_attack_24:
            db $04                               
            db $E0,$18,$00,$F9                   
            db $E1,$1A,$01,$01                   
            db $14,$F8,$01,$16                   
            db $00                               
  
  grant_spr_attack_26:
            db $05                               
            db $E0,$1C,$00,$EE                   
            db $E1,$1E,$F6,$E1                   
            db $20,$FE,$01,$0C                   
            db $F8,$01,$0E,$00                   
  
  grant_spr_attackStairDown_2A:
            db $04                               
            db $DA,$18,$00,$FB                   
            db $DB,$1A,$03,$F9                   
  
            db $2A,$F8,$F9,$2C                   
            db $00                               
  
  grant_spr_attackStairDown_2C:
            db $05                               
            db $DA,$1C,$00,$EF                   
            db $DB,$1E,$F7,$DB                   
  
            db $20,$FF,$F9,$2A                   
            db $F8,$F9,$2C,$00                   
  
  grant_spr_attackStairUp_2E:
            db $04                               
            db $DA,$18,$00,$F9                   
            db $DB,$1A,$01,$F9                   
  
            db $26,$F8,$F9,$28                   
            db $00                               
  
  grant_spr_attackStairUp_30:
            db $05                               
            db $DA,$1C,$00,$EE                   
            db $DB,$1E,$F6,$DB                    
            db $20,$FE,$F9,$26                   
            db $F8,$F9,$28,$00                   
  
  grant_spr_attackDuck_32:
            db $04                               
            db $E8,$18,$00,$FC                   
            db $E9,$1A,$04,$09                   
            db $22,$F8,$09,$24                   
            db $00                               
  
  grant_spr_attackDuck_34:
            db $05                               
            db $E8,$1C,$00,$EE                   
            db $E9,$1E,$F6,$E9                   
            db $20,$FE,$09,$22                   
            db $F8,$09,$24,$00                   
  
  grant_spr_climpWallDown_36:
            db $02                               
            db $F0,$2E,$80,$F8                   
            db $F1,$30,$00                       
  
  grant_spr_climbWallDown_38:
            db $04                               
            db $D0,$36,$80,$F8                   
            db $D1,$38,$00,$F1                   
            db $32,$F8,$F1,$34                   
            db $00                               
  
  grant_spr_climbWallDown_attack_3A:
            db $03                               
            db $F0,$3A,$80,$F8                   
            db $F1,$3C,$00,$F1                   
            db $3E,$08                           
  
  grant_spr_climbCornerUp_3C:
            db $03                               
            db $E0,$50,$00,$F8                   
            db $01,$52,$F8,$01                   
            db $54,$00                           
  
  grant_spr_climbCornerDown_3E:
            db $03                               
            db $E0,$52,$80,$F8                   
            db $E1,$54,$00,$01                   
            db $50,$F8                           
  
  grant_spr_climbCornerUp_40:
            db $03                               
            db $E0,$56,$00,$F8                   
            db $F1,$58,$00,$F1                   
            db $5A,$08                           
  
  grant_spr_climbCornerDown_42:
            db $03                               
            db $F0,$58,$80,$00                   
            db $F1,$5A,$08,$01                   
            db $56,$F8                           
  
  grant_spr_attack_28:
            db $04                               
            db $E0,$5C,$00,$F8                   
            db $E1,$5E,$00,$01                   
            db $14,$F8,$01,$16                   
            db $00                               
    
    
if !grantNinjaStar == 1 
  grant_spr_attack_knife_44:
            db $05                               
          ; db $E4,$60,$01,$E4                   
            db $E0,$1C,$00,$EC
            db $E1,$1E,$F4                   
            db $E1,$20,$FC                  
            db $01,$14,$F8                   
            db $01,$16,$00  

  grant_spr_attackDuck_4A:
            db $05                               
          ; db $EE,$60,$01,$E6                   
            db $EA,$1C,$00,$EE                   
            db $EB,$1E,$F6
            db $EB,$20,$FE                   
            db $09,$22,$F8                   
            db $09,$24,$00 
 
  grant_spr_attackStairUp_4E:
            db $05                              
          ; db $DC,$60,$01,$E6                   
            db $D8,$1C,$00,$EE                   
            db $D9,$1E,$F6
            db $D9,$20,$FE                   
            db $F9,$26,$f8                   
            db $F9,$28,$00 

  grant_spr_attackStairDown_52:
            db $05                               
          ; db $DC,$60,$01,$E6                   
            db $D8,$1C,$00,$EE                   
            db $D9,$1E,$F6
            db $D9,$20,$FE                   
            db $F9,$2A,$F8                   
            db $F9,$2C,$00            
else  
  
  grant_spr_attack_knife_44:
            db $05                               
            db $E4,$60,$01,$E4                   
            db $E0,$1C,$00,$EC
            db $E1,$1E,$F4                   
            db $E1,$20,$FC                  
            db $01,$14,$F8                   
            db $01,$16,$00   
  
  grant_spr_attackDuck_4A:
            db $06                               
            db $EE,$60,$01,$E6                   
            db $EA,$1C,$00,$EE                   
            db $EB,$1E,$F6
            db $EB,$20,$FE                   
            db $09,$22,$F8                   
            db $09,$24,$00  
  
  grant_spr_attackStairUp_4E:
            db $06                               
            db $DC,$60,$01,$E6                   
            db $D8,$1C,$00,$EE                   
            db $D9,$1E,$F6
            db $D9,$20,$FE                   
            db $F9,$26,$f8                   
            db $F9,$28,$00                                                         

  grant_spr_attackStairDown_52:
            db $06                               
            db $DC,$60,$01,$E6                   
            db $D8,$1C,$00,$EE                   
            db $D9,$1E,$F6
            db $D9,$20,$FE                   
            db $F9,$2A,$F8                   
            db $F9,$2C,$00  
endif 

  grant_spr_attackStairUp_4C:
            db $04                               
            db $D8,$5C,$00,$FA                   
            db $D9,$5E,$02
            db $F9,$26,$F8                   
            db $F9,$28,$00   
  
  grant_spr_attackDuck_46:
            db $04                               
            db $E8,$5C,$00,$FC                   
            db $E9,$5E,$04
            db $09,$22,$F8                  
            db $09,$24,$00   
          
  
  grant_spr_attackStairDown_50:
            db $04                               
            db $D8,$5C,$00,$FA                   
            db $D9,$5E,$02,$F9                   
            db $2A,$F8,$F9,$2C                   
            db $00                                                

}


{ ; spriteList_alucard_03 
  
  alucard_spr_Walk_02:
            db $05                              
            db $C0,$00,$00,$FC                  
            db $E1,$02,$F8,$E1                  
            db $04,$00,$01,$06                  
            db $F9,$01,$08,$01                  
  
  alucard_spr_Walk_04:
            db $05                              
            db $C0,$0A,$00,$FC                  
            db $E1,$0C,$F8,$E1                  
            db $0E,$00,$01,$10                  
            db $F8,$01,$12,$00                  
  
  alucard_spr_Walk_06:
            db $05                              
            db $C0,$00,$00,$FC                  
            db $E1,$14,$F8,$E1                  
            db $16,$00,$01,$18                  
            db $F9,$01,$1A,$01                  
  
  alucard_spr_StairDown_0A:
            db $05                              
            db $C0,$00,$00,$FC                  
            db $E1,$02,$F8,$E1                  
            db $04,$00,$01,$06                  
            db $F9,$01,$1C,$01                  
  
  alucard_spr_StairUp_0C:
            db $05                              
            db $C0,$00,$00,$FC                  
            db $E1,$14,$F8,$E1                  
            db $16,$00,$01,$1E                  
            db $F9,$01,$1A,$01                  
  
  alucard_spr_attack_18:
            db $05                              
            db $C0,$00,$00,$FB                  
            db $E1,$20,$F4,$E1                  
            db $22,$FC,$01,$24                  
            db $F8,$01,$26,$00                  
  
  alucard_spr_attack_1A:
            db $08                              
            db $C0,$00,$00,$FC                  
            db $E1,$02,$F8,$E1                  
            db $28,$00,$E1,$2A                  
            db $08,$01,$06,$F9                  
            db $01,$2C,$00,$01                  
            db $2E,$08,$EB,$30                  
            db $10                              
  
  alucard_spr_attack_1C:
            db $07                              
            db $C0,$00,$00,$FC                  
            db $E1,$02,$F8,$E1                  
            db $32,$00,$E1,$34                  
            db $08,$01,$06,$F9                  
            db $01,$2C,$00,$01                  
            db $2E,$08                          
  
  alucard_spr_duck_16:
            db $04                              
            db $E8,$38,$00,$F8                  
            db $E9,$3A,$00,$09                  
            db $3C,$F8,$09,$3E                  
            db $00                              
  
  alucard_spr_duck_0E:
            db $04                              
            db $F0,$38,$00,$F8                  
            db $F1,$3A,$00,$11                  
            db $3C,$F8,$11,$3E                  
            db $00                              
  
  alucard_spr_attackDuck_1E:
            db $04                              
            db $F0,$40,$00,$F8                  
            db $F1,$42,$00,$11                  
            db $44,$F8,$11,$46                  
            db $00                              
  
  alucard_spr_attackDuck_20:
            db $07                              
            db $F0,$38,$00,$F8                  
            db $F1,$48,$00,$F1                  
            db $2A,$08,$11,$3C                  
            db $F8,$11,$4A,$00                  
            db $11,$2E,$08,$F9                  
            db $30,$10                          
  
  alucard_spr_attackDuck_22:
            db $06                              
            db $F0,$38,$00,$F8                  
            db $F1,$48,$00,$F1                  
            db $34,$08,$11,$3C                  
            db $F8,$11,$4A,$00                  
            db $11,$36,$08                      
  
  alucard_spr_hurt_10:
            db $04                              
            db $E0,$4C,$00,$FB                  
            db $E1,$4E,$03,$01                  
            db $50,$F8,$01,$52                  
            db $00                              
  
  alucard_spr_hurt_12:
            db $04                              
            db $E0,$4C,$00,$F8                  
            db $E1,$4E,$00,$01                  
            db $36,$F8,$01,$3E                  
            db $00                              
  
  alucard_spr_dead_14:
            db $04                              
            db $00,$54,$00,$E8                  
            db $01,$56,$F0,$01                  
            db $58,$F8,$01,$5A                  
            db $00                              
  
  alucard_spr_bat_24:
            db $02                              
            db $F0,$60,$00,$F8                  
            db $F1,$62,$00                      
  
  alucard_spr_bat_26:
            db $02                              
            db $F6,$64,$00,$F8                  
            db $F7,$66,$00                      
  
  alucard_spr_bat_28:
            db $02                              
            db $FC,$68,$00,$F8                  
            db $FD,$6A,$00                      
  
  alucard_spr_batTransform_2A:
            db $06                              
            db $F0,$38,$00,$F8                  
            db $F1,$48,$00,$F1                  
            db $34,$08,$11,$3C                  
            db $F8,$11,$4A,$00                  
            db $11,$36,$08                      
  
  alucard_spr_batTransform_2C:
            db $07                              
            db $F0,$38,$00,$F8                  
            db $F1,$48,$00,$F1                  
            db $2A,$08,$11,$3C                  
            db $F8,$11,$4A,$00                  
            db $11,$2E,$08,$F9                  
            db $30,$10                          
  
  alucard_spr_batTransform_2E:
            db $04                              
            db $F0,$40,$00,$F8                  
            db $F1,$42,$00,$11                  
            db $44,$F8,$11,$46                  
            db $00                              
  
  alucard_spr_batTransform_30:
            db $04                              
            db $00,$6C,$01,$F8                  
            db $01,$6E,$00,$F1                  
            db $40,$F8,$F1,$42                  
  
            db $00                              
  
  alucard_spr_batTransform_32:
            db $08                              
            db $E0,$72,$01,$F8                  
            db $E1,$76,$00,$01                  
            db $74,$F8,$01,$78                  
            db $00,$E1,$70,$F0                  
            db $F0,$40,$00,$F8                  
            db $F1,$42,$00,$E8                  
            db $70,$41,$08                      
  
  alucard_spr_batTransform_34:
            db $08                              
            db $F0,$7A,$01,$F0                  
            db $F1,$7C,$F8,$11                  
            db $7E,$F5,$00,$60                  
            db $00,$F8,$01,$62                  
            db $00,$F0,$7C,$41                  
            db $00,$F1,$7A,$08                  
            db $11,$7E,$03                      
  
  alucard_shotRed_40:
            db $01                              
            db $F0,$5C,$03,$FC                  
  
  alucard_shotBlue_42:
            db $01                              
            db $F0,$5C,$01,$FC                  
  
  alucard_spriteAssemb_44:
            db $02                              
            db $F0,$5E,$01,$FC                  
            db $F0,$5E,$41,$00                  

}



  
  spriteList_enemy_04:
            dw spr_04_09_Zombie_00               ;0D8BE9|        |0D8D7E;
            dw spr_04_09_Zombie_00               ;0D8BEB|        |0D8D7E;
            dw spr_04_Zombie_04                  ;0D8BED|        |0D8D8C;
            dw spr_04_ZombieAppear_06            ;0D8BEF|        |0D8D9A;
            dw spr_04_ZombieAppear_08            ;0D8BF1|        |0D8DA3;
            dw spr_04_Bird_0a                    ;0D8BF3|        |0D8DAB;
            dw spr_04_Bird_0c                    ;0D8BF5|        |0D8DB9;
            dw spr_04_Bird_10                    ;0D8BF7|        |0D8DC1;
            dw spr_04_Bird_0c                    ;0D8BF9|        |0D8DB9;
            dw spr_04_BirdSit_12                 ;0D8BFB|        |0D8DCF;
            dw spr_04_ghost_14                   ;0D8BFD|        |0D8E03;
            dw spr_04_ghost_16                   ;0D8BFF|        |0D8E08; 
            dw spr_04_ghost_18                   ;0D8C01|        |0D8E0D;
            dw spr_04_ghostFull_1A               ;0D8C03|        |0D8E15;
            dw spr_04_ghostFull_1C               ;0D8C05|        |0D8E1D;
            dw spr_04_batHank_1E                 ;0D8C07|        |0D8E25;
            dw spr_04_bat_20                     ;0D8C09|        |0D8E2E;
            dw spr_04_bat_22                     ;0D8C0B|        |0D8E36;
            dw spr_04_bat_24                     ;0D8C0D|        |0D8E3E;
            dw spr_04_bat_22                     ;0D8C0F|        |0D8E36;
            dw spr_04_medusa_28                  ;0D8C11|        |0D8E66;
            dw spr_04_medusa_2A                  ;0D8C13|        |0D8E6E;
            dw spr_04_axeArmor_2C                ;0D8C15|        |0D8E96;
            dw spr_04_axeArmor_2E                ;0D8C17|        |0D8EA7;
            dw spr_04_axeArmor_30                ;0D8C19|        |0D8EB8;
            dw spr_04_axeArmor_32                ;0D8C1B|        |0D8ED3;
            dw spr_04_swordSkellyWalk_34         ;0D8C1D|        |0D8F19;
            dw spr_04_swordSkellyWalk_36         ;0D8C1F|        |0D8F27;
            dw spr_04_blob_38                    ;0D8C21|        |0D90A5;
            dw spr_04_blob_3A                    ;0D8C23|        |0D90AD;
            dw spr_04__3C                        ;0D8C25|        |0D90B5;
            dw spr_04_bonePillar_3E              ;0D8C27|        |0D8F71;
            dw spr_04__40                        ;0D8C29|        |0D8F80;
            dw spr_04__42                        ;0D8C2B|        |0D8F8F;
            dw spr_04__44                        ;0D8C2D|        |0D8F9D;
            dw spr_04_fishMan_jump_46            ;0D8C2F|        |0D8FAB;
            dw spr_04_fishMan_48                 ;0D8C31|        |0D8FBC;
            dw spr_04_fishMan_4A                 ;0D8C33|        |0D8FCA;
            dw spr_04_hunchBack_4C               ;0D8C35|        |0D8FEE;
            dw spr_04_hunchBack_4E               ;0D8C37|        |0D8FF6;
            dw spr_04_hunchBack_4E               ;0D8C39|        |0D8FF6;
            dw spr_04__52                        ;0D8C3B|        |0D8EE7;
            dw spr_04__54                        ;0D8C3D|        |0D8F05;
            dw spr_04_09_Zombie_00               ;0D8C3F|        |0D8D7E;
            dw spr_04_eye_58                     ;0D8C41|        |0D9068;
            dw spr_04_eye_5A                     ;0D8C43|        |0D9070;
            dw spr_04_eye_5C                     ;0D8C45|        |0D9078;
            dw spr_04_eye_5E                     ;0D8C47|        |0D9080;
            dw spr_04_eyeTear_60                 ;0D8C49|        |0D9088;
            dw spr_04_blob_idle_62               ;0D8C4B|        |0D908D;
            dw spr_04_blob_64                    ;0D8C4D|        |0D9095;
            dw spr_04_blob_66                    ;0D8C4F|        |0D909D;
            dw spr_04_mummy_68                   ;0D8C51|        |0D90BD;
            dw spr_04_mummy_6A                   ;0D8C53|        |0D90CE;
            dw spr_04_mummy_6C                   ;0D8C55|        |0D90DF;
            dw spr_04_mummy_6A                   ;0D8C57|        |0D90CE;
            dw spr_04_mummy_dead_70              ;0D8C59|        |0D90F0;
            dw spr_04_mummy_dead_72              ;0D8C5B|        |0D90FE;
            dw spr_04_mummy_appear_74            ;0D8C5D|        |0D9106;
            dw spr_04_mummy_appear_76            ;0D8C5F|        |0D9123;
            dw spr_04_mummy_appear_78            ;0D8C61|        |0D9140;
            dw spr_04_mummy_appear_7A            ;0D8C63|        |0D915C;
            dw spr_04_mummy_appear_7C            ;0D8C65|        |0D9177;
            dw spr_04_medusa_Q2_7E               ;0D8C67|        |0D8E86;
            dw spr_04_medusa_Q2_80               ;0D8C69|        |0D8E8E;
            dw spr_04_09_Zombie_00               ;0D8C6B|        |0D8D7E;
            dw spr_04_09_Zombie_00               ;0D8C6D|        |0D8D7E;
            dw spr_04_09_Zombie_00               ;0D8C6F|        |0D8D7E;
            dw spr_04_09_Zombie_00               ;0D8C71|        |0D8D7E;
            dw spr_04_09_Zombie_00               ;0D8C73|        |0D8D7E;
            dw spr_04_shildGargoyl_8C            ;0D8C75|        |0D919E;
            dw spr_04_shildGargoyl_8E            ;0D8C77|        |0D91B8;
            dw spr_04_shildGargoyl_8E            ;0D8C79|        |0D91B8;
            dw spr_04_skellyWalk_92              ;0D8C7B|        |0D91D2;
            dw spr_04_skellyWalk_94              ;0D8C7D|        |0D91E0;
            dw spr_04_skellyThrow_96             ;0D8C7F|        |0D91EE;
            dw spr_04_skellyThrow_98             ;0D8C81|        |0D91FF;
            dw spr_04_skellyThrow_9A             ;0D8C83|        |0D920D;
            dw spr_04_Skelly_crumble_9C          ;0D8C85|        |0D921E;
            dw spr_04_Skelly_crumble_9E          ;0D8C87|        |0D922D;
            dw spr_04_Skelly_crumble_A0          ;0D8C89|        |0D9235;
            dw spr_04_bone_A2                    ;0D8C8B|        |0D923D;
            dw spr_04_bone_A4                    ;0D8C8D|        |0D9245;
            dw spr_04_bone_A6                    ;0D8C8F|        |0D924A;
            dw spr_04_whipSkelly_A8              ;0D8C91|        |0D9252;
            dw spr_04_whipSkelly_AA              ;0D8C93|        |0D9269;
            dw spr_04_whipSkelly_windup_AC       ;0D8C95|        |0D9281;
            dw spr_04_whipSkelly_windup_AC       ;0D8C97|        |0D9281;
            dw spr_04_bandage_B0                 ;0D8C99|        |0D918D;
            dw spr_04__B2                        ;0D8C9B|        |0D9195;
            dw spr_04_swordSkelly_B4             ;0D8C9D|        |0D8F35;
            dw spr_04_swordSkelly_B6             ;0D8C9F|        |0D8F46;
            dw spr_04__B8                        ;0D8CA1|        |0D92B2;
            dw spr_04_headlessKnight_BA          ;0D8CA3|        |0D92C4;
            dw spr_04_spider_BC                  ;0D8CA5|        |0D9345;
            dw spr_04_spider_BE                  ;0D8CA7|        |0D9356;
            dw spr_04_spider_string_C0           ;0D8CA9|        |0D9367;
            dw spr_04_spider_string_C2           ;0D8CAB|        |0D936C;
            dw spr_04_spider_string_C4           ;0D8CAD|        |0D9375;
            dw spr_04_spider_string_C6           ;0D8CAF|        |0D9382;
            dw spr_04_spider_string_C8           ;0D8CB1|        |0D9393;
            dw spr_04_spider_shot_CA             ;0D8CB3|        |0D93C1;
            dw spr_04_spider_shot_CC             ;0D8CB5|        |0D93C6;
            dw spr_04__CE                        ;0D8CB7|        |0D8E46;
            dw spr_04__D0                        ;0D8CB9|        |0D8E4E;
            dw spr_04__D2                        ;0D8CBB|        |0D8E56;
            dw spr_04__D4                        ;0D8CBD|        |0D8E5E;
            dw spr_04__D2                        ;0D8CBF|        |0D8E56;
            dw spr_04_spider_string_D8           ;0D8CC1|        |0D93A8;
            dw spr_04__DA                        ;0D8CC3|        |0D94A0;
            dw spr_04__DC                        ;0D8CC5|        |0D94A5;
            dw spr_04__DE                        ;0D8CC7|        |0D9455;
            dw spr_04__E0                        ;0D8CC9|        |0D9462;
            dw spr_04__E2                        ;0D8CCB|        |0D946E;
            dw spr_04__E4                        ;0D8CCD|        |0D947E;
            dw spr_04__E6                        ;0D8CCF|        |0D948E;
            dw spr_04__E8                        ;0D8CD1|        |0D9497;
            dw spr_04__EA                        ;0D8CD3|        |0D94AA;
            dw spr_04__EC                        ;0D8CD5|        |0D94B6;
            dw spr_04_whipSkelly_attack_EE       ;0D8CD7|        |0D9295;
            dw spr_04_swordSkelly_F0             ;0D8CD9|        |0D8F5A;
            dw spr_04_headlessKnight_F2          ;0D8CDB|        |0D92D6;
            dw spr_04_headlessKnight_attack_F4   ;0D8CDD|        |0D92EB;
            dw spr_04_headlessKnight_attack_F6   ;0D8CDF|        |0D9309;
            dw spr_04_headlessKnight_attack_F8   ;0D8CE1|        |0D9327;
            dw spr_09_frog_attack_FA             ;0D8CE3|        |0D9517;
            dw spr_09_frog_attack_FC             ;0D8CE5|        |0D9529;
            dw spr_09_speaKnight_attack_Q2_FE    ;0D8CE7|        |0D8D67;
  
  spriteList_enemy_09:
            dw spr_04_09_Zombie_00               ;0D8CE9|        |0D8D7E;
            dw spr_09__02                        ;0D8CEB|        |0D93DA;
            dw spr_09__04                        ;0D8CED|        |0D93E3;
            dw spr_09__06                        ;0D8CEF|        |0D93EC;
            dw spr_09__08                        ;0D8CF1|        |0D93FD;
            dw spr_09__0A                        ;0D8CF3|        |0D9419;
            dw spr_09__0B                        ;0D8CF5|        |0D9430;
            dw spr_09__0E                        ;0D8CF7|        |0D9441;
            dw spr_09__10                        ;0D8CF9|        |0D94C2;
            dw spr_09__12                        ;0D8CFB|        |0D94CD;
            dw spr_09_frog_14                    ;0D8CFD|        |0D94E1;
            dw spr_09_frog_16                    ;0D8CFF|        |0D94EC;
            dw spr_04_09_Zombie_00               ;0D8D01|        |0D8D7E;
            dw spr_09_mudMan_18                  ;0D8D03|        |0D9541;
            dw spr_09_mudMan_1A                  ;0D8D05|        |0D954F;
            dw spr_09_mudMan_1C                  ;0D8D07|        |0D955D;
            dw spr_09_mudMan_1E                  ;0D8D09|        |0D956B; 
            dw spr_09_mudMan_20                  ;0D8D0B|        |0D9574;
            dw spr_09_fishMan_inWater_22         ;0D8D0D|        |0D8FD8;
            dw spr_09_fishMan_inWater_24         ;0D8D0F|        |0D8FE3;
            dw spr_09_fireMan_fire_26            ;0D8D11|        |0D957C;
            dw spr_09_fireMan_fire_28            ;0D8D13|        |0D958D;
            dw spr_09_fireMan_fire_2A            ;0D8D15|        |0D959E;
            dw spr_09_fireMan_fire_2C            ;0D8D17|        |0D95AF;
            dw spr_09_fireMan_fire_2E            ;0D8D19|        |0D95B4;
            dw spr_09__30                        ;0D8D1B|        |0D95B9;
            dw spr_09_speaKnight_32              ;0D8D1D|        |0D95BE;
            dw spr_09_speaKnight_34              ;0D8D1F|        |0D95CC;
            dw spr_09_speaKnight_36              ;0D8D21|        |0D95DA;
            dw spr_09_boneSnakeHead_38           ;0D8D23|        |0D8FFE;
            dw spr_09_boneSnake_3A               ;0D8D25|        |0D9006;
            dw spr_09_boneSnake_3C               ;0D8D27|        |0D901E;
            dw spr_09_boneSnake_3E               ;0D8D29|        |0D902E;
            dw spr_09_boneSnake_40               ;0D8D2B|        |0D903E;
            dw spr_09_boneSnake_42               ;0D8D2D|        |0D9048;
            dw spr_09__44                        ;0D8D2F|        |0D9058;
            dw spr_09_boneSnake_46               ;0D8D31|        |0D900E;
            dw spr_09_boneSnake_48               ;0D8D33|        |0D9016;
            dw spr_09_boneSnake_4A               ;0D8D35|        |0D9026;
            dw spr_09_boneSnake_4C               ;0D8D37|        |0D9036;
            dw spr_09_boneSnake_4E               ;0D8D39|        |0D9043;
            dw spr_09__50                        ;0D8D3B|        |0D9050;
            dw spr_09__52                        ;0D8D3D|        |0D9060;
            dw spr_09_fuzzy_54                   ;0D8D3F|        |0D9612;
            dw spr_09_fuzzy_56                   ;0D8D41|        |0D961A;
            dw spr_09__58                        ;0D8D43|        |0D95E8;
            dw spr_09__5A                        ;0D8D45|        |0D95F6;
            dw spr_09__5C                        ;0D8D47|        |0D9604;
            dw spr_09_frog_5E                    ;0D8D49|        |0D94FD;
            dw spr_09_frog_attack_60             ;0D8D4B|        |0D9508;
            dw spr_09__62                        ;0D8D4D|        |0D9622;
            dw spr_09__64                        ;0D8D4F|        |0D962A;
            dw spr_09__66                        ;0D8D51|        |0D8DD7;
            dw spr_09__68                        ;0D8D53|        |0D8DE5;
            dw spr_09__6A                        ;0D8D55|        |0D8DED;
            dw spr_09__68                        ;0D8D57|        |0D8DE5;
            dw spr_09__6E                        ;0D8D59|        |0D8DFB;
            dw spr_09_harpy_70                   ;0D8D5B|        |0D9632;
            dw spr_09_harpy_72                   ;0D8D5D|        |0D9650;
            dw spr_09_harpy_74                   ;0D8D5F|        |0D9671;
            dw spr_09_harpy_76                   ;0D8D61|        |0D9688;
            dw spr_09_7A                         ;0D8D63|        |0D8E76;
            dw spr_09_7C                         ;0D8D65|        |0D8E7E;

{  ; spriteList_enemy_04, spriteList_enemy_09 

  
  spr_09_speaKnight_attack_Q2_FE:
            db $07                               
            db $F0,$71,$01,$E4                   
            db $E1,$73,$EC,$E1                   
            db $75,$F4,$E1,$77                   
            db $FC,$E1,$79,$04                   
            db $01,$7B,$FC,$01                   
            db $7D,$04                           
  
  spr_04_09_Zombie_00:
            db $04                               
            db $E0,$80,$02,$F4                   
            db $E1,$82,$FC,$01                   
            db $88,$F8,$01,$8A                   
            db $00                               
  
    spr_04_Zombie_04:
            db $04                               
            db $E2,$80,$02,$F5                   
            db $E3,$82,$FD,$01                   
            db $84,$F8,$01,$86                   
            db $00                               
  
  spr_04_ZombieAppear_06:
            db $02                               
            db $00,$90,$02,$F8                   
            db $00,$90,$42,$00                   
  
  spr_04_ZombieAppear_08:
            db $02                               
            db $00,$8C,$02,$F8                   
            db $01,$8E,$00                       
  
    spr_04_Bird_0a:
            db $04                               
            db $E0,$92,$02,$FD                   
            db $E1,$94,$05,$01                   
            db $96,$F8,$01,$98                   
            db $00                               
  
    spr_04_Bird_0c:
            db $02                               
            db $00,$9A,$02,$F8                   
            db $01,$9C,$00                       
  
    spr_04_Bird_10:
            db $04                               
            db $E2,$9E,$02,$F8                   
            db $E3,$A0,$00,$03                   
            db $A2,$F8,$03,$A4                   
            db $00                               
  
    spr_04_BirdSit_12:
            db $02                               
            db $00,$A6,$02,$F8                   
            db $01,$A8,$00                       
  
      spr_09__66:
            db $04                               
            db $E0,$D2,$02,$FD                   
            db $E1,$D4,$05,$01                   
            db $D6,$F8,$01,$D8                   
            db $00                               
  
      spr_09__68:
            db $02                               
            db $00,$DA,$02,$F8                   
            db $01,$DC,$00                       
  
      spr_09__6A:
            db $04                               
            db $E2,$DE,$02,$F8                   
            db $E3,$E0,$00,$03                   
            db $E2,$F8,$03,$E4                   
            db $00                               
  
      spr_09__6E:
            db $02                               
            db $00,$E6,$02,$F8                   
            db $01,$E8,$00                       
  
    spr_04_ghost_14:
            db $01                               
            db $F0,$BE,$01,$FC                   
  
    spr_04_ghost_16:
            db $01                               
            db $F0,$B4,$01,$FC                   
  
    spr_04_ghost_18:
            db $02                               
            db $F0,$B0,$01,$F8                   
            db $F1,$B2,$00                       
  
  spr_04_ghostFull_1A:
            db $02                               
            db $F0,$AA,$01,$F8                   
            db $F1,$AC,$00                       
  
  spr_04_ghostFull_1C:
            db $02                               
            db $F0,$AA,$01,$F8                   
            db $F1,$AE,$00                       
  
    spr_04_batHank_1E:
            db $02                               
            db $F0,$CC,$03,$F8                   
            db $F0,$CC,$43,$00                   
  
      spr_04_bat_20:
            db $02                               
            db $E8,$C0,$03,$F8                   
            db $E9,$C2,$00                       
  
      spr_04_bat_22:
            db $02                               
            db $F0,$C4,$03,$F8                   
            db $F1,$C6,$00                       
  
      spr_04_bat_24:
            db $02                               
            db $F8,$C8,$03,$F8                   
            db $F9,$CA,$00                       
  
      spr_04__CE:
            db $02                               
            db $F0,$DE,$03,$F8                   
            db $F1,$DE,$00                       
  
      spr_04__D0:
            db $02                               
            db $F0,$D2,$03,$F8                   
            db $F1,$D4,$00                       
  
      spr_04__D2:
            db $02                               
            db $F0,$D6,$03,$F8                   
            db $F1,$D8,$00                       
  
      spr_04__D4:
            db $02                               
            db $F0,$DA,$03,$F8                   
            db $F1,$DC,$00                       
  
    spr_04_medusa_28:
            db $02                               
            db $F0,$EA,$01,$F8                   
            db $F1,$EC,$00                       
  
    spr_04_medusa_2A:
            db $02                               
            db $F0,$EE,$01,$F8                   
            db $F1,$F0,$00                       
  
        spr_09_7A:
            db $02                               
            db $F0,$8A,$01,$F8                   
            db $F1,$8C,$00                       
  
        spr_09_7C:
            db $02                               
            db $F0,$8E,$01,$F8                   
            db $F1,$AE,$00                       
  
  spr_04_medusa_Q2_7E:
            db $02                               
            db $F0,$59,$01,$F8                   
            db $F1,$5B,$00                       
  
  spr_04_medusa_Q2_80:
            db $02                               
            db $F0,$5D,$01,$F8                   
            db $F1,$5F,$00                       
  
  spr_04_axeArmor_2C:
            db $05                               
            db $F0,$D6,$01,$F0                   
            db $E1,$D8,$F8,$E1                   
            db $DA,$00,$01,$DC                   
            db $F8,$01,$DE,$00                   
  
  spr_04_axeArmor_2E:
            db $05                               
            db $F0,$D6,$01,$EF                   
            db $E1,$D8,$F7,$E1                   
            db $DA,$FF,$01,$E0                   
            db $F8,$01,$E2,$00                   
  
  spr_04_axeArmor_30:
            db $08                               
            db $F0,$D6,$01,$F0                   
            db $E1,$D8,$F8,$E1                   
            db $E8,$00,$E1,$EE                   
            db $08,$01,$E4,$F8                   
            db $01,$E6,$00,$C8                   
            db $EC,$41,$06,$C9                   
            db $EA,$0E                           
  
  spr_04_axeArmor_32:
            db $06                               
            db $E0,$F0,$01,$ED                   
            db $E1,$F2,$F5
            db $E1,$F4,$FD                  
            db $01,$F6,$F0                   
            db $01,$F8,$F8                   
            db $01,$E6,$00                       
  
      spr_04__52:
            db $09                               
            db $F0,$D4,$01,$F0                   
            db $F1,$D8,$F8,$F1                   
            db $E8,$00,$F1,$EE                   
            db $08,$11,$CE,$F2                   
            db $11,$D0,$FA,$11                   
            db $D2,$03,$D6,$EC                   
            db $41,$06,$D7,$EA                   
            db $0E                               
  
      spr_04__54:
            db $06                               
            db $F0,$F0,$01,$F1                   
            db $F1,$F2,$F9,$F1                   
            db $F4,$01,$11,$CE                   
            db $F2,$11,$D0,$FA                   
            db $11,$D2,$02                       
  
  spr_04_swordSkellyWalk_34:
            db $04                               
            db $E0,$D4,$01,$F7                   
            db $E1,$D6,$FF,$01                   
            db $D8,$F8,$01,$DA                   
            db $00                               
  
  spr_04_swordSkellyWalk_36:
            db $04                               
            db $E2,$D4,$01,$F7                   
            db $E3,$D6,$FF,$01                   
            db $DC,$F8,$01,$DE                   
            db $00                               
  
  spr_04_swordSkelly_B4:
            db $05                               
            db $E2,$E0,$01,$EE                   
            db $E3,$E2,$F6,$E3                   
            db $D6,$FE,$01,$E4                   
            db $F8,$01,$DE,$00                   
  
  spr_04_swordSkelly_B6:
            db $06                               
            db $C0,$E6,$01,$F7                   
            db $C1,$E8,$FF,$E1                   
            db $EA,$F7,$E1,$EC                   
            db $FF,$01,$EE,$F8                   
            db $01,$DA,$00                       
  
  spr_04_swordSkelly_F0:
            db $07                               
            db $E2,$D4,$01,$F6                   
            db $E3,$D6,$FE,$01                   
            db $DC,$F8,$01,$DE                   
            db $00,$FB,$F0,$E0                   
            db $FB,$F2,$E8,$FB                   
            db $F4,$F0                           
  
  spr_04_bonePillar_3E:
            db $04                               
            db $E0,$80,$01,$F8                   
            db $E1,$82,$00,$00                   
            db $82,$41,$F8,$01                   
  
            db $80,$00                           
  
      spr_04__40:
            db $04                               
            db $E0,$FA,$01,$F8                   
            db $E1,$FC,$00,$00                   
            db $FC,$41,$F8,$01                   
            db $FA,$00                           
  
      spr_04__42:
            db $04                               
            db $E0,$90,$03,$F7                   
            db $E1,$92,$FF,$01                   
            db $94,$F8,$01,$96                   
            db $00                               
  
      spr_04__44:
            db $04                               
            db $E2,$90,$03,$F5                   
            db $E3,$92,$FD,$01                   
            db $98,$F8,$01,$9A                   
            db $00                               
  
  spr_04_fishMan_jump_46:
            db $05                               
            db $E0,$9C,$03,$F4                   
            db $E1,$9E,$FC,$E1                   
            db $A0,$04,$01,$A2                   
            db $F8,$01,$A4,$00                   
  
    spr_04_fishMan_48:
            db $04                               
            db $F0,$90,$03,$F7                   
            db $F1,$92,$FF,$11                   
            db $B8,$F8,$11,$BA                   
            db $00                               
  
    spr_04_fishMan_4A:
            db $04                               
            db $E0,$A6,$03,$F7                   
            db $E1,$A8,$FF,$01                   
            db $94,$F8,$01,$96                   
            db $00                               
  
  spr_09_fishMan_inWater_22:
            db $03                               
            db $F0,$B2,$02,$F4                   
            db $F1,$B4,$FC,$F1                   
            db $B6,$04                           
  
  spr_09_fishMan_inWater_24:
            db $03                               
            db $F0,$B2,$82,$F4                   
            db $F1,$B4,$FC,$F1                   
            db $B6,$04                           
  
  spr_04_hunchBack_4C:
            db $02                               
            db $F0,$84,$02,$F8                   
            db $F1,$86,$00                       
  
  spr_04_hunchBack_4E:
            db $02                               
            db $F0,$88,$02,$F8                   
            db $F1,$8A,$00                       
  
  spr_09_boneSnakeHead_38:
            db $02                               
            db $F0,$E0,$01,$F8                   
            db $F1,$E2,$00                       
  
  spr_09_boneSnake_3A:
            db $02                               
            db $F0,$E4,$01,$F8                   
            db $F1,$E6,$00                       
  
  spr_09_boneSnake_46:
            db $02                               
            db $F0,$90,$01,$F8                   
            db $F1,$92,$00                       
  
  spr_09_boneSnake_48:
            db $02                               
            db $F0,$94,$01,$F8                   
            db $F1,$96,$00                       
  
  spr_09_boneSnake_3C:
            db $02                               
            db $F0,$E8,$01,$F8                   
            db $F1,$EA,$00                       
  
  spr_09_boneSnake_4A:
            db $02                               
            db $F0,$98,$01,$F8                   
            db $F1,$9A,$00                       
  
  spr_09_boneSnake_3E:
            db $02                               
            db $F0,$EC,$01,$F8                   
            db $F1,$EE,$00                       
  
  spr_09_boneSnake_4C:
            db $02                               
            db $F0,$9C,$01,$F8                   
            db $F1,$9E,$00                       
  
  spr_09_boneSnake_40:
            db $01                               
            db $F0,$F0,$01,$FC                   
  
  spr_09_boneSnake_4E:
            db $01                               
            db $F0,$A0,$01,$FC                   
  
  spr_09_boneSnake_42:
            db $02                               
            db $F0,$F2,$01,$F8                   
            db $F1,$F4,$00                       
  
      spr_09__50:
            db $02                               
            db $F0,$A2,$01,$F8                   
            db $F1,$A4,$00                       
  
      spr_09__44:
            db $02                               
            db $F0,$FA,$C1,$F8                   
            db $F1,$F8,$00                       
  
      spr_09__52:
            db $02                               
            db $F0,$9A,$C1,$F8                   
            db $F1,$98,$00                       
  
      spr_04_eye_58:
            db $02                               
            db $F0,$80,$03,$F8                   
            db $F1,$82,$00                       
  
      spr_04_eye_5A:
            db $02                               
            db $F0,$80,$03,$F8                   
            db $F1,$86,$00                       
  
      spr_04_eye_5C:
            db $02                               
            db $F0,$84,$03,$F8                   
            db $F1,$86,$00                       
  
      spr_04_eye_5E:
            db $02                               
            db $F0,$88,$03,$F8                   
            db $F1,$82,$00                       
  
    spr_04_eyeTear_60:
            db $01                               
            db $F0,$8A,$03,$FC                   
  
  spr_04_blob_idle_62:
            db $02                               
            db $F0,$8C,$02,$F8                   
            db $F1,$8E,$00                       
  
    spr_04_blob_64:
            db $02                               
            db $F0,$90,$02,$F8                   
            db $F1,$92,$00                       
  
    spr_04_blob_66:
            db $02                               
            db $F0,$94,$02,$F8                   
            db $F1,$96,$00                       
  
    spr_04_blob_38:
            db $02                               
            db $F0,$8E,$C2,$F8                   
            db $F1,$8C,$00                       
  
    spr_04_blob_3A:
            db $02                               
            db $F0,$92,$C2,$F8                   
            db $F1,$90,$00                       
  
      spr_04__3C:
            db $02                               
            db $F0,$96,$C2,$F8                   
            db $F1,$94,$00                       
  
    spr_04_mummy_68:
            db $05                               
            db $E0,$98,$01,$F8                   
            db $E1,$9A,$00,$01                   
            db $9C,$F8,$01,$9E                   
            db $00,$C1,$BE,$FB                   
  
    spr_04_mummy_6A:
            db $05                               
            db $E0,$98,$01,$F8                   
            db $E1,$9A,$00,$01                   
            db $A0,$F8,$01,$A2                   
            db $00,$C1,$BE,$FB                   
  
    spr_04_mummy_6C:
            db $05                               
            db $E0,$98,$01,$F8                   
            db $E1,$9A,$00,$01                   
            db $A4,$F8,$01,$A6                   
            db $00,$C1,$BE,$FB                   
  
  spr_04_mummy_dead_70:
            db $04                               
            db $E0,$A8,$01,$F8                   
            db $E1,$AA,$00,$01                   
            db $9C,$F8,$01,$9E                   
            db $00                               
  
  spr_04_mummy_dead_72:
            db $02                               
            db $00,$AA,$41,$F8                   
            db $01,$A8,$00                       
  
  spr_04_mummy_appear_74:
            db $08                               
            db $A0,$AC,$01,$F8                   
            db $A1,$AE,$00,$C0                   
            db $AE,$41,$F8,$C1                   
            db $AC,$00,$E0,$AC                   
            db $01,$F8,$E1,$AE                   
            db $00,$00,$AE,$41                   
            db $F8,$01,$AC,$00                   
  
  spr_04_mummy_appear_76:
            db $08                               
            db $A0,$AE,$41,$F8                   
            db $A1,$AC,$00,$C0                   
            db $AC,$01,$F8,$C1                   
            db $AE,$00,$E0,$AE                   
            db $41,$F8,$E1,$AC                   
            db $00,$00,$B0,$01                   
            db $F8,$01,$B2,$00                   
  
  spr_04_mummy_appear_78:
            db $08                               
            db $A0,$AC,$01,$F8                   
            db $A1,$AE,$00,$C0                   
            db $AE,$41,$F8,$C1                   
            db $AC,$00,$E0,$AC                   
            db $01,$F8,$E1,$AE                   
            db $00,$01,$A0,$F8                   
            db $01,$A2,$00                       
  
  spr_04_mummy_appear_7A:
            db $08                               
            db $A0,$AE,$41,$F8                   
            db $A1,$AC,$00,$C0                   
            db $AC,$01,$F8,$C1                   
            db $AE,$00,$E1,$B4                   
            db $F8,$E1,$B6,$00                   
            db $01,$A0,$F8,$01                   
            db $A2,$00                           
  
  spr_04_mummy_appear_7C:
            db $06                               
            db $C0,$AE,$41,$F8                   
            db $C1,$AC,$00,$E0                   
            db $98,$01,$F8,$E1                   
            db $9A,$00,$00,$A0                   
            db $01,$F8,$01,$A2                   
            db $00                               
  
    spr_04_bandage_B0:
            db $02                               
            db $F0,$B8,$01,$F8                   
            db $F1,$BA,$00                       
  
      spr_04__B2:
            db $02                               
            db $F0,$BC,$01,$F8                   
            db $F0,$BA,$81,$00                   
  
  spr_04_shildGargoyl_8C:
            db $08                               
            db $E0,$C0,$02,$F0                   
            db $E1,$C2,$F8,$E1                   
            db $C4,$00,$E1,$C6                   
            db $08,$01,$C8,$F8                   
            db $01,$CA,$00,$21                   
            db $CC,$F8,$21,$CE                   
            db $00                               
  
  spr_04_shildGargoyl_8E:
            db $08                               
            db $E2,$C0,$02,$F0                   
            db $E3,$C2,$F8,$E3                   
            db $D0,$00,$F3,$D2                   
            db $08,$03,$C8,$F8                   
            db $03,$CA,$00,$23                   
            db $CC,$F8,$23,$CE                   
            db $00                               
  
  spr_04_skellyWalk_92:
            db $04                               
            db $E0,$C0,$01,$F7                   
            db $E1,$C2,$FF,$01                   
            db $C4,$F8,$01,$C6                   
            db $00                               
  
  spr_04_skellyWalk_94:
            db $04                               
            db $E0,$C0,$01,$F8                   
            db $E1,$C2,$00,$01                   
            db $C8,$F8,$01,$CA                   
            db $00                               
  
  spr_04_skellyThrow_96:
            db $05                               
            db $E0,$D0,$01,$F8                   
            db $E1,$D2,$00,$E1                   
            db $D4,$08,$01,$C4                   
            db $F8,$01,$CE,$00                   
  
  spr_04_skellyThrow_98:
            db $04                               
            db $E0,$D6,$01,$FB                   
            db $E1,$D8,$03,$01                   
            db $CC,$F8,$01,$CE                   
            db $00                               
  
  spr_04_skellyThrow_9A:
            db $05                               
            db $E2,$DA,$01,$EE                   
            db $E1,$DC,$F6,$E1                   
            db $DE,$FE,$01,$C6                   
            db $F8,$01,$C6,$00                   
  
  spr_04_Skelly_crumble_9C:
            db $04                               
            db $E0,$E2,$41,$F9                   
            db $E1,$E0,$FF,$00                   
            db $C8,$01,$F8,$01                   
            db $CA,$00                           
  
  spr_04_Skelly_crumble_9E:
            db $02                               
            db $00,$E0,$01,$F8                   
            db $01,$E2,$00                       
  
  spr_04_Skelly_crumble_A0:
            db $02                               
            db $00,$E4,$01,$F8                   
            db $01,$E6,$00                       
  
    spr_04_bone_A2:
            db $02                               
            db $F0,$F8,$01,$F8                   
            db $F1,$FA,$00                       
  
    spr_04_bone_A4:
            db $01                               
            db $F0,$FC,$01,$FC                   
  
    spr_04_bone_A6:
            db $02                               
            db $F0,$FA,$41,$F8                   
            db $F1,$F8,$00                       
  
  spr_04_whipSkelly_A8:
            db $07                               
            db $E0,$D0,$01,$F8                   
            db $E1,$D2,$00,$E1                   
            db $D4,$08,$E1,$EC                   
            db $10,$01,$C4,$F8                   
            db $01,$CE,$00,$01                   
            db $EE,$10                           
  
  spr_04_whipSkelly_AA:
            db $07                               
            db $E0,$D0,$01,$F7                   
            db $E1,$D2,$FF,$E1                   
            db $D4,$07,$E1,$EC                   
            db $0F,$01,$E8,$F7                   
            db $01,$EA,$FF,$00                   
            db $EE,$41,$0E                       
  
  spr_04_whipSkelly_windup_AC:
            db $06                               
            db $E0,$D6,$01,$FB                   
            db $E1,$D8,$03,$E1                   
            db $F0,$0B,$E3,$F2                   
            db $13,$01,$CC,$F8                   
            db $01,$CE,$00                       
  
  spr_04_whipSkelly_attack_EE:
            db $09                               
            db $F0,$F4,$01,$CE                   
            db $F1,$F6,$D6,$F1                   
            db $F6,$DE,$F1,$F6                   
            db $E6,$E3,$DA,$EE                   
            db $E1,$DC,$F6,$E1                   
            db $DE,$FE,$01,$CC                   
            db $F8,$01,$CE,$00                   
  
      spr_04__B8:
            db $05                               
            db $DC,$C0,$01,$F0                   
  
            db $E0,$C2,$02,$F8                   
            db $E1,$C4,$00,$01                   
            db $C6,$F8,$01,$C8                   
            db $00                               
  
  spr_04_headlessKnight_BA:
            db $05                               
            db $E0,$C0,$01,$EF                   
            db $E0,$C2,$02,$F7                   
            db $E1,$C4,$FF,$01                   
            db $CA,$F7,$01,$CC                   
            db $FF                               
  
  spr_04_headlessKnight_F2:
            db $06                               
            db $E0,$CE,$01,$E8                   
            db $E1,$D0,$F0,$E0                   
            db $C2,$02,$F8,$E1                   
            db $C4,$00,$01,$D2                   
            db $F7,$01,$D4,$FF                   
  
  spr_04_headlessKnight_attack_F4:
            db $09                               
            db $E0,$D6,$01,$D6                   
            db $E1,$D6,$DE,$E0                   
            db $D8,$02,$E6,$E1                   
            db $DA,$EE,$E1,$DC                   
            db $F6,$01,$DE,$E8                   
            db $01,$E0,$F0,$01                   
            db $E2,$F8,$01,$E4                   
            db $00                               
  
  spr_04_headlessKnight_attack_F6:
            db $09                               
            db $E0,$E6,$01,$D6                   
            db $E1,$E8,$DE,$E0                   
            db $D8,$02,$E6,$E1                   
            db $DA,$EE,$E1,$DC                   
            db $F6,$01,$DE,$E8                   
            db $01,$E0,$F0,$01                   
            db $E2,$F8,$01,$E4                   
            db $00                               
  
  spr_04_headlessKnight_attack_F8:
            db $09                               
            db $F6,$E6,$01,$D6                   
            db $F7,$E8,$DE,$E2                   
            db $D8,$02,$E6,$E1                   
            db $DA,$EE,$E1,$DC                   
            db $F6,$01,$DE,$E8                   
            db $01,$E0,$F0,$01                   
            db $E2,$F8,$01,$E4                   
            db $00                               
  
    spr_04_spider_BC:
            db $04                               
            db $E0,$80,$03,$F8                   
            db $E0,$80,$43,$00                   
            db $00,$82,$03,$F8                   
            db $00,$82,$43,$00                   
  
    spr_04_spider_BE:
            db $04                               
            db $E0,$84,$03,$F8                   
            db $E0,$84,$43,$00                   
            db $00,$86,$03,$F8                   
            db $00,$86,$43,$00                   
  
  spr_04_spider_string_C0:
            db $01                               
            db $F0,$8C,$03,$FC                   
  
  spr_04_spider_string_C2:
            db $02                               
            db $E0,$8C,$03,$FC                   
            db $00,$8C,$03,$FC                   
  
  spr_04_spider_string_C4:
            db $03                               
            db $D0,$8C,$03,$FC                   
            db $F0,$8C,$03,$FC                   
            db $10,$8C,$03,$FC                   
  
  spr_04_spider_string_C6:
            db $04                               
            db $C0,$8C,$03,$FC                   
            db $E0,$8C,$03,$FC                   
            db $00,$8C,$03,$FC                   
            db $20,$8C,$03,$FC                   
  
  spr_04_spider_string_C8:
            db $05                               
            db $B0,$8C,$03,$FC                   
            db $D0,$8C,$03,$FC                   
            db $F0,$8C,$03,$FC                   
            db $10,$8C,$03,$FC                   
            db $30,$8C,$03,$FC                   
  
  spr_04_spider_string_D8:
            db $06                               
            db $A0,$8C,$03,$FC                   
            db $C0,$8C,$03,$FC                   
            db $E0,$8C,$03,$FC                   
            db $00,$8C,$03,$FC                   
            db $20,$8C,$03,$FC                   
            db $40,$8C,$03,$FC                   
  
  spr_04_spider_shot_CA:
            db $01                               
            db $F0,$88,$03,$FC                   
  
  spr_04_spider_shot_CC:
            db $01                               
            db $F0,$8A,$03,$FC                   
  
  trevorSpr_flame_56:
            db $01                               
            db $F0,$EB,$03,$FC                   
  
  trevorSpr_flame_58:
            db $01                               
            db $F0,$ED,$03,$FC                   
  
  trevorSpr_flame_5A:
            db $01                               
            db $F0,$EF,$03,$FC                   
  
      spr_09__02:
            db $02                               
            db $E0,$8E,$02,$F8                   
            db $E0,$8E,$42,$FF                   
  
      spr_09__04:
            db $02                               
            db $E0,$90,$02,$F8                   
            db $E0,$90,$42,$FF                   
  
      spr_09__06:
            db $04                               
            db $E0,$92,$02,$F8                   
            db $E0,$92,$42,$FF                   
            db $00,$94,$02,$F8                   
            db $00,$94,$42,$FF                   
  
      spr_09__08:
            db $08                               
            db $E0,$96,$02,$E8                   
            db $E1,$98,$F0,$E1                   
            db $9A,$F8,$E0,$9A                   
            db $42,$FF,$E1,$98                   
            db $07,$E1,$96,$0F                   
            db $00,$9C,$02,$F8                   
            db $01,$9C,$FF                       
  
      spr_09__0A:
            db $07                               
            db $E0,$9E,$02,$F0                   
            db $E1,$A0,$F8,$E1                   
            db $A2,$00,$E1,$A4                   
            db $08,$E1,$A6,$10                   
            db $01,$A8,$F8,$01                   
            db $AA,$00                           
  
      spr_09__0B:
            db $05                               
            db $E0,$AE,$02,$FB                   
            db $E1,$B0,$03,$F9                   
            db $AC,$F0,$01,$B2                   
            db $F8,$01,$B4,$00                   
  
      spr_09__0E:
            db $06                               
            db $F0,$AC,$02,$F0                   
            db $F1,$B6,$F8,$F1                   
            db $B8,$00,$11,$BA                   
            db $F0,$11,$BC,$F8                   
            db $11,$BE,$00                       
  
      spr_04__DE:
            db $03                               
            db $E0,$DE,$03,$F8                   
            db $E0,$DE,$43,$00                   
            db $00,$EA,$03,$FC                   
  
      spr_04__E0:
            db $03                               
            db $E0,$E0,$03,$F8                   
            db $E0,$E0,$43,$00                   
            db $01,$F0,$FC                       
  
      spr_04__E2:
            db $04                               
            db $E0,$E2,$03,$F4                   
            db $E1,$E4,$FC,$E0                   
            db $E2,$43,$04,$00                   
            db $EA,$03,$FC                       
  
      spr_04__E4:
            db $04                               
            db $E0,$E6,$03,$F4                   
            db $E1,$E8,$FC,$E0                   
            db $E6,$43,$04,$00                   
            db $F0,$03,$FC                       
  
      spr_04__E6:
            db $02                               
            db $F0,$DE,$03,$F8                   
            db $F0,$DE,$43,$00                   
  
      spr_04__E8:
            db $02                               
            db $F0,$E0,$03,$F8                   
            db $F0,$E0,$43,$00                   
  
      spr_04__DA:
            db $01                               
            db $F0,$EC,$03,$FC                   
  
      spr_04__DC:
            db $01                               
            db $F0,$EE,$03,$FC                   
  
      spr_04__EA:
            db $03                               
            db $F0,$E2,$03,$F4                   
            db $F1,$E4,$FC,$F0                   
            db $E2,$43,$04                       
  
      spr_04__EC:
            db $03                               
            db $F0,$E6,$03,$F4                   
            db $F1,$E8,$FC,$F0                   
            db $E6,$43,$04                       
  
      spr_09__10:
            db $03                               
            db $F0,$84,$03,$F4                   
            db $F1,$86,$FC,$F1                   
            db $88,$04                           
  
      spr_09__12:
            db $06                               
            db $E0,$84,$03,$F0                   
            db $E1,$86,$F8,$E1                   
            db $A8,$00,$01,$AA                   
            db $F8,$01,$AC,$00                   
            db $F9,$AE,$08                       
  
    spr_09_frog_14:
            db $03                               
            db $F0,$8A,$03,$F4                   
            db $F1,$8C,$FC,$F1                   
            db $88,$04                           
  
    spr_09_frog_16:
            db $05                               
            db $F0,$90,$03,$F0                   
            db $E9,$92,$F8,$E1                   
            db $94,$00,$E1,$96                   
            db $08,$01,$98,$00                   
  
    spr_09_frog_5E:
            db $03                               
            db $F0,$80,$03,$F4                   
            db $F1,$82,$FC,$F1                   
            db $88,$04                           
  
  spr_09_frog_attack_60:
            db $04                               
            db $F0,$9A,$01,$F4                   
            db $F0,$80,$03,$F4                   
            db $F1,$82,$FC,$F1                   
            db $88,$04                           
  
  spr_09_frog_attack_FA:
            db $05                               
            db $F0,$9C,$01,$EC                   
            db $F1,$9E,$F4,$F0                   
            db $80,$03,$F4,$F1                   
            db $82,$FC,$F1,$88                   
            db $04                               
  
  spr_09_frog_attack_FC:
            db $07                               
            db $F0,$9C,$01,$DC                   
            db $F1,$A0,$E4,$F3                   
            db $A0,$EC,$F1,$9E                   
            db $F4,$F0,$80,$03                   
            db $F4,$F1,$82,$FC                   
            db $F1,$88,$04                       
  
    spr_09_mudMan_18:
            db $04                               
            db $E0,$95,$02,$F5                   
            db $E1,$97,$FD,$01                   
            db $99,$F8,$01,$9B                   
            db $00                               
  
    spr_09_mudMan_1A:
            db $04                               
            db $E0,$9D,$02,$F5                   
            db $E1,$9F,$FD,$01                   
            db $B0,$F8,$01,$B2                   
            db $00                               
  
    spr_09_mudMan_1C:
            db $04                               
            db $E0,$B4,$02,$F5                   
            db $E1,$B6,$FD,$01                   
            db $B8,$F8,$01,$BA                   
            db $00                               
  
    spr_09_mudMan_1E:
            db $02                               
            db $00,$A2,$02,$F8                   
            db $00,$A2,$42,$00                   
  
    spr_09_mudMan_20:
            db $02                               
            db $00,$BC,$02,$F8                   
            db $01,$BE,$00                       
  
  spr_09_fireMan_fire_26:
            db $05                               
            db $E0,$D8,$02,$F8                   
            db $E1,$DA,$00,$01                   
            db $DC,$F8,$01,$DE                   
  
            db $00,$01,$E0,$08                   
  
  spr_09_fireMan_fire_28:
            db $05                               
            db $E0,$E2,$02,$F8                   
            db $E1,$E4,$00,$01                   
            db $E6,$F8,$01,$E8                   
            db $00,$01,$EA,$08                   
  
  spr_09_fireMan_fire_2A:
            db $05                               
            db $E0,$EC,$02,$F9                   
            db $E1,$EE,$01,$01                   
            db $F0,$F8,$01,$F2                   
            db $00,$01,$F8,$08                   
  
  spr_09_fireMan_fire_2C:
            db $01                               
            db $F0,$F4,$02,$FC                   
  
  spr_09_fireMan_fire_2E:
            db $01                               
            db $F0,$F6,$02,$FC                   
  
      spr_09__30:
            db $01                               
            db $F0,$F8,$02,$FC                   
  
  spr_09_speaKnight_32:
            db $04                               
            db $E2,$B0,$01,$F8                   
            db $E3,$B2,$00,$01                   
            db $B4,$F8,$01,$B6                   
            db $00                               
  
  spr_09_speaKnight_34:
            db $04                               
            db $E2,$B0,$01,$F8                   
            db $E3,$B2,$00,$01                   
            db $B8,$F8,$01,$BA                   
            db $00                               
  
  spr_09_speaKnight_36:
            db $04                               
            db $E0,$B0,$01,$F8                   
            db $E1,$B2,$00,$01                   
            db $BC,$F8,$01,$BE                   
            db $00                               
  
      spr_09__58:
            db $04                               
            db $E2,$C0,$01,$F8                   
            db $E3,$C2,$00,$01                   
            db $C4,$F8,$01,$C6                   
            db $00                               
  
      spr_09__5A:
            db $04                               
            db $E2,$C0,$01,$F8                   
            db $E3,$C2,$00,$01                   
            db $C8,$F8,$01,$CA                   
            db $00                               
  
      spr_09__5C:
            db $04                               
            db $E0,$C0,$01,$F8                   
            db $E1,$C2,$00,$01                   
            db $CC,$F8,$01,$CE                   
            db $00                               
  
    spr_09_fuzzy_54:
            db $02                               
            db $F0,$F6,$01,$F8                   
            db $F1,$F8,$00                       
  
    spr_09_fuzzy_56:
            db $02                               
            db $F0,$FA,$01,$F8                   
            db $F1,$FC,$00                       
  
      spr_09__62:
            db $02                               
            db $F0,$B6,$01,$F8                   
            db $F1,$B8,$00                       
  
      spr_09__64:
            db $02                               
            db $F0,$BA,$01,$F8                   
            db $F1,$BC,$00                       
  
    spr_09_harpy_70:
            db $09                               
            db $D0,$C0,$01,$F0                   
            db $E1,$C2,$F8,$E1                   
            db $C4,$00,$DB,$C6                   
            db $08,$D1,$C8,$10                   
            db $01,$CA,$FB,$01                   
            db $CC,$03,$1A,$84                   
            db $02,$F8,$1B,$86                   
            db $00                               
  
    spr_09_harpy_72:
            db $0A                               
            db $E6,$CE,$01,$F0                   
            db $E1,$D0,$F8,$E1                   
            db $D2,$00,$E7,$D4                   
            db $08,$05,$D6,$F0                   
            db $01,$D8,$F8,$01                   
            db $DA,$00,$05,$DC                   
            db $08,$1E,$88,$02                   
            db $F8,$1F,$8A,$00                   
  
    spr_09_harpy_74:
            db $07                               
            db $D0,$C0,$01,$F0                   
            db $E1,$C2,$F8,$E1                   
            db $C4,$00,$DB,$C6                   
            db $08,$D1,$C8,$10                   
            db $01,$CA,$FB,$01                   
            db $CC,$03                           
  
    spr_09_harpy_76:
            db $08                               
            db $E6,$CE,$01,$F0                   
            db $E1,$D0,$F8,$E1                   
            db $D2,$00,$E7,$D4                   
            db $08,$05,$D6,$F0                   
            db $01,$D8,$F8,$01                   
            db $DA,$00,$05,$DC                   
            db $08                               

}

  
  spriteList_boss_05:
            dw spr_05_bossBoneKing_walk_00       ;0D96A2|        |0D9782;
            dw spr_05_bossBoneKing_walk_00       ;0D96A4|        |0D9782;
            dw spr_05_bossBoneKing_walk_04       ;0D96A6|        |0D97A9;
            dw spr_05_bossBoneKing_walk_06       ;0D96A8|        |0D97CA;
            dw spr_05_bossBoneKing_walk_04       ;0D96AA|        |0D97A9;
            dw spr_05_bossBoneKing_attack_0A     ;0D96AC|        |0D97EE;
            dw spr_05_bossBoneKing_attack_0C     ;0D96AE|        |0D9815;
            dw spr_05_bossBoneKing_attack_0E     ;0D96B0|        |0D9836;
            dw spr_05_bossBoneKing_jump_10       ;0D96B2|        |0D9860; 
            dw spr_05__12                        ;0D96B4|        |0D9881;
            dw spr_05__14                        ;0D96B6|        |0D9889;
            dw spr_05__16                        ;0D96B8|        |0D988E;
            dw spr_05_bossStoneGolum_18          ;0D96BA|        |0D9896;
            dw spr_05_bossStoneGolum_1A          ;0D96BC|        |0D98B7;
            dw spr_05_bossStoneGolum_hammer_1C   ;0D96BE|        |0D98D8;
            dw spr_05_bossStoneGolum_1A          ;0D96C0|        |0D98B7;
            dw spr_05_bossStoneGolum_hammer_20   ;0D96C2|        |0D98FC;
            dw spr_05_bossStoneGolum_hammer_22   ;0D96C4|        |0D9920;
            dw spr_05__24                        ;0D96C6|        |0D9944;
            dw spr_05__26                        ;0D96C8|        |0D9961;
            dw spr_05_lighningLvL_28             ;0D96CA|        |0D996F;
            dw spr_05_bossBoneKing_walk_00       ;0D96CC|        |0D9782;
            dw spr_05_bossBoneKing_walk_00       ;0D96CE|        |0D9782; 
            dw spr_05_lighning_2E                ;0D96D0|        |0D9978;
            dw spr_05_bossBoneKing_walk_00       ;0D96D2|        |0D9782;
            dw spr_05_bossBoneKing_walk_00       ;0D96D4|        |0D9782; 
            dw spr_05_bossBoneKing_walk_00       ;0D96D6|        |0D9782;
            dw spr_05_bossBoneKing_walk_00       ;0D96D8|        |0D9782;
            dw spr_05_bossBoneKing_walk_00       ;0D96DA|        |0D9782;
            dw spr_05_bossGrant_pre_3A           ;0D96DC|        |0D99F3;
            dw spr_05_bossGrant_jump_3C          ;0D96DE|        |0D9A07;
            dw spr_05_bossGrant_climbWall_3E     ;0D96E0|        |0D9A1B;
            dw spr_05_bossGrant_climbWall_40     ;0D96E2|        |0D9A2F;
            dw spr_05_bossGrant_climbCelling_42  ;0D96E4|        |0D9A43;
            dw spr_05_bossGrant_climbCelling_44  ;0D96E6|        |0D9A57;
            dw spr_05_bossGrant_46               ;0D96E8|        |0D9A6E;
            dw spr_05_bossGrant_48               ;0D96EA|        |0D9A82;
            dw spr_05_bossGrant_dead_4A          ;0D96EC|        |0D9A96;
            dw spr_05_bossGrant_dagger_4C        ;0D96EE|        |0D9AA7;
            dw spr_05__4E                        ;0D96F0|        |0D9AAF;
            dw spr_05__50                        ;0D96F2|        |0D9AB7;
            dw spr_05__52                        ;0D96F4|        |0D9ABF;
            dw spr_05__54                        ;0D96F6|        |0D9AC7;
            dw spr_05_bossBat_big_56             ;0D96F8|        |0D9AF0;
            dw spr_05_bossBat_big_58             ;0D96FA|        |0D9B17;
            dw spr_05_bossBat_mid_5A             ;0D96FC|        |0D9B31;
            dw spr_05_bossBat_mid_5C             ;0D96FE|        |0D9B48;
            dw spr_05_bossBat_small_5E           ;0D9700|        |0D9B5F;
            dw spr_05_bossBat_small_60           ;0D9702|        |0D9B6A;
            dw spr_05_bossBat_tiny_62            ;0D9704|        |0D9B78;
            dw spr_05_bossBat_tiny_64            ;0D9706|        |0D9B80; 
            dw spr_05_bossBat_pre_66             ;0D9708|        |0D9B88;
            dw spr_05__68                        ;0D970A|        |0D9B96;
            dw spr_05__6A                        ;0D970C|        |0D9BBD;
            dw spr_05_alucard_head_6C            ;0D970E|        |0D9BD7;
            dw spr_05_alucard_appear_6E          ;0D9710|        |0D9BDC; 
            dw spr_05_alucard_appear_70          ;0D9712|        |0D9BF6;
            dw spr_05_alucard_appear_72          ;0D9714|        |0D9C17;
            dw spr_05_alucard_appear_74          ;0D9716|        |0D9C45;
            dw spr_05_alucard_appear_76          ;0D9718|        |0D9C66;
            dw spr_05_alucard_attackFull_78      ;0D971A|        |0D9C87;
            dw spr_05_alucard_bat_7A             ;0D971C|        |0D9CB1;
            dw spr_05_alucard_bats_7C            ;0D971E|        |0D9CBD;
            dw spr_05__7E                        ;0D9720|        |0D9CC6;
            dw spr_05_alucard_flameShot_80       ;0D9722|        |0D9CCE;
            dw spr_05__82                        ;0D9724|        |0D9CD6;
            dw spr_05_alucard_death_84           ;0D9726|        |0D9CDE;
            dw spr_05_alucard_death_86           ;0D9728|        |0D9CFB;
            dw spr_05_alucard_death_88           ;0D972A|        |0D9D15;
            dw spr_05_alucard_rise_8A            ;0D972C|        |0D9D26;
            dw spr_05_alucard_rise_8C            ;0D972E|        |0D9D37;
            dw spr_05_alucard_rise_8E            ;0D9730|        |0D9D45;
            dw spr_05_alucard_rise_90            ;0D9732|        |0D9D53;
            dw spr_05_alucard_rise_92            ;0D9734|        |0D9D61;
            dw spr_05_bossGrant_rise_94          ;0D9736|        |0D9ACF;
            dw spr_05_bossGrant_rise_96          ;0D9738|        |0D9ADD;
            dw spr_05_bossGrant_rise_98          ;0D973A|        |0D9AE8;
            dw spr_05__9A                        ;0D973C|        |0D9D6F;
            dw spr_05__9C                        ;0D973E|        |0D9D7D;
            dw spr_05_bossBoneDragon_head_9E     ;0D9740|        |0D9D88;
            dw spr_05_bossBoneDragon_A0          ;0D9742|        |0D9D93;
            dw spr_05_bossBoneDragon_A2          ;0D9744|        |0D9DA1;
            dw spr_05_bossBoneDragon_A4          ;0D9746|        |0D9DAF;
            dw spr_05_bossBoneDragon_A6          ;0D9748|        |0D9DB7;
            dw spr_05_bossBoneDragon_A8          ;0D974A|        |0D9DBF;
            dw spr_05_bossBoneDragon_AA          ;0D974C|        |0D9DC4;
            dw spr_05_bossBoneDragon_AC          ;0D974E|        |0D9DCC;
            dw spr_05__AE                        ;0D9750|        |0D9DD4;
            dw spr_05__B0                        ;0D9752|        |0D9DD9;
            dw spr_05__B2                        ;0D9754|        |0D9DDE;
            dw spr_05__B4                        ;0D9756|        |0D9DE3;
            dw spr_05__B6                        ;0D9758|        |0D9DE8;
            dw spr_05_bossWaterDragons_splash_B8 ;0D975A|        |0D9DED;
            dw spr_05_bossWaterDragons_splash_BA ;0D975C|        |0D9DF2;
            dw spr_05_bossWaterDragons_splash_BC ;0D975E|        |0D9DFB;
            dw spr_05_bossWaterDragons_splash_BE ;0D9760|        |0D9E1A;
            dw spr_05_bossWaterDragons_splash_C0 ;0D9762|        |0D9E31;
            dw spr_05_bossWaterDragons_splash_C2 ;0D9764|        |0D9E40; 
            dw spr_05_bossFrank_C4               ;0D9766|        |0D9E4F;
            dw spr_05_bossFrank_C6               ;0D9768|        |0D9E75;
            dw spr_05_bossFrank_C8               ;0D976A|        |0D9E95;
            dw spr_05_bossFrank_C6               ;0D976C|        |0D9E75;
            dw spr_05_bossFrank_attack_CC        ;0D976E|        |0D9EBB;
            dw spr_05_bossFrank_attack_CE        ;0D9770|        |0D9EE1;
            dw spr_05_bossFrank_attack_D0        ;0D9772|        |0D9F0A;
            dw spr_05_bossFrank_throw_D2         ;0D9774|        |0D9F30;
            dw spr_05_bossFrank_throw_D4         ;0D9776|        |0D9F56;
            dw spr_05_bossFrank_death_D6         ;0D9778|        |0D9F82;
            dw spr_05_bossFrank_throw_D8         ;0D977A|        |0D9F9F;
            dw spr_05_bossFrank_hit_DA           ;0D977C|        |0D9FB3;
            dw spr_05__DC                        ;0D977E|        |0DA9B9;
            dw spr_05__DE                        ;0D9780|        |0DA99B;


{ ; spriteList_boss_05 
  
  spr_05_bossBoneKing_walk_00:
            db $0C                             
            db $F0,$C0,$03,$00                 
            db $F1,$C2,$08,$D2                 
            db $80,$02,$EE,$D3                 
            db $82,$F6,$D3,$84                 
            db $FE,$D1,$86,$E8                 
            db $F1,$88,$E8,$F1                 
            db $8A,$F0,$F1,$8C                 
            db $F8,$11,$8E,$F8                 
            db $11,$90,$00,$11                 
            db $92,$08                         
  
  spr_05_bossBoneKing_walk_04:
            db $0A                             
            db $F2,$C0,$03,$FF                 
            db $F3,$C2,$07,$D0                 
            db $80,$02,$F0,$D1                 
  
            db $82,$F8,$D1,$84                 
  
            db $00,$E1,$94,$E8                 
            db $F1,$96,$F0,$F1                 
            db $98,$F8,$11,$9A                 
            db $FA,$11,$9C,$02                 
  
  spr_05_bossBoneKing_walk_06:
            db $0B                             
            db $F2,$C0,$03,$FD                 
            db $F3,$C2,$05,$D2                 
            db $80,$02,$F0,$D3                 
  
            db $82,$F8,$D3,$84                 
  
            db $00,$F1,$9E,$E8                 
            db $F1,$A0,$F0,$F1                 
            db $A2,$F8,$11,$A4                 
            db $F8,$11,$A6,$00                 
            db $11,$A8,$08                     
  
  spr_05_bossBoneKing_attack_0A:
            db $0C                             
            db $F0,$C0,$03,$01                 
            db $F1,$C2,$09,$D2                 
            db $80,$02,$F3,$D3                 
  
            db $82,$FB,$D3,$84                 
  
            db $03,$D1,$86,$EA                 
            db $F1,$88,$EA,$F1                 
            db $8A,$F2,$F1,$8C                 
            db $FA,$11,$8E,$F8                 
            db $11,$90,$00,$11                 
            db $92,$08                         
  
  spr_05_bossBoneKing_attack_0C:
            db $0A                             
            db $F0,$C0,$03,$01                 
            db $F1,$C2,$09,$D2                 
            db $AA,$02,$F8,$D3                 
            db $AC,$00,$D3,$AE                 
            db $08,$D3,$B0,$10                 
            db $F1,$8C,$FB,$11                 
            db $8E,$F8,$11,$90                 
            db $00,$11,$92,$08                 
  
  spr_05_bossBoneKing_attack_0E:
            db $0D                             
            db $F2,$C0,$03,$00                 
            db $F3,$C2,$08,$D2                 
            db $80,$02,$F0,$D3                 
            db $82,$F8,$D3,$84                 
            db $00,$F7,$9E,$D8                 
            db $F7,$A0,$E0,$F5                 
            db $B2,$E8,$F1,$B4                 
            db $F0,$F1,$A2,$F8                 
            db $11,$A4,$F8,$11                 
            db $A6,$00,$11,$A8                 
            db $08                             
  
  spr_05_bossBoneKing_jump_10:
            db $0A                             
            db $F2,$C0,$03,$FF                 
            db $F3,$C2,$07,$D0                 
            db $80,$02,$F0,$D1                 
  
            db $82,$F8,$D1,$84                 
  
            db $00,$E1,$94,$E8                 
            db $F1,$96,$F0,$F1                 
            db $98,$F8,$11,$F2                 
            db $F8,$11,$F4,$00                 
  
      spr_05__12:
            db $02                             
            db $F8,$EC,$02,$F8                 
            db $F9,$EE,$00                     
  
      spr_05__14:
            db $01                             
            db $F8,$F0,$02,$FC                 
  
      spr_05__16:
            db $02                             
            db $F8,$EE,$42,$F8                 
            db $F9,$EC,$00                     
  
  spr_05_bossStoneGolum_18:
            db $0A                             
            db $C2,$80,$01,$F2                 
            db $C3,$82,$FA,$C3                 
            db $84,$02,$E1,$86                 
            db $F6,$E1,$88,$FE                 
            db $E1,$8A,$06,$01                 
            db $8C,$FC,$01,$8E                 
            db $04,$BA,$B4,$02                 
            db $FF,$BB,$B6,$07                 
  
  spr_05_bossStoneGolum_1A:
            db $0A                             
            db $C0,$80,$01,$F3                 
            db $C1,$82,$FB,$C1                 
            db $84,$03,$E1,$90                 
            db $F7,$E1,$92,$FF                 
            db $E1,$94,$07,$01                 
            db $96,$FB,$01,$98                 
            db $03,$BA,$B4,$02                 
            db $00,$BB,$B6,$08                 
  
  spr_05_bossStoneGolum_hammer_1C:
            db $0B                             
            db $C0,$80,$01,$F4                 
            db $C1,$82,$FC,$C1                 
            db $84,$04,$E1,$9A                 
            db $F8,$E1,$9C,$00                 
            db $E1,$9E,$08,$01                 
            db $A0,$F8,$01,$A2                 
            db $00,$01,$A4,$08                 
            db $B8,$B4,$02,$00                 
            db $B9,$B6,$08                     
  
  spr_05_bossStoneGolum_hammer_20:
            db $0B                             
            db $C0,$A6,$01,$F9                 
            db $C1,$A8,$01,$C1                 
            db $AA,$09,$E1,$AC                 
            db $F8,$E1,$AE,$00                 
            db $E1,$B0,$08,$01                 
            db $A0,$F8,$01,$A2                 
            db $00,$01,$A4,$08                 
            db $B0,$B8,$02,$08                 
            db $B1,$BA,$10                     
  
  spr_05_bossStoneGolum_hammer_22:
            db $0B                             
            db $C0,$80,$01,$F2                 
            db $C1,$82,$FA,$C1                 
            db $84,$02,$E1,$B2                 
            db $F6,$E1,$88,$FE                 
            db $E1,$8A,$06,$01                 
            db $8C,$FC,$01,$8E                 
            db $04,$00,$B8,$02                 
            db $E4,$01,$BA,$EC                 
            db $01,$BE,$F4                     
  
      spr_05__24:
            db $09                             
            db $A0,$C4,$02,$FB                 
            db $C1,$C6,$F3,$C1                 
            db $C8,$FB,$C1,$CA                 
            db $03,$E1,$CC,$F8                 
            db $E1,$CE,$00,$01                 
            db $D0,$F3,$01,$D2                 
            db $FB,$01,$D4,$03                 
  
      spr_05__26:
            db $04                             
            db $F0,$51,$01,$F0                 
            db $F1,$61,$F8,$F1                 
            db $53,$00,$F1,$63                 
            db $08                             
  
  spr_05_lighningLvL_28:
            db $02                             
            db $00,$F4,$01,$FC                 
            db $18,$F4,$41,$F8                 
  
  spr_05_lighning_2E:
            db $1B                             
            db $80,$F0,$01,$FC                 
  
            db $91,$C4,$CC,$91                 
            db $C8,$D4,$90,$C4                 
            db $C1,$DC,$A0,$C6                 
            db $41,$E4,$A1,$C8                 
            db $EC,$A0,$C4,$01                 
            db $F4,$A0,$F2,$41                 
            db $FC,$B0,$E0,$01                 
            db $D4,$B1,$D6,$DC                 
            db $B1,$C4,$04,$C1                 
            db $D8,$CC,$C1,$F2                 
            db $FC,$D0,$D8,$41                 
            db $D4,$E0,$F2,$01                 
            db $F6,$E1,$F0,$FC                 
            db $E1,$C8,$04,$E1                 
            db $CE,$0C,$01,$F2                 
            db $F2,$00,$F2,$C1                 
            db $FC,$00,$C2,$01                 
            db $14,$21,$E0,$E4                 
            db $21,$F2,$EC,$20                 
            db $F0,$C1,$FC,$40                 
            db $CA,$41,$E4,$40                 
            db $F2,$01,$FC,$60                 
            db $F2,$41,$FC                     
  
  spr_05_bossStoneGolum_dead_10:
            db $08                             
            db $C2,$80,$01,$F2                 
            db $C3,$82,$FA,$C3                 
            db $84,$02,$E1,$86                 
            db $F6,$E1,$88,$FE                 
            db $E1,$8A,$06,$BA                 
            db $B4,$02,$FF,$BB                 
            db $B6,$07                         
  
  spr_05_bossGrant_pre_3A:
            db $06                             
            db $E0,$80,$02,$F8                 
            db $E1,$82,$00,$E1                 
            db $84,$08,$01,$86                 
            db $F8,$01,$88,$00                 
            db $01,$8A,$08                     
  
  spr_05_bossGrant_jump_3C:
            db $06                             
            db $F0,$8C,$02,$E8                 
            db $E1,$8E,$F0,$E1                 
            db $90,$F8,$E1,$92                 
            db $00,$01,$94,$00                 
            db $01,$96,$08                     
  
  spr_05_bossGrant_climbWall_3E:
            db $06                             
            db $E0,$98,$02,$F0                 
            db $E1,$9A,$F8,$E1                 
            db $9C,$00,$01,$9E                 
            db $F0,$01,$A0,$F8                 
            db $01,$A2,$00                     
  
  spr_05_bossGrant_climbWall_40:
            db $06                             
            db $D6,$A4,$02,$F0                 
            db $E1,$A6,$F8,$E1                 
            db $A8,$00,$11,$AA                 
            db $F0,$01,$AC,$F8                 
            db $01,$AE,$00                     
  
  spr_05_bossGrant_climbCelling_42:
            db $06                             
            db $F0,$B0,$02,$F0                 
            db $E1,$B2,$F8,$E1                 
            db $B4,$00,$01,$B6                 
            db $F8,$01,$B8,$00                 
            db $F1,$BA,$08                     
  
  spr_05_bossGrant_climbCelling_44:
            db $07                             
            db $E0,$BC,$02,$F0                 
            db $E1,$BE,$F8,$01                 
            db $C0,$F0,$01,$C2                 
            db $F8,$F1,$C4,$00                 
            db $E9,$C6,$08,$E1                 
            db $C8,$10                         
  
  spr_05_bossGrant_46:
            db $06                             
            db $E0,$9E,$82,$F0                 
            db $E1,$A0,$F8,$E1                 
            db $A2,$00,$01,$98                 
            db $F0,$01,$9A,$F8                 
            db $01,$9C,$00                     
  
  spr_05_bossGrant_48:
            db $06                             
            db $D0,$AA,$82,$F0                 
            db $E1,$AC,$F8,$E1                 
            db $AE,$00,$0B,$A4                 
            db $F0,$01,$A6,$F8                 
            db $01,$A8,$00                     
  
  spr_05_bossGrant_dead_4A:
            db $05                             
            db $F0,$CE,$02,$E8                 
            db $F1,$D0,$F0,$F1                 
            db $D2,$F8,$F1,$D4                 
            db $00,$F1,$D6,$08                 
  
  spr_05_bossGrant_dagger_4C:
            db $02                             
            db $F0,$D8,$81,$F8                 
            db $F1,$DA,$00                     
  
      spr_05__4E:
            db $02                             
            db $F0,$DC,$02,$F8                 
            db $F1,$DE,$00                     
  
      spr_05__50:
            db $02                             
            db $F0,$DE,$42,$F8                 
            db $F1,$DC,$00                     
  
      spr_05__52:
            db $02                             
            db $F0,$DE,$C2,$F8                 
            db $F1,$DC,$00                     
  
      spr_05__54:
            db $02                             
            db $F0,$DC,$82,$F8                 
            db $F1,$DE,$00                     
  
  spr_05_bossGrant_rise_94:
            db $04                             
            db $F0,$F2,$00,$F0                 
            db $F1,$F4,$F8,$F1                 
            db $F6,$00,$F1,$F8                 
            db $08                             
  
  spr_05_bossGrant_rise_96:
            db $03                             
            db $F0,$E0,$00,$F4                 
            db $F1,$E2,$FC,$F1                 
            db $E4,$04                         
  
  spr_05_bossGrant_rise_98:
            db $02                             
            db $F0,$CA,$02,$F8                 
            db $F1,$CC,$00                     
  
  spr_05_bossBat_big_56:
            db $0C                             
            db $E0,$82,$02,$F8                 
            db $E1,$84,$00,$E1                 
            db $86,$08,$E1,$88                 
            db $10,$E1,$8A,$18                 
            db $01,$8C,$F8,$01                 
            db $8E,$00,$01,$90                 
            db $08,$01,$92,$10                 
            db $01,$E0,$F0,$E0                 
            db $8A,$42,$E8,$E1                 
            db $88,$F0                         
  
  spr_05_bossBat_big_58:
            db $08                             
            db $D0,$94,$02,$F8                 
            db $D1,$96,$00,$F1                 
            db $98,$F7,$F1,$9A                 
            db $FF,$F1,$9C,$07                 
            db $11,$9E,$F6,$11                 
            db $A0,$FE,$11,$A2                 
            db $06                             
  
  spr_05_bossBat_mid_5A:
            db $07                             
            db $E0,$A4,$02,$F0                 
            db $E1,$A6,$F8,$E1                 
            db $A8,$00,$E1,$AA                 
            db $08,$E1,$AC,$10                 
            db $01,$AE,$F8,$01                 
            db $B0,$00                         
  
  spr_05_bossBat_mid_5C:
            db $07                             
            db $E0,$B2,$02,$F9                 
            db $E1,$B4,$FF,$01                 
            db $B6,$F8,$01,$B8                 
            db $00,$01,$BA,$08                 
            db $21,$BC,$FA,$21                 
            db $BE,$02                         
  
  spr_05_bossBat_small_5E:
            db $03                             
            db $F0,$C0,$02,$F8                 
            db $F1,$C2,$00,$F1                 
            db $C4,$08                         
  
  spr_05_bossBat_small_60:
            db $03                             
            db $F0,$C6,$02,$FB                 
            db $F1,$C8,$03,$01                 
            db $CA,$FB,$01,$CC                 
            db $03                             
  
  spr_05_bossBat_tiny_62:
            db $02                             
            db $F0,$CE,$02,$F8                 
            db $F1,$D0,$00                     
  
  spr_05_bossBat_tiny_64:
            db $02                             
            db $F8,$D2,$02,$F8                 
            db $F9,$D4,$00                     
  
  spr_05_bossBat_pre_66:
            db $04                             
            db $E0,$D6,$02,$F8                 
            db $E1,$D8,$00,$01                 
            db $DA,$F8,$01,$DC                 
            db $00                             
  
      spr_05__68:
            db $0C                             
            db $E0,$8C,$82,$F8                 
            db $E1,$8E,$00,$E1                 
            db $90,$08,$E1,$92                 
            db $10,$E1,$E0,$F0                 
            db $01,$82,$F8,$01                 
            db $84,$00,$01,$86                 
            db $08,$01,$88,$10                 
            db $01,$8A,$18,$00                 
            db $8A,$C2,$E8,$01                 
            db $88,$F0                         
  
      spr_05__6A:
            db $08                             
            db $D0,$9E,$82,$F6                 
            db $D1,$A0,$FE,$D1                 
            db $A2,$06,$F1,$98                 
            db $F7,$F1,$9A,$FF                 
            db $F1,$9C,$07,$11                 
            db $94,$F8,$11,$96                 
            db $00                             
  
  spr_05_alucard_head_6C:
            db $01                             
            db $00,$80,$03,$00                 
  
  spr_05_alucard_appear_6E:
            db $08                             
            db $E0,$82,$01,$F4                 
            db $E1,$84,$FC,$E1                 
            db $86,$04,$E1,$88                 
            db $0C,$01,$8A,$F4                 
            db $01,$8C,$FC,$01                 
            db $8E,$04,$01,$90                 
            db $0C                             
  
  spr_05_alucard_appear_70:
            db $0A                             
            db $D4,$92,$01,$F4                 
            db $D1,$94,$FC,$D1                 
            db $96,$04,$D5,$98                 
            db $0C,$E0,$BE,$03                 
            db $F8,$E1,$C0,$00                 
            db $E1,$C2,$08,$01                 
            db $C4,$F8,$01,$C6                 
            db $00,$01,$C8,$08                 
  
  spr_05_alucard_appear_72:
            db $0E                             
            db $B0,$B6,$03,$FF                 
            db $A0,$9A,$01,$F4                 
            db $A1,$9C,$FC,$A1                 
            db $9E,$04,$A1,$A0                 
            db $0C,$C0,$B8,$03                 
            db $F8,$C1,$BA,$00                 
            db $C1,$BC,$08,$E1                 
            db $BE,$F8,$E1,$C0                 
            db $00,$E1,$C2,$08                 
            db $01,$C4,$F8,$01                 
            db $C6,$00,$01,$C8                 
            db $08                             
  
  spr_05_alucard_appear_74:
            db $0A                             
            db $B0,$B6,$01,$FF                 
            db $C0,$B8,$03,$F8                 
            db $C1,$BA,$00,$C1                 
            db $BC,$08,$E1,$BE                 
            db $F8,$E1,$C0,$00                 
            db $E1,$C2,$08,$01                 
            db $C4,$F8,$01,$C6                 
            db $00,$01,$C8,$08                 
  
  spr_05_alucard_appear_76:
            db $0A                             
            db $B0,$B6,$01,$FF                 
            db $C0,$CA,$03,$F8                 
            db $C1,$BA,$00,$C1                 
            db $BC,$08,$E1,$CC                 
            db $F8,$E1,$CE,$00                 
            db $E1,$C2,$08,$01                 
            db $D0,$F8,$01,$D2                 
            db $00,$01,$C8,$08                 
  
  spr_05_alucard_attackFull_78:
            db $0D                             
            db $B0,$B6,$01,$FF                 
            db $C0,$D4,$03,$F8                 
            db $C1,$D6,$00,$C1                 
            db $D8,$08,$C1,$DA                 
            db $10,$E1,$CC,$F8                 
            db $E1,$EA,$00,$E1                 
            db $EA,$08,$E1,$DC                 
            db $10,$01,$D0,$F8                 
            db $01,$EA,$00,$01                 
            db $EA,$08,$01,$DE                 
            db $10                             
  
  spr_05_alucard_bat_7A:
            db $03                             
            db $F0,$A2,$03,$F4                 
            db $F1,$A4,$FC,$F0                 
            db $A2,$43,$04                     
  
  spr_05_alucard_bats_7C:
            db $02                             
            db $F0,$A6,$03,$F8                 
            db $F0,$A6,$43,$00                 
  
      spr_05__7E:
            db $02                             
            db $F0,$A8,$03,$F8                 
            db $F1,$AA,$00                     
  
  spr_05_alucard_flameShot_80:
            db $02                             
            db $F0,$AC,$03,$F8                 
            db $F1,$AE,$00                     
  
      spr_05__82:
            db $02                             
            db $F0,$AC,$83,$F8                 
            db $F1,$AE,$00                     
  
  spr_05_alucard_death_84:
            db $09                             
            db $C6,$B8,$03,$F8                 
            db $C7,$BA,$00,$C7                 
            db $BC,$08,$E1,$B8                 
            db $F8,$E1,$C0,$00                 
            db $E1,$C2,$08,$01                 
            db $C4,$F8,$01,$C6                 
            db $00,$01,$C8,$08                 
  
  spr_05_alucard_death_86:
            db $08                             
            db $00,$E2,$03,$F0                 
            db $01,$EA,$F8,$01                 
            db $E4,$00,$01,$E6                 
            db $08,$01,$E8,$10                 
            db $E7,$B8,$F8,$E7                 
            db $BA,$00,$E7,$BC                 
            db $08                             
  
  spr_05_alucard_death_88:
            db $05                             
            db $00,$EC,$03,$F0                 
            db $01,$EE,$F8,$01                 
            db $F0,$00,$01,$F2                 
            db $08,$01,$F4,$10                 
  
  spr_05_alucard_rise_8A:
            db $05                             
            db $00,$EC,$01,$F0                 
            db $01,$EE,$F8,$01                 
            db $F0,$00,$01,$F2                 
            db $08,$01,$F4,$10                 
  
  spr_05_alucard_rise_8C:
            db $04                             
            db $00,$F6,$02,$F4                 
            db $01,$F8,$FC,$01                 
            db $FA,$04,$01,$FC                 
            db $0C                             
  
  spr_05_alucard_rise_8E:
            db $04,$00,$F6,$01                 
            db $F4,$01,$F8,$FC                 
            db $01,$FA,$04,$01                 
            db $FC,$0C                         
  
  spr_05_alucard_rise_90:
            db $04                             
            db $E0,$57,$01,$F8                 
            db $E1,$59,$00,$01                 
            db $69,$F8,$01,$6B                 
            db $00                             
  
  spr_05_alucard_rise_92:
            db $04                             
            db $E0,$57,$03,$F8                 
            db $E1,$59,$00,$01                 
            db $69,$F8,$01,$6B                 
            db $00                             
  
      spr_05__9A:
            db $04                             
            db $E0,$D4,$02,$F7                 
            db $E1,$D6,$FF,$01                 
            db $D8,$F9,$01,$DA                 
            db $01                             
  
      spr_05__9C:
            db $03                             
            db $EA,$C0,$02,$F4                 
            db $EF,$C2,$FC,$F1                 
            db $C4,$04                         
  
  spr_05_bossBoneDragon_head_9E:
            db $03                             
            db $F2,$C6,$02,$F4                 
            db $F1,$C8,$FC,$EF                 
            db $CA,$04                         
  
  spr_05_bossBoneDragon_A0:
            db $04                             
            db $E0,$CE,$02,$FC                 
            db $E1,$D0,$04,$F1                 
            db $CC,$F4,$01,$D2                 
            db $FC                             
  
  spr_05_bossBoneDragon_A2:
            db $04                             
            db $E0,$DA,$C2,$F7                 
            db $E1,$D8,$FF,$01                 
            db $D6,$F9,$01,$D4                 
            db $01                             
  
  spr_05_bossBoneDragon_A4:
            db $02                             
            db $F0,$E2,$02,$F8                 
            db $F1,$E4,$00                     
  
  spr_05_bossBoneDragon_A6:
            db $02                             
            db $F0,$DE,$02,$F8                 
            db $F1,$E0,$00                     
  
  spr_05_bossBoneDragon_A8:
            db $01                             
            db $F0,$DC,$02,$FC                 
  
  spr_05_bossBoneDragon_AA:
            db $02                             
            db $F0,$E0,$42,$F8                 
            db $F1,$DE,$00                     
  
  spr_05_bossBoneDragon_AC:
            db $02                             
            db $F0,$E4,$42,$F8                 
            db $F1,$E2,$00                     
  
      spr_05__AE:
            db $01                             
            db $F0,$EA,$02,$FC                 
  
      spr_05__B0:
            db $01                             
            db $F0,$E8,$02,$FC                 
  
      spr_05__B2:
            db $01                             
            db $F0,$E6,$02,$FC                 
  
      spr_05__B4:
            db $01                             
            db $F0,$E8,$82,$FC                 
  
      spr_05__B6:
            db $01                             
            db $F0,$EA,$82,$FC                 
  
  spr_05_bossWaterDragons_splash_B8:
            db $01                             
            db $00,$B6,$01,$FC                 
  
  spr_05_bossWaterDragons_splash_BA:
            db $02                             
            db $00,$B8,$01,$F8                 
            db $00,$B8,$41,$00                 
  
  spr_05_bossWaterDragons_splash_BC:
            db $08                             
            db $C0,$BA,$01,$F8                 
            db $C0,$EE,$41,$00                 
            db $E0,$BC,$01,$F8                 
            db $E0,$BC,$41,$00                 
            db $00,$BE,$01,$F0                 
            db $01,$EC,$F8,$00                 
            db $EC,$41,$00,$01                 
            db $BE,$08                         
  
  spr_05_bossWaterDragons_splash_BE:
            db $06                             
            db $E0,$EE,$01,$F8                 
            db $E0,$BA,$41,$00                 
            db $00,$F0,$01,$F0                 
            db $01,$F2,$F8,$00                 
            db $F2,$41,$00,$01                 
            db $F0,$08                         
  
  spr_05_bossWaterDragons_splash_C0:
            db $04                             
            db $00,$F4,$01,$F0                 
            db $01,$F6,$F8,$00                 
            db $F6,$41,$00,$01                 
            db $F4,$08                         
  
  spr_05_bossWaterDragons_splash_C2:
            db $04                             
            db $00,$F8,$01,$F0                 
            db $01,$F8,$F8,$00                 
            db $F8,$41,$00,$01                 
            db $F8,$08                         
  
  spr_05_bossFrank_C4:
            db $0C                             
            db $C2,$80,$02,$EF                 
            db $C1,$82,$F7
            db $C1,$84,$00                 
            db $E1,$86,$F2                 
            db $E1,$88,$FA                 
            db $E1,$8A,$02
            db $01,$8C,$F0                 
            db $01,$8E,$F8                
            db $01,$90,$00                 
            db $21,$92,$F3
            db $21,$94,$FB                 
            db $21,$96,$03                                            
  
  spr_05_bossFrank_C6:
            db $0A                             
            db $C0,$80,$02,$F0                 
            db $C1,$98,$F8
            db $C1,$9A,$00                 
            db $E1,$9C,$F0                  
            db $E1,$9E,$F8                 
            db $E1,$A0,$00
            db $01,$A2,$F6                 
            db $01,$A4,$FE                 
            db $21,$A6,$F8                 
            db $21,$A8,$00                     
  
  spr_05_bossFrank_C8:
            db $0C                             
            db $C2,$80,$02,$F1                 
            db $C1,$AA,$F9,$C1                 
            db $AC,$01,$E1,$AE                 
            db $F3,$E1,$B0,$FB                 
            db $E1,$B2,$03,$01                 
            db $B4,$F2,$01,$B6                 
            db $FA,$01,$B8,$02                 
            db $21,$BA,$F3,$21                 
            db $BC,$FB,$21,$BE                 
            db $03                             
  
  spr_05_bossFrank_attack_CC:
            db $0C                             
            db $C2,$80,$02,$F4                 
            db $C1,$82,$FC,$C1                 
            db $84,$04,$E1,$86                 
            db $F5,$E1,$88,$FD                 
            db $E1,$8A,$05,$01                 
            db $C0,$F1,$01,$C2                 
            db $F9,$01,$90,$01                 
            db $21,$C4,$F0,$21                 
            db $C6,$FB,$21,$96                 
            db $03                             
  
  spr_05_bossFrank_attack_CE:
            db $0D                             
            db $C2,$80,$02,$F6                 
            db $C1,$82,$FE,$C1                 
            db $84,$06,$E1,$C8                 
            db $F0,$E1,$CA,$F8                 
            db $E1,$CC,$00,$E1                 
            db $CE,$08,$01,$D0                 
            db $EB,$01,$D2,$F3                 
            db $01,$D4,$FB,$01                 
            db $D6,$03,$21,$D8                 
            db $FB,$21,$DA,$03                 
  
  spr_05_bossFrank_attack_D0:
            db $0C                             
            db $C2,$80,$02,$EC                 
            db $C1,$82,$F4,$C1                 
            db $84,$FC,$E1,$86                 
            db $F0,$E1,$88,$F8                 
            db $E1,$8A,$00,$01                 
            db $8C,$EF,$01,$8E                 
            db $F7,$01,$90,$FF                 
            db $21,$92,$F3,$21                 
            db $94,$FB,$21,$96                 
            db $03                             
  
  spr_05_bossFrank_throw_D2:
            db $0C                             
            db $C0,$DC,$02,$F4                 
            db $C1,$DE,$FC,$C1                 
            db $E0,$04,$E1,$E2                 
            db $F4,$E1,$9E,$FC                 
            db $E1,$A0,$04,$01                 
            db $E4,$F1,$01,$8E                 
            db $F7,$01,$90,$01                 
            db $21,$92,$F3,$21                 
            db $94,$FB,$21,$96                 
            db $03                             
  
  spr_05_bossFrank_throw_D4:
            db $0E                             
            db $C2,$80,$02,$EC                 
            db $C1,$82,$F4,$C1                 
            db $84,$FC,$E1,$E6                 
            db $E0,$E1,$E8,$E8                 
            db $E1,$EA,$F0,$E1                 
            db $88,$F8,$E1,$8A                 
            db $00,$01,$E4,$EF                 
            db $01,$8E,$F7,$01                 
            db $90,$FF,$21,$92                 
            db $F3,$21,$94,$FB                 
            db $21,$96,$03                     
  
  spr_05_bossFrank_death_D6:
            db $09                             
            db $C2,$80,$02,$EC                 
            db $C1,$82,$F4,$C1                 
            db $84,$FC,$E1,$86                 
            db $F0,$E1,$88,$F8                 
            db $E1,$8A,$00,$01                 
            db $EC,$F3,$01,$EE                 
            db $FB,$01,$F0,$03                 
  
  spr_05_bossFrank_throw_D8:
            db $06                             
            db $C2,$80,$02,$EC                 
            db $C1,$82,$F4,$C1                 
  
            db $84,$FC,$E1,$86                 
            db $F0,$E1,$88,$F8                 
            db $E1,$8A,$00                     
  
  spr_05_bossFrank_hit_DA:
            db $0B                             
            db $C0,$F2,$02,$F9                 
            db $C1,$F4,$01,$E1                 
            db $AE,$F5,$E1,$B0                 
            db $FD,$E1,$B2,$05                 
            db $01,$B4,$F2,$01                 
            db $B6,$FA,$01,$B8                 
            db $02,$21,$BA,$F3                 
            db $21,$BC,$FB,$21                 
            db $BE,$03                         

}

  
  spriteList_boss_08:
            dw spr_05_bossFrank_stone_00         ;0D9FD6|        |0DA0D6;
            dw spr_08__02                        ;0D9FD8|        |0DA0DE;
            dw spr_05_bossFrank_throw_D4         ;0D9FDA|        |0D9F56;
            dw spr_05_bossFrank_stone_00         ;0D9FDC|        |0DA0D6;
            dw spr_05_bossBoneKing_attack_0A     ;0D9FDE|        |0D97EE;
            dw spr_05_bossBoneKing_attack_0C     ;0D9FE0|        |0D9815;
            dw spr_05_bossBoneKing_attack_0E     ;0D9FE2|        |0D9836;
            dw spr_05_bossStoneGolum_18          ;0D9FE4|        |0D9896;
            dw spr_05_bossStoneGolum_dead_10     ;0D9FE6|        |0D99D8;
            dw spr_08__12                        ;0D9FE8|        |0DA104;
            dw spr_08__14                        ;0D9FEA|        |0DA112;
            dw spr_08_bossWaterDragons_dead_16   ;0D9FEC|        |0DA120;
            dw spr_08_bossWaterDragons_head_18   ;0D9FEE|        |0DA12E;
            dw spr_08_bossWaterDragons_dead_neack_1A;0D9FF0|        |0DA13F;
            dw spr_08_bossWaterDragons_dead_neack_1C;0D9FF2|        |0DA147;
            dw spr_08__1E                        ;0D9FF4|        |0DA9C3;
            dw spr_08__20                        ;0D9FF6|        |0DA9A5;
            dw spr_08__22                        ;0D9FF8|        |0DA9AF;
            dw spr_08_bossWaterDragons_appear_24 ;0D9FFA|        |0DA14F;
            dw spr_08_bossWaterDragons_neackMid_26;0D9FFC|        |0DA15D;
            dw spr_08_bossWaterDragons_appear_28 ;0D9FFE|        |0DA171;
            dw spr_08_bossWaterDragons_neackLong_2A;0DA000|        |0DA18B;
            dw spr_08_bossWaterDragons_appear_2C ;0DA002|        |0DA1AB;
            dw spr_08__2E                        ;0DA004|        |0DA1C8;
            dw spr_08__30                        ;0DA006|        |0DA1E5;
            dw spr_08__32                        ;0DA008|        |0DA202;
            dw spr_08_bossMedusa_attack_34       ;0DA00A|        |0DA225;
            dw spr_08_bossMedusa_attack_36       ;0DA00C|        |0DA248;
            dw spr_08_bossMedusa_38              ;0DA00E|        |0DA26B;
            dw spr_08_bossMedusa_3A              ;0DA010|        |0DA291;
            dw spr_08_bossMedusa_3C              ;0DA012|        |0DA2B7;
            dw spr_08_bossMedusa_3E              ;0DA014|        |0DA2DD;
            dw spr_08_bossMedusa_pre_40          ;0DA016|        |0DA2FB;
            dw spr_08_bossMedusa_appear_42       ;0DA018|        |0DA306;
            dw spr_08_bossMedusa_appear_44       ;0DA01A|        |0DA311;
            dw spr_08_bossMedusa_appear_46       ;0DA01C|        |0DA320;
            dw spr_08_bossMedusa_appear_48       ;0DA01E|        |0DA335;
            dw spr_08_bossMedusa_snakeArrow_4A   ;0DA020|        |0DA350;
            dw spr_08_bossMedusa_beam_4C         ;0DA022|        |0DA35B;
            dw spr_08_bossMedusa_beam_4E         ;0DA024|        |0DA363;
            dw spr_08_bossMedusa_beam_50         ;0DA026|        |0DA368;
            dw spr_08_bossMedusa_beam_52         ;0DA028|        |0DA36D;
            dw spr_08_bossBoneKing_pre_54        ;0DA02A|        |0DA376;
            dw spr_08_bossBoneKing_rise_56       ;0DA02C|        |0DA388;
            dw spr_08_bossBoneKing_rise_58       ;0DA02E|        |0DA3A3;
            dw spr_08__5A                        ;0DA030|        |0DA3BE;
            dw spr_08__5C                        ;0DA032|        |0DA3D5;
            dw spr_08__5E                        ;0DA034|        |0DA3EC;
            dw spr_08__60                        ;0DA036|        |0DA40D;
            dw spr_08_bossLeviaton_pre_62        ;0DA038|        |0DA431;
            dw spr_08_bossLeviaton_64            ;0DA03A|        |0DA44E;
            dw spr_08_bossLeviaton_66            ;0DA03C|        |0DA46B;
            dw spr_08_bossLeviaton_68            ;0DA03E|        |0DA488;
            dw spr_08_bossLeviaton_6A            ;0DA040|        |0DA4C9;
            dw spr_08_bossLeviaton_6C            ;0DA042|        |0DA4FE;
            dw spr_08_bossLeviaton_6A            ;0DA044|        |0DA4C9;
            dw spr_08_bossLeviaton_stump_70      ;0DA046|        |0DA530;
            dw spr_08_bossSpirite_pre_72         ;0DA048|        |0DA59A;
            dw spr_08_bossSpirite_pre_74         ;0DA04A|        |0DA5A2;
            dw spr_08_bossSpirite_pre_76         ;0DA04C|        |0DA5AE;
            dw spr_08_bossSpirite_burst_78       ;0DA04E|        |0DA5C6;
            dw spr_08_bossMummy_7A               ;0DA050|        |0DA5CB;
            dw spr_08_bossMummy_7C               ;0DA052|        |0DA5DF;
            dw spr_08_bossMummy_7E               ;0DA054|        |0DA5F0;
            dw spr_08_bossMummy_dead_80          ;0DA056|        |0DA601;
            dw spr_08_bossMummy_dead_82          ;0DA058|        |0DA618;
            dw spr_08_bossMummy_dead_84          ;0DA05A|        |0DA62C;
            dw spr_08_bossMummy_dead_86          ;0DA05C|        |0DA63A;
            dw spr_08_bossMummy_bandage_88       ;0DA05E|        |0DA649;
            dw spr_08__8A                        ;0DA060|        |0DA651;
            dw spr_08_bossDrac_pre_8C            ;0DA062|        |0DA65A;
            dw spr_08_bossDrac_appear_8E         ;0DA064|        |0DA66C;
            dw spr_08_bossDrac_idle_90           ;0DA066|        |0DA687;
            dw spr_08_bossDrac_attack_92         ;0DA068|        |0DA6A8;
            dw spr_08_bossDrac_attack_94         ;0DA06A|        |0DA6C9;
            dw spr_08_bossDrac_bigFlame_96       ;0DA06C|        |0DA6F6;
            dw spr_08_bossDrac_bigFlame_98       ;0DA06E|        |0DA6FE;
            dw spr_08_bossDrac_bigFlame_9A       ;0DA070|        |0DA706;
            dw spr_08_bossDrac_bigFlame_9C       ;0DA072|        |0DA712;
            dw spr_08_bossDrac_bigFlame_9E       ;0DA074|        |0DA72B;
            dw spr_08_bossDrac_bigFlame_A0       ;0DA076|        |0DA74F;
            dw spr_08_bossDrac_flame_A2          ;0DA078|        |0DA779;
            dw spr_08_bossDrac_flame_A4          ;0DA07A|        |0DA77E;
            dw spr_08_bossDrac_flame_A6          ;0DA07C|        |0DA786;
            dw spr_08_bossDrac_flame_A8          ;0DA07E|        |0DA791;
            dw spr_08_bossLeviaton_dead_AA       ;0DA080|        |0DA571;
            dw spr_08_bossSpirite_upsideDown_AC  ;0DA082|        |0DA5BA;
            dw spr_08_bossDeath_AE               ;0DA084|        |0DA79F;
            dw spr_08_bossDeath_B0               ;0DA086|        |0DA7D2;
            dw spr_08_bossDeath_B2               ;0DA088|        |0DA805;
            dw spr_08_bossDeath_death_B4         ;0DA08A|        |0DA83E;
            dw spr_08_bossDeath_death_B6         ;0DA08C|        |0DA871;
            dw spr_08_bossDeath_syth_B8          ;0DA08E|        |0DA8A6;
            dw spr_08_bossDeath_syth_BA          ;0DA090|        |0DA8AE;
            dw spr_08_bossDeath_syth_BC          ;0DA092|        |0DA8B6;
            dw spr_08_bossDeath_syth_BE          ;0DA094|        |0DA8BE;
            dw spr_08_bossDrac2_C0               ;0DA096|        |0DA8C6;
            dw spr_08_bossDrac2_C2               ;0DA098|        |0DA8D1;
            dw spr_08_bossDrac2_C4               ;0DA09A|        |0DA8DC; 
            dw spr_08_bossDrac2_C6               ;0DA09C|        |0DA8E7;
            dw spr_08_bossDrac2_C8               ;0DA09E|        |0DA8F2;
            dw spr_08_bossDrac2_CA               ;0DA0A0|        |0DA8FD;
            dw spr_08_bossDrac2_CC               ;0DA0A2|        |0DA908;
            dw spr_08_bossDrac2_CE               ;0DA0A4|        |0DA916;
            dw spr_08_bossDrac2_D0               ;0DA0A6|        |0DA924;
            dw spr_08_bossDrac2_D2               ;0DA0A8|        |0DA932;
            dw spr_08_bossDrac2_D4               ;0DA0AA|        |0DA941;
            dw spr_08_bossDrac2_drip_D6          ;0DA0AC|        |0DA950;
            dw spr_08_bossDrac2_drip_D8          ;0DA0AE|        |0DA955;
            dw spr_08_bossDrac2_drip_DA          ;0DA0B0|        |0DA95D;
            dw spr_08_bossDrac2_drip_DC          ;0DA0B2|        |0DA965;
            dw spr_08_bossDrac2_drip_DE          ;0DA0B4|        |0DA970;
            dw spr_08__E0                        ;0DA0B6|        |0DA97C;
            dw spr_08__E2                        ;0DA0B8|        |0DA981;
            dw spr_08_bossDrac3_eyes_E4          ;0DA0BA|        |0DA989;
            dw spr_08_bossDrac3_eyes_E6          ;0DA0BC|        |0DA992;
            dw spr_08__E8                        ;0DA0BE|        |0DA9A0;
            dw spr_08_bossDrac3_laser_EA         ;0DA0C0|        |0DA9AA;
            dw spr_08__EC                        ;0DA0C2|        |0DA9B4;
            dw spr_08__EE                        ;0DA0C4|        |0DA9BE;
            dw spr_08_bossDrac_head_F0           ;0DA0C6|        |0DA9C8;
            dw spr_08__F2                        ;0DA0C8|        |0DA9CD;
            dw spr_08__F4                        ;0DA0CA|        |0DA9D2;
            dw spr_08__F6                        ;0DA0CC|        |0DA9D7;
            dw spr_08__F8                        ;0DA0CE|        |0DA9DC;
            dw spr_08__FA                        ;0DA0D0|        |0DA9E1;
            dw spr_08__FC                        ;0DA0D2|        |0DA9E6;
            dw spr_08__FE                        ;0DA0D4|        |0DA9EB;

{ ; spriteList_boss_08, spriteList_objects_06.. 05  
  
  spr_05_bossFrank_stone_00:
            db $02                      
            db $F0,$FA,$01,$F8          
            db $F1,$FC,$00              
  
      spr_08__02:
            db $0C                      
            db $C2,$80,$02,$F3          
            db $C1,$82,$FB              
            db $C1,$84,$03              
            db $E1,$F6,$F5
            db $E1,$F8,$FD              
            db $E1,$8A,$05              
            db $01,$E4,$F1              
            db $01,$8E,$F9
            db $01,$90,$01              
            db $21,$92,$F3              
            db $21,$94,$FB              
            db $21,$96,$03              
  
      spr_08__12:
            db $04                               
            db $C0,$80,$03,$F8                   
            db $C1,$82,$00,$E1                   
            db $84,$F8,$E1,$86                   
            db $00                               
  
      spr_08__14:
            db $04                               
            db $D8,$88,$03,$F0                   
            db $E1,$8A,$F0,$E1                   
            db $8C,$F8,$E1,$8E                   
            db $00                               
  
  spr_08_bossWaterDragons_dead_16:
            db $04                               
            db $E8,$90,$03,$E8                   
            db $E1,$92,$F0,$E1                   
            db $94,$F8,$E1,$96                   
            db $00                               
  
  spr_08_bossWaterDragons_head_18:
            db $05                               
            db $E0,$98,$03,$E8                   
            db $D1,$9A,$F0,$F1                   
            db $9C,$F0,$E1,$9E                   
            db $F8,$E1,$A0,$00                   
  
  spr_08_bossWaterDragons_dead_neack_1A:
            db $02                               
            db $F0,$A2,$03,$F8                   
            db $F1,$A4,$00                       
  
  spr_08_bossWaterDragons_dead_neack_1C:
            db $02                               
            db $F0,$A6,$03,$F8                   
            db $F1,$AE,$00                       
  
  spr_08_bossWaterDragons_appear_24:
            db $04                               
            db $F0,$A2,$03,$F8                   
            db $F1,$A4,$00,$11                   
            db $A2,$F8,$11,$A4                   
            db $00                               
  
  spr_08_bossWaterDragons_neackMid_26:
            db $06                               
            db $F0,$A2,$03,$F8                   
            db $F1,$A4,$00,$11                   
            db $A2,$F8,$11,$A4                   
            db $00,$31,$A2,$F8                   
            db $31,$A4,$00                       
  
  spr_08_bossWaterDragons_appear_28:
            db $08                               
            db $F0,$A2,$03,$F8                   
            db $F1,$A4,$00,$11                   
            db $A2,$F8,$11,$A4                   
            db $00,$31,$A2,$F8                   
            db $31,$A4,$00,$51                   
            db $A2,$F8,$51,$A4                   
            db $00                               
  
  spr_08_bossWaterDragons_neackLong_2A:
            db $0A                               
            db $F0,$A2,$03,$F8                   
            db $F1,$A4,$00,$11                   
            db $A2,$F8,$11,$A4                   
            db $00,$31,$A2,$F8                   
            db $31,$A4,$00,$51                   
            db $A2,$F8,$51,$A4                   
            db $00,$71,$A2,$F8                   
            db $71,$A4,$00                       
  
  spr_08_bossWaterDragons_appear_2C:
            db $09                               
            db $D2,$9A,$03,$F2                   
            db $D3,$9C,$FA,$EB                   
            db $98,$EA,$F3,$9E                   
            db $F2,$F3,$A0,$FA                   
            db $11,$80,$F0,$11                   
            db $82,$F8,$11,$84                   
  
            db $00,$11,$86,$08                   
  
      spr_08__2E:
            db $09                               
            db $D0,$9A,$03,$F1                   
            db $D1,$9C,$F9,$E9                   
            db $98,$E9,$F1,$9E                   
            db $F1,$F1,$A0,$F9                   
            db $11,$80,$F0,$11                   
            db $8A,$F8,$11,$8C                   
            db $00,$11,$8E,$08                   
  
      spr_08__30:
            db $09                               
            db $D0,$9A,$03,$F0                   
            db $D1,$9C,$F8,$E9                   
            db $98,$E8,$F1,$9E                   
            db $F0,$F1,$A0,$F8                   
            db $11,$90,$F0,$11                   
            db $92,$F8,$11,$94                   
            db $00,$11,$96,$08                   
  
      spr_08__32:
            db $0B                               
            db $D2,$9A,$03,$F4                   
            db $D3,$9C,$FC,$D1                   
            db $A2,$E7,$F1,$A4                   
            db $E7,$F1,$A6,$ED                   
            db $F1,$A8,$F5,$F1                   
            db $AA,$FD,$11,$80                   
            db $F0,$11,$82,$F8                   
            db $11,$84,$00,$11                   
            db $86,$08                           
  
  spr_08_bossMedusa_attack_34:
            db $0B                               
            db $D0,$9A,$03,$F5                   
            db $D1,$9C,$FD,$D1                   
            db $A2,$E7,$F1,$A4                   
            db $E7,$F1,$A6,$EF                   
            db $F1,$AC,$F7,$F1                   
            db $AE,$FF,$11,$80                   
            db $F0,$11,$82,$F8                   
            db $11,$84,$00,$11                   
            db $86,$08                           
  
  spr_08_bossMedusa_attack_36:
            db $0B                               
            db $D0,$9A,$03,$F5                   
            db $D1,$B0,$FD,$D1                   
            db $A2,$E9,$F1,$B2                   
            db $E7,$F1,$B4,$EF                   
            db $F1,$B6,$F7,$F1                   
            db $B8,$FF,$11,$80                   
            db $F0,$11,$82,$F8                   
            db $11,$84,$00,$11                   
            db $86,$08                           
  
  spr_08_bossMedusa_38:
            db $0C                               
            db $D0,$BA,$03,$E4                   
            db $D1,$BC,$EC,$D1                   
            db $BE,$F4,$D1,$C0                   
            db $FC,$F1,$C2,$E4                   
            db $F1,$C4,$EC,$F1                   
            db $C6,$F4,$F1,$C8                   
            db $FC,$11,$80,$F0                   
            db $11,$82,$F8,$11                   
            db $84,$00,$11,$86                   
            db $08                               
  
  spr_08_bossMedusa_3A:
            db $0C                               
            db $D0,$BA,$03,$E4                   
            db $D1,$BC,$EC,$D1                   
            db $BE,$F4,$D1,$C0                   
            db $FC,$F1,$C2,$E4                   
            db $F1,$C4,$EC,$F1                   
            db $CA,$F4,$F1,$CC                   
            db $FC,$11,$80,$F0                   
            db $11,$82,$F8,$11                   
            db $84,$00,$11,$86                   
            db $08                               
  
  spr_08_bossMedusa_3C:
            db $0C                               
            db $D2,$BA,$03,$E8                   
            db $D3,$CE,$EF,$D3                   
            db $BE,$F7,$D3,$C0                   
            db $FF,$F3,$C2,$E8                   
            db $F3,$D0,$F0,$F3                   
            db $D2,$F8,$F3,$D4                   
            db $00,$11,$80,$F0                   
            db $11,$82,$F8,$11                   
            db $84,$00,$11,$86                   
            db $08                               
  
  spr_08_bossMedusa_3E:
            db $09                               
            db $D0,$9A,$01,$F0                   
            db $D1,$9C,$F8,$E8                   
            db $98,$03,$E8,$F1                   
            db $9E,$F0,$F1,$A0                   
            db $F8,$11,$90,$F0                   
            db $11,$92,$F8,$11                   
            db $94,$00,$11,$96                   
            db $08                               
  
  spr_08_bossMedusa_pre_40:
            db $03                               
            db $F0,$E6,$03,$F4                   
            db $F1,$E8,$FC,$F1                   
            db $EA,$04                           
  
  spr_08_bossMedusa_appear_42:
            db $03                               
            db $F0,$EC,$03,$F4                   
            db $F1,$EE,$FC,$F1                   
            db $F0,$04                           
  
  spr_08_bossMedusa_appear_44:
            db $04                               
            db $F0,$EA,$43,$F0                   
            db $F0,$F2,$03,$F8                   
            db $F1,$F4,$00,$F1                   
            db $F0,$08                           
  
  spr_08_bossMedusa_appear_46:
            db $06                               
            db $D0,$F4,$43,$F8                   
            db $D1,$F2,$00,$F1                   
            db $F0,$F0,$F0,$F6                   
            db $03,$F8,$F1,$F8                   
            db $00,$F1,$EA,$08                   
  
  spr_08_bossMedusa_appear_48:
            db $08                               
            db $B0,$F2,$03,$F8                   
            db $B1,$F4,$00,$F1                   
            db $F0,$08,$D0,$F8                   
            db $43,$F8,$D1,$F6                   
            db $00,$F1,$EA,$F0                   
            db $F1,$F8,$F8,$F1                   
            db $F6,$00                           
  
  spr_08_bossMedusa_snakeArrow_4A:
            db $03                               
            db $F0,$D6,$01,$F8                   
            db $F1,$D8,$00,$F1                   
            db $DA,$08                           
  
  spr_08_bossMedusa_beam_4C:
            db $02                               
            db $F0,$DC,$01,$F8                   
            db $F1,$DE,$00                       
  
  spr_08_bossMedusa_beam_4E:
            db $01                               
            db $F0,$E0,$03,$FC                   
  
  spr_08_bossMedusa_beam_50:
            db $01                               
            db $F0,$E2,$03,$FC                   
  
  spr_08_bossMedusa_beam_52:
            db $02                               
            db $E0,$E4,$03,$FC                   
            db $00,$E4,$83,$FC                   
  
  spr_08_bossBoneKing_pre_54:
            db $05                               
            db $10,$E4,$03,$0C                   
            db $11,$E6,$14,$10                   
            db $C4,$02,$F0,$11                   
            db $C6,$F8,$11,$C8                   
            db $00                               
  
  spr_08_bossBoneKing_rise_56:
            db $08                               
            db $10,$E8,$03,$08                   
            db $11,$EA,$10,$F0                   
            db $CC,$02,$00,$F1                   
            db $CE,$08,$11,$D0                   
            db $F0,$11,$D2,$F8                   
            db $11,$D4,$00,$11                   
            db $D6,$08                           
  
  spr_08_bossBoneKing_rise_58:
            db $08                               
            db $10,$E8,$03,$00                   
            db $11,$EA,$08,$F0                   
            db $D8,$02,$F0,$F1                   
            db $DA,$F8,$F1,$DC                   
            db $00,$11,$DE,$F0                   
            db $11,$E0,$F8,$11                   
            db $E2,$00                           
  
      spr_08__5A:
            db $07                               
            db $E0,$F0,$02,$00                   
            db $DD,$80,$F1,$E1                   
            db $E6,$F9,$E1,$E8                   
            db $01,$01,$EA,$F0                   
            db $01,$EC,$F8,$01                   
            db $8A,$00                           
  
      spr_08__5C:
            db $07                               
            db $E0,$FA,$02,$EE                   
            db $E1,$FC,$F6,$E1                   
            db $84,$FE,$F1,$EE                   
            db $E6,$01,$EA,$F0                   
            db $01,$EC,$F8,$01                   
            db $8A,$00                           
  
      spr_08__5E:
            db $0A                               
            db $F8,$C2,$43,$E9                   
            db $F9,$C0,$F1,$D2                   
            db $80,$02,$F1,$D3                   
            db $82,$F9,$D3,$84                   
            db $01,$F1,$BC,$F9                   
            db $F1,$BE,$01,$11                   
            db $A4,$F8,$11,$A6                   
            db $00,$11,$A8,$08                   
  
      spr_08__60:
            db $0B                               
            db $00,$C0,$03,$00                   
            db $01,$C2,$08,$E2                   
            db $80,$02,$F0,$E3                   
            db $82,$F8,$E3,$84                   
            db $00,$01,$9E,$E8                   
            db $01,$A0,$F0,$01                   
            db $A2,$F8,$21,$B6                   
            db $F3,$21,$B8,$FB                   
            db $21,$BA,$03                       
  
  spr_08_bossLeviaton_pre_62:
            db $09                               
            db $E0,$CA,$02,$F4                   
            db $E1,$CC,$FC,$E1                   
            db $CA,$04,$01,$CE                   
            db $F4,$01,$D4,$FC                   
            db $01,$CE,$04,$21                   
            db $D0,$F4,$21,$D2                   
            db $FC,$21,$D0,$04                   
  
  spr_08_bossLeviaton_64:
            db $09                               
            db $E0,$CA,$02,$F4                   
            db $E1,$CC,$FC,$E1                   
            db $CA,$04,$01,$CE                   
            db $F4,$01,$D6,$FC                   
            db $01,$CE,$04,$21                   
            db $D0,$F4,$21,$D2                   
            db $FC,$21,$D0,$04                   
  
  spr_08_bossLeviaton_66:
            db $09                               
            db $E0,$CA,$02,$F4                   
            db $E1,$CC,$FC,$E1                   
            db $CA,$04,$01,$CE                   
            db $F4,$01,$D8,$FC                   
            db $01,$CE,$04,$21                   
            db $D0,$F4,$21,$D2                   
            db $FC,$21,$D0,$04                   
  
  spr_08_bossLeviaton_68:
            db $15                               
            db $C0,$80,$02,$E8                   
            db $C1,$82,$F0,$C1                   
            db $84,$F8,$C1,$86                   
            db $00,$C1,$88,$08                   
            db $C1,$8A,$10,$E1                   
            db $8C,$E8,$E1,$8E                   
            db $F0,$E1,$90,$F8                   
            db $E1,$92,$00,$E1                   
            db $94,$08,$E1,$96                   
            db $10,$01,$98,$E8                   
            db $01,$9A,$F0,$01                   
            db $9C,$F8,$01,$9E                   
            db $00,$01,$A0,$08                   
            db $01,$A2,$10,$21                   
            db $A4,$EE,$21,$A6                   
            db $F6,$21,$A8,$FE                   
  
  spr_08_bossLeviaton_6A:
            db $11                               
            db $C0,$AA,$02,$F0                   
            db $C1,$84,$F8,$C1                   
            db $AC,$00,$C1,$AE                   
            db $08,$E1,$8C,$E8                   
            db $E1,$8E,$F0,$E1                   
            db $90,$F8,$E1,$92                   
            db $00,$E1,$B0,$08                   
            db $01,$98,$E8,$01                   
            db $9A,$F0,$01,$9C                   
            db $F8,$01,$9E,$00                   
            db $01,$B2,$08,$21                   
            db $A4,$EE,$21,$A6                   
            db $F6,$21,$A8,$FE                   
  
  spr_08_bossLeviaton_6C:
            db $10                               
            db $C0,$B4,$02,$F0                   
            db $C1,$B6,$F8,$C1                   
            db $B8,$00,$E1,$8C                   
            db $E8,$E1,$8E,$F0                   
            db $E1,$90,$F8,$E1                   
            db $92,$00,$E1,$BA                   
            db $08,$01,$98,$E8                   
            db $01,$9A,$F0,$01                   
            db $9C,$F8,$01,$9E                   
            db $00,$01,$A0,$08                   
            db $21,$A4,$EE,$21                   
            db $A6,$F6,$21,$A8                   
            db $FE                               
  
  spr_08_bossLeviaton_stump_70:
            db $15                               
            db $D0,$80,$02,$E8                   
            db $D1,$82,$F0,$D1                   
            db $84,$F8,$D1,$86                   
            db $00,$D1,$88,$08                   
            db $D1,$8A,$10,$F1                   
            db $8C,$E8,$F1,$8E                   
            db $F0,$F1,$90,$F8                   
            db $F1,$92,$00,$F1                   
            db $94,$08,$F1,$96                   
            db $10,$11,$BC,$E8                   
            db $11,$BE,$F0,$11                   
            db $C0,$F8,$11,$C2                   
            db $00,$11,$A0,$08                   
            db $11,$A2,$10,$31                   
            db $C4,$F0,$31,$C6                   
            db $F8,$31,$C8,$00                   
  
  spr_08_bossLeviaton_dead_AA:
            db $0D                               
            db $C0,$B4,$02,$F0                   
            db $C1,$B6,$F8,$C1                   
            db $B8,$00,$E1,$8C                   
            db $E8,$E1,$8E,$F0                   
            db $E1,$90,$F8,$E1                   
            db $92,$00,$E1,$B4                   
            db $08,$01,$98,$E8                   
            db $01,$9A,$F0,$01                   
            db $9C,$F8,$01,$9E                   
            db $00,$01,$A0,$08                   
  
  spr_08_bossSpirite_pre_72:
            db $02                               
            db $D0,$F0,$01,$FC                   
            db $F1,$F2,$FC                       
  
  spr_08_bossSpirite_pre_74:
            db $03                               
            db $D0,$F4,$01,$FC                   
            db $F1,$F6,$F8,$F0                   
            db $F6,$41,$00                       
  
  spr_08_bossSpirite_pre_76:
            db $03                               
            db $D0,$F8,$01,$FC                   
            db $F1,$FA,$F8,$F0                   
            db $FA,$41,$00                       
  
  spr_08_bossSpirite_upsideDown_AC:
            db $03                               
            db $F0,$F8,$81,$FC                   
            db $D1,$FA,$F8,$D0                   
            db $FA,$C1,$00                       
  
  spr_08_bossSpirite_burst_78:
            db $01                               
            db $F0,$FC,$01,$FC                   
  
  spr_08_bossMummy_7A:
            db $06                               
            db $D0,$C0,$02,$FE                   
            db $F1,$C2,$F0,$F1                   
            db $C4,$F8,$F1,$C6                   
            db $00,$11,$C8,$FB                   
            db $11,$CA,$03                       
  
  spr_08_bossMummy_7C:
            db $05                               
            db $D0,$C0,$02,$FF                   
            db $F1,$CC,$F8,$F1                   
            db $CE,$00,$11,$D0                   
            db $F8,$11,$D2,$00                   
  
  spr_08_bossMummy_7E:
            db $05                               
            db $D2,$C0,$02,$FF                   
            db $F1,$D4,$F8,$F1                   
            db $D6,$00,$11,$D8                   
            db $FC,$11,$DA,$04                   
  
  spr_08_bossMummy_dead_80:
            db $07                               
            db $D0,$DE,$02,$F8                   
            db $D1,$DC,$00,$E1                   
            db $DC,$F0,$F1,$DC                   
  
            db $F8,$F1,$DE,$00                   
            db $11,$C8,$FB,$11                   
            db $CA,$03                           
  
  spr_08_bossMummy_dead_82:
            db $06                               
            db $F0,$DC,$82,$F8                   
            db $F1,$DC,$00,$F1                   
            db $DE,$08,$01,$DE                   
            db $F0,$11,$C8,$FB                   
            db $11,$CA,$03                       
  
  spr_08_bossMummy_dead_84:
            db $04                               
            db $10,$DE,$02,$F0                   
            db $11,$D4,$F8,$11                   
            db $D6,$00,$11,$DC                   
            db $08                               
  
  spr_08_bossMummy_dead_86:
            db $04                               
            db $10,$E0,$02,$F0                   
            db $11,$E2,$F8,$10                   
            db $E2,$41,$00,$11                   
            db $E0,$08                           
  
  spr_08_bossMummy_bandage_88:
            db $02                               
            db $F0,$EA,$02,$F8                   
            db $F1,$EC,$00                       
  
      spr_08__8A:
            db $02                               
            db $F0,$EE,$02,$F8                   
            db $F0,$EC,$82,$00                   
  
  spr_08_bossDrac_pre_8C:
            db $05                               
            db $D0,$B6,$01,$E8                   
            db $E0,$AE,$02,$E4                   
            db $E1,$B0,$EC,$F1                   
            db $B2,$F4,$11,$B4                   
            db $F4                               
  
  spr_08_bossDrac_appear_8E:
            db $08                               
            db $D2,$C6,$01,$FD                   
            db $E0,$B8,$02,$F0                   
            db $E1,$BA,$F8,$E1                   
            db $BC,$00,$01,$BE                   
            db $F4,$01,$C0,$FC                   
            db $11,$C2,$F4,$11                   
            db $C4,$FC                           
  
  spr_08_bossDrac_idle_90:
            db $0A                               
            db $CE,$AC,$01,$FC                   
            db $D0,$80,$02,$F4                   
            db $D1,$82,$FC,$D1                   
            db $84,$04,$F1,$86                   
            db $F4,$F1,$88,$FC                   
            db $F1,$8A,$04,$11                   
            db $8C,$F4,$11,$8E                   
            db $FC,$11,$90,$04                   
  
  spr_08_bossDrac_attack_92:
            db $0A                               
            db $CE,$AC,$01,$FC                   
            db $D0,$80,$02,$F4                   
            db $D1,$92,$FC,$D1                   
            db $84,$04,$F1,$86                   
            db $F4,$F1,$94,$FC                   
            db $F1,$8A,$04,$11                   
            db $8C,$F4,$11,$96                   
            db $FC,$11,$98,$04                   
  
  spr_08_bossDrac_attack_94:
            db $0E                               
            db $CE,$AC,$01,$FC                   
            db $D0,$80,$02,$F4                   
            db $D1,$92,$FC,$D1                   
            db $9C,$04,$F1,$86                   
            db $F4,$F1,$A0,$FC                   
            db $F1,$A2,$04,$11                   
            db $8C,$F4,$11,$A6                   
            db $FC,$11,$A8,$04                   
            db $B1,$9A,$04,$D1                   
            db $9E,$04,$F1,$A4                   
            db $04,$11,$AA,$04                   
  
  spr_08_bossDrac_bigFlame_96:
            db $02                               
            db $F0,$C8,$03,$F8                   
            db $F1,$CA,$00                       
  
  spr_08_bossDrac_bigFlame_98:
            db $02                               
            db $F0,$E0,$03,$F8                   
            db $F1,$E2,$00                       
  
  spr_08_bossDrac_bigFlame_9A:
            db $03                               
            db $D0,$E4,$03,$FC                   
            db $F1,$E6,$F8,$F0                   
            db $E6,$C3,$00                       
  
  spr_08_bossDrac_bigFlame_9C:
            db $07                               
            db $90,$E4,$43,$FC                   
            db $B0,$E6,$03,$F8                   
            db $D1,$E8,$F8,$11                   
            db $EA,$F8,$B0,$E6                   
            db $C3,$00,$D1,$E8                   
            db $00,$11,$EA,$00                   
  
  spr_08_bossDrac_bigFlame_9E:
            db $0B                               
            db $B0,$E4,$03,$FC                   
            db $D1,$E6,$F8,$F1                   
            db $E8,$F8,$11,$EA                   
            db $F8,$31,$EA,$F8                   
            db $51,$EA,$F8,$D0                   
            db $E6,$C3,$00,$F1                   
            db $E8,$00,$11,$EA                   
            db $00,$31,$EA,$00                   
            db $51,$EA,$00                       
  
  spr_08_bossDrac_bigFlame_A0:
            db $0D                               
            db $90,$E4,$03,$FC                   
            db $B1,$E6,$F8,$D1                   
            db $E8,$F8,$F1,$E8                   
            db $F8,$11,$EA,$F8                   
            db $31,$EA,$F8,$51                   
            db $EA,$F8,$B0,$E6                   
            db $C3,$00,$D1,$E8                   
            db $00,$F1,$E8,$00                   
            db $11,$EA,$00,$31                   
            db $EA,$00,$51,$EA                   
            db $00                               
  
  spr_08_bossDrac_flame_A2:
            db $01                               
            db $F0,$CC,$03,$FC                   
  
  spr_08_bossDrac_flame_A4:
            db $02                               
            db $D0,$CE,$03,$FC                   
            db $F1,$D0,$FC                       
  
  spr_08_bossDrac_flame_A6:
            db $03                               
            db $B0,$CE,$03,$FC                   
            db $D1,$D0,$FC,$F1                   
            db $D2,$FC                           
  
  spr_08_bossDrac_flame_A8:
            db $04                               
            db $90,$CE,$03,$FC                   
            db $B1,$D0,$FC,$D1                   
            db $D2,$FC,$F1,$D4                   
            db $FC                               
  
  spr_08_bossDeath_AE:
            db $10                               
            db $C0,$80,$02,$F8                   
            db $C1,$82,$00,$C1                   
            db $84,$08,$E1,$8A                   
            db $F0,$E1,$8C,$F8                   
            db $E1,$8E,$00,$E1                   
            db $90,$08,$01,$92                   
            db $F0,$01,$94,$F8                   
            db $01,$96,$00,$01                   
            db $98,$08,$21,$9A                   
            db $F5,$21,$9C,$FD                   
            db $21,$9E,$FB,$C2                   
            db $86,$01,$10,$CD                   
            db $88,$18                           
  
  spr_08_bossDeath_B0:
            db $10                               
            db $C0,$80,$02,$F8                   
            db $C1,$82,$00,$C1                   
            db $84,$08,$E1,$A0                   
            db $F0,$E1,$A2,$F8                   
            db $E1,$A4,$00,$E1                   
            db $A6,$08,$01,$A8                   
            db $F0,$01,$AA,$F8                   
            db $01,$AC,$00,$01                   
            db $AE,$08,$21,$B0                   
            db $F0,$21,$B2,$F8                   
            db $21,$B4,$00,$C2                   
            db $86,$01,$10,$CD                   
            db $88,$18                           
  
  spr_08_bossDeath_B2:
            db $12                               
            db $C0,$80,$02,$F8                   
            db $C1,$82,$00,$C1                   
            db $84,$08,$FD,$B6                   
            db $E8,$E1,$BA,$F0                   
            db $E1,$BC,$F8,$E1                   
            db $BE,$00,$E1,$C0                   
            db $08,$1D,$B8,$E8                   
            db $01,$C2,$F0,$01                   
            db $C4,$F8,$01,$C6                   
            db $00,$01,$C8,$08                   
            db $21,$CA,$F0,$21                   
            db $CC,$F8,$21,$CE                   
            db $00,$C2,$86,$01                   
            db $10,$CD,$88,$18                   
  
  spr_08_bossDeath_death_B4:
            db $10                               
            db $C0,$80,$02,$F8                   
            db $C1,$82,$00,$C1                   
            db $D0,$08,$E1,$D2                   
            db $F0,$E1,$D4,$F8                   
            db $E1,$D6,$00,$E1                   
            db $90,$08,$01,$D8                   
            db $F0,$01,$DA,$F8                   
            db $01,$96,$00,$01                   
            db $98,$08,$21,$E0                   
            db $F5,$21,$9C,$FD                   
            db $21,$9E,$05,$20                   
            db $DC,$01,$E5,$21                   
  
            db $DE,$ED                           
  
  spr_08_bossDeath_death_B6:
            db $11                               
            db $C0,$80,$02,$F8                   
            db $C1,$82,$00,$C1                   
            db $D0,$08,$E1,$E2                   
            db $D8,$E1,$E4,$E0                   
            db $E9,$E6,$E8,$E1                   
            db $E8,$F0,$E1,$EA                   
            db $F8,$E1,$D6,$00                   
            db $E1,$A6,$08,$01                   
            db $EC,$F0,$01,$EE                   
            db $F8,$01,$AC,$00                   
            db $01,$AE,$08,$21                   
            db $B0,$F0,$21,$B2                   
            db $F8,$21,$B4,$00                   
  
  spr_08_bossDeath_syth_B8:
            db $02                               
            db $F0,$F6,$C3,$F8                   
            db $F1,$F4,$00                       
  
  spr_08_bossDeath_syth_BA:
            db $02                               
            db $F0,$F0,$03,$F8                   
            db $F1,$F2,$00                       
  
  spr_08_bossDeath_syth_BC:
            db $02                               
            db $F0,$F4,$03,$F8                   
            db $F1,$F6,$00                       
  
  spr_08_bossDeath_syth_BE:
            db $02                               
            db $F0,$F2,$C3,$F8                   
            db $F1,$F0,$00                       
  
  spr_08_bossDrac2_C0:
            db $03                               
            db $E0,$80,$02,$F8                   
            db $01,$82,$F8,$01                   
            db $84,$00                           
  
  spr_08_bossDrac2_C2:
            db $03                               
            db $E0,$A0,$02,$F8                   
            db $01,$A2,$F8,$01                   
            db $A4,$00                           
  
  spr_08_bossDrac2_C4:
            db $03                               
            db $E0,$C0,$01,$F8                   
            db $01,$C2,$F8,$01                   
            db $C4,$00                           
  
  spr_08_bossDrac2_C6:
            db $03                               
            db $E0,$86,$02,$F8                   
            db $01,$88,$F8,$01                   
            db $8A,$00                           
  
  spr_08_bossDrac2_C8:
            db $03                               
            db $E0,$A6,$02,$F8                   
            db $01,$A8,$F8,$01                   
            db $AA,$00                           
  
  spr_08_bossDrac2_CA:
            db $03                               
            db $E0,$C6,$01,$F8                   
            db $01,$C8,$F8,$01                   
            db $CA,$00                           
  
  spr_08_bossDrac2_CC:
            db $04                               
            db $E0,$8C,$02,$F8                   
            db $E1,$90,$00,$01                   
            db $8E,$F8,$01,$92                   
            db $00                               
  
  spr_08_bossDrac2_CE:
            db $04                               
            db $E0,$DE,$02,$F8                   
            db $E1,$B0,$00,$01                   
            db $AE,$F8,$01,$B2                   
            db $00                               
  
  spr_08_bossDrac2_D0:
            db $04                               
            db $E0,$CC,$01,$F8                   
            db $E1,$CE,$00,$01                   
            db $8E,$F8,$01,$92                   
            db $00                               
  
  spr_08_bossDrac2_D2:
            db $04                               
            db $F0,$94,$03,$F0                   
            db $F1,$96,$F8,$F0                   
            db $96,$43,$00,$F1                   
            db $94,$08                           
  
  spr_08_bossDrac2_D4:
            db $04                               
            db $F0,$98,$03,$F0                   
            db $F1,$9A,$F8,$F0                   
            db $9A,$43,$00,$F1                   
            db $98,$08                           
  
  spr_08_bossDrac2_drip_D6:
            db $01                               
            db $F0,$9C,$03,$FC                   
  
  spr_08_bossDrac2_drip_D8:
            db $02                               
            db $D0,$B4,$03,$FC                   
            db $F1,$B6,$FC                       
  
  spr_08_bossDrac2_drip_DA:
            db $02                               
            db $F0,$B8,$03,$F8                   
            db $F1,$BA,$00                       
  
  spr_08_bossDrac2_drip_DC:
            db $02                               
            db $F0,$BC,$03,$F4                   
            db $F1,$BE,$FC,$F1                   
            db $D0,$04                           
  
  spr_08_bossDrac2_drip_DE:
            db $02                               
            db $F0,$D2,$03,$F4                   
            db $F1,$D4,$FC,$F0                   
            db $D2,$43,$04                       
  
      spr_08__E0:
            db $01                               
            db $F0,$EC,$01,$00                   
  
      spr_08__E2:
            db $02                               
            db $F0,$EE,$01,$F8                   
            db $F1,$F0,$00                       
  
  spr_08_bossDrac3_eyes_E4:
            db $02                               
            db $F0,$D6,$01,$F8                   
            db $F0,$D6,$41,$00                   
  
  spr_08_bossDrac3_eyes_E6:
            db $02                               
            db $F0,$D8,$01,$F8                   
            db $F0,$D8,$41,$00                   
  
      spr_05__DE:
            db $01                               
            db $F0,$F4,$81,$F8                   
  
      spr_08__E8:
            db $01                               
            db $F0,$F4,$01,$FC                   
  
      spr_08__20:
            db $01                               
            db $F0,$F6,$81,$FC                   
  
  spr_08_bossDrac3_laser_EA:
            db $01                               
            db $F0,$F6,$01,$FC                   
  
      spr_08__22:
            db $01                               
            db $F0,$F8,$81,$F8                   
  
      spr_08__EC:
            db $01                               
            db $F0,$F8,$01,$F8                   
  
      spr_05__DC:
            db $01                               
            db $F0,$FA,$81,$F8                   
  
      spr_08__EE:
            db $01                               
            db $F0,$FA,$01,$F8                   
  
      spr_08__1E:
            db $01                               
            db $F0,$FC,$01,$F8                   
  
  spr_08_bossDrac_head_F0:
            db $01                               
            db $F0,$AC,$01,$FC                   
  
      spr_08__F2:
            db $01                               
            db $F0,$AC,$01,$FC                   
  
      spr_08__F4:
            db $01                               
            db $F0,$84,$01,$FC                   
  
      spr_08__F6:
            db $01                               
            db $F0,$8A,$01,$FC                   
  
      spr_08__F8:
            db $01                               
            db $F0,$90,$01,$FC                   
  
      spr_08__FA:
            db $01                               
            db $F0,$80,$01,$FC                   
  
      spr_08__FC:
            db $01                               
            db $F0,$86,$01,$FC                   
  
      spr_08__FE:
            db $01                               
            db $F0,$8C,$01,$FC                   
  
        spr_06_90:
            db $06                               
            db $DA,$C8,$43,$01                   
            db $F9,$D4,$F1,$FC                   
            db $EC,$83,$01,$E8                   
            db $D6,$03,$F9,$09                   
            db $C8,$F9,$13,$C8                   
            db $09                               
  
        spr_06_91:
            db $03                               
            db $E0,$E8,$03,$00                   
            db $01,$E4,$F8,$01                   
            db $E6,$00                           
  
        spr_06_92:
            db $03                               
            db $F4,$D4,$03,$00                   
            db $FB,$D8,$F8,$FA                   
            db $C2,$C3,$00                       
  
  spr_06_mapWaySympha_93:
            db $09                               
            db $D8,$C6,$C3,$F1                   
            db $DF,$C6,$F9,$E0                   
            db $CE,$43,$01,$DF                   
            db $C6,$09,$01,$C2                   
            db $F9,$EE,$DA,$03                   
            db $E9,$FF,$C6,$F1                   
            db $FF,$C8,$01,$01                   
            db $DC,$09                           
  
  
        spr_06_94:
            db $03                               
            db $EE,$C8,$03,$F6                   
            db $FF,$C2,$06,$E2                   
            db $C2,$C3,$FE                       
  
  spr_06_mapGhostShip_95:
            db $0C                               
            db $D0,$84,$03,$F8                   
            db $D1,$86,$00,$E1                   
            db $82,$F0,$F1,$8E                   
  
            db $F8,$F1,$90,$00                   
            db $E1,$88,$08,$EF                   
            db $8A,$10,$FB,$80                   
            db $E8,$01,$8C,$F0                   
            db $11,$94,$F8,$11                   
            db $96,$00,$01,$92                   
            db $08                               
  
        spr_06_96:
            db $0C                               
            db $D0,$A0,$03,$F8                   
            db $D1,$A2,$00,$E1                   
            db $9A,$F0,$F1,$BC                   
            db $F8,$F1,$BE,$00                   
            db $E1,$A4,$08,$EF                   
            db $8A,$10,$FB,$98                   
            db $E8,$01,$A6,$F0                   
            db $11,$A8,$F8,$11                   
            db $96,$00,$01,$92                   
            db $08                               
  
  spr_06_mapWayTerrorTower_97:
            db $02                               
            db $DE,$E8,$43,$FE                   
            db $FE,$EA,$03,$FD                   
  
        spr_06_98:
            db $04                               
            db $E8,$E2,$03,$EF                   
            db $F1,$CA,$F7,$F1                   
            db $E0,$FF,$09,$CA                   
            db $07                               
  
  spr_06_mapWaySwamp_99:
            db $06                               
            db $CE,$C6,$C3,$F8                   
            db $E0,$C6,$43,$00                   
            db $E6,$DA,$03,$F0                   
            db $F7,$C8,$F8,$03                   
            db $C6,$00,$03,$C4                   
            db $08                               
  
        spr_06_9a:
            db $06                               
            db $00,$C8,$43,$E9                   
            db $01,$C2,$F1,$01                   
            db $EC,$F9,$F5,$C8                   
            db $01,$F3,$C2,$09                   
            db $EF,$EC,$11                       
  
        spr_06_9b:
            db $03                               
            db $FC,$C2,$43,$F6                   
            db $F2,$C4,$03,$FE                   
            db $E5,$DE,$06                       
  
        spr_06_9c:
            db $09                               
            db $D4,$EC,$C3,$E4                   
            db $F6,$C4,$43,$FC                   
            db $F3,$C8,$04,$E7                   
            db $D2,$0C,$CB,$EC                   
            db $04,$F2,$C8,$03                   
            db $EC,$F7,$C4,$F4                   
            db $D7,$D4,$14,$C7                   
            db $CC,$0C                           
  
  spr_06_mapSymphaWalking_9d:
            db $04                               
            db $E0,$40,$00,$F8                   
            db $E1,$42,$00,$01                   
            db $44,$F8,$01,$46                   
            db $00                               
  
  spr_06_mapSymphaWalking_a0:
            db $04                               
            db $E0,$48,$00,$F8                   
            db $E1,$4A,$00,$01                   
            db $4C,$F8,$01,$4E                   
  
            db $00                               
  
  spr_06_mapSymphaWalking_9f:
            db $04                               
            db $E0,$50,$00,$F8                   
            db $E1,$52,$00,$01                   
            db $54,$F8,$01,$56                   
            db $00                               
  
  spr_06_mapGrantWalking_a1:
            db $04                               
            db $E0,$40,$00,$F4                   
            db $E1,$42,$FC,$01                   
            db $44,$F8,$01,$46                   
            db $00                               
  
  spr_06_mapGrantWalking_a2:
            db $04                               
            db $E0,$48,$00,$F5                   
            db $E1,$4A,$FD,$01                   
            db $4C,$F8,$01,$4E                   
            db $00                               
  
  spr_06_mapGrantWalking_a3:
            db $04                               
            db $E0,$50,$00,$F4                   
            db $E1,$52,$FC,$01                   
            db $54,$F8,$01,$56                   
            db $00                               
  
  spr_06_mapAlucardWalking_a4:
            db $05                               
            db $C0,$40,$00,$FC                   
            db $E1,$42,$F8,$E1                   
            db $44,$00,$01,$46                   
            db $F9,$01,$48,$01                   
  
  spr_06_mapAlucardWalking_a6:
            db $05                               
            db $C0,$4A,$00,$FC                   
            db $E1,$4C,$F8,$E1                   
            db $4E,$00,$01,$50                   
            db $F8,$01,$52,$00                   
  
        spr_06_a5:
            db $05                               
            db $C0,$40,$00,$FC                   
            db $E1,$54,$F8,$E1                   
            db $56,$00,$01,$58                   
            db $F9,$01,$5A,$01                   
  
    spr_06_mapPin_a9:
            db $02                               
            db $00,$9C,$02,$00                   
            db $01,$9E,$08                       
  
        spr_06_aa:
            db $02                               
            db $00,$B8,$02,$00                   
            db $01,$BA,$08                       
  
  spr_06_map2_startPoint_b3:
            db $01                               
            db $00,$C0,$02,$00                   
  
  spr_06_map2_bossBat_b4:
            db $02                               
            db $00,$B0,$03,$F8                   
            db $00,$B0,$43,$00                   
  
  spr_06_map2_bossBat_b5:
            db $02                               
            db $00,$B2,$03,$F8                   
            db $00,$B2,$43,$00                   
  
        spr_06_b6:
            db $02                               
            db $00,$B4,$03,$F8                   
            db $00,$B4,$43,$00                   
  
        spr_06_b7:
            db $02                               
            db $02,$B6,$03,$F8                   
            db $02,$B6,$43,$00                   
  
        spr_06_b8:
            db $02                               
            if !cv3ClimbableRope == 1
            db $F0,$BB,$03,$F8
            db $F1,$BD,$00
            else
            db $F0,$6A,$03,$F8                   
            db $F1,$6C,$00                       
            endif
  
        spr_06_b9:
            db $01                               
            if !cv3ClimbableRope == 1
            db $F0,$BF,$00,$F8
            else
            db $F0,$6E,$00,$F8                   
            endif
  
        spr_06_ba:
            db $02                               
            db $F0,$15,$23,$F8                   
            db $F0,$15,$63,$00                   
  
        spr_06_bb:
            db $02                               
            db $F0,$17,$23,$F8                   
            db $F0,$17,$63,$00                   
  
        spr_06_bc:
            db $02                               
            db $F0,$DA,$41,$F8                   
            db $F1,$D8,$00                       

}

  
  spriteList_objects_06:
            dw spr_06_07_objects_00              ;0DABE7|        |0DAE99;
            dw spr_06_door_02                    ;0DABE9|        |0DAEA7;
            dw spr_06_door_04                    ;0DABEB|        |0DAEBB;
            dw spr_06_door_02                    ;0DABED|        |0DAEA7;
            dw spr_06_swing_stigth_08            ;0DABEF|        |0DB075;
            dw spr_06_swing_0a                   ;0DABF1|        |0DB07D;
            dw spr_06_swing_0c                   ;0DABF3|        |0DB085;
            dw spr_06_swing_0e                   ;0DABF5|        |0DB08D;
            dw spr_06_swing_10                   ;0DABF7|        |0DB095;
            dw spr_06_swing_left_12              ;0DABF9|        |0DB09D;
            dw spr_06_swing_left_14              ;0DABFB|        |0DB0A5;
            dw spr_06_swing_left_16              ;0DABFD|        |0DB0AD;
            dw spr_06_swing_left_18              ;0DABFF|        |0DB0B5;
            dw spr_06_platform_1a                ;0DAC01|        |0DB0BD;
            dw spr_06_platform_turning_1c        ;0DAC03|        |0DB0CB;
            dw spr_06_platform_turning_1e        ;0DAC05|        |0DB0DC;
            dw spr_06_platform_turning_20        ;0DAC07|        |0DB0E4;
            dw spr_06_platform_1a                ;0DAC09|        |0DB0BD;
            dw spr_06_platform_spike_24          ;0DAC0B|        |0DB0F5;
            dw spr_06_platform_spike_turning_26  ;0DAC0D|        |0DB103;
            dw spr_06_platform_spike_turning_28  ;0DAC0F|        |0DB117;
            dw spr_06_platform_spike_turning_2a  ;0DAC11|        |0DB125;
            dw spr_06_platform_spike_upsideDown_2c;0DAC13|        |0DB139;
            dw spr_06_platform_spike_turning_2a  ;0DAC15|        |0DB125;
            dw spr_06_platform_spike_turning_28  ;0DAC17|        |0DB117;
            dw spr_06_platform_spike_turning_26  ;0DAC19|        |0DB103;
            dw spr_06_platform_spike_24          ;0DAC1B|        |0DB0F5;
            dw spr_06_gearKog_up_36              ;0DAC1D|        |0DB147;
            dw spr_06_gearKog_turing_38          ;0DAC1F|        |0DB14C;
            dw spr_06_gearKog_turing_3a          ;0DAC21|        |0DB151;
            dw spr_06_gearKog_turing_3c          ;0DAC23|        |0DB156;
            dw spr_06_gearKog_staight_3e         ;0DAC25|        |0DB15B;
            dw spr_06_gearKog_turing_40          ;0DAC27|        |0DB160;
            dw spr_06_gearKog_turing_42          ;0DAC29|        |0DB165;
            dw spr_06_gearKog_turing_44          ;0DAC2B|        |0DB16A;
            dw spr_06_gearKog_down_46            ;0DAC2D|        |0DB16F;
            dw spr_06_pandalom_stringStright_48  ;0DAC2F|        |0DB174;
            dw spr_06_pandalom_string_4a         ;0DAC31|        |0DB179;
            dw spr_06_pandalom_string_4c         ;0DAC33|        |0DB17E;
            dw spr_06_pandalom_string_4e         ;0DAC35|        |0DB186;
            dw spr_06_pandalom_string_50         ;0DAC37|        |0DB18E;
            dw spr_06_pandalom_52                ;0DAC39|        |0DB196;
            dw spr_06_spike_upDown_54            ;0DAC3B|        |0DB1B2;
            dw spr_drip_56                       ;0DAC3D|        |0DB1E6;
            dw spr_drip_58                       ;0DAC3F|        |0DB1EF;
            dw spr_drip_5a                       ;0DAC41|        |0DB1F7;
            dw spr_drip_5c                       ;0DAC43|        |0DB1FF;
            dw spr_drip_fall_5e                  ;0DAC45|        |0DB204;
            dw spr_drip_block_60                 ;0DAC47|        |0DB209;
            dw spr_drip_block_62                 ;0DAC49|        |0DB211;
            dw spr_drip_block_64                 ;0DAC4B|        |0DB21A;
            dw spr_drip_block_66                 ;0DAC4D|        |0DB222;
            dw spr_drip_block_68                 ;0DAC4F|        |0DB22A;
            dw spr_drip_block_6a                 ;0DAC51|        |0DB233;
            dw spr_drip_block_6c                 ;0DAC53|        |0DB23C;
            dw spr_drip_block_6e                 ;0DAC55|        |0DB245;
            dw spr_06_playerEncounter_trevor_70  ;0DAC57|        |0DB24D;
            dw spr_06_playerEncounter_trevor_72  ;0DAC59|        |0DB25B;
            dw spr_06_playerEncounter_trevor_idle74;0DAC5B|        |0DB266;
            dw spr_06_playerEncounter_trevor_yes_76;0DAC5D|        |0DB274;
            dw spr_06_playerEncounter_trevor_no_78;0DAC5F|        |0DB282;
            dw spr_06_playerEncounter_trevor_no_7a;0DAC61|        |0DB290;
            dw spr_06_playerEncounter_grant_7c   ;0DAC63|        |0DB29E;
            dw spr_06_object_7e                  ;0DAC65|        |0DB2AC;
            dw spr_06_object_80                  ;0DAC67|        |0DB2BA;
            dw spr_06_81                         ;0DAC69|        |0DB2C8;
            dw spr_06_82                         ;0DAC6B|        |0DB2E9;
            dw spr_06_playerEncounter_grantTalk_83;0DAC6D|        |0DB30A;
            dw spr_06_playerEncounter_alucard_84 ;0DAC6F|        |0DB318;
            dw spr_06_playerEncounter_alucard_85 ;0DAC71|        |0DB329;
            dw spr_06_playerEncounter_alucard_idle_86;0DAC73|        |0DB33A;
            dw spr_06_87                         ;0DAC75|        |0DB34B;
            dw spr_06_88                         ;0DAC77|        |0DB36F;
            dw spr_06_89                         ;0DAC79|        |0DB393;
            dw spr_06_symphaEncounter_8a         ;0DAC7B|        |0DB3A4;
            dw spr_06_symphaEncounter_8b         ;0DAC7D|        |0DB3B2;
            dw spr_06_symphaEncounter_8c         ;0DAC7F|        |0DB3C0;
            dw spr_06_symphaEncounter_8d         ;0DAC81|        |0DB3CE;
            dw spr_06_symphaEncounter_8e         ;0DAC83|        |0DB3EF;
            dw spr_06_symphaEncounter_8f         ;0DAC85|        |0DB410;
            dw spr_06_90                         ;0DAC87|        |0DA9F0;
            dw spr_06_91                         ;0DAC89|        |0DAA06;
            dw spr_06_92                         ;0DAC8B|        |0DAA11;
            dw spr_06_mapWaySympha_93            ;0DAC8D|        |0DAA1D;
            dw spr_06_94                         ;0DAC8F|        |0DAA3C;
            dw spr_06_mapGhostShip_95            ;0DAC91|        |0DAA48;
            dw spr_06_96                         ;0DAC93|        |0DAA6E;
            dw spr_06_mapWayTerrorTower_97       ;0DAC95|        |0DAA94;
            dw spr_06_98                         ;0DAC97|        |0DAA9D;
            dw spr_06_mapWaySwamp_99             ;0DAC99|        |0DAAAB;
            dw spr_06_9a                         ;0DAC9B|        |0DAAC1;
            dw spr_06_9b                         ;0DAC9D|        |0DAAD5;
            dw spr_06_9c                         ;0DAC9F|        |0DAAE1;
            dw spr_06_mapSymphaWalking_9d        ;0DACA1|        |0DAB00;
            dw spr_06_mapSymphaWalking_a0        ;0DACA3|        |0DAB0E;
            dw spr_06_mapSymphaWalking_9f        ;0DACA5|        |0DAB1C;
            dw spr_06_mapSymphaWalking_a0        ;0DACA7|        |0DAB0E;
            dw spr_06_mapGrantWalking_a1         ;0DACA9|        |0DAB2A;
            dw spr_06_mapGrantWalking_a2         ;0DACAB|        |0DAB38;
            dw spr_06_mapGrantWalking_a3         ;0DACAD|        |0DAB46;
            dw spr_06_mapGrantWalking_a2         ;0DACAF|        |0DAB38;
            dw spr_06_mapAlucardWalking_a4       ;0DACB1|        |0DAB54;
            dw spr_06_mapAlucardWalking_a6       ;0DACB3|        |0DAB65;
            dw spr_06_a5                         ;0DACB5|        |0DAB76;
            dw spr_06_mapAlucardWalking_a6       ;0DACB7|        |0DAB65;
            dw spr_06_mapPin_a9                  ;0DACB9|        |0DAB87;
            dw spr_06_mapPin_a9                  ;0DACBB|        |0DAB87;
            dw spr_06_mapPin_a9                  ;0DACBD|        |0DAB87;
            dw spr_06_aa                         ;0DACBF|        |0DAB8F;
            dw spr_06_symphaEncounter_ab         ;0DACC1|        |0DB41E;
            dw spr_06_symphaEncounter_ac         ;0DACC3|        |0DB444;
            dw spr_06_symphaEncounter_ad         ;0DACC5|        |0DB452;
            dw spr_06_symphaEncounter_ae         ;0DACC7|        |0DB460;
            dw spr_06_symphaEncounter_af         ;0DACC9|        |0DB46E;
            dw spr_06_symphaEncounter_b0         ;0DACCB|        |0DB488;
            dw spr_06_symphaEncounter_b1         ;0DACCD|        |0DB49F;
            dw spr_06_crumbleBlockFall_b2        ;0DACCF|        |0DB4AD;
            dw spr_06_map2_startPoint_b3         ;0DACD1|        |0DAB97;
            dw spr_06_map2_bossBat_b4            ;0DACD3|        |0DAB9C;
            dw spr_06_map2_bossBat_b5            ;0DACD5|        |0DABA5;
            dw spr_06_b6                         ;0DACD7|        |0DABAE;
            dw spr_06_b7                         ;0DACD9|        |0DABB7;
            dw spr_06_b8                         ;0DACDB|        |0DABC0;
            dw spr_06_b9                         ;0DACDD|        |0DABC8;
            dw spr_06_ba                         ;0DACDF|        |0DABCD;
            dw spr_06_bb                         ;0DACE1|        |0DABD6;
            dw spr_06_bc                         ;0DACE3|        |0DABDF;
            dw spr_06_bd                         ;0DACE5|        |0DB1CC;
  
  spriteList_enemy_0a:
            dw spr_0A_symphaRelease_01           ;0DACE7|        |0DB4B5;
            dw spr_0A_symphaRelease_01           ;0DACE9|        |0DB4B5;
            dw spr_0A_symphaRelease_02           ;0DACEB|        |0DB4C4;
            dw spr_0A_symphaRelease_03           ;0DACED|        |0DB4D3;
            dw spr_0A_symphaRelease_04           ;0DACEF|        |0DB4E1;
            dw spr_0A_symphaRelease_05           ;0DACF1|        |0DB4FE;
            dw spr_0A_symphaRelease_06           ;0DACF3|        |0DB50C;
            dw spr_0A_symphaRelease_07           ;0DACF5|        |0DB51D;
            dw spr_0A_08                         ;0DACF7|        |0DB52B;
            dw spr_0A_09                         ;0DACF9|        |0DB534;
            dw spr_0A_0a                         ;0DACFB|        |0DB54F;
            dw spr_0A_endingCastle_0b            ;0DACFD|        |0DB581;
            dw spr_0A_ending_0c                  ;0DACFF|        |0DB5C2;
            dw spr_0A_0d                         ;0DAD01|        |0DB5F4;
            dw spr_0A_endingTrevorSolo_0e        ;0DAD03|        |0DB605;
            dw spr_0A_endingTrevorSolo_0f        ;0DAD05|        |0DB616;
            dw spr_0A_endingTrevorSolo_10        ;0DAD07|        |0DB62A;
            dw spr_0A_endingGrant_11             ;0DAD09|        |0DB63E;
            dw spr_0A_endingGrant_12             ;0DAD0B|        |0DB64C;
            dw spr_0A_endingGrant_13             ;0DAD0D|        |0DB65D;
            dw spr_0A_endingAlucard_14           ;0DAD0F|        |0DB66E;
            dw spr_0A_endingAlucard_15           ;0DAD11|        |0DB682;
            dw spr_0A_endingAlucard_16           ;0DAD13|        |0DB699;
            dw spr_0A_endingSympha_17            ;0DAD15|        |0DB6B0;
            dw spr_0A_endingSympha_18            ;0DAD17|        |0DB6C1;
            dw spr_0A_endingSympha_1d            ;0DAD19|        |0DB6D3;
            dw spr_0A_endingSympha_1e            ;0DAD1B|        |0DB6EB;
            dw spr_0A_endingSympha_1b            ;0DAD1D|        |0DB700;
            dw spr_0A_endingSympha_1e            ;0DAD1F|        |0DB6EB;
            dw spr_0A_endingSympha_1d            ;0DAD21|        |0DB6D3;
            dw spr_0A_endingSympha_1e            ;0DAD23|        |0DB6EB;
            dw spr_0A_endingSympha_1f            ;0DAD25|        |0DB715;
            dw spr_0A_endingSympha_20            ;0DAD27|        |0DB736;
            dw spr_0A_borderPWselect_21          ;0DAD29|        |0DB75D;
            dw spr_0A_bossWaterDragons_Fire_appear_22;0DAD2B|        |0DADC5;
            dw spr_0A_bossWaterDragons_Fire_appear_23;0DAD2D|        |0DADCA;
            dw spr_0A_bossWaterDragons_Fire_appear_24;0DAD2F|        |0DADD2;
            dw spr_0A_bossWaterDragons_Fire_appear_25;0DAD31|        |0DADDD;
            dw spr_0A_bossWaterDragons_Fire_full_26;0DAD33|        |0DADEB;
            dw spr_0A_bossWaterDragons_Fire_full_27;0DAD35|        |0DADFC;
            dw spr_0A_28                         ;0DAD37|        |0DAE0D;
            dw spr_0A_29                         ;0DAD39|        |0DAE15;
            dw spr_0A_2c                         ;0DAD3B|        |0DAE1D;
            dw spr_0A_2b                         ;0DAD3D|        |0DAE25;
            dw spr_0A_2c                         ;0DAD3F|        |0DAE1D;
            dw spr_0A_2d                         ;0DAD41|        |0DAE3A;
            dw spr_0A_2e                         ;0DAD43|        |0DAE42;
            dw spr_0A_2f                         ;0DAD45|        |0DAE4A;
            dw spr_0A_30                         ;0DAD47|        |0DAE58;
            dw spr_09_speaKnight_Q2_31           ;0DAD49|        |0DAE66;
            dw spr_09_speaKnight_Q2_32           ;0DAD4B|        |0DAE77;
            dw spr_09_speaKnight_Q2_33           ;0DAD4D|        |0DAE88;
            dw spr_0A_34                         ;0DAD4F|        |0DAE2D;
            dw spr_0A_bossLeviaton_shot_35       ;0DAD51|        |0DAE32;
  
  spriteList_objects_07:
            dw spr_06_07_objects_00              ;0DAD53|        |0DAE99;
            dw spr_07_candle_02                  ;0DAD55|        |0DAEF8;
            dw spr_07_candle_04                  ;0DAD57|        |0DAEFD;
            dw spr_06_07_objects_00              ;0DAD59|        |0DAE99;
            dw spr_06_07_objects_00              ;0DAD5B|        |0DAE99;
            dw spr_07_torchStand_0a              ;0DAD5D|        |0DAF1D;
            dw spr_07_torchStand_0c              ;0DAD5F|        |0DAF2E;
            dw spr_07__0d                        ;0DAD61|        |0DAF51;
            dw spr_07__0e                        ;0DAD63|        |0DAF56;
            dw spr_07__0f                        ;0DAD65|        |0DAF5F;
            dw spr_07_fireBall_10                ;0DAD67|        |0DAF64;
            dw spr_07__11                        ;0DAD69|        |0DAF69;
            dw spr_07_crumblBridgePobble_12      ;0DAD6B|        |0DAF7F;
            dw spr_07_waterSplash_13             ;0DAD6D|        |0DAFA0;
            dw spr_07_wallMeat_14                ;0DAD6F|        |0DAFA5;
            dw spr_07_porion_15                  ;0DAD71|        |0DAFAD;
            dw spr_07_rossery_16                 ;0DAD73|        |0DAFB5;
            dw spr_07_oneUp_17                   ;0DAD75|        |0DAFBD;
            dw spr_07_moneyBag_18                ;0DAD77|        |0DAFC5;
            dw spr_07_money100_19                ;0DAD79|        |0DAFCD;
            dw spr_07_money200_1a                ;0DAD7B|        |0DAFD5;
            dw spr_07_money400_1b                ;0DAD7D|        |0DAFDD;
            dw spr_07_money700_11c               ;0DAD7F|        |0DAFE5;
            dw spr_07_money1000_1d               ;0DAD81|        |0DAFED;
            dw spr_07_money2000_1e               ;0DAD83|        |0DAFF5;
            dw spr_07_money_1f                   ;0DAD85|        |0DAFFD;
            dw spr_07_money_20                   ;0DAD87|        |0DB005;
            dw spr_07_axeAxearmor_21             ;0DAD89|        |0DAED8;
            dw spr_07_axeAxearmor_22             ;0DAD8B|        |0DAEE0;
            dw spr_07_axeAxearmor_23             ;0DAD8D|        |0DAEE8;
            dw spr_07_axeAxearmor_24             ;0DAD8F|        |0DAEF0;
            dw trevorSpr_flame_56                ;0DAD91|        |0D93CB;
            dw trevorSpr_flame_58                ;0DAD93|        |0D93D0;
            dw trevorSpr_flame_5A                ;0DAD95|        |0D93D5;
            dw trevorSpr_flame_58                ;0DAD97|        |0D93D0;
            dw spr_07__2e                        ;0DAD99|        |0DB058;
            dw spr_07_block4Pebbles_2f           ;0DAD9B|        |0DAF84;
            dw spr_07_block2Pebbles_30           ;0DAD9D|        |0DAF95;
            dw spr_07_flameBossKill_31           ;0DAD9F|        |0DAF3F;
            dw spr_07_flameBossKill_32           ;0DADA1|        |0DAF48;
            dw spr_07_crumblBridgeStone_33       ;0DADA3|        |0DAF77;
            dw spr_07__34                        ;0DADA5|        |0DB05D;
            dw spr_07__35                        ;0DADA7|        |0DB065;
            dw spr_07__36                        ;0DADA9|        |0DB06D;
            dw spr_07_multiShot2_37              ;0DADAB|        |0DB018;
            dw spr_07_multiShot3_38              ;0DADAD|        |0DB020;
            dw spr_07_Orb_39                     ;0DADAF|        |0DB038;
            dw spr_07_Orb_3a                     ;0DADB1|        |0DB041;
            dw spr_07_lantern_3b                 ;0DADB3|        |0DAF02;
            dw spr_07_lantern_3e                 ;0DADB5|        |0DAF0B;
            dw spr_07_lantern_3d                 ;0DADB7|        |0DAF14;
            dw spr_07_lantern_3e                 ;0DADB9|        |0DAF0B;
            dw spr_07_clock_3f                   ;0DADBB|        |0DB028;
            dw spr_07_whipUpgrade_40             ;0DADBD|        |0DB030;
            dw spr_06_07_objects_00              ;0DADBF|        |0DAE99;
            dw spr_07_bossDrac3_platform_42      ;0DADC1|        |0DB04A;
            dw spr_07_money_44                   ;0DADC3|        |0DB00D;


{ ; spriteList_all over the place 
  
  spr_0A_bossWaterDragons_Fire_appear_22:
            db $01                              
            db $F0,$B0,$02,$F0                  
  
  spr_0A_bossWaterDragons_Fire_appear_23:
            db $02                              
            db $F0,$B0,$82,$E8                  
            db $F1,$FC,$F0                      
  
  spr_0A_bossWaterDragons_Fire_appear_24:
            db $03                              
            db $F0,$B0,$02,$E0                  
            db $F1,$FA,$E8,$F1                  
            db $FC,$F0                          
  
  spr_0A_bossWaterDragons_Fire_appear_25:
            db $04                              
            db $F0,$B0,$82,$D8                  
            db $F1,$B4,$E0,$F1                  
            db $FA,$E8,$F1,$FC                  
            db $F0                              
  
  spr_0A_bossWaterDragons_Fire_full_26:
            db $05                              
            db $F0,$B0,$02,$D0                  
            db $F1,$B2,$D8,$F1                  
            db $B4,$E0,$F1,$FA                  
            db $E8,$F1,$FC,$F0                  
  
  spr_0A_bossWaterDragons_Fire_full_27:
            db $05                              
            db $F0,$B0,$82,$D0                  
            db $F1,$B2,$D8,$F1                  
            db $B4,$E0,$F1,$FA                  
            db $E8,$F1,$FC,$F0                  
  
        spr_0A_28:
            db $02                              
            db $F0,$B0,$02,$F0                  
            db $F1,$FC,$F8                      
  
        spr_0A_29:
            db $02                              
            db $E8,$41,$03,$F8                  
            db $E9,$43,$00                      
  
        spr_0A_2c:
            db $02                              
            db $F0,$45,$03,$F8                  
            db $F1,$47,$00                      
  
        spr_0A_2b:
            db $02                              
            db $F8,$49,$03,$F8                  
            db $F9,$4B,$00                      
  
        spr_0A_34:
            db $01                              
            db $F0,$DA,$03,$FC                  
  
  spr_0A_bossLeviaton_shot_35:
            db $02                              
            db $F0,$DC,$03,$F8                  
            db $F1,$DE,$00                      
  
        spr_0A_2d:
            db $02                              
            db $F0,$77,$01,$F8                  
            db $F1,$79,$00                      
  
        spr_0A_2e:
            db $02                              
            db $F0,$7B,$01,$F8                  
            db $F1,$7D,$00                      
  
        spr_0A_2f:
            db $04                              
            db $E0,$41,$02,$F4                  
            db $E1,$43,$FC,$01                  
            db $45,$F8,$01,$47                  
            db $00                              
  
        spr_0A_30:
            db $04                              
            db $E2,$55,$02,$F5                  
            db $E3,$57,$FD,$01                  
            db $49,$F8,$01,$4B                  
            db $00                              
  
  spr_09_speaKnight_Q2_31:
            db $05                              
            db $EE,$71,$01,$F4                  
            db $E3,$61,$FC,$E3                  
            db $63,$04,$01,$65                  
            db $FC,$01,$67,$04                  
  
  spr_09_speaKnight_Q2_32:
            db $05                              
            db $F0,$71,$01,$F4                  
            db $E3,$61,$FC,$E3                  
            db $63,$04,$01,$69                  
            db $FC,$01,$6B,$04                  
  
  spr_09_speaKnight_Q2_33:
            db $05                              
            db $EC,$71,$01,$F4                  
            db $E1,$61,$FC,$E1                  
            db $63,$04,$01,$6D                  
            db $FC,$01,$6F,$04                  
  
  spr_06_07_objects_00:
            db $04                              
            db $F0,$4D,$00,$F0                  
            db $F1,$5D,$F8,$F1                  
            db $6D,$00,$F1,$7D                  
            db $08                              
  
    spr_06_door_02:
            db $06                              
            db $C0,$05,$03,$F0                  
            db $C1,$0F,$F8,$E1                  
            db $07,$F0,$E1,$09                  
            db $F8,$01,$07,$F0                  
            db $01,$09,$F8                      
  
    spr_06_door_04:
            db $09                              
            db $C0,$0B,$03,$E8                  
            db $C1,$0D,$F0,$C1                  
            db $0D,$F8,$E1,$09                  
            db $E8,$E1,$09,$F0                  
            db $E1,$09,$F8,$01                  
            db $09,$E8,$01,$09                  
            db $F0,$01,$09,$F8                  
  
  spr_07_axeAxearmor_21:
            db $02                              
            db $F0,$EA,$01,$F8                  
            db $F1,$EC,$00                      
  
  spr_07_axeAxearmor_22:
            db $02                              
            db $F0,$EC,$41,$F8                  
            db $F1,$EA,$00                      
  
  spr_07_axeAxearmor_23:
            db $02                              
            db $F0,$EC,$C1,$F8                  
            db $F1,$EA,$00                      
  
  spr_07_axeAxearmor_24:
            db $02                              
            db $F0,$EA,$81,$F8                  
            db $F1,$EC,$00                      
  
    spr_07_candle_02:
            db $01                              
            db $F0,$F1,$03,$FC                  
  
    spr_07_candle_04:
            db $01                              
            db $F0,$F3,$03,$FC                  
  
    spr_07_lantern_3b:
            db $02                              
            db $F0,$2B,$01,$F8                  
            db $F0,$2B,$41,$00                  
  
    spr_07_lantern_3e:
            db $02                              
            db $F0,$1D,$01,$F8                  
            db $F0,$1D,$41,$00                  
  
    spr_07_lantern_3d:
            db $02                              
            db $F0,$1F,$01,$F8                  
            db $F0,$1F,$41,$00                  
  
  spr_07_torchStand_0a:
            db $04                              
            db $E0,$15,$03,$F8                  
            db $E0,$15,$43,$00                  
            db $00,$19,$01,$F8                  
            db $00,$19,$41,$00                  
  
  spr_07_torchStand_0c:
            db $04                              
            db $E0,$17,$03,$F8                  
            db $E0,$17,$43,$00                  
            db $00,$19,$01,$F8                  
            db $00,$19,$41,$00                  
  
  spr_07_flameBossKill_31:
            db $02                              
            db $00,$15,$03,$F8                  
            db $00,$15,$43,$00                  
  
  spr_07_flameBossKill_32:
            db $02                              
            db $00,$17,$03,$F8                  
            db $00,$17,$43,$00                  
  
      spr_07__0d:
            db $01                              
            db $F0,$25,$03,$FC                  
  
      spr_07__0e:
            db $02                              
            db $F0,$03,$03,$F8                  
            db $F0,$03,$43,$00                  
  
      spr_07__0f:
            db $01                              
            db $F0,$E1,$03,$FC                  
  
  spr_07_fireBall_10:
            db $01                              
            db $F8,$E3,$03,$FC                  
  
      spr_07__11:
            db $04                              
            db $F0,$E5,$00,$F0                  
            db $F1,$E5,$F8,$F1                  
            db $E5,$00,$F1,$E5                  
            db $08                              
  
  spr_07_crumblBridgeStone_33:
            db $02                              
            db $F2,$BF,$40,$F8                  
            db $F3,$BD,$00                      
  
  spr_07_crumblBridgePobble_12:
            db $01                              
            db $F0,$E7,$01,$FC                  
  
  spr_07_block4Pebbles_2f:
            db $05                              
            db $E4,$E7,$01,$F8                  
            db $E5,$E7,$00,$F5                  
            db $E7,$F8,$F5,$E7                  
            db $FD,$F5,$E7,$00                  
  
  spr_07_block2Pebbles_30:
            db $03                              
            db $F8,$E7,$01,$F8                  
            db $F9,$E7,$FD,$F9                  
            db $E7,$00                          
  
  spr_07_waterSplash_13:
            db $01                              
            db $F0,$E9,$01,$FC                  
  
  spr_07_wallMeat_14:
            db $02                              
            db $F0,$D1,$03,$F8                  
            db $F1,$D3,$00                      
  
    spr_07_porion_15:
            db $02                              
            db $F0,$D5,$00,$F8                  
            db $F1,$D7,$00                      
  
    spr_07_rossery_16:
            db $02                              
            db $F0,$D9,$01,$F8                  
            db $F1,$DB,$00                      
  
    spr_07_oneUp_17:
            db $02                              
            db $F0,$F9,$03,$F8                  
            db $F1,$FB,$00                      
  
  spr_07_moneyBag_18:
            db $02                              
            db $F0,$CD,$01,$F8                  
            db $F1,$CF,$00                      
  
  spr_07_money100_19:
            db $02                              
            db $F0,$C1,$01,$F8                  
            db $F1,$C9,$00                      
  
  spr_07_money200_1a:
            db $02                              
            db $F0,$C3,$01,$F8                  
            db $F1,$C9,$00                      
  
  spr_07_money400_1b:
            db $02                              
            db $F0,$C5,$01,$F8                  
            db $F1,$C9,$00                      
  
  spr_07_money700_11c:
            db $02                              
            db $F0,$C7,$01,$F8                  
            db $F1,$C9,$00                      
  
  spr_07_money1000_1d:
            db $02                              
            db $F0,$C1,$01,$F8                  
            db $F1,$CB,$00                      
  
  spr_07_money2000_1e:
            db $02                              
            db $F0,$C3,$01,$F8                  
            db $F1,$CB,$00                      
  
    spr_07_money_1f:
            db $02                              
            db $F0,$C5,$01,$F8                  
            db $F1,$CB,$00                      
  
    spr_07_money_20:
            db $02                              
            db $F0,$C7,$01,$F8                  
            db $F1,$CB,$00                      
  
    spr_07_money_44:
            db $03                              
            db $F0,$C1,$01,$F4                  
            db $F1,$CB,$FC,$F1                  
            db $C9,$04                          
  
  spr_07_multiShot2_37:
            db $02                              
            db $F0,$70,$03,$F8                  
            db $F1,$72,$00                      
  
  spr_07_multiShot3_38:
            db $02                              
            db $F0,$74,$01,$F8                  
            db $F1,$76,$00                      
  
    spr_07_clock_3f:
            db $02                              
            db $F0,$11,$01,$F8                  
            db $F1,$13,$00                      
  
  spr_07_whipUpgrade_40:
            db $02                              
            db $F0,$21,$01,$F8                  
            db $F1,$23,$00                      
  
      spr_07_Orb_39:
            db $02                              
            db $F0,$F5,$03,$F8                  
            db $F0,$F5,$43,$00                  
  
      spr_07_Orb_3a:
            db $02                              
            db $F0,$F7,$03,$F8                  
            db $F0,$F7,$43,$00                  
  
  spr_07_bossDrac3_platform_42:
            db $04                              
            db $F0,$BD,$00,$F0                  
            db $F1,$BF,$F8,$F1                  
            db $BD,$00,$F1,$BF                  
            db $08                              
  
      spr_07__2e:
            db $01                              
            db $00,$E7,$00,$FC                  
  
      spr_07__34:
            db $02                              
            db $F0,$7C,$01,$F8                  
            db $F1,$7E,$00                      
  
      spr_07__35:
            db $02                              
            db $F0,$7C,$03,$F8                  
            db $F1,$7E,$00                      
  
      spr_07__36:
            db $02                              
            db $F0,$7C,$00,$F8                  
            db $F1,$7E,$00                      
  
  spr_06_swing_stigth_08:
            db $02                              
            db $F0,$98,$01,$F8                  
            db $F1,$9A,$00                      
  
    spr_06_swing_0a:
            db $02                              
            db $F0,$98,$01,$F8                  
            db $F3,$9A,$00                      
  
    spr_06_swing_0c:
            db $02                              
            db $F0,$9C,$01,$F8                  
            db $F1,$9E,$00                      
  
    spr_06_swing_0e:
            db $02                              
            db $F0,$A0,$01,$F8                  
            db $F1,$A2,$00                      
  
    spr_06_swing_10:
            db $02                              
            db $F0,$A4,$01,$F8                  
            db $F1,$A6,$00                      
  
  spr_06_swing_left_12:
            db $02                              
            db $F2,$9A,$41,$F8                  
            db $F1,$98,$00                      
  
  spr_06_swing_left_14:
            db $02                              
            db $F0,$9E,$41,$F8                  
            db $F1,$9C,$00                      
  
  spr_06_swing_left_16:
            db $02                              
            db $F0,$A2,$41,$F8                  
            db $F1,$A0,$00                      
  
  spr_06_swing_left_18:
            db $02                              
            db $F0,$A6,$41,$F8                  
            db $F1,$A4,$00                      
  
  spr_06_platform_1a:
            db $04                              
            db $F8,$E5,$02,$F0                  
            db $F9,$E5,$F8,$F9                  
            db $E5,$00,$F9,$E5                  
            db $08                              
  
  spr_06_platform_turning_1c:
            db $05                              
            db $E6,$80,$02,$EE                  
            db $E7,$82,$F6,$E7                  
            db $84,$FE,$07,$86                  
            db $FE,$01,$88,$06                  
  
  spr_06_platform_turning_1e:
            db $02                              
            db $E0,$8A,$02,$F8                  
            db $01,$8A,$F8                      
  
  spr_06_platform_turning_20:
            db $05                              
            db $FA,$80,$82,$EE                  
            db $FB,$82,$F6,$FB                  
            db $84,$FE,$DB,$86                  
            db $FE,$E1,$88,$06                  
  
  spr_06_platform_spike_24:
            db $04                              
            db $F0,$8C,$01,$F0                  
            db $F1,$8C,$F8,$F1                  
            db $8C,$00,$F1,$8C                  
            db $08                              
  
  spr_06_platform_spike_turning_26:
            db $06                              
            db $E4,$8E,$01,$F0                  
            db $E1,$90,$F8,$E1                  
            db $84,$00,$01,$92                  
            db $F8,$01,$94,$00                  
            db $FB,$88,$08                      
  
  spr_06_platform_spike_turning_28:
            db $04                              
            db $E0,$96,$01,$F8                  
            db $E1,$8A,$00,$01                  
            db $96,$F8,$01,$8A                  
            db $00                              
  
  spr_06_platform_spike_turning_2a:
            db $06                              
            db $FC,$8E,$81,$F0                  
            db $E1,$92,$F8,$E1                  
            db $94,$00,$01,$90                  
            db $F8,$01,$84,$00                  
            db $E7,$88,$08                      
  
  spr_06_platform_spike_upsideDown_2c:
            db $04                              
            db $F0,$8C,$81,$F0                  
            db $F1,$8C,$F8,$F1                  
            db $8C,$00,$F1,$8C                  
            db $08                              
  
  spr_06_gearKog_up_36:
            db $01                              
            db $F2,$80,$02,$FC                  
  
  spr_06_gearKog_turing_38:
            db $01                              
            db $F2,$82,$02,$FD                  
  
  spr_06_gearKog_turing_3a:
            db $01                              
            db $F2,$84,$02,$FE                  
  
  spr_06_gearKog_turing_3c:
            db $01                              
            db $F4,$86,$02,$FE                  
  
  spr_06_gearKog_staight_3e:
            db $01                              
            db $F6,$88,$02,$FE                  
  
  spr_06_gearKog_turing_40:
            db $01                              
            db $EC,$86,$82,$FE                  
  
  spr_06_gearKog_turing_42:
            db $01                              
            db $F0,$84,$82,$FE                  
  
  spr_06_gearKog_turing_44:
            db $01                              
            db $F0,$82,$82,$FD                  
  
  spr_06_gearKog_down_46:
            db $01                              
            db $F0,$80,$82,$FC                  
  
  spr_06_pandalom_stringStright_48:
            db $01                              
            db $F0,$A8,$02,$FC                  
  
  spr_06_pandalom_string_4a:
            db $01                              
            db $F0,$AA,$02,$FC                  
  
  spr_06_pandalom_string_4c:
            db $02                              
            db $F0,$AC,$02,$F8                  
            db $F1,$AE,$00                      
  
  spr_06_pandalom_string_4e:
            db $02                              
            db $F0,$B0,$02,$F8                  
            db $F1,$B2,$00                      
  
  spr_06_pandalom_string_50:
            db $02                              
            db $F0,$B4,$02,$F8                  
            db $F1,$B6,$00                      
  
  spr_06_pandalom_52:
            db $08                              
            db $E0,$BC,$02,$F0                  
            db $E1,$BE,$F8,$E1                  
            db $B8,$00,$E1,$BA                  
            db $08,$00,$BA,$C2                  
            db $F0,$01,$B8,$F8                  
            db $00,$B8,$82,$00                  
            db $01,$BA,$08                      
  
  spr_06_spike_upDown_54:
            db $08                              
            db $E0,$DF,$01,$F0                  
            db $E1,$DF,$F8,$E1                  
            db $DF,$00,$E1,$DF                  
            db $08,$01,$27,$F0                  
            db $01,$27,$F8,$01                  
            db $27,$00,$01,$27                  
            db $08                              
  
        spr_06_bd:
            db $08                              
            db $E0,$DF,$01,$F0                  
            db $E1,$DF,$F8,$E1                  
            db $DF,$00,$E1,$DF                  
            db $08,$01,$27,$F0                  
            db $01,$27,$F8,$01                  
            db $27,$00,$01,$27                  
            db $08                              
  
      spr_drip_56:
            db $02                              
            db $F0,$CA,$01,$F8                  
            db $F0,$CA,$41,$00                  
  
      spr_drip_58:
            db $02                              
            db $F0,$CC,$01,$F8                  
            db $F1,$CE,$00                      
  
      spr_drip_5a:
            db $02                              
            db $F0,$CE,$41,$F8                  
            db $F1,$CC,$00                      
  
      spr_drip_5c:
            db $01                              
            db $00,$D0,$01,$FC                  
  
    spr_drip_fall_5e:
            db $01                              
            db $F0,$D2,$01,$FC                  
  
    spr_drip_block_60:
            db $02                              
            db $FC,$D4,$01,$F8                  
            db $FD,$D6,$00                      
  
    spr_drip_block_62:
            db $02                              
            db $FC,$CA,$81,$F8                  
            db $FC,$CA,$C1,$00                  
  
    spr_drip_block_64:
            db $02                              
            db $F0,$A3,$02,$F8                  
            db $F1,$A5,$00                      
  
    spr_drip_block_66:
            db $02                              
            db $F0,$A7,$02,$F8                  
            db $F1,$A9,$00                      
  
    spr_drip_block_68:
            db $02                              
            db $F0,$AB,$02,$F8                  
            db $F0,$AB,$42,$00                  
  
    spr_drip_block_6a:
            db $02                              
            db $F0,$AD,$02,$F8                  
            db $F0,$AD,$42,$00                  
  
    spr_drip_block_6c:
            db $02                              
            db $F0,$AF,$02,$F8                  
            db $F0,$AF,$42,$00                  
  
    spr_drip_block_6e:
            db $02                              
            db $F0,$BD,$00,$F9                  
            db $F1,$BF,$01                      
  
  spr_06_playerEncounter_trevor_70:
            db $04                              
            db $E0,$40,$00,$F8                  
            db $E1,$42,$00,$01                  
            db $44,$F8,$01,$46                  
            db $00                              
  
  spr_06_playerEncounter_trevor_72:
            db $03                              
            db $E0,$48,$00,$F8                  
            db $E1,$4A,$00,$01                  
            db $4C,$FC                          
  
  
  spr_06_playerEncounter_trevor_idle74:
            db $04                              
            db $E0,$4E,$00,$F8                  
            db $E1,$50,$00,$01                  
            db $52,$F8,$01,$54                  
            db $00                              
  
  spr_06_playerEncounter_trevor_yes_76:
            db $04                              
            db $E0,$78,$00,$F9                  
            db $E1,$50,$01,$01                  
            db $52,$F8,$01,$54                  
            db $00                              
  
  spr_06_playerEncounter_trevor_no_78:
            db $04                              
            db $E0,$7A,$00,$F9                  
            db $E1,$50,$01,$01                  
            db $52,$F8,$01,$54                  
            db $00                              
  
  spr_06_playerEncounter_trevor_no_7a:
            db $04                              
            db $E0,$7C,$00,$F9                  
            db $E1,$50,$01,$01                  
            db $52,$F8,$01,$54                  
            db $00                              
  
  spr_06_playerEncounter_grant_7c:
            db $04                              
            db $EA,$56,$00,$F4                  
            db $EB,$58,$FC,$0B                  
            db $5A,$F8,$0B,$5C                  
            db $00                              
  
    spr_06_object_7e:
            db $04                              
            db $EA,$5E,$00,$F5                  
            db $EB,$60,$FD,$0B                  
            db $62,$F8,$0B,$64                  
            db $00                              
  
    spr_06_object_80:
            db $04                              
            db $EA,$66,$00,$F4                  
            db $EB,$68,$FC,$0B                  
            db $6A,$F8,$0B,$6C                  
            db $00                              
  
        spr_06_81:
            db $0A                              
            db $E8,$58,$41,$EE                  
            db $E9,$74,$F6,$09                  
            db $5C,$EA,$09,$5A                  
            db $F2,$E9,$72,$FE                  
            db $E0,$E2,$00,$00                  
            db $E1,$E4,$08,$E1                  
            db $E6,$10,$01,$44                  
            db $08,$01,$46,$10                  
  
        spr_06_82:
            db $0A                              
            db $E8,$58,$41,$EE                  
            db $E9,$74,$F6,$09                  
            db $5C,$EA,$09,$5A                  
            db $F2,$EB,$9E,$FE                  
            db $E0,$E8,$00,$00                  
            db $E1,$EA,$08,$E1                  
            db $E6,$10,$01,$44                  
            db $08,$01,$46,$10                  
  
  spr_06_playerEncounter_grantTalk_83:
            db $04                              
            db $EA,$76,$00,$F5                  
            db $EB,$58,$FD,$0B                  
            db $5A,$F8,$0B,$5C                  
            db $00                              
  
  spr_06_playerEncounter_alucard_84:
            db $05                              
            db $D2,$7E,$00,$FB                  
            db $F1,$80,$F7,$F1                  
            db $82,$FF,$11,$84                  
  
            db $F8,$11,$86,$00                  
  
  spr_06_playerEncounter_alucard_85:
            db $05                              
            db $D0,$7E,$00,$FC                  
            db $F1,$88,$F8,$F1                  
            db $8A,$00,$11,$8C                  
            db $F8,$11,$8E,$00                  
  
  spr_06_playerEncounter_alucard_idle_86:
            db $05                              
            db $D2,$7E,$00,$FC                  
            db $F1,$90,$F7,$F1                  
            db $92,$FF,$11,$94                  
            db $F8,$11,$96,$00                  
  
        spr_06_87:
            db $0B                              
            db $D2,$7E,$43,$F5                  
            db $F1,$82,$EF,$F1                  
            db $F6,$F7,$11,$86                  
            db $ED,$11,$84,$F5                  
            db $F1,$F4,$FF,$F0                  
            db $E2,$00,$00,$F1                  
            db $E4,$08,$F1,$E6                  
            db $10,$11,$44,$08                  
            db $11,$46,$10                      
  
        spr_06_88:
            db $0B                              
            db $D2,$7E,$43,$F5                  
            db $F1,$82,$EF,$F1                  
            db $F8,$FF,$11,$86                  
            db $ED,$11,$84,$F5                  
            db $F1,$FA,$F7,$F0                  
            db $E8,$00,$00,$F1                  
            db $EA,$08,$F1,$E6                  
            db $10,$11,$44,$08                  
            db $11,$46,$10                      
  
        spr_06_89:
            db $05                              
            db $D2,$7E,$00,$FD                  
            db $F1,$98,$F8,$F1                  
            db $92,$00,$11,$94                  
            db $F9,$11,$96,$01                  
  
  spr_06_symphaEncounter_8a:
            db $04                              
            db $E0,$A0,$00,$F8                  
            db $E1,$A2,$00,$01                  
            db $A4,$F8,$01,$A6                  
            db $00                              
  
  spr_06_symphaEncounter_8b:
            db $04                              
            db $E0,$A8,$00,$F8                  
            db $E1,$AA,$00,$01                  
            db $AC,$F8,$01,$AE                  
            db $00                              
  
  spr_06_symphaEncounter_8c:
            db $04                              
            db $E0,$B0,$00,$F8                  
            db $E1,$B2,$00,$01                  
            db $B4,$F8,$01,$B6                  
            db $00                              
  
  spr_06_symphaEncounter_8d:
            db $0A                              
            db $E0,$B2,$42,$EE                  
            db $E1,$EE,$F6,$01                  
            db $B6,$EE,$01,$B4                  
            db $F6,$E1,$EC,$FE                  
            db $E0,$E2,$00,$00                  
            db $E1,$E4,$08,$E1                  
            db $E6,$10,$01,$44                  
            db $08,$01,$46,$10                  
  
  spr_06_symphaEncounter_8e:
            db $0A                              
            db $E0,$B2,$42,$EE                  
            db $E1,$F2,$F6,$01                  
            db $B6,$EE,$01,$B4                  
            db $F6,$F1,$F0,$FE                  
            db $E0,$E8,$00,$00                  
            db $E1,$EA,$08,$E1                  
            db $E6,$10,$01,$44                  
            db $08,$01,$46,$10                  
  
  spr_06_symphaEncounter_8f:
            db $04                              
            db $E0,$B8,$00,$F8                  
            db $E3,$B2,$00,$01                  
            db $B4,$F8,$01,$B6                  
            db $00                              
  
  spr_06_symphaEncounter_ab:
            db $0C                              
            db $A0,$F2,$01,$F8                  
            db $A1,$CA,$00,$C1                  
            db $E0,$F0,$C1,$F0                  
            db $F8,$E1,$F2,$F8                  
            db $E1,$F0,$00,$01                  
            db $F2,$F0,$01,$F2                  
            db $00,$21,$D6,$E8                  
            db $21,$CA,$00,$21                  
            db $DC,$08,$41,$D6                  
  
            db $E0                              
  
  spr_06_symphaEncounter_ac:
            db $04                              
            db $E0,$80,$00,$F8                  
            db $E1,$82,$00,$01                  
            db $84,$F8,$01,$86                  
            db $00                              
  
  spr_06_symphaEncounter_ad:
            db $04                              
            db $E0,$88,$00,$F8                  
            db $E1,$8A,$00,$01                  
            db $8C,$F8,$01,$8E                  
            db $00                              
  
  spr_06_symphaEncounter_ae:
            db $04                              
            db $E0,$90,$00,$F8                  
            db $E1,$92,$00,$01                  
            db $94,$FC,$01,$96                  
            db $04                              
  
  spr_06_symphaEncounter_af:
            db $08                              
            db $E0,$98,$00,$00                  
            db $E1,$9A,$08,$E1                  
            db $9C,$10,$E1,$9E                  
            db $18,$01,$A0,$00                  
            db $01,$A2,$08,$01                  
            db $A4,$10,$01,$A6                  
            db $18                              
  
  spr_06_symphaEncounter_b0:
            db $07                              
            db $E0,$98,$00,$00                  
            db $E1,$A8,$08,$E1                  
            db $AA,$10,$01,$A0                  
            db $00,$01,$A2,$08                  
            db $01,$AC,$10,$01                  
            db $AE,$18                          
  
  spr_06_symphaEncounter_b1:
            db $04                              
            db $E0,$B0,$00,$00                  
            db $E1,$B2,$08,$01                  
            db $B4,$00,$01,$B6                  
            db $08                              
  
  spr_06_crumbleBlockFall_b2:
            db $02                              
            db $E0,$2D,$03,$00                  
            db $E1,$2F,$08                      
  
  spr_0A_symphaRelease_01:
            db $04                              
            db $E0,$8E,$01,$F7                  
            db $01,$90,$F1,$E0                  
            db $8E,$41,$01,$01                  
            db $90,$07                          
  
  spr_0A_symphaRelease_02:
            db $04                              
            db $E0,$90,$41,$F7                  
            db $01,$8E,$F1,$E0                  
            db $90,$01,$01,$01                  
            db $8E,$07                          
  
  spr_0A_symphaRelease_03:
            db $04                              
            db $E0,$80,$01,$F8                  
            db $E1,$82,$00,$01                  
            db $84,$F8,$01,$86                  
            db $00                              
  
  spr_0A_symphaRelease_04:
            db $08                              
            db $DE,$8E,$C3,$F1                  
            db $DE,$8E,$83,$07                  
            db $E0,$82,$03,$F8                  
            db $E1,$82,$00,$FF                  
            db $90,$F1,$01,$84                  
            db $F8,$01,$86,$00                  
            db $FE,$90,$43,$07                  
  
  spr_0A_symphaRelease_05:
            db $04                              
            db $E0,$80,$02,$F8                  
            db $E1,$82,$00,$01                  
            db $84,$F8,$01,$86                  
            db $00                              
  
  spr_0A_symphaRelease_06:
            db $05                              
            db $E0,$80,$02,$F8                  
            db $E1,$82,$00,$01                  
            db $88,$F4,$01,$8A                  
            db $FC,$01,$8C,$04                  
  
  spr_0A_symphaRelease_07:
            db $04                              
            db $E0,$F8,$02,$F8                  
            db $E1,$FA,$00,$01                  
            db $FC,$F8,$01,$EE                  
            db $00                              
  
        spr_0A_08:
            db $02                              
            db $F0,$5C,$00,$F8                  
            db $F0,$5C,$40,$00                  
  
        spr_0A_09:
            db $08                              
            db $D0,$5E,$00,$F0                  
            db $D1,$5E,$F8,$D1                  
            db $5E,$00,$D1,$5E                  
            db $08,$F1,$5E,$F0                  
            db $F1,$5C,$F8,$F1                  
            db $5E,$08,$F0,$5C                  
            db $40,$00                          
  
  
        spr_0A_0a:
            db $10                              
            db $A0,$BA,$41,$F8                  
            db $C1,$BC,$F8,$C1                  
            db $9E,$00,$E1,$A0                  
            db $00,$E1,$A2,$08                  
            db $E1,$A4,$10,$E1                  
            db $A6,$18,$01,$A8                  
            db $00,$01,$AA,$18                  
            db $21,$B6,$F8,$21                  
            db $AC,$00,$21,$AE                  
            db $10,$21,$B0,$18                  
            db $41,$B8,$F8,$41                  
            db $B2,$10,$41,$B4                  
            db $18                              
  
  spr_0A_endingCastle_0b:
            db $15                              
            db $A0,$80,$21,$F8                  
            db $A1,$82,$00,$C1                  
            db $84,$F0,$C1,$86                  
            db $F8,$C1,$88,$00                  
            db $C1,$8A,$08,$C1                  
            db $8C,$10,$E1,$8E                  
            db $E8,$E1,$90,$F0                  
            db $E1,$94,$F8,$E1                  
            db $9E,$00,$E1,$9E                  
            db $08,$E1,$9E,$10                  
            db $E1,$96,$18,$01                  
            db $98,$E8,$01,$9A                  
            db $F0,$01,$9E,$F8                  
            db $01,$9E,$00,$01                  
            db $9E,$08,$01,$9E                  
            db $10,$01,$9C,$18                  
  
    spr_0A_ending_0c:
            db $10                              
            db $E0,$D4,$03,$E0                  
            db $E1,$D0,$F0,$E1                  
            db $D2,$F8,$E1,$D4                  
            db $00,$E1,$D6,$08                  
            db $E1,$D6,$10,$E1                  
            db $D8,$18,$01,$D0                  
            db $E8,$01,$DA,$00                  
            db $01,$DC,$08,$01                  
            db $DC,$10,$01,$DE                  
  
            db $18,$21,$DA,$F8                  
            db $21,$DC,$00,$21                  
            db $DC,$08,$21,$DE                  
  
            db $10                              
  
        spr_0A_0d:
            db $05                              
            db $C0,$00,$00,$FD                  
            db $E1,$02,$F8,$E1                  
            db $04,$00,$01,$06                  
            db $F8,$01,$08,$00                  
  
  spr_0A_endingTrevorSolo_0e:
            db $05                              
            db $C0,$00,$00,$FD                  
            db $E1,$0A,$F8,$E1                  
            db $0C,$00,$01,$0E                  
            db $F8,$01,$10,$00                  
  
  spr_0A_endingTrevorSolo_0f:
            db $06                              
            db $C0,$00,$00,$FD                  
            db $E1,$12,$F8,$E1                  
            db $14,$00,$01,$18                  
            db $F8,$01,$1A,$00                  
            db $F9,$16,$F0                      
  
  spr_0A_endingTrevorSolo_10:
            db $06                              
            db $C0,$00,$00,$FD                  
            db $E1,$1C,$F8,$E1                  
            db $1E,$00,$01,$22                  
            db $F8,$01,$24,$00                  
            db $FF,$20,$F0                      
  
  spr_0A_endingGrant_11:
            db $04                              
            db $E0,$74,$02,$FA                  
            db $E1,$76,$02,$01                  
            db $7A,$00,$01,$78                  
            db $F8                              
  
  spr_0A_endingGrant_12:
            db $05                              
            db $E0,$7C,$02,$F6                  
            db $E1,$7E,$FE,$E1                  
            db $C0,$06,$01,$7A                  
            db $00,$01,$78,$F8                  
  
  spr_0A_endingGrant_13:
            db $05                              
            db $E0,$C2,$02,$F6                  
            db $E1,$C4,$FE,$E1                  
            db $C6,$06,$01,$7A                  
            db $00,$01,$78,$F8                  
  
  spr_0A_endingAlucard_14:
            db $06                              
            db $C0,$54,$02,$F8                  
            db $C1,$56,$00,$E1                  
            db $58,$F8,$E1,$5A                  
            db $00,$01,$5C,$F8                  
            db $01,$5E,$00                      
  
  spr_0A_endingAlucard_15:
            db $07                              
            db $C0,$54,$02,$F8                  
            db $C1,$56,$00,$E1                  
            db $60,$F8,$E1,$62                  
  
            db $00,$01,$66,$F8                  
            db $01,$68,$00,$F1                  
            db $64,$F0                          
  
  spr_0A_endingAlucard_16:
            db $07                              
            db $C0,$54,$02,$F8                  
            db $C1,$56,$00,$E1                  
            db $6A,$F8,$E1,$6C                  
            db $00,$01,$70,$F8                  
            db $01,$72,$00,$F3                  
            db $6E,$F0                          
  
  spr_0A_endingSympha_17:
            db $05                              
            db $C0,$26,$02,$FC                  
            db $E1,$28,$F8,$E1                  
            db $2A,$00,$01,$2C                  
            db $F8,$01,$2E,$00                  
  
  spr_0A_endingSympha_18:
            db $05                              
            db $C0,$30,$00,$FC                  
            db $E0,$32,$02,$F8                  
            db $E1,$34,$00,$01                  
            db $2C,$F8,$01,$2E                  
            db $00                              
  
  spr_0A_endingSympha_1d:
            db $07                              
            db $C0,$30,$00,$FC                  
            db $E1,$3E,$F3,$E1                  
            db $40,$FB,$E0,$36                  
  
            db $02,$F8,$E1,$38                  
            db $00,$01,$2C,$F8                  
            db $01,$2E,$00                      
  
  spr_0A_endingSympha_1e:
            db $06                              
            db $C0,$30,$00,$FC                  
            db $E1,$42,$F4,$E1                  
            db $44,$FC,$E0,$3A                  
            db $02,$00,$01,$2C                  
            db $F8,$01,$2E,$00                  
  
  spr_0A_endingSympha_1b:
            db $06                              
            db $C0,$30,$00,$FC                  
            db $E1,$46,$F4,$E1                  
            db $48,$FC,$E0,$3C                  
            db $02,$00,$01,$2C                  
            db $F8,$01,$2E,$00                  
  
  spr_0A_endingSympha_1f:
            db $0A                              
            db $C0,$4A,$00,$EF                  
            db $E1,$02,$E9,$E1                  
            db $4E,$F0,$E1,$50                  
            db $F8,$01,$06,$E8                  
            db $01,$08,$F0,$C1                  
            db $4C,$F8,$E0,$52                  
  
            db $02,$00,$01,$2C                  
            db $F8,$01,$2E,$00                  
  
  spr_0A_endingSympha_20:
            db $0C                              
            db $C0,$E0,$00,$F1                  
            db $C1,$E2,$F9,$E1                  
            db $F0,$E9,$E1,$F2                  
            db $F1,$E1,$EC,$F9                  
            db $E1,$EE,$01,$01                  
            db $06,$EB,$01,$08                  
            db $F3,$E0,$E4,$02                  
            db $F9,$E1,$E6,$01                  
            db $01,$E8,$F8,$01                  
            db $EA,$00                          
  
  spr_0A_borderPWselect_21:
            db $02                              
            if !cv3ClimbableRope == 1
            db $F0,$B9,$41,$F8
            else
            db $F0,$64,$41,$F8                  
            endif
            db $F1,$62,$00                      

}


if !moveCrumbleBlock == 0
assert pc() <= $B765  
org $37E63    
base $BE63 
endif 
; free space for sprites ------------------------------------------------------------------- 

if !cv3ClimbableRope == 1
    incsrc "code/custom/trevor_rope_sprites.asm"
endif
if !cv3InvertedGravity == 1
    incsrc "code/custom/inverted_gravity_sprites.asm"
endif








; ------------------------------------------------------------------------------------------
assert pc() <= $c000
pad $38000


if !moveCrumbleBlock == 1 
org LAST_BANK+$1BE8
base $FBE8
crumbleBlock: 
    LDA.B #$A8                            ;0FFBE8|A99A    |      ;
    JSR.W swapPRGbankStore                ;0FFBEA|20E6E2  |0FE2E6;
    jsr mainCrumbleBlock                    ;0FFBEE|        |0DB7BF;

org LAST_BANK+$1F60
base $FF60
goBank_00_D: 
    LDA.B #$A8                           ;0FFF60|A99A    |      ;
        JSR.W swapPRGbankStore               ;0FFF62|20E6E2  |0FE2E6;
        jsr bankD_r7f0                        ;0FFF66|        |0DBDEF;

org LAST_BANK+$1F6D
base $FF6D
        LDA.B #$A8                           ;0FFF6D|A99A    |      ;
        JSR.W swapPRGbankStore               ;0FFF6F|20E6E2  |0FE2E6;
        jsr bossSkull_BGroutine                       ;0FFF73|        |0DBDBC;

org $9950
base $9950                  ; falling block stage a 4 0 
        LDA.W PTR16_02995F,Y                 ;029950|B95F99  |02995F;
        STA.B $00                            ;029953|8500    |000000;
        LDA.W PTR16_02995F+1,Y                 ;029955|B96099  |029960;
        STA.B $01                            ;029958|8501    |000001;
        LDA.B #$A8                           ;02995A|A99A    |      ;
        jmp runRAM_00_inBankA                 ;02995D|        |0FE62F;
 
    PTR16_02995F: 
     dw CODE_0DB782                       ;02995F|        |0DB782;
         dw CODE_0DB9E4                       ;029961|        |0DB9E4;




pullPC 
  miscSprite_findSlot_00: 
            LDA.B #$10                           ;0DB765|A910    |      ;
                       LDY.W r_entity_ID         ;0DB767|AC4E05  |0D054E;
                       CPY.B #$02                           ;0DB76A|C002    |      ;
                       BNE CODE_0DB770                      ;0DB76C|D002    |0DB770;
                       LDA.B #$0C                           ;0DB76E|A90C    |      ;
 
          CODE_0DB770: CLC                                  ;0DB770|18      |      ;
                       ADC.W r_entity_YPos                ;0DB771|6D1C04  |0D041C;
                       BCS CODE_0DB77A                      ;0DB774|B004    |0DB77A;
                       CMP.B #$F0                           ;0DB776|C9F0    |      ;
                       BCC CODE_0DB77C                      ;0DB778|9002    |0DB77C;
 
          CODE_0DB77A: ADC.B #$0F                           ;0DB77A|690F    |      ;
 
          CODE_0DB77C: TAY                                  ;0DB77C|A8      |      ;
                       LDA.B r_tempCurrRoomIdx              ;0DB77D|A50E    |00000E;
                       JMP.W writeCollusionAtPos            ;0DB77F|4C88B7  |0DB788;
      CODE_0DB782:
                       LDA.W r_entity_XPos,X              ;0DB782|BD3804  |0D0438;
                       LDY.W r_entity_YPos,X              ;0DB785|BC1C04  |0D041C;
 
  writeCollusionAtPos: AND.B #$F0                           ;0DB788|29F0    |      ;
                       LSR A                                ;0DB78A|4A      |      ;
                       LSR A                                ;0DB78B|4A      |      ;
                       LSR A                                ;0DB78C|4A      |      ;
                       STA.B r_collisionPointXvalDiv32      ;0DB78D|8512    |000012;
                       TYA                                  ;0DB78F|98      |      ;
                       LDY.B r_sceneScrollOffsetHi          ;0DB790|A457    |000057;
                       SEC                                  ;0DB792|38      |      ;
                       SBC.B #$30                           ;0DB793|E930    |      ;
                       BCS CODE_0DB79A                      ;0DB795|B003    |0DB79A;
                       SBC.B #$0F                           ;0DB797|E90F    |      ;
                       DEY                                  ;0DB799|88      |      ;
 
          CODE_0DB79A: CLC                                  ;0DB79A|18      |      ;
                       ADC.B r_sceneScrollOffsetLo          ;0DB79B|6556    |000056;
                       BCS CODE_0DB7A3                      ;0DB79D|B004    |0DB7A3;
                       CMP.B #$F0                           ;0DB79F|C9F0    |      ;
                       BCC CODE_0DB7A6                      ;0DB7A1|9003    |0DB7A6;
 
          CODE_0DB7A3: ADC.B #$0F                           ;0DB7A3|690F    |      ;
                       INY                                  ;0DB7A5|C8      |      ;
 
          CODE_0DB7A6: AND.B #$F0                           ;0DB7A6|29F0    |      ;
                       STA.B $00                            ;0DB7A8|8500    |000000;
                       STA.B $0B                            ;0DB7AA|850B    |00000B;
                       STY.B r_roomSectionChrBanksDataOffset;0DB7AC|840F    |00000F;
                       LDA.B #$0A                           ;0DB7AE|A90A    |      ;
                       ASL.B $00                            ;0DB7B0|0600    |000000;
                       ROL A                                ;0DB7B2|2A      |      ;
                       ASL.B $00                            ;0DB7B3|0600    |000000;
                       ROL A                                ;0DB7B5|2A      |      ;
                       STA.B r_collisionPointAbsoluteXInRoom;0DB7B6|8513    |000013;
                       LDA.B r_collisionPointXvalDiv32      ;0DB7B8|A512    |000012;
                       ORA.B $00                            ;0DB7BA|0500    |000000;
                       STA.B r_collisionPointXvalDiv32      ;0DB7BC|8512    |000012;
 
         quitNotEqual: RTS                                  ;0DB7BE|60      |      ;
 
 
    mainCrumbleBlock: STY.B $09                            ;0DB7BF|8409    |000009; other misc??
                       LDA.B r_roomOrientation              ;0DB7C1|A568    |000068;
                       BPL CODE_0DB7FB                      ;0DB7C3|1036    |0DB7FB;
                       LDA.B r_index                        ;0DB7C5|A510    |000010;
                       STA.B r_tempCurrRoomIdx              ;0DB7C7|850E    |00000E;
                       JSR.W miscSprite_findSlot_00         ;0DB7C9|2065B7  |0DB765;
                       JSR.W miscSprite_hardcodedLvLstuff_01;0DB7CC|20B8B8  |0DB8B8;
                       BNE quitNotEqual                     ;0DB7CF|D0ED    |0DB7BE;
                       JSR.W miscSprite_col_03              ;0DB7D1|2005BA  |0DBA05;
                       BMI waitCrumble                      ;0DB7D4|300B    |0DB7E1;
                       LDA.B #$10                           ;0DB7D6|A910    |      ; crumble sound
                       db $20                               ;0DB7D8|        |      ;
                       dw lunchMusic                        ;0DB7D9|        |0FE25F;
                       JSR.W processCrumble__00             ;0DB7DB|20A3B9  |0DB9A3;
                       JMP.W processCrumble_01              ;0DB7DE|4C82B9  |0DB982;
 
 
          waitCrumble: JSR.W miscSprite__06                 ;0DB7E1|20E1BA  |0DBAE1;
                       BCS quitNotEqual                     ;0DB7E4|B0D8    |0DB7BE;
                       LDA.W r_entity_YPos                ;0DB7E6|AD1C04  |0D041C;
                       CLC                                  ;0DB7E9|18      |      ;
                       ADC.B #$08                           ;0DB7EA|6908    |      ;
                       STA.B r_collisionPointAbsoluteXRoom  ;0DB7EC|8514    |000014;
                       LDA.B r_tempCurrRoomIdx              ;0DB7EE|A50E    |00000E;
                       STA.B r_15                           ;0DB7F0|8515    |000015;
                       db $20                               ;0DB7F2|        |      ;
                       dw collusion_stuff_bank80                       ;0DB7F3|        |0FE935;
                       JSR.W miscSprite__07                 ;0DB7F5|2031B8  |0DB831;
                       JMP.W miscSprite_makeObj_0B          ;0DB7F8|4C3FB8  |0DB83F;
 
 
          CODE_0DB7FB: LDA.B r_collisionPointAbsoluteXInRoom;0DB7FB|A513    |000013;
                       STA.B r_tempCurrRoomIdx              ;0DB7FD|850E    |00000E;
                       LDA.B r_collisionPointAbsoluteXRoom  ;0DB7FF|A514    |000014;
                       STA.B r_roomSectionChrBanksDataOffset;0DB801|850F    |00000F;
                       JSR.W miscSprite_hardcodedLvLstuff_01;0DB803|20B8B8  |0DB8B8;
                       BNE quitNotEqual                     ;0DB806|D0B6    |0DB7BE;
                       JSR.W miscSprite_col_03              ;0DB808|2005BA  |0DBA05;
                       BMI CODE_0DB81B                      ;0DB80B|300E    |0DB81B;
                       LDA.B #$10                           ;0DB80D|A910    |      ;
                       db $20                               ;0DB80F|        |      ;
                       dw lunchMusic                        ;0DB810|        |0FE25F;
                       JSR.W miscSprite__09                 ;0DB812|20B2B9  |0DB9B2;
                       JSR.W processCrumble__00             ;0DB815|20A3B9  |0DB9A3;
                       JMP.W processCrumble_01              ;0DB818|4C82B9  |0DB982;
 
 
          CODE_0DB81B: JSR.W miscSprite__08                 ;0DB81B|20E7BA  |0DBAE7;  
                       BCS CODE_0DB85D                      ;0DB81E|B03D    |0DB85D;
                       JSR.W miscSprite__09                 ;0DB820|20B2B9  |0DB9B2;
                       LDY.B r_stage                        ;0DB823|A432    |000032;
                       db $B9                               ;0DB825|        |      ; lda
                       dw bank_levelBlockScene              ;0DB826|        |0FC94B;
                       db $20                               ;0DB828|        |      ;
                       dw drawBlock_Y_Bank80                       ;0DB829|        |0FE9B3;  ; FIXME SPRITEDRAW BUG
                       JSR.W miscSprite__07                 ;0DB82B|2031B8  |0DB831;    ; FIXME SPRITEDRAW BUG
                       JMP.W miscSprite__0A                 ;0DB82E|4C5EB8  |0DB85E;
 
 
       miscSprite__07: JSR.W CODE_0DB9E4                    ;0DB831|20E4B9  |0DB9E4;
                       JSR.W CODE_0DB8DE                    ;0DB834|20DEB8  |0DB8DE;
                       JSR.W CODE_0DB94B                    ;0DB837|204BB9  |0DB94B;
                       LDA.B #$11                           ;0DB83A|A911    |      ;
                       db $4C                               ;0DB83C|        |      ;
 
                       dw lunchMusic                        ;0DB83D|        |0FE25F;
 
miscSprite_makeObj_0B: JSR.W findEmptySlot                  ;0DB83F|2083B8  |0DB883;
                       BNE noSlotFound                      ;0DB842|D03E    |0DB882;
                       JSR.W makeFallingBlock_ID89_entity   ;0DB844|2091B8  |0DB891;
                       LDA.B r_tempCurrRoomIdx              ;0DB847|A50E    |00000E;
                       AND.B #$E0                           ;0DB849|29E0    |      ;
                       LDY.B r_collisionValIsForRightHalfOf32x16block;0DB84B|A4A5    |0000A5;
                       BEQ CODE_0DB851                      ;0DB84D|F002    |0DB851;
                       ORA.B #$10                           ;0DB84F|0910    |      ;
 
          CODE_0DB851: STA.W r_entity_XPos,X              ;0DB851|9D3804  |0D0438;
                       LDA.W r_entity_YPos                ;0DB854|AD1C04  |0D041C;
                       CLC                                  ;0DB857|18      |      ;
                       ADC.B #$1D                           ;0DB858|691D    |      ;
                       STA.W r_entity_YPos,X              ;0DB85A|9D1C04  |0D041C;
 
          CODE_0DB85D: RTS                                  ;0DB85D|60      |      ;
 
 
       miscSprite__0A: JSR.W findEmptySlot                  ;0DB85E|2083B8  |0DB883;
                       BNE noSlotFound                      ;0DB861|D01F    |0DB882;
                       JSR.W makeFallingBlock_ID89_entity   ;0DB863|2091B8  |0DB891;
                       LDA.B r_collisionPointXvalDiv32      ;0DB866|A512    |000012;
                       ASL A                                ;0DB868|0A      |      ;
                       ASL A                                ;0DB869|0A      |      ;
                       ASL A                                ;0DB86A|0A      |      ;
                       AND.B #$E0                           ;0DB86B|29E0    |      ;
                       LDY.B r_collisionValIsForRightHalfOf32x16block;0DB86D|A4A5    |0000A5;
                       BEQ CODE_0DB873                      ;0DB86F|F002    |0DB873;
                       ORA.B #$10                           ;0DB871|0910    |      ;
 
          CODE_0DB873: SEC                                  ;0DB873|38      |      ;
                       SBC.B r_sceneScrollOffsetLo          ;0DB874|E556    |000056;
                       STA.W r_entity_XPos,X              ;0DB876|9D3804  |0D0438;
                       LDA.W r_entity_YPos                ;0DB879|AD1C04  |0D041C;
                       CLC                                  ;0DB87C|18      |      ;
                       ADC.B #$1E                           ;0DB87D|691E    |      ;
                       STA.W r_entity_YPos,X              ;0DB87F|9D1C04  |0D041C;
 
          noSlotFound: RTS                                  ;0DB882|60      |      ;
 
 
        findEmptySlot: LDX.B #$01                           ;0DB883|A201    |      ;
 
          CODE_0DB885: LDA.W r_entity_ID,X       ;0DB885|BD4E05  |0D054E;
                       BEQ CODE_0DB890                      ;0DB888|F006    |0DB890;
                       INX                                  ;0DB88A|E8      |      ;
                       CPX.B #$12                           ;0DB88B|E012    |      ;
                       BCC CODE_0DB885                      ;0DB88D|90F6    |0DB885;
                       INX                                  ;0DB88F|E8      |      ;
 
          CODE_0DB890: RTS                                  ;0DB890|60      |      ;
 
 
makeFallingBlock_ID89_entity: db $20                               ;0DB891|        |      ;
                       dw clearAll_entitySlot                    ;0DB892|        |0FFED7;
                       LDA.B #$89                           ;0DB894|A989    |      ;
                       STA.W r_entity_ID,X       ;0DB896|9D4E05  |0D054E;
                       LDA.B #$0C                           ;0DB899|A90C    |      ;
                       LDY.B #$00                           ;0DB89B|A000    |      ;
                       db $20                               ;0DB89D|        |      ;
                       dw setSpriteAndAnimGroup_AY              ;0DB89E|        |0FEF5C;
                       LDA.B #$E8                           ;0DB8A0|A9E8    |      ;
                       STA.W r_entity_spriteID,X        ;0DB8A2|9D0004  |0D0400;
                       LDA.B #$01                           ;0DB8A5|A901    |      ;
                       STA.W $0657,X                        ;0DB8A7|9D5706  |0D0657;
                       STA.W r_entity_FacingLeft,X        ;0DB8AA|9DA804  |0D04A8;
                       LDA.B #$60                           ;0DB8AD|A960    |      ;
                       STA.W r_entity_mask,X            ;0DB8AF|9D7004  |0D0470;
                       LDA.B #$03                           ;0DB8B2|A903    |      ;
                       STA.W r_entity_PaletteOverride,X   ;0DB8B4|9D5404  |0D0454;
                       RTS                                  ;0DB8B7|60      |      ;
 
 
miscSprite_hardcodedLvLstuff_01: LDY.B #$01                           ;0DB8B8|A001    |      ;
                       LDA.B r_stage                        ;0DB8BA|A532    |000032;
                       CMP.B #$07                           ;0DB8BC|C907    |      ;
                       BEQ CODE_0DB8CB                      ;0DB8BE|F00B    |0DB8CB;
                       CMP.B #$0A                           ;0DB8C0|C90A    |      ;
                       BNE CODE_0DB8CA                      ;0DB8C2|D006    |0DB8CA;
                       LDA.B r_blockLevel                   ;0DB8C4|A533    |000033;
                       CMP.B #$01                           ;0DB8C6|C901    |      ;
                       BEQ CODE_0DB8CB                      ;0DB8C8|F001    |0DB8CB;
 
          CODE_0DB8CA: DEY                                  ;0DB8CA|88      |      ;
 
          CODE_0DB8CB: LDA.B r_tempCurrRoomIdx              ;0DB8CB|A50E    |00000E;
                       LSR A                                ;0DB8CD|4A      |      ;
                       LSR A                                ;0DB8CE|4A      |      ;
                       LSR A                                ;0DB8CF|4A      |      ;
                       LSR A                                ;0DB8D0|4A      |      ;
                       TAX                                  ;0DB8D1|AA      |      ;
                       INC.W $03B0,X                        ;0DB8D2|FEB003  |0D03B0;
                       LDA.W $03B0,X                        ;0DB8D5|BDB003  |0D03B0;
                       AND.W DATA8_0DB8DC,Y                 ;0DB8D8|39DCB8  |0DB8DC;
                       RTS                                  ;0DB8DB|60      |      ;
 
 
         DATA8_0DB8DC: db $0F,$07                           ;0DB8DC|        |      ;
 
          CODE_0DB8DE: LDA.B #$00                           ;0DB8DE|A900    |      ;
                       STA.B $04                            ;0DB8E0|8504    |000004;
                       LDA.B r_collisionPointXvalDiv32      ;0DB8E2|A512    |000012;
                       ASL A                                ;0DB8E4|0A      |      ;
                       ASL A                                ;0DB8E5|0A      |      ;
                       ROL.B $04                            ;0DB8E6|2604    |000004;
                       ASL A                                ;0DB8E8|0A      |      ;
                       ASL A                                ;0DB8E9|0A      |      ;
                       ASL A                                ;0DB8EA|0A      |      ;
                       ASL A                                ;0DB8EB|0A      |      ;
                       ASL A                                ;0DB8EC|0A      |      ;
                       ROL.B $04                            ;0DB8ED|2604    |000004;
                       LDX.B $04                            ;0DB8EF|A604    |000004;
                       LDA.B r_collisionPointYinScreen      ;0DB8F1|A511    |000011;
                       JSR.W CODE_0DB932                    ;0DB8F3|2032B9  |0DB932;
                       LDX.B r_collisionValIsForRightHalfOf32x16block;0DB8F6|A6A5    |0000A5;
                       LDA.B r_tempCurrSection              ;0DB8F8|A50D    |00000D;
                       AND.W DATA8_0DBA50,X                 ;0DB8FA|3D50BA  |0DBA50;
                       CMP.W DATA8_0DBA50,X                 ;0DB8FD|DD50BA  |0DBA50;
                       BEQ CODE_0DB942                      ;0DB900|F040    |0DB942;
                       CPX.B #$00                           ;0DB902|E000    |      ;
                       BEQ CODE_0DB90A                      ;0DB904|F004    |0DB90A;
                       LSR A                                ;0DB906|4A      |      ;
                       LSR A                                ;0DB907|4A      |      ;
                       LSR A                                ;0DB908|4A      |      ;
                       LSR A                                ;0DB909|4A      |      ;
 
          CODE_0DB90A: STA.B $00                            ;0DB90A|8500    |000000;
                       LDY.B $09                            ;0DB90C|A409    |000009;
                       LDA.W r_collisionMap,Y             ;0DB90E|B9E006  |0D06E0;
                       AND.W DATA8_0DBA50,X                 ;0DB911|3D50BA  |0DBA50;
                       BNE CODE_0DB942                      ;0DB914|D02C    |0DB942;
                       LDA.B r_coreLoadingFuncAddr          ;0DB916|A516    |000016;
                       PHA                                  ;0DB918|48      |      ;
                       LDA.B $17                            ;0DB919|A517    |000017;
                       PHA                                  ;0DB91B|48      |      ;
                       LDA.B $00                            ;0DB91C|A500    |000000;
                       JSR.W CODE_0DBB14                    ;0DB91E|2014BB  |0DBB14;
 
                       LDA.B $04                            ;0DB921|A504    |000004;
                       EOR.B #$01                           ;0DB923|4901    |      ;
                       TAX                                  ;0DB925|AA      |      ;
                       LDA.B r_tempCurrGroup                ;0DB926|A50C    |00000C;
                       JSR.W CODE_0DB932                    ;0DB928|2032B9  |0DB932;
                       PLA                                  ;0DB92B|68      |      ;
                       STA.B $17                            ;0DB92C|8517    |000017;
                       PLA                                  ;0DB92E|68      |      ;
                       STA.B r_coreLoadingFuncAddr          ;0DB92F|8516    |000016;
                       RTS                                  ;0DB931|60      |      ;
 
 
          CODE_0DB932: AND.W DATA8_0DB943,X                 ;0DB932|3D43B9  |0DB943;
                       STA.B $01                            ;0DB935|8501    |000001;
                       LDY.B #$04                           ;0DB937|A004    |      ;
                       LDA.B (r_coreLoadingFuncAddr),Y      ;0DB939|B116    |000016;
                       AND.W DATA8_0DB947,X                 ;0DB93B|3D47B9  |0DB947;
                       ORA.B $01                            ;0DB93E|0501    |000001;
                       STA.B r_tempCurrGroup                ;0DB940|850C    |00000C;
 
          CODE_0DB942: RTS                                  ;0DB942|60      |      ;
 
 
         DATA8_0DB943: db $FC,$F3,$CF,$3F                   ;0DB943|        |      ;
 
         DATA8_0DB947: db $03,$0C,$30,$C0                   ;0DB947|        |      ;
 
          CODE_0DB94B: LDY.B #$00                           ;0DB94B|A000    |      ;
                       JSR.W CODE_0DB970                    ;0DB94D|2070B9  |0DB970;
                       LDA.B #$20                           ;0DB950|A920    |      ;
                       ORA.B r_collisionPointXvalDiv32      ;0DB952|0512    |000012;
                       STA.B r_collisionPointXvalDiv32      ;0DB954|8512    |000012;
                       JSR.W CODE_0DB970                    ;0DB956|2070B9  |0DB970;
                       LDA.B #$01                           ;0DB959|A901    |      ;
                       db $20                               ;0DB95B|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB95C|        |0FED14;
                       LDA.B r_collisionPointAbsoluteXRoom  ;0DB95E|A514    |000014;
                       db $20                               ;0DB960|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB961|        |0FED14;
                       LDA.B r_15                           ;0DB963|A515    |000015;
                       db $20                               ;0DB965|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB966|        |0FED14;
                       LDA.B r_tempCurrGroup                ;0DB968|A50C    |00000C;
                       db $20                               ;0DB96A|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB96B|        |0FED14;
                       db $4C                               ;0DB96D|        |      ;
 
                       dw closeVramQueue                    ;0DB96E|        |0FED12;
 
          CODE_0DB970: JSR.W CODE_0DB994                    ;0DB970|2094B9  |0DB994;
                       LDA.B (r_coreLoadingFuncAddr),Y      ;0DB973|B116    |000016;
                       db $20                               ;0DB975|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB976|        |0FED14;
                       INY                                  ;0DB978|C8      |      ;
                       LDA.B (r_coreLoadingFuncAddr),Y      ;0DB979|B116    |000016;
                       db $20                               ;0DB97B|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB97C|        |0FED14;
                       INY                                  ;0DB97E|C8      |      ;
                       db $4C                               ;0DB97F|        |      ;
 
                       dw closeVramQueue                    ;0DB980|        |0FED12;
 
    processCrumble_01: JSR.W CODE_0DB994                    ;0DB982|2094B9  |0DB994;
                       LDY.B r_temp_Xpos                    ;0DB985|A40A    |00000A;
                       LDA.W DATA8_0DB990,Y                 ;0DB987|B990B9  |0DB990;
                       db $20                               ;0DB98A|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB98B|        |0FED14;
                       db $4C                               ;0DB98D|        |      ;
 
                       dw closeVramQueue                    ;0DB98E|        |0FED12;
 
         DATA8_0DB990: db $2C,$2E,$2F,$2D                   ;0DB990|        |      ;
 
          CODE_0DB994: LDA.B #$01                           ;0DB994|A901    |      ;
                       db $20                               ;0DB996|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB997|        |0FED14;
                       LDA.B r_collisionPointXvalDiv32      ;0DB999|A512    |000012;
                       db $20                               ;0DB99B|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DB99C|        |0FED14;
                       LDA.B r_collisionPointAbsoluteXInRoom;0DB99E|A513    |000013;
                       db $4C                               ;0DB9A0|        |      ;
 
                       dw getIDX_storeByteVramQueue         ;0DB9A1|        |0FED14;
 
   processCrumble__00: LDY.B r_temp_Xpos                    ;0DB9A3|A40A    |00000A;
                       LDA.W DATA8_0DB9AE,Y                 ;0DB9A5|B9AEB9  |0DB9AE;
                       CLC                                  ;0DB9A8|18      |      ;
                       ADC.B r_collisionPointXvalDiv32      ;0DB9A9|6512    |000012;
                       STA.B r_collisionPointXvalDiv32      ;0DB9AB|8512    |000012;
                       RTS                                  ;0DB9AD|60      |      ;
 
 
         DATA8_0DB9AE: db $00,$01,$21,$20                   ;0DB9AE|        |      ;
 
       miscSprite__09: LDA.B r_collisionPointAbsoluteXInRoom;0DB9B2|A513    |000013;
                       AND.B #$F0                           ;0DB9B4|29F0    |      ;
                       STA.B r_collisionPointXvalDiv32      ;0DB9B6|8512    |000012;
                       LDA.B r_collisionPointAbsoluteXRoom  ;0DB9B8|A514    |000014;
                       EOR.B r_075                          ;0DB9BA|4575    |000075;
                       LSR A                                ;0DB9BC|4A      |      ;
                       LDA.B #$20                           ;0DB9BD|A920    |      ;
                       BCC CODE_0DB9C3                      ;0DB9BF|9002    |0DB9C3;
                       LDA.B #$24                           ;0DB9C1|A924    |      ;
 
          CODE_0DB9C3: STA.B r_collisionPointAbsoluteXInRoom;0DB9C3|8513    |000013;
                       LDA.W r_entity_YPos                ;0DB9C5|AD1C04  |0D041C;
                       LSR A                                ;0DB9C8|4A      |      ;
                       LSR A                                ;0DB9C9|4A      |      ;
                       LSR A                                ;0DB9CA|4A      |      ;
                       LSR A                                ;0DB9CB|4A      |      ;
                       ROR.B r_collisionPointXvalDiv32      ;0DB9CC|6612    |000012;
                       LSR A                                ;0DB9CE|4A      |      ;
                       ROR.B r_collisionPointXvalDiv32      ;0DB9CF|6612    |000012;
                       LSR A                                ;0DB9D1|4A      |      ;
                       ROR.B r_collisionPointXvalDiv32      ;0DB9D2|6612    |000012;
                       ORA.B r_collisionPointAbsoluteXInRoom;0DB9D4|0513    |000013;
                       STA.B r_collisionPointAbsoluteXInRoom;0DB9D6|8513    |000013;
                       CLC                                  ;0DB9D8|18      |      ;
                       LDA.B #$40                           ;0DB9D9|A940    |      ;
                       ADC.B r_collisionPointXvalDiv32      ;0DB9DB|6512    |000012;
                       STA.B r_collisionPointXvalDiv32      ;0DB9DD|8512    |000012;
                       BCC CODE_0DB9E3                      ;0DB9DF|9002    |0DB9E3;
                       INC.B r_collisionPointAbsoluteXInRoom;0DB9E1|E613    |000013;
 
          CODE_0DB9E3: RTS                                  ;0DB9E3|60      |      ;
 
 
          CODE_0DB9E4: LDA.B r_collisionPointAbsoluteXInRoom;0DB9E4|A513    |000013;
                       AND.B #$FC                           ;0DB9E6|29FC    |      ;
                       ORA.B #$03                           ;0DB9E8|0903    |      ;
                       STA.B r_15                           ;0DB9EA|8515    |000015;
                       LDA.B r_collisionPointAbsoluteXInRoom;0DB9EC|A513    |000013;
                       AND.B #$03                           ;0DB9EE|2903    |      ;
                       ORA.B #$0C                           ;0DB9F0|090C    |      ;
                       STA.B r_collisionPointAbsoluteXRoom  ;0DB9F2|8514    |000014;
                       LDA.B r_collisionPointXvalDiv32      ;0DB9F4|A512    |000012;
                       ASL A                                ;0DB9F6|0A      |      ;
                       ROL.B r_collisionPointAbsoluteXRoom  ;0DB9F7|2614    |000014;
                       ASL A                                ;0DB9F9|0A      |      ;
                       ASL A                                ;0DB9FA|0A      |      ;
                       ASL A                                ;0DB9FB|0A      |      ;
                       ROL.B r_collisionPointAbsoluteXRoom  ;0DB9FC|2614    |000014;
                       ASL A                                ;0DB9FE|0A      |      ;
                       ROL.B r_collisionPointAbsoluteXRoom  ;0DB9FF|2614    |000014;
                       ASL A                                ;0DBA01|0A      |      ;
                       ROL.B r_collisionPointAbsoluteXRoom  ;0DBA02|2614    |000014;
                       RTS                                  ;0DBA04|60      |      ;
 
 
    miscSprite_col_03: LDA.B r_collisionValIsForRightHalfOf32x16block;0DBA05|A5A5    |0000A5;
                       TAX                                  ;0DBA07|AA      |      ;
                       LDY.B $09                            ;0DBA08|A409    |000009;
                       LDA.W r_collisionMap,Y             ;0DBA0A|B9E006  |0D06E0;
                       AND.W DATA8_0DBA50,X                 ;0DBA0D|3D50BA  |0DBA50;
                       STA.B $00                            ;0DBA10|8500    |000000;
                       LDA.W r_collisionMap,Y             ;0DBA12|B9E006  |0D06E0;
                       AND.W DATA8_0DBA4E,X                 ;0DBA15|3D4EBA  |0DBA4E;
                       CMP.W DATA8_0DBA48,X                 ;0DBA18|DD48BA  |0DBA48;
                       BNE CODE_0DBA27                      ;0DBA1B|D00A    |0DBA27;
                       CLC                                  ;0DBA1D|18      |      ;
                       ADC.W DATA8_0DBA4A,X                 ;0DBA1E|7D4ABA  |0DBA4A;
                       JSR.W CODE_0DBA52                    ;0DBA21|2052BA  |0DBA52;
                       JMP.W CODE_0DBA2E                    ;0DBA24|4C2EBA  |0DBA2E;
 
 
          CODE_0DBA27: CLC                                  ;0DBA27|18      |      ;
                       ADC.W DATA8_0DBA4C,X                 ;0DBA28|7D4CBA  |0DBA4C;
                       JSR.W CODE_0DBA52                    ;0DBA2B|2052BA  |0DBA52;
 
          CODE_0DBA2E: AND.W DATA8_0DBA4E,X                 ;0DBA2E|3D4EBA  |0DBA4E;
                       STA.B r_temp_Xpos                    ;0DBA31|850A    |00000A;
                       ORA.B $00                            ;0DBA33|0500    |000000;
                       STA.W r_collisionMap,Y             ;0DBA35|99E006  |0D06E0;
                       LDA.B r_temp_Xpos                    ;0DBA38|A50A    |00000A;
                       CMP.B #$10                           ;0DBA3A|C910    |      ;
                       BCC CODE_0DBA42                      ;0DBA3C|9004    |0DBA42;
                       LSR A                                ;0DBA3E|4A      |      ;
                       LSR A                                ;0DBA3F|4A      |      ;
                       LSR A                                ;0DBA40|4A      |      ;
                       LSR A                                ;0DBA41|4A      |      ;
 
          CODE_0DBA42: SEC                                  ;0DBA42|38      |      ;
                       SBC.B #$0C                           ;0DBA43|E90C    |      ;
                       STA.B r_temp_Xpos                    ;0DBA45|850A    |00000A;
                       RTS                                  ;0DBA47|60      |      ;
 
 
         DATA8_0DBA48: db $40,$04                           ;0DBA48|        |      ;
 
 
         DATA8_0DBA4A: db $80,$08                           ;0DBA4A|        |      ;
 
         DATA8_0DBA4C: db $10,$01                           ;0DBA4C|        |      ;
 
         DATA8_0DBA4E: db $F0,$0F                           ;0DBA4E|        |      ;
 
         DATA8_0DBA50: db $0F,$F0                           ;0DBA50|        |      ;
 
          CODE_0DBA52: PHA                                  ;0DBA52|48      |      ;
                       STY.B $02                            ;0DBA53|8402    |000002;
                       LDA.B r_tempCurrRoomIdx              ;0DBA55|A50E    |00000E;
                       LSR A                                ;0DBA57|4A      |      ;
                       LSR A                                ;0DBA58|4A      |      ;
                       LSR A                                ;0DBA59|4A      |      ;
                       LSR A                                ;0DBA5A|4A      |      ;
                       TAY                                  ;0DBA5B|A8      |      ;
                       LDA.B #$00                           ;0DBA5C|A900    |      ;
                       STA.W $03B0,Y                        ;0DBA5E|99B003  |0D03B0;
                       LDY.B $02                            ;0DBA61|A402    |000002;
                       PLA                                  ;0DBA63|68      |      ;
                       RTS                                  ;0DBA64|60      |      ;
 
 
         DATA8_0DBA65:  db $03,$01,$00,$00
            db $03,$01,$00,$01   ;0DBA65|        |      ;
            db $03,$01,$00,$02
            db $03,$03,$00,$00   ;0DBA6D|        |      ;
            db $03,$03,$00,$01
            db $03,$03,$00,$02   ;0DBA75|        |      ;
            db $07,$00,$00,$00
            db $07,$05,$00,$00   ;0DBA7D|        |      ;
            db $07,$05,$00,$01
            db $07,$05,$00,$02   ;0DBA85|        |      ;
            db $07,$05,$01,$00
            db $08,$03,$00,$01   ;0DBA8D|        |      ;
            db $08,$03,$00,$02
            db $08,$04,$00,$01   ;0DBA95|        |      ;
            db $08,$04,$00,$02
            db $08,$04,$00,$04   ;0DBA9D|        |      ;
            db $0A,$01,$00,$00
            db $0A,$01,$00,$01   ;0DBAA5|        |      ;
            db $0A,$05,$00,$01
            db $0A,$05,$00,$02   ;0DBAAD|        |      ;
            db $0A,$06,$01,$00
            db $0A,$06,$01,$01   ;0DBAB5|        |      ;
            db $0A,$06,$01,$02
            db $0A,$06,$01,$03   ;0DBABD|        |      ;
            db $0B,$02,$01,$00
            db $0B,$02,$01,$01   ;0DBAC5|        |      ;
            db $0E,$00,$01,$00
            db $0E,$00,$01,$01   ;0DBACD|        |      ;
            db $0E,$00,$01,$02
            db $0E,$00,$00,$00   ;0DBAD5|        |      ;
            db $0E,$00,$00,$01                   ;0DBADD|        |      ;
 
       miscSprite__06: JSR.W CODE_0DBB3E                    ;0DBAE1|203EBB  |0DBB3E;
                       BCC CODE_0DBAEC                      ;0DBAE4|9006    |0DBAEC;
 
          CODE_0DBAE6: RTS                                  ;0DBAE6|60      |      ;
 
 
       miscSprite__08: JSR.W CODE_0DBB5B                    ;0DBAE7|205BBB  |0DBB5B;
                       BCS CODE_0DBAE6                      ;0DBAEA|B0FA    |0DBAE6;
 
          CODE_0DBAEC: LDA.B $03                            ;0DBAEC|A503    |000003;
                       ASL A                                ;0DBAEE|0A      |      ;
                       ASL A                                ;0DBAEF|0A      |      ;
                       ASL A                                ;0DBAF0|0A      |      ;
                       STA.B $00                            ;0DBAF1|8500    |000000;
                       LDA.B r_tempCurrRoomIdx              ;0DBAF3|A50E    |00000E;
                       LSR A                                ;0DBAF5|4A      |      ;
                       LSR A                                ;0DBAF6|4A      |      ;
                       LSR A                                ;0DBAF7|4A      |      ;
                       LSR A                                ;0DBAF8|4A      |      ;
                       LSR A                                ;0DBAF9|4A      |      ;
                       PHP                                  ;0DBAFA|08      |      ;
                       CLC                                  ;0DBAFB|18      |      ;
                       ADC.B $00                            ;0DBAFC|6500    |000000;
                       TAY                                  ;0DBAFE|A8      |      ;
                       LDA.B #$00                           ;0DBAFF|A900    |      ;
                       PLP                                  ;0DBB01|28      |      ;
                       ROL A                                ;0DBB02|2A      |      ;
                       TAX                                  ;0DBB03|AA      |      ;
                       LDA.W DATA8_0DBBCA,Y                 ;0DBB04|B9CABB  |0DBBCA;
                       STA.B r_tempCurrSection              ;0DBB07|850D    |00000D;
                       AND.W DATA8_0DBA4E,X                 ;0DBB09|3D4EBA  |0DBA4E;
                       CPX.B #$00                           ;0DBB0C|E000    |      ;
                       BNE CODE_0DBB14                      ;0DBB0E|D004    |0DBB14;
                       LSR A                                ;0DBB10|4A      |      ;
                       LSR A                                ;0DBB11|4A      |      ;
                       LSR A                                ;0DBB12|4A      |      ;
                       LSR A                                ;0DBB13|4A      |      ;
 
          CODE_0DBB14: STA.B $00                            ;0DBB14|8500    |000000;
                       JSR.W CODE_0DBB91                    ;0DBB16|2091BB  |0DBB91;
                       LDA.B r_stage                        ;0DBB19|A532    |000032;
                       ASL A                                ;0DBB1B|0A      |      ;
                       TAY                                  ;0DBB1C|A8      |      ;
                       LDA.W crumbleBlock_BG_stageList,Y                 ;0DBB1D|B9C2BC  |0DBCC2;
                       STA.B $02                            ;0DBB20|8502    |000002;
                       LDA.W crumbleBlock_BG_stageList+1,Y                 ;0DBB22|B9C3BC  |0DBCC3;
                       STA.B $03                            ;0DBB25|8503    |000003;
                       LDA.B $00                            ;0DBB27|A500    |000000;
                       ASL A                                ;0DBB29|0A      |      ;
                       ASL A                                ;0DBB2A|0A      |      ;
                       CLC                                  ;0DBB2B|18      |      ;
                       ADC.B $00                            ;0DBB2C|6500    |000000;
                       STA.B $00                            ;0DBB2E|8500    |000000;
                       CLC                                  ;0DBB30|18      |      ;
                       LDA.B $00                            ;0DBB31|A500    |000000;
                       ADC.B $02                            ;0DBB33|6502    |000002;
                       STA.B r_coreLoadingFuncAddr          ;0DBB35|8516    |000016;
                       LDA.B $03                            ;0DBB37|A503    |000003;
                       ADC.B #$00                           ;0DBB39|6900    |      ;
                       STA.B $17                            ;0DBB3B|8517    |000017;
                       RTS                                  ;0DBB3D|60      |      ;
 
 
          CODE_0DBB3E: LDA.W r_entity_YPos                ;0DBB3E|AD1C04  |0D041C;
                       SEC                                  ;0DBB41|38      |      ;
                       SBC.B #$20                           ;0DBB42|E920    |      ;
                       CLC                                  ;0DBB44|18      |      ;
                       ADC.B r_sceneScrollOffsetLo          ;0DBB45|6556    |000056;
                       BCS CODE_0DBB4D                      ;0DBB47|B004    |0DBB4D;
                       CMP.B #$F0                           ;0DBB49|C9F0    |      ;
                       BCC CODE_0DBB50                      ;0DBB4B|9003    |0DBB50;
 
          CODE_0DBB4D: ADC.B #$0F                           ;0DBB4D|690F    |      ;
                       SEC                                  ;0DBB4F|38      |      ;
 
          CODE_0DBB50: STA.B $0B                            ;0DBB50|850B    |00000B;
                       LDA.B r_sceneScrollOffsetHi          ;0DBB52|A557    |000057;
                       ADC.B #$00                           ;0DBB54|6900    |      ;
                       STA.B $07                            ;0DBB56|8507    |000007;
                       JMP.W CODE_0DBB5F                    ;0DBB58|4C5FBB  |0DBB5F;
 
 
          CODE_0DBB5B: LDA.B r_roomSectionChrBanksDataOffset;0DBB5B|A50F    |00000F;
                       STA.B $07                            ;0DBB5D|8507    |000007;
 
          CODE_0DBB5F: LDA.B #$1F                           ;0DBB5F|A91F    |      ;
                       STA.B $02                            ;0DBB61|8502    |000002;
                       LDA.B r_stage                        ;0DBB63|A532    |000032;
                       STA.B $04                            ;0DBB65|8504    |000004;
                       LDA.B r_blockLevel                   ;0DBB67|A533    |000033;
                       STA.B $05                            ;0DBB69|8505    |000005;
                       LDA.B r_roomIdx                      ;0DBB6B|A534    |000034;
                       STA.B $06                            ;0DBB6D|8506    |000006;
                       LDA.B #$00                           ;0DBB6F|A900    |      ;
                       STA.B $03                            ;0DBB71|8503    |000003;
 
          CODE_0DBB73: LDA.B $03                            ;0DBB73|A503    |000003;
                       ASL A                                ;0DBB75|0A      |      ;
                       ASL A                                ;0DBB76|0A      |      ;
                       TAY                                  ;0DBB77|A8      |      ;
                       LDX.B #$00                           ;0DBB78|A200    |      ;
 
          CODE_0DBB7A: LDA.B $04,X                          ;0DBB7A|B504    |000004;
                       CMP.W DATA8_0DBA65,Y                 ;0DBB7C|D965BA  |0DBA65;
                       BNE CODE_0DBB89                      ;0DBB7F|D008    |0DBB89;
                       INY                                  ;0DBB81|C8      |      ;
                       INX                                  ;0DBB82|E8      |      ;
                       CPX.B #$04                           ;0DBB83|E004    |      ;
                       BNE CODE_0DBB7A                      ;0DBB85|D0F3    |0DBB7A;
                       CLC                                  ;0DBB87|18      |      ;
                       RTS                                  ;0DBB88|60      |      ;
 
 
          CODE_0DBB89: INC.B $03                            ;0DBB89|E603    |000003;
                       DEC.B $02                            ;0DBB8B|C602    |000002;
                       BNE CODE_0DBB73                      ;0DBB8D|D0E4    |0DBB73;
                       SEC                                  ;0DBB8F|38      |      ;
                       RTS                                  ;0DBB90|60      |      ;
 
 
          CODE_0DBB91: LDA.B $00                            ;0DBB91|A500    |000000;
                       LDY.B r_stage                        ;0DBB93|A432    |000032;
                       CPY.B #$0A                           ;0DBB95|C00A    |      ;
                       BNE CODE_0DBBAA                      ;0DBB97|D011    |0DBBAA;
                       CMP.B #$0E                           ;0DBB99|C90E    |      ;
                       BNE CODE_0DBBC5                      ;0DBB9B|D028    |0DBBC5;
                       LDA.B #$0D                           ;0DBB9D|A90D    |      ;
                       LDY.B $0B                            ;0DBB9F|A40B    |00000B;
                       CPY.B #$A0                           ;0DBBA1|C0A0    |      ;
                       BCC CODE_0DBBA7                      ;0DBBA3|9002    |0DBBA7;
                       LDA.B #$0B                           ;0DBBA5|A90B    |      ;
 
          CODE_0DBBA7: STA.B $00                            ;0DBBA7|8500    |000000;
                       RTS                                  ;0DBBA9|60      |      ;
 
 
          CODE_0DBBAA: CPY.B #$0B                           ;0DBBAA|C00B    |      ;
                       BNE CODE_0DBBC5                      ;0DBBAC|D017    |0DBBC5;
                       LDY.B r_roomSectionChrBanksDataOffset;0DBBAE|A40F    |00000F;
                       BNE CODE_0DBBC5                      ;0DBBB0|D013    |0DBBC5;
                       SEC                                  ;0DBBB2|38      |      ;
                       SBC.B #$0D                           ;0DBBB3|E90D    |      ;
                       BCC CODE_0DBBC5                      ;0DBBB5|900E    |0DBBC5;
                       ASL A                                ;0DBBB7|0A      |      ;
                       TAY                                  ;0DBBB8|A8      |      ;
                       LDA.B $0B                            ;0DBBB9|A50B    |00000B;
                       CMP.B #$A0                           ;0DBBBB|C9A0    |      ;
                       BCC CODE_0DBBC0                      ;0DBBBD|9001    |0DBBC0;
                       INY                                  ;0DBBBF|C8      |      ;
 
          CODE_0DBBC0: LDA.W DATA8_0DBBC6,Y                 ;0DBBC0|B9C6BB  |0DBBC6;
                       STA.B $00                            ;0DBBC3|8500    |000000;
 
          CODE_0DBBC5: RTS                                  ;0DBBC5|60      |      ;
 
 
         DATA8_0DBBC6: db $02,$01,$03,$04                   ;0DBBC6|        |      ;
     DATA8_0DBBCA: db $FF,$FF,$00,$FF,$00,$FF,$FF,$FF   ;0DBBCA|        |      ;
                       db $FF,$FF,$12,$00,$FF,$FF,$00,$FF   ;0DBBD2|        |      ;
                       db $FF,$FF,$FF,$00,$FF,$00,$FF,$00   ;0DBBDA|        |      ;
                       db $FF,$FF,$FF,$FF,$00,$FF,$FF,$FF   ;0DBBE2|        |      ;
                       db $FF,$00,$FF,$FF,$FF,$FF,$FF,$FF   ;0DBBEA|        |      ;
                       db $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ;0DBBF2|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$00,$FF,$FF   ;0DBBFA|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$12,$F3   ;0DBC02|        |      ;
                       db $0F,$00,$FF,$FF,$FF,$FF,$FF,$FF   ;0DBC0A|        |      ;
                       db $00,$F0,$30,$12,$FF,$00,$FF,$FF   ;0DBC12|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$00,$FF   ;0DBC1A|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$34,$FF,$34   ;0DBC22|        |      ;
                       db $FF,$34,$FF,$12,$FF,$12,$FF,$FF   ;0DBC2A|        |      ;
                       db $00,$FF,$12,$12,$12,$12,$12,$12   ;0DBC32|        |      ;
                       db $05,$FF,$FF,$12,$FF,$12,$FF,$FF   ;0DBC3A|        |      ;
                       db $FF,$50,$FF,$FF,$FF,$FF,$FF,$FF   ;0DBC42|        |      ;
                       db $FF,$FF,$FF,$FF,$00,$FF,$12,$FF   ;0DBC4A|        |      ;
                       db $34,$FF,$12,$FF,$00,$FF,$FF,$FF   ;0DBC52|        |      ;
                       db $FF,$FF,$56,$78,$56,$FF,$FF,$FF   ;0DBC5A|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$56,$FF,$FF   ;0DBC62|        |      ;
                       db $FF,$9A,$FF,$FF,$FF,$FF,$FF,$FF   ;0DBC6A|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$BC,$BC,$FF   ;0DBC72|        |      ;
                       db $FF,$FF,$DC,$BC,$FC,$FF,$BC,$FF   ;0DBC7A|        |      ;
                       db $FF,$DC,$EC,$BC,$BC,$BC,$FF,$FF   ;0DBC82|        |      ;
                       db $23,$11,$23,$DE,$11,$23,$11,$FF   ;0DBC8A|        |      ;
                       db $FF,$11,$23,$11,$11,$23,$FF,$FF   ;0DBC92|        |      ;
                       db $FF,$FF,$FF,$FF,$FF,$FB,$FF,$FF   ;0DBC9A|        |      ;
                       db $01,$12,$FF,$FF,$34,$FF,$34,$56   ;0DBCA2|        |      ;
                       db $01,$FF,$FF,$FF,$FF,$78,$34,$9A   ;0DBCAA|        |      ;
                       db $FF,$FF,$00,$00,$00,$FF,$FF,$FF   ;0DBCB2|        |      ;
                       db $00,$00,$FF,$00,$FF,$FF,$FF,$FF   ;0DBCBA|        |      ;
 
 
 crumbleBlock_BG_stageList: 
            dw crumbleBlock_BG_00_to_06          ;0DBCC2|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCC4|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCC6|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCC8|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCCA|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCCC|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCCE|        |0DBCE0;
            dw crumbleBlock_BG_Stage_7           ;0DBCD0|        |0DBCEF;
            dw crumbleBlock_BG_Stage_8           ;0DBCD2|        |0DBD03;
            dw crumbleBlock_BG_00_to_06          ;0DBCD4|        |0DBCE0;
            dw crumbleBlock_BG__Stage_A          ;0DBCD6|        |0DBD21;
            dw crumbleBlock_BG__Stage_E          ;0DBCD8|        |0DBD67;
            dw crumbleBlock_BG_00_to_06          ;0DBCDA|        |0DBCE0;
            dw crumbleBlock_BG_00_to_06          ;0DBCDC|        |0DBCE0;
            dw crumbleBlock_BG_06                ;0DBCDE|        |0DBD80;
 
 
    crumbleBlock_BG_00_to_06: 
            db $00,$00,$00,$00,$00,$7C,$3E,$7C   ;0DBCE0|        |      ; plus 9 c d
            db $3E,$55,$7F,$00,$7E,$00,$55       ;0DBCE8|        |      ;
    
    crumbleBlock_BG_Stage_7: 
            db $00,$00,$00,$00,$00,$80,$81,$94   ;0DBCEF|        |      ;
            db $91,$AA,$A0,$A1,$B0,$B1,$AA,$77   ;0DBCF7|        |      ;
            db $00,$84,$95,$AA                   ;0DBCFF|        |      ;
    
    crumbleBlock_BG_Stage_8: 
            db $00,$00,$00,$00,$00,$00,$00,$84   ;0DBD03|        |      ;
            db $85,$AA,$AC,$00,$B4,$AC,$FF,$84   ;0DBD0B|        |      ;
            db $85,$94,$95,$AA,$86,$3F,$96,$AC   ;0DBD13|        |      ;
            db $FF,$00,$AC,$AC,$00,$FF           ;0DBD1B|        |      ;
    
    crumbleBlock_BG__Stage_A: 
            db $00,$00,$00,$00,$00,$4D,$4C,$5D   ;0DBD21|        |      ;
            db $5F,$FF                           ;0DBD29|        |      ;
    
    crumbleBlock_BG__Stage_B: 
            db $00,$00,$5E,$00,$FF,$5D,$5F,$4C   ;0DBD2B|        |      ;
            db $4F,$FF,$4F,$4C,$5F,$5D,$FF,$5D   ;0DBD33|        |      ;
            db $00,$00,$4D,$55,$5D,$00,$4C,$5C   ;0DBD3B|        |      ;
            db $55,$4D,$4C,$5D,$5F,$55,$4F,$5F   ;0DBD43|        |      ;
            db $5E,$5D,$55,$6B,$88,$7C,$6A,$55   ;0DBD4B|        |      ;
            db $7E,$7F,$89,$7E,$55,$80,$81,$90   ;0DBD53|        |      ;
            db $91,$AA,$81,$82,$91,$92,$AA,$80   ;0DBD5B|        |      ;
            db $81,$84,$91,$AA                   ;0DBD63|        |      ;
    
    crumbleBlock_BG__Stage_E: 
            db $00,$00,$00,$00,$00,$40,$41,$50   ;0DBD67|        |      ;
            db $51,$55,$84,$85,$94,$95,$55,$86   ;0DBD6F|        |      ;
            db $87,$96,$97,$55,$49,$49,$48,$48   ;0DBD77|        |      ;
            db $55                               ;0DBD7F|        |      ;
    
    crumbleBlock_BG_06: 
            db $00,$00,$00,$00,$00,$00,$4C,$00   ;0DBD80|        |      ;
            db $4C,$AA,$4F,$00,$4F,$00,$AA,$A8   ;0DBD88|        |      ;
            db $A9,$92,$B0,$FF,$96,$00,$A6,$00   ;0DBD90|        |      ;
            db $FF,$00,$A3,$00,$91,$55,$B7,$00   ;0DBD98|        |      ;
            db $3E,$00,$55,$00,$00,$9B,$AA,$FF   ;0DBDA0|        |      ;
            db $8E,$9C,$AB,$9C,$FF,$9C,$28,$9B   ;0DBDA8|        |      ;
            db $39,$FF,$00,$AA,$8F,$28,$FF,$3E   ;0DBDB0|        |      ;
            db $00,$3E,$00,$55                   ;0DBDB8|        |      ;
 
 
          bossSkull_BGroutine: 
          LDA.B #$01                           ;0DBDBC|A901    |      ;
                       db $20                               ;0DBDBE|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBDBF|        |0FED14;
                       LDA.B #$00                           ;0DBDC1|A900    |      ;
                       db $20                               ;0DBDC3|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBDC4|        |0FED14;
                       LDA.B #$23                           ;0DBDC6|A923    |      ;
                       db $20                               ;0DBDC8|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBDC9|        |0FED14;
                       LDA.B #$BC                           ;0DBDCB|A9BC    |      ;
                       STA.B $03                            ;0DBDCD|8503    |000003;
                       LDY.B #$00                           ;0DBDCF|A000    |      ;
 
          CODE_0DBDD1: LDA.B $03                            ;0DBDD1|A503    |000003;
                       db $20                               ;0DBDD3|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBDD4|        |0FED14;
                       CLC                                  ;0DBDD6|18      |      ;
                       ADC.B #$02                           ;0DBDD7|6902    |      ;
                       db $20                               ;0DBDD9|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBDDA|        |0FED14;
                       INY                                  ;0DBDDC|C8      |      ;
                       CPY.B #$20                           ;0DBDDD|C020    |      ;
                       BCS DATA8_0DBDEC                     ;0DBDDF|B00B    |0DBDEC;
                       CPY.B #$10                           ;0DBDE1|C010    |      ;
                       BNE CODE_0DBDD1                      ;0DBDE3|D0EC    |0DBDD1;
                       LDA.B #$BD                           ;0DBDE5|A9BD    |      ;
                       STA.B $03                            ;0DBDE7|8503    |000003;
                       JMP.W CODE_0DBDD1                    ;0DBDE9|4CD1BD  |0DBDD1;
 
 
         DATA8_0DBDEC: db $4C                               ;0DBDEC|        |      ;
 
                       dw closeVramQueue                    ;0DBDED|        |0FED12;
 
           bankD_r7f0: LDA.W $07F0                          ;0DBDEF|ADF007  |0D07F0;
                       BMI CODE_0DBDFE                      ;0DBDF2|300A    |0DBDFE;
                       ORA.B #$80                           ;0DBDF4|0980    |      ;
                       STA.W $07F0                          ;0DBDF6|8DF007  |0D07F0;
                       LDA.B #$00                           ;0DBDF9|A900    |      ;
                       STA.W $07F1                          ;0DBDFB|8DF107  |0D07F1;
 
          CODE_0DBDFE: LDA.W $07F0                          ;0DBDFE|ADF007  |0D07F0;
                       ASL A                                ;0DBE01|0A      |      ;
                       TAY                                  ;0DBE02|A8      |      ;
                       LDA.B #$00                           ;0DBE03|A900    |      ;
                       STA.B $01                            ;0DBE05|8501    |000001;
                       LDA.W $07F1                          ;0DBE07|ADF107  |0D07F1;
                       ASL A                                ;0DBE0A|0A      |      ;
                       ROL.B $01                            ;0DBE0B|2601    |000001;
                       ASL A                                ;0DBE0D|0A      |      ;
                       ROL.B $01                            ;0DBE0E|2601    |000001;
                       ASL A                                ;0DBE10|0A      |      ;
                       ROL.B $01                            ;0DBE11|2601    |000001;
                       ASL A                                ;0DBE13|0A      |      ;
                       ROL.B $01                            ;0DBE14|2601    |000001;
                       ASL A                                ;0DBE16|0A      |      ;
                       ROL.B $01                            ;0DBE17|2601    |000001;
                       STA.B $00                            ;0DBE19|8500    |000000;
                       CLC                                  ;0DBE1B|18      |      ;
                       LDA.W DATA8_0DBE5D,Y                 ;0DBE1C|B95DBE  |0DBE5D;
                       ADC.B $00                            ;0DBE1F|6500    |000000;
                       STA.B $00                            ;0DBE21|8500    |000000;
                       LDA.W DATA8_0DBE5E,Y                 ;0DBE23|B95EBE  |0DBE5E;
                       ADC.B $01                            ;0DBE26|6501    |000001;
                       STA.B $01                            ;0DBE28|8501    |000001;
                       LDA.B #$01                           ;0DBE2A|A901    |      ;
                       db $20                               ;0DBE2C|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBE2D|        |0FED14;
                       LDA.B $00                            ;0DBE2F|A500    |000000;
                       db $20                               ;0DBE31|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBE32|        |0FED14;
                       LDA.B $01                            ;0DBE34|A501    |000001;
                       db $20                               ;0DBE36|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBE37|        |0FED14;
                       LDY.B #$20                           ;0DBE39|A020    |      ;
                       LDA.B #$00                           ;0DBE3B|A900    |      ;
 
         DATA8_0DBE3D: db $20                               ;0DBE3D|        |      ;
                       dw getIDX_storeByteVramQueue         ;0DBE3E|        |0FED14;
                       DEY                                  ;0DBE40|88      |      ;
                       BNE DATA8_0DBE3D                     ;0DBE41|D0FA    |0DBE3D;
                       db $20                               ;0DBE43|        |      ;
                       dw closeVramQueue                    ;0DBE44|        |0FED12;
                       LDA.W $07F0                          ;0DBE46|ADF007  |0D07F0;
                       AND.B #$7F                           ;0DBE49|297F    |      ;
                       TAY                                  ;0DBE4B|A8      |      ;
                       INC.W $07F1                          ;0DBE4C|EEF107  |0D07F1;
                       LDA.W $07F1                          ;0DBE4F|ADF107  |0D07F1;
                       CMP.W DATA8_0DBE61,Y                 ;0DBE52|D961BE  |0DBE61;
                       BCC CODE_0DBE5C                      ;0DBE55|9005    |0DBE5C;
                       LDA.B #$FF                           ;0DBE57|A9FF    |      ;
                       STA.W $07F1                          ;0DBE59|8DF107  |0D07F1;
 
          CODE_0DBE5C: RTS                                  ;0DBE5C|60      |      ;
 
 
         DATA8_0DBE5D: db $C0                               ;0DBE5D|        |      ;
 
         DATA8_0DBE5E: db $20,$00,$24                       ;0DBE5E|        |      ;
 
         DATA8_0DBE61: db $1E,$20                           ;0DBE61|        |      ;     
pushPC 

endif 

