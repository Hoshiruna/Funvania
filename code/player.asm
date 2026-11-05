
{	; lastBank hijacks
org LAST_BANK+$6C8
base $E6C8  
		LDA.B #$9C                           
		JSR.W swapPRGbankStore                                             
		JSR.W player_processing 
		
org LAST_BANK+$1523							; main processing 
base $f523
		LDA.B #$9C               
        JSR.W swapPRGbankStore     
        JSR.W player_processing  
		
org LAST_BANK+$15CB
base $F5CB  
		LDA.B #$9C                           
		JSR.W swapPRGbankStore                                             
		JSR.W player_processing              

org LAST_BANK+$17DC
base $F7DC  
		LDA.B #$9C                           
		JSR.W swapPRGbankStore                                             
		JSR.W player_processing 

;	org $32452								; !! used in boss.asm 
;	base $A452
;	        dw bossDoupleGanger_jump_00              
;	        dw bossDoupleGanger_hurt_01              
;	        dw bossDoupleGanger_duck_02              
;	        dw bossDoupleGanger_attack_03            
;	        dw bossDoupleGanger_collusion_04         
;	        dw bossDoupleGanger_anim_05              
;	        dw bossDoupleGanger_AlucardAttack_06     
;			dw bossDoupleGanger_weaponAnim_07        
	
}


org $38000
base $8000
bank_9c:
db $9C                               ;0E8000|        |      ; NES PRG 38000



	if !grantSaveClimbSpeed == 1
		playerX_r_spd = $01
		playerX_r_subSpd = $40
		playerX_l_spd = $fe 
		playerX_l_subSpd = $c0
	else 
		playerX_r_spd = $01
		playerX_r_subSpd = $00
		playerX_l_spd = $ff 
		playerX_l_subSpd = $00
	endif 


	if !grantSaveClimbSpeed == 1	
		grant_climb_X_l_spd = $ff 	
		grant_climb_X_l_subSpd = $00
		grant_climb_X_r_spd = $01	
		grant_climb_X_r_subSpd = $00
	else 	
		grant_climb_X_l_spd = $fe 	
		grant_climb_X_l_subSpd = $c0
		grant_climb_X_r_spd = $01	
		grant_climb_X_r_subSpd = $40
	endif 


if !alucardStairAttack == 1 
    alucardAttackStairs:
		lda.w r_entity_ID
		cmp #$03
		bne +	
		lda $562
        bne +
		jsr alucardBaseAttack                 
    +   jmp player_animCountDown             
     
	characterCheckAluSt:	
	   	cmp #$03
		beq +
		
		lda #$00
		rts 
	 +  lda $3b
		rts 
endif 

if !jumpControllDirection == 1
		jumpControll:
;					lda $413			; skip turing when whip is out 

					lda.w r_Player_StateDoubled
					cmp #$08			; check if in jump state 
					bne endJumpControll
					lda.b r_Joy1Held
					and #$03		
					beq endJumpControll
					
					tay 
					ldx #$ff
					lda #$00
					cpy #$02
					beq +
					
					ldy #$01
					ldx #$01
					lda #$00					
					
				+	dey 
					sty.w r_entity_FacingLeft 
					stx.w r_entity_Xspd
					sta.w r_entity_XsubSpd
					
		endJumpControll:
if !jumpControllHight == 1			
		shortHop:
					lda.b r_autoPlay
					bne +
					
					lda.b r_Joy1Held
					and #$80
					bne +
					
					lda.w r_entity_Yspd
					bpl +
					
					lda.w r_entity_extra
					cmp #$0e
					bcc +
					
					lda #$1c				   ; jump turn point  
					sta.w r_entity_extra		
					
					lda #$00
					sta.w r_entity_Yspd			
				+	 
	
endif 

					rts 
		
		dislunchFromStairs:
					lda.b r_Joy1
					and #$80
					beq +						
					lda #$06
					sta.w r_Player_StateDoubled	
				+	rts 

		newDuckRoutine:				
					lda.b r_Joy1Held
					and #$03		
					beq ++
					
					tay 
					ldx #$ff
					lda #$80
					cpy #$02
					beq +
					
					ldy #$01
					ldx #$00
					lda #$80					
					
				+	dey 
					sty.w r_entity_FacingLeft 
					stx.w r_entity_Xspd
					sta.w r_entity_XsubSpd					
;					jsr updateSpriteAnimFrame			; needs new animation idx 
				++						
					
					rts 


endif 			 
 
if !grantNinjaStar == 1

	ninjaGrantWeponDelay = $20	


;			lda.w r_player_subWeID_01			; weapon init checks 
;			beq +
;			lda.w r_player_subWeID_02
;			beq +
;			lda.b r_trevorWhipLevel+1 
;			beq +
;			lda.w r_player_subWeID_03
;			beq +

;		weaponDelayChek:						; works but the weapon should always go of when initiated.. else wired things can happen.. and sound 
;			lda.b r_trevorWhipLevel+1 
;			cmp.b #ninjaGrantWeponDelay
;			bcs +
;			sec 
;			rts 
;		+	lda #$00
;			sta.b r_trevorWhipLevel+1 



		initGrantNewAxe:						
			LDX.B #$14
				
			lda.b r_trevorWhipLevel+1 
			cmp.b #ninjaGrantWeponDelay
			bcc stopAxeThrow		
			
			LDA.W r_entity_ID,X 
			beq startAxeThrow
			inx 
			LDA.W r_entity_ID,X 
			beq startAxeThrow
			inx 
			LDA.W r_entity_ID,X 
			beq startAxeThrow

		stopAxeThrow:
			lda #$ff 	
			sta.w r_entity_AnimTimer	
			sec 
			rts 
			
		startAxeThrow:	
			lda #$0e 
			sta.w r_entity_ID,X 
			
			lda #$00                                 
			sta.w r_trevorWhipLevel+1 
			sta.w r_entity_extra,X                                                  
			sta.w r_entity_AnimTimer,x                        
			sta.w r_Player_StateDoubled,X      
			sta.w r_damagActionFlag,X       			
			
			clc 
			rts 		
endif 
 



{ ; data tables
 
  subweaponHeartCost:     ; 0EBAB6|        |      ;   
        db $00      
        db $01            ; SUBWE_AXE = $01             
        db $01            ; SUBWE_CROSS = $02      
        db $01            ; SUBWE_DAGGER = $03      
        db $01            ; SUBWE_HOLYW = $04      
        db $01            ; SUBWE_FLAME = $05      
        db $01            ; SUBWE_FREEZ = $06      
        db $01            ; SUBWE_ORB = $07      
        db $01            ; SUBWE_GRANT_DAGGER = $08    
        db $01            ; SUBWE_GRANT_AXE = $09      
        db $00            ; SUBWE_ALUCARD = $0A    
        db $05            ; SUBWE_CLOCK = $0B                  
  
}

 
{ ; routines..   
			
      CODE_0E8001:
						LDA.B r_CogSize                      ;0E8001|A595    |000095;
						ASL A                                ;0E8003|0A      |      ;
						ASL A                                ;0E8004|0A      |      ;
						TAY                                  ;0E8005|A8      |      ;
						LDA.W cogMovmentData,Y               ;0E8006|B94688  |0E8846;
						STA.B r_pointerQueue                 ;0E8009|8508    |000008;
						LDA.W cogMovmentData+1,Y                 ;0E800B|B94788  |0E8847;
						STA.B $09                            ;0E800E|8509    |000009;
						LDA.W PTR16_0E8848,Y                 ;0E8010|B94888  |0E8848;
						STA.B r_temp_Xpos                    ;0E8013|850A    |00000A;
						LDA.W PTR16_0E8848+1,Y                 ;0E8015|B94988  |0E8849;
						STA.B $0B                            ;0E8018|850B    |00000B;
						LDA.B r_knockBackDirrection          ;0E801A|A590    |000090;
						BPL CODE_0E8035                      ;0E801C|1017    |0E8035;
						AND.B #$7F                           ;0E801E|297F    |      ;
						TAY                                  ;0E8020|A8      |      ;
						LDA.W r_entity_XsubSpd             ;0E8021|AD0905  |0E0509;
						SEC                                  ;0E8024|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0E8025|F108    |000008;
						STA.W r_entity_XsubSpd             ;0E8027|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0E802A|ADF204  |0E04F2;
						SBC.B #$00                           ;0E802D|E900    |      ;
						STA.W r_entity_Xspd                ;0E802F|8DF204  |0E04F2;
						JMP.W CODE_0E8047                    ;0E8032|4C4780  |0E8047;
	
	
			CODE_0E8035:
						TAY                                  ;0E8035|A8      |      ;
						LDA.W r_entity_XsubSpd             ;0E8036|AD0905  |0E0509;
						CLC                                  ;0E8039|18      |      ;
						ADC.B (r_pointerQueue),Y             ;0E803A|7108    |000008;
						STA.W r_entity_XsubSpd             ;0E803C|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0E803F|ADF204  |0E04F2;
						ADC.B #$00                           ;0E8042|6900    |      ;
						STA.W r_entity_Xspd                ;0E8044|8DF204  |0E04F2;
	
			CODE_0E8047:
						CPY.B #$34                           ;0E8047|C034    |      ;
						BCS CODE_0E805D                      ;0E8049|B012    |0E805D;
						LDA.W r_entity_YsubSpd             ;0E804B|AD3705  |0E0537;
						CLC                                  ;0E804E|18      |      ;
						ADC.B (r_temp_Xpos),Y                ;0E804F|710A    |00000A;
						STA.W r_entity_YsubSpd             ;0E8051|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0E8054|AD2005  |0E0520;
						ADC.B #$00                           ;0E8057|6900    |      ;
						STA.W r_entity_Yspd                ;0E8059|8D2005  |0E0520;
						RTS                                  ;0E805C|60      |      ;
	
	
			CODE_0E805D:
						TYA                                  ;0E805D|98      |      ;
						SEC                                  ;0E805E|38      |      ;
						SBC.B #$34                           ;0E805F|E934    |      ;
						ASL A                                ;0E8061|0A      |      ;
						TAY                                  ;0E8062|A8      |      ;
						LDA.W r_entity_YsubSpd             ;0E8063|AD3705  |0E0537;
						CLC                                  ;0E8066|18      |      ;
						ADC.W DATA8_0E8912,Y                 ;0E8067|791289  |0E8912;
						STA.W r_entity_YsubSpd             ;0E806A|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0E806D|AD2005  |0E0520;
						ADC.W DATA8_0E8913,Y                 ;0E8070|791389  |0E8913;
						STA.W r_entity_Yspd                ;0E8073|8D2005  |0E0520;
						RTS                                  ;0E8076|60      |      ;
	
	
		setKnockBackSpd:
						LDA.B r_knockBackDirrection          ;0E8077|A590    |000090;
						BMI CODE_0E8091                      ;0E8079|3016    |0E8091;
						TAY                                  ;0E807B|A8      |      ;
						LDA.W r_entity_XsubSpd             ;0E807C|AD0905  |0E0509;
						SEC                                  ;0E807F|38      |      ;
						SBC.W DATA8_0E892C,Y                 ;0E8080|F92C89  |0E892C;
						STA.W r_entity_XsubSpd             ;0E8083|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0E8086|ADF204  |0E04F2;
						SBC.B #$00                           ;0E8089|E900    |      ;
						STA.W r_entity_Xspd                ;0E808B|8DF204  |0E04F2;
						JMP.W CODE_0E80A6                    ;0E808E|4CA680  |0E80A6;
	
	
			CODE_0E8091:
						AND.B #$7F                           ;0E8091|297F    |      ;
						TAY                                  ;0E8093|A8      |      ;
						LDA.W r_entity_XsubSpd             ;0E8094|AD0905  |0E0509;
						CLC                                  ;0E8097|18      |      ;
						ADC.W DATA8_0E892C,Y                 ;0E8098|792C89  |0E892C;
						STA.W r_entity_XsubSpd             ;0E809B|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0E809E|ADF204  |0E04F2;
						ADC.B #$00                           ;0E80A1|6900    |      ;
						STA.W r_entity_Xspd                ;0E80A3|8DF204  |0E04F2;
	
			CODE_0E80A6:
						LDA.W r_entity_YsubSpd             ;0E80A6|AD3705  |0E0537;
						CLC                                  ;0E80A9|18      |      ;
						ADC.W DATA8_0E894D,Y                 ;0E80AA|794D89  |0E894D;
						STA.W r_entity_YsubSpd             ;0E80AD|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0E80B0|AD2005  |0E0520;
						ADC.B #$00                           ;0E80B3|6900    |      ;
						STA.W r_entity_Yspd                ;0E80B5|8D2005  |0E0520;
						RTS                                  ;0E80B8|60      |      ;
	
	
	chemberBeforeDrac_E11:
						LDA.B r_sceneScrollOffsetLo          ;0E80B9|A556    |000056;
						ORA.B r_sceneScrollOffsetHi          ;0E80BB|0557    |000057;
						BNE CODE_0E80D8                      ;0E80BD|D019    |0E80D8;
						LDA.W r_entity_XPos                ;0E80BF|AD3804  |0E0438;
						CMP.B #$40                           ;0E80C2|C940    |      ;
						BCS CODE_0E80D8                      ;0E80C4|B012    |0E80D8;
						LDA.W r_entity_YPos                ;0E80C6|AD1C04  |0E041C;
						SEC                                  ;0E80C9|38      |      ;
						SBC.B #$70                           ;0E80CA|E970    |      ;
						BCS CODE_0E80D0                      ;0E80CC|B002    |0E80D0;
						EOR.B #$FF                           ;0E80CE|49FF    |      ;
	
			CODE_0E80D0:
						CMP.B #$08                           ;0E80D0|C908    |      ;
						BCS CODE_0E80D8                      ;0E80D2|B004    |0E80D8;
						LDA.B #$0E                           ;0E80D4|A90E    |      ;
						STA.B r_damagePlayer                 ;0E80D6|8581    |000081;
	
			CODE_0E80D8:
						RTS                                  ;0E80D8|60      |      ;
	
	
		chemberBeforeDrac:
						LDA.B r_stage                        ;0E80D9|A532    |000032;
						CMP.B #$0E                           ;0E80DB|C90E    |      ;
						BNE CODE_0E80EE                      ;0E80DD|D00F    |0E80EE;
						LDA.B r_blockLevel                   ;0E80DF|A533    |000033;
						CMP.B #$01                           ;0E80E1|C901    |      ;
						BNE CODE_0E80EE                      ;0E80E3|D009    |0E80EE;
						LDA.B r_roomIdx                      ;0E80E5|A534    |000034;
						CMP.B #$01                           ;0E80E7|C901    |      ;
						BNE CODE_0E80EE                      ;0E80E9|D003    |0E80EE;
						JSR.W chemberBeforeDrac_E11          ;0E80EB|20B980  |0E80B9;
	
			CODE_0E80EE:
						LDA.W r_Player_StateDoubled        ;0E80EE|AD6505  |0E0565;
						CMP.B #$0A                           ;0E80F1|C90A    |      ;
						BEQ CODE_0E80F9                      ;0E80F3|F004    |0E80F9;
						CMP.B #$1C                           ;0E80F5|C91C    |      ;
						BNE CODE_0E8101                      ;0E80F7|D008    |0E8101;
	
			CODE_0E80F9:
						LDA.W r_entity_ID         ;0E80F9|AD4E05  |0E054E;
						CLC                                  ;0E80FC|18      |      ;
						ADC.B #$04                           ;0E80FD|6904    |      ;
						BNE CODE_0E8104                      ;0E80FF|D003    |0E8104;
	
			CODE_0E8101:
						LDA.W r_entity_ID         ;0E8101|AD4E05  |0E054E;
	
			CODE_0E8104:
						STA.B r_currPartnerID                ;0E8104|8582    |000082;
						LDA.B r_delayElevators               ;0E8106|A5AF    |0000AF;
						BEQ CODE_0E810C                      ;0E8108|F002    |0E810C;
						DEC.B r_delayElevators               ;0E810A|C6AF    |0000AF;
	
			CODE_0E810C:
						LDA.B r_deathDelay                   ;0E810C|A5BF    |0000BF;
						BNE CODE_0E812B                      ;0E810E|D01B    |0E812B;
						LDA.B r_invincableFrames             ;0E8110|A580    |000080;
						BEQ CODE_0E811E                      ;0E8112|F00A    |0E811E;
						DEC.B r_invincableFrames             ;0E8114|C680    |000080;
						LDY.B #$80                           ;0E8116|A080    |      ;
						LDA.B r_frameCount         ;0E8118|A51A    |00001A;
						AND.B #$01                           ;0E811A|2901    |      ;
						BEQ CODE_0E8120                      ;0E811C|F002    |0E8120;
	
			CODE_0E811E:
						LDY.B #$00                           ;0E811E|A000    |      ;
	
			CODE_0E8120:
						STY.W r_entity_mask              ;0E8120|8C7004  |0E0470;
						LDA.B r_powerUpDrop                  ;0E8123|A5B7    |0000B7;
						BNE CODE_0E8139                      ;0E8125|D012    |0E8139;
						LDA.B r_damagePlayer                 ;0E8127|A581    |000081;
						BNE CODE_0E812C                      ;0E8129|D001    |0E812C;
	
			CODE_0E812B:
						RTS                                  ;0E812B|60      |      ;
	
	
			CODE_0E812C:
						CMP.B #$0D                           ;0E812C|C90D    |      ;
						BEQ CODE_0E818F                      ;0E812E|F05F    |0E818F;
						CMP.B #$0E                           ;0E8130|C90E    |      ;
						BEQ CODE_0E8154                      ;0E8132|F020    |0E8154;
						AND.B #$F0                           ;0E8134|29F0    |      ;
						BNE CODE_0E81A2                      ;0E8136|D06A    |0E81A2;
						RTS                                  ;0E8138|60      |      ;
	
	
			CODE_0E8139:
						LDA.B #$00                           ;0E8139|A900    |      ;
						STA.B r_powerUpDrop                  ;0E813B|85B7    |0000B7;
						LDA.B r_gameTransition               ;0E813D|A52A    |00002A;
						STA.B $9F                            ;0E813F|859F    |00009F;
						LDA.B #$19                           ;0E8141|A919    |      ;
						STA.B r_gameTransition               ;0E8143|852A    |00002A;
						LDA.W r_Player_StateDoubled        ;0E8145|AD6505  |0E0565;
						ORA.B #$80                           ;0E8148|0980    |      ;
						STA.W r_Player_StateDoubled        ;0E814A|8D6505  |0E0565;
						LDA.B #$2C                           ;0E814D|A92C    |      ;
						STA.B r_timerGenerel                 ;0E814F|8530    |000030;
						PLA                                  ;0E8151|68      |      ;
						PLA                                  ;0E8152|68      |      ;
	
			CODE_0E8153:
						RTS                                  ;0E8153|60      |      ;
	
	
			CODE_0E8154:
						LDA.B #$00                           ;0E8154|A900    |      ;
						LDX.B #$10                           ;0E8156|A210    |      ;
						db $20                               ;0E8158|        |      ;
						dw playerCollusionCheck              ;0E8159|        |0FFCDD;
						BEQ CODE_0E8172                      ;0E815B|F015    |0E8172;
						LDA.B r_stage                        ;0E815D|A532    |000032;
						CMP.B #$01                           ;0E815F|C901    |      ;
						BEQ CODE_0E8167                      ;0E8161|F004    |0E8167;
						LDA.B r_sceneScrollOffsetLo          ;0E8163|A556    |000056;
						BNE CODE_0E8172                      ;0E8165|D00B    |0E8172;
	
			CODE_0E8167:
						LDA.W r_Player_StateDoubled        ;0E8167|AD6505  |0E0565;
						CMP.B #$02                           ;0E816A|C902    |      ;
						BEQ CODE_0E8173                      ;0E816C|F005    |0E8173;
						CMP.B #$04                           ;0E816E|C904    |      ;
						BEQ CODE_0E8173                      ;0E8170|F001    |0E8173;
	
			CODE_0E8172:
						RTS                                  ;0E8172|60      |      ;
	
	
			CODE_0E8173:
						JSR.W CODE_0E8A02                    ;0E8173|20028A  |0E8A02;
						LDA.W r_entity_ID         ;0E8176|AD4E05  |0E054E;
						CMP.B #$02                           ;0E8179|C902    |      ;
						BNE CODE_0E8186                      ;0E817B|D009    |0E8186;
						LDA.W r_entity_YPos                ;0E817D|AD1C04  |0E041C;
						CLC                                  ;0E8180|18      |      ;
						ADC.B #$04                           ;0E8181|6904    |      ;
						STA.W r_entity_YPos                ;0E8183|8D1C04  |0E041C;
	
			CODE_0E8186:
						LDA.B #$18                           ;0E8186|A918    |      ;
						STA.B r_gameTransition               ;0E8188|852A    |00002A;
						LDA.B #$00                           ;0E818A|A900    |      ;
						STA.B r_menuSelectIdx                ;0E818C|856B    |00006B;
						RTS                                  ;0E818E|60      |      ;
	
	
			CODE_0E818F:
						JSR.W getSlot13_resetOamSpec         ;0E818F|20C4BD  |0EBDC4;
						LDA.B #$3C                           ;0E8192|A93C    |      ;
						STA.W $05D4                          ;0E8194|8DD405  |0E05D4;
						LDA.B #$28                           ;0E8197|A928    |      ;
						STA.W r_Player_StateDoubled        ;0E8199|8D6505  |0E0565;
						LDA.B #$00                           ;0E819C|A900    |      ;
						STA.W r_stairsStuneTimer           ;0E819E|8DEB05  |0E05EB;
						RTS                                  ;0E81A1|60      |      ;
	
	
			CODE_0E81A2:
						NOP                                  ;0E81A2|EA      |      ;
						LDA.B r_invincableFrames             ;0E81A3|A580    |000080;
						ORA.B r_potionTimer                  ;0E81A5|05AD    |0000AD;
						BNE CODE_0E812B                      ;0E81A7|D082    |0E812B;
						LDA.W r_entity_ID         ;0E81A9|AD4E05  |0E054E;
						ASL A                                ;0E81AC|0A      |      ;
						TAY                                  ;0E81AD|A8      |      ;
						LDA.W PTR16_0E8298,Y                 ;0E81AE|B99882  |0E8298;
						STA.B r_pointerQueue                 ;0E81B1|8508    |000008;
						LDA.W PTR16_0E8298+1,Y                 ;0E81B3|B99982  |0E8299;
						STA.B $09                            ;0E81B6|8509    |000009;
						LDY.B #$00                           ;0E81B8|A000    |      ;
	
			CODE_0E81BA:
						LDA.B (r_pointerQueue),Y             ;0E81BA|B108    |000008;
						BMI CODE_0E8208                      ;0E81BC|304A    |0E8208;
						CMP.W r_Player_StateDoubled        ;0E81BE|CD6505  |0E0565;
						BEQ CODE_0E81C7                      ;0E81C1|F004    |0E81C7;
						INY                                  ;0E81C3|C8      |      ;
						INY                                  ;0E81C4|C8      |      ;
						BNE CODE_0E81BA                      ;0E81C5|D0F3    |0E81BA;
	
			CODE_0E81C7:
						INY                                  ;0E81C7|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0E81C8|B108    |000008;
						BEQ CODE_0E8153                      ;0E81CA|F087    |0E8153;
						JSR.W CODE_0E8263                    ;0E81CC|206382  |0E8263;
						BEQ playerGetHurt                      ;0E81CF|F03A    |0E820B;
						LDY.W r_entity_ID         ;0E81D1|AC4E05  |0E054E;
						LDA.W playerGetHurt_SoundID,Y                 ;0E81D4|B99482  |0E8294;
						jsr lunchMusic                       ;0E81D8|        |0FE25F;
		
						LDA.B #$00                           ;0E81DD|A900    |      ;
						STA.W r_entity_PaletteOverride     ;0E81DF|8D5404  |0E0454;
						LDA.W r_Player_StateDoubled        ;0E81E2|AD6505  |0E0565;
						STA.W $05D4                          ;0E81E5|8DD405  |0E05D4;
						LDA.B #$20                           ;0E81E8|A920    |      ;
						STA.W r_stairsStuneTimer           ;0E81EA|8DEB05  |0E05EB;
						LDA.B #$01                           ;0E81ED|A901    |      ;
						STA.W r_boss_batRiverSwap          ;0E81EF|8D0206  |0E0602;
						LDA.B #$78                           ;0E81F2|A978    |      ;
						STA.B r_invincableFrames             ;0E81F4|8580    |000080;
						LDA.B #$26                           ;0E81F6|A926    |      ;
						STA.W r_Player_StateDoubled        ;0E81F8|8D6505  |0E0565;
						
						JSR.W getSlot13_resetOamSpec         ;0E81DA|20C4BD  |0EBDC4;
						RTS                                  ;0E81FB|60      |      ;
	
				;		LDY.W r_entity_ID         ;0E81FC|AC4E05  |0E054E;		
				;		LDA.W playerGetHurt_SoundID,Y       ; looks like dead code. BUG?!
				;		jsr lunchMusic                      
				;		JMP.W setPlayerDeath                
	
	
			CODE_0E8208:
						JSR.W CODE_0E8263                    ;0E8208|206382  |0E8263;
	
			playerGetHurt:
						LDY.W r_entity_ID         ;0E820B|AC4E05  |0E054E;
						LDA.W playerGetHurt_SoundID,Y                 ;0E820E|B99482  |0E8294;
						jsr lunchMusic                      
						
						LDA.B #$00                           ;0E8217|A900    |      ;
						STA.W r_entity_PaletteOverride     ;0E8219|8D5404  |0E0454;
						LDA.W r_Player_StateDoubled        ;0E821C|AD6505  |0E0565;
						STA.W $05D4                          ;0E821F|8DD405  |0E05D4;
						LDA.B #$20                           ;0E8222|A920    |      ;
						STA.W r_stairsStuneTimer           ;0E8224|8DEB05  |0E05EB;
						LDA.B #$00                           ;0E8227|A900    |      ;
						STA.W r_boss_batRiverSwap          ;0E8229|8D0206  |0E0602;
						LDA.B #$78                           ;0E822C|A978    |      ;
						STA.B r_invincableFrames             ;0E822E|8580    |000080;
						LDA.B #$26                           ;0E8230|A926    |      ;
						STA.W r_Player_StateDoubled        ;0E8232|8D6505  |0E0565;
						LDA.B #$10                           ;0E8235|A910    |      ;
						STA.W r_entity_spriteID          ;0E8237|8D0004  |0E0400;
						LDA.B #$FE                           ;0E823A|A9FE    |      ;
						STA.W r_entity_Yspd                ;0E823C|8D2005  |0E0520;
						
						JSR.W getSlot13_resetOamSpec         ;0E8214|20C4BD  |0EBDC4;
						
						LDA.B #$00                           ;0E823F|A900    |      ;
						STA.W r_entity_YsubSpd             ;0E8241|8D3705  |0E0537;
						LDA.B r_knockBackDirrection          ;0E8244|A590    |000090;
						BEQ CODE_0E8253                      ;0E8246|F00B    |0E8253;
						LDA.B #$01                           ;0E8248|A901    |      ;
						STA.W r_entity_FacingLeft          ;0E824A|8DA804  |0E04A8;
						LDA.B #$01                           ;0E824D|A901    |      ;
						LDY.B #$00                           ;0E824F|A000    |      ;
						BEQ CODE_0E825C                      ;0E8251|F009    |0E825C;
	
			CODE_0E8253:
						LDA.B #$00                           ;0E8253|A900    |      ;
						STA.W r_entity_FacingLeft          ;0E8255|8DA804  |0E04A8;
						LDA.B #$FF                           ;0E8258|A9FF    |      ;
						LDY.B #$00                           ;0E825A|A000    |      ;
	
			CODE_0E825C:
						STA.W r_entity_Xspd                ;0E825C|8DF204  |0E04F2;
						STY.W r_entity_XsubSpd             ;0E825F|8C0905  |0E0509;
						RTS                                  ;0E8262|60      |      ;
	
	
			CODE_0E8263:
						LDA.W r_entity_ID         ;0E8263|AD4E05  |0E054E;
						ASL A                                ;0E8266|0A      |      ;
						TAY                                  ;0E8267|A8      |      ;
						LDA.W PTR16_0E82E4,Y                 ;0E8268|B9E482  |0E82E4;
						STA.B r_pointerQueue                 ;0E826B|8508    |000008;
						LDA.W PTR16_0E82E4+1,Y                 ;0E826D|B9E582  |0E82E5;
						STA.B $09                            ;0E8270|8509    |000009;
						LDA.B r_damagePlayer                 ;0E8272|A581    |000081;
						LSR A                                ;0E8274|4A      |      ;
						LSR A                                ;0E8275|4A      |      ;
						LSR A                                ;0E8276|4A      |      ;
						LSR A                                ;0E8277|4A      |      ;
						CMP.B #$0F                           ;0E8278|C90F    |      ;
						BEQ CODE_0E828E                      ;0E827A|F012    |0E828E;
						TAY                                  ;0E827C|A8      |      ;
						LDA.B (r_pointerQueue),Y             ;0E827D|B108    |000008;
						TAY                                  ;0E827F|A8      |      ;
						LDA.B r_HUD_healthPlayer             ;0E8280|A53C    |00003C;
						SEC                                  ;0E8282|38      |      ;
						SBC.W DATA8_0E830C,Y                 ;0E8283|F90C83  |0E830C;
						BCS CODE_0E828A                      ;0E8286|B002    |0E828A;
						LDA.B #$00                           ;0E8288|A900    |      ;
	
			CODE_0E828A:
						STA.B r_HUD_healthPlayer             ;0E828A|853C    |00003C;
						CLC                                  ;0E828C|18      |      ;
						RTS                                  ;0E828D|60      |      ;
	
	
			CODE_0E828E:
						LDA.B #$00                           ;0E828E|A900    |      ;
						STA.B r_HUD_healthPlayer             ;0E8290|853C    |00003C;
						SEC                                  ;0E8292|38      |      ;
						RTS                                  ;0E8293|60      |      ;
	
	
			playerGetHurt_SoundID:
						db $73,$75,$74,$76                   ;0E8294|        |      ;
	
			PTR16_0E8298:
						dw DATA8_0E82A0                      ;0E8298|        |0E82A0;
						dw DATA8_0E82AF                      ;0E829A|        |0E82AF;
						dw DATA8_0E82BE                      ;0E829C|        |0E82BE;
						dw DATA8_0E82CD                      ;0E829E|        |0E82CD;
	
			DATA8_0E82A0:
						db $10,$01,$12,$01,$14,$01,$1E,$01   ;0E82A0|        |      ;
						db $24,$01,$16,$00,$26,$00,$FF       ;0E82A8|        |      ;
	
			DATA8_0E82AF:
						db $10,$01,$12,$01,$14,$01,$1E,$01   ;0E82AF|        |      ;
						db $24,$01,$16,$00,$26,$00,$FF       ;0E82B7|        |      ;
	
			DATA8_0E82BE:
						db $10,$01,$12,$01,$14,$01,$1E,$01   ;0E82BE|        |      ;
						db $24,$01,$16,$00,$26,$00,$FF       ;0E82C6|        |      ;
	
			DATA8_0E82CD:
						db $10,$01,$12,$01,$14,$01,$1E,$01   ;0E82CD|        |      ;
						db $24,$01,$16,$00,$26,$00,$30,$00   ;0E82D5|        |      ;
						db $32,$00,$3C,$00,$3E,$00,$FF       ;0E82DD|        |      ;
	
			PTR16_0E82E4:
						dw DATA8_0E82EC                      ;0E82E4|        |0E82EC;
						dw DATA8_0E82FC                      ;0E82E6|        |0E82FC;
						dw DATA8_0E82FC                      ;0E82E8|        |0E82FC;
						dw DATA8_0E82EC                      ;0E82EA|        |0E82EC;
	
			DATA8_0E82EC:
						db $00,$01,$02,$03,$04,$05,$06,$07   ;0E82EC|        |      ;
						db $08,$09,$0A,$0B,$0C,$0D,$0E,$0F   ;0E82F4|        |      ;
	
			DATA8_0E82FC:
						db $00,$02,$03,$04,$05,$06,$07,$08   ;0E82FC|        |      ;
						db $09,$0A,$0C,$0C,$0D,$0E,$0F,$0F   ;0E8304|        |      ;
	
			DATA8_0E830C:
						db $00,$08,$0C,$10,$14,$18,$1C,$20   ;0E830C|        |      ;
						db $24,$28,$2C,$30,$34,$38,$3C,$40   ;0E8314|        |      ;
}	


{ ; player routines 
	
	
	player_state26_hit:
						LDA.W r_entity_ID         ;0E831C|AD4E05  |0E054E;
						CMP.B #$03                           ;0E831F|C903    |      ;
						BNE CODE_0E833C                      ;0E8321|D019    |0E833C;
						LDA.B r_HUD_healthPlayer             ;0E8323|A53C    |00003C;
						BEQ playerNotHit                     ;0E8325|F026    |0E834D;
						LDY.B #$00                           ;0E8327|A000    |      ;
	
			CODE_0E8329:
						LDA.W alucardBatStates,Y        ;0E8329|B9A2A6  |0EA6A2;
						BMI CODE_0E833C                      ;0E832C|300E    |0E833C;
						CMP.W $05D4                          ;0E832E|CDD405  |0E05D4;
						BEQ CODE_0E8336                      ;0E8331|F003    |0E8336;
						INY                                  ;0E8333|C8      |      ;
						BNE CODE_0E8329                      ;0E8334|D0F3    |0E8329;
	
			CODE_0E8336:
						LDA.B #$3C                           ;0E8336|A93C    |      ;
						STA.W r_Player_StateDoubled        ;0E8338|8D6505  |0E0565;
						RTS                                  ;0E833B|60      |      ;
	
	
			CODE_0E833C:
						LDA.W r_boss_batRiverSwap          ;0E833C|AD0206  |0E0602;
						BEQ playerNotHit                     ;0E833F|F00C    |0E834D;
						DEC.W r_stairsStuneTimer           ;0E8341|CEEB05  |0E05EB;
						BNE CODE_0E834C                      ;0E8344|D006    |0E834C;
						LDA.W $05D4                          ;0E8346|ADD405  |0E05D4;
						STA.W r_Player_StateDoubled        ;0E8349|8D6505  |0E0565;
	
			CODE_0E834C:
						RTS                                  ;0E834C|60      |      ;
	
	
			playerNotHit:
						LDA.B #$08                           ;0E834D|A908    |      ;
						LDY.W r_entity_Xspd                ;0E834F|ACF204  |0E04F2;
						BPL CODE_0E8356                      ;0E8352|1002    |0E8356;
						LDA.B #$F8                           ;0E8354|A9F8    |      ;
	
			CODE_0E8356:
						STA.B r_pointerQueue                 ;0E8356|8508    |000008;
						LDX.B #$F0                           ;0E8358|A2F0    |      ;
						db $20                               ;0E835A|        |      ;
						dw playerCollusionCheck              ;0E835B|        |0FFCDD;
						BNE CODE_0E8368                      ;0E835D|D009    |0E8368;
						LDA.B r_pointerQueue                 ;0E835F|A508    |000008;
						LDX.B #$00                           ;0E8361|A200    |      ;
						db $20                               ;0E8363|        |      ;
						dw playerCollusionCheck              ;0E8364|        |0FFCDD;
						BEQ CODE_0E836E                      ;0E8366|F006    |0E836E;
	
			CODE_0E8368:
						JSR.W CODE_0E97CF                    ;0E8368|20CF97  |0E97CF;
						JMP.W CODE_0E8371                    ;0E836B|4C7183  |0E8371;
	
	
			CODE_0E836E:
						JSR.W CODE_0E97A1                    ;0E836E|20A197  |0E97A1;
	
			CODE_0E8371:
						LDA.W r_Player_StateDoubled        ;0E8371|AD6505  |0E0565;
						CMP.B #$02                           ;0E8374|C902    |      ;
						BEQ CODE_0E8379                      ;0E8376|F001    |0E8379;
						RTS                                  ;0E8378|60      |      ;
	
	
			CODE_0E8379:
						LDA.B #$00                           ;0E8379|A900    |      ;
						STA.B r_timerClunk_drop              ;0E837B|85B9    |0000B9;
						LDA.W r_entity_ID         ;0E837D|AD4E05  |0E054E;
						CMP.B #$02                           ;0E8380|C902    |      ;
						BNE CODE_0E8393                      ;0E8382|D00F    |0E8393;
						LDA.B r_conveyaerRoomEffect          ;0E8384|A58B    |00008B;
						CMP.B #$01                           ;0E8386|C901    |      ;
						BEQ CODE_0E8393                      ;0E8388|F009    |0E8393;
						LDA.W r_entity_YPos                ;0E838A|AD1C04  |0E041C;
						CLC                                  ;0E838D|18      |      ;
						ADC.B #$04                           ;0E838E|6904    |      ;
						STA.W r_entity_YPos                ;0E8390|8D1C04  |0E041C;
	
			CODE_0E8393:
						LDA.B r_HUD_healthPlayer             ;0E8393|A53C    |00003C;
						BEQ initPlayerDeath                  ;0E8395|F001    |0E8398;
						RTS                                  ;0E8397|60      |      ;
	
	
		initPlayerDeath:
						LDA.B r_deathDelay                   ;0E8398|A5BF    |0000BF;
						BNE CODE_0E83A9                      ;0E839A|D00D    |0E83A9;
						LDA.B #$00                           ;0E839C|A900    |      ;
						STA.B r_HUD_healthPlayer             ;0E839E|853C    |00003C;
						LDA.B #$2E                           ;0E83A0|A92E    |      ;
						STA.W r_Player_StateDoubled        ;0E83A2|8D6505  |0E0565;
						LDA.B #$80                           ;0E83A5|A980    |      ;
						STA.B r_deathDelay                   ;0E83A7|85BF    |0000BF;
	
			CODE_0E83A9:
						RTS                                  ;0E83A9|60      |      ;
	
	
	do_invincableFrames:
						LDA.B r_invincableFrames             ;0E83AA|A580    |000080;
						BNE CODE_0E83BD                      ;0E83AC|D00F    |0E83BD;
						LDX.B #$F8                           ;0E83AE|A2F8    |      ;
						LDA.B #$00                           ;0E83B0|A900    |      ;
						db $20                               ;0E83B2|        |      ;
						dw playerCollusionCheck              ;0E83B3|        |0FFCDD;
						CMP.B #$05                           ;0E83B5|C905    |      ;
						BEQ CODE_0E83BF                      ;0E83B7|F006    |0E83BF;
						CMP.B #$07                           ;0E83B9|C907    |      ;
						BEQ CODE_0E83BF                      ;0E83BB|F002    |0E83BF;
	
			CODE_0E83BD:
						CLC                                  ;0E83BD|18      |      ;
						RTS                                  ;0E83BE|60      |      ;
	
	
			CODE_0E83BF:
						JSR.W player_death_routine           ;0E83BF|20F483  |0E83F4;
						SEC                                  ;0E83C2|38      |      ;
						RTS                                  ;0E83C3|60      |      ;
	
	
			CODE_0E83C4:
						LDA.B r_conveyaerRoomEffect          ;0E83C4|A58B    |00008B;
						CMP.B #$01                           ;0E83C6|C901    |      ;
						BEQ CODE_0E83DD                      ;0E83C8|F013    |0E83DD;
						CMP.B #$05                           ;0E83CA|C905    |      ;
						BEQ CODE_0E83DD                      ;0E83CC|F00F    |0E83DD;
						CMP.B #$06                           ;0E83CE|C906    |      ;
						BEQ CODE_0E83DD                      ;0E83D0|F00B    |0E83DD;
						LDX.B #$0C                           ;0E83D2|A20C    |      ;
						LDA.B #$00                           ;0E83D4|A900    |      ;
						db $20                               ;0E83D6|        |      ;
						dw playerCollusionCheck              ;0E83D7|        |0FFCDD;
						BNE CODE_0E83DD                      ;0E83D9|D002    |0E83DD;
						SEC                                  ;0E83DB|38      |      ;
						RTS                                  ;0E83DC|60      |      ;
	
	
			CODE_0E83DD:
						CLC                                  ;0E83DD|18      |      ;
						RTS                                  ;0E83DE|60      |      ;
	
	
		doCrumbleBlock_00:
						db $20                               ;0E83DF|        |      ;
						dw crumbleBlock                      ;0E83E0|        |0FFBE8;
						LDX.B r_pointerQueue                 ;0E83E2|A608    |000008;
						LDA.B #$FB                           ;0E83E4|A9FB    |      ;
	
		doCrumbleBlock_01:
						db $20                               ;0E83E6|        |      ;
						dw playerCollusionCheck              ;0E83E7|        |0FFCDD;
						CMP.B #$04                           ;0E83E9|C904    |      ;
						BEQ DATA8_0E83EF                     ;0E83EB|F002    |0E83EF;
						SEC                                  ;0E83ED|38      |      ;
						RTS                                  ;0E83EE|60      |      ;
	
	
			DATA8_0E83EF:
						db $20                               ;0E83EF|        |      ;
						dw crumbleBlock                      ;0E83F0|        |0FFBE8;
						SEC                                  ;0E83F2|38      |      ;
						RTS                                  ;0E83F3|60      |      ;
	
	
	player_death_routine:
						LDA.B r_deathDelay                   ;0E83F4|A5BF    |0000BF;
						BNE CODE_0E841C                      ;0E83F6|D024    |0E841C;
						LDA.B #$00                           ;0E83F8|A900    |      ;
						STA.B r_HUD_healthPlayer             ;0E83FA|853C    |00003C;
						JMP.W playerGetHurt                    ;0E83FC|4C0B82  |0E820B;
	
	
			DATA8_0E83FF:
						db $20                               ;0E83FF|        |      ;
						dw playerCollusionCheck              ;0E8400|        |0FFCDD;
						BEQ CODE_0E840A                      ;0E8402|F006    |0E840A;
						CMP.B #$01                           ;0E8404|C901    |      ;
						BEQ CODE_0E840A                      ;0E8406|F002    |0E840A;
						CMP.B #$08                           ;0E8408|C908    |      ;
	
			CODE_0E840A:
						RTS                                  ;0E840A|60      |      ;
	
	
			checkCollusion_CMP_01:
						db $20                               ;0E840B|        |      ;
						dw playerCollusionCheck              ;0E840C|        |0FFCDD;
						BEQ CODE_0E8412                      ;0E840E|F002    |0E8412;
						CMP.B #$01                           ;0E8410|C901    |      ;
	
			CODE_0E8412:
						RTS                                  ;0E8412|60      |      ;
	
	
			CODE_0E8413:
						LDA.B r_invincableFrames             ;0E8413|A580    |000080;
						BNE CODE_0E841C                      ;0E8415|D005    |0E841C;
						JSR.W player_death_routine           ;0E8417|20F483  |0E83F4;
						PLA                                  ;0E841A|68      |      ;
						PLA                                  ;0E841B|68      |      ;
	
			CODE_0E841C:
						RTS                                  ;0E841C|60      |      ;
	
	
			CODE_0E841D:
						LDX.B #$0C                           ;0E841D|A20C    |      ;
						BNE CODE_0E8423                      ;0E841F|D002    |0E8423;
	
		playerCollusion:
						LDX.B #$10                           ;0E8421|A210    |      ;
	
			CODE_0E8423:
						STX.B r_pointerQueue                 ;0E8423|8608    |000008;
						LDA.B r_conveyaerRoomEffect          ;0E8425|A58B    |00008B;
						CMP.B #$01                           ;0E8427|C901    |      ;
						BNE CODE_0E842E                      ;0E8429|D003    |0E842E;
						JMP.W CODE_0E84E0                    ;0E842B|4CE084  |0E84E0;
	
	
			CODE_0E842E:
						CMP.B #$05                           ;0E842E|C905    |      ;
						BNE CODE_0E8435                      ;0E8430|D003    |0E8435;
						JMP.W CODE_0E8513                    ;0E8432|4C1385  |0E8513;
	
	
			CODE_0E8435:
						CMP.B #$06                           ;0E8435|C906    |      ;
						BNE CODE_0E843C                      ;0E8437|D003    |0E843C;
						JMP.W CODE_0E851E                    ;0E8439|4C1E85  |0E851E;
	
	
			CODE_0E843C:
						LDA.B #$05                           ;0E843C|A905    |      ;
						db $20                               ;0E843E|        |      ;
						dw playerCollusionCheck              ;0E843F|        |0FFCDD;
						BEQ CODE_0E8461                      ;0E8441|F01E    |0E8461;
						CMP.B #$01                           ;0E8443|C901    |      ;
						BEQ CODE_0E84C0                      ;0E8445|F079    |0E84C0;
						CMP.B #$02                           ;0E8447|C902    |      ;
						BEQ CODE_0E8490                      ;0E8449|F045    |0E8490;
						CMP.B #$03                           ;0E844B|C903    |      ;
						BEQ CODE_0E84AA                      ;0E844D|F05B    |0E84AA;
						CMP.B #$04                           ;0E844F|C904    |      ;
						BEQ doCrumbleBlock_00                ;0E8451|F08C    |0E83DF;
						CMP.B #$05                           ;0E8453|C905    |      ;
						BEQ CODE_0E8413                      ;0E8455|F0BC    |0E8413;
						CMP.B #$07                           ;0E8457|C907    |      ;
						BEQ CODE_0E8413                      ;0E8459|F0B8    |0E8413;
						CMP.B #$0C                           ;0E845B|C90C    |      ;
						BCS doCrumbleBlock_00                ;0E845D|B080    |0E83DF;
						BCC CODE_0E848C                      ;0E845F|902B    |0E848C;
	
			CODE_0E8461:
						LDX.B r_pointerQueue                 ;0E8461|A608    |000008;
						LDA.B #$FB                           ;0E8463|A9FB    |      ;
						db $20                               ;0E8465|        |      ;
						dw playerCollusionCheck              ;0E8466|        |0FFCDD;
						BEQ CODE_0E848E                      ;0E8468|F024    |0E848E;
						CMP.B #$01                           ;0E846A|C901    |      ;
						BEQ CODE_0E84C9                      ;0E846C|F05B    |0E84C9;
						CMP.B #$02                           ;0E846E|C902    |      ;
						BEQ CODE_0E8490                      ;0E8470|F01E    |0E8490;
						CMP.B #$03                           ;0E8472|C903    |      ;
						BEQ CODE_0E84AA                      ;0E8474|F034    |0E84AA;
						CMP.B #$04                           ;0E8476|C904    |      ;
						BNE CODE_0E847D                      ;0E8478|D003    |0E847D;
						JMP.W DATA8_0E83EF                   ;0E847A|4CEF83  |0E83EF;
	
	
			CODE_0E847D:
						CMP.B #$05                           ;0E847D|C905    |      ;
						BEQ CODE_0E8413                      ;0E847F|F092    |0E8413;
						CMP.B #$07                           ;0E8481|C907    |      ;
						BEQ CODE_0E8413                      ;0E8483|F08E    |0E8413;
						CMP.B #$0C                           ;0E8485|C90C    |      ;
						BCC CODE_0E848C                      ;0E8487|9003    |0E848C;
						JMP.W DATA8_0E83EF                   ;0E8489|4CEF83  |0E83EF;
	
	
			CODE_0E848C:
						SEC                                  ;0E848C|38      |      ;
						RTS                                  ;0E848D|60      |      ;
	
	
			CODE_0E848E:
						CLC                                  ;0E848E|18      |      ;
						RTS                                  ;0E848F|60      |      ;
	
	
			CODE_0E8490:
						LDA.B r_gameTransition               ;0E8490|A52A    |00002A;
						CMP.B #$1B                           ;0E8492|C91B    |      ;
						BNE CODE_0E849A                      ;0E8494|D004    |0E849A;
						LDA.B #$00                           ;0E8496|A900    |      ;
						BEQ CODE_0E84A6                      ;0E8498|F00C    |0E84A6;
	
			CODE_0E849A:
						LDA.B r_conveyaerRoomEffect          ;0E849A|A58B    |00008B;
						CMP.B #$08                           ;0E849C|C908    |      ;
						BNE CODE_0E84A4                      ;0E849E|D004    |0E84A4;
						LDA.B #$09                           ;0E84A0|A909    |      ;
						BNE CODE_0E84A6                      ;0E84A2|D002    |0E84A6;
	
			CODE_0E84A4:
						LDA.B #$0B                           ;0E84A4|A90B    |      ;
	
			CODE_0E84A6:
						STA.B r_conveyaerRoomEffect          ;0E84A6|858B    |00008B;
						SEC                                  ;0E84A8|38      |      ;
						RTS                                  ;0E84A9|60      |      ;
	
	
			CODE_0E84AA:
						LDA.B r_gameTransition               ;0E84AA|A52A    |00002A;
						CMP.B #$1B                           ;0E84AC|C91B    |      ;
						BNE CODE_0E84B4                      ;0E84AE|D004    |0E84B4;
						LDA.B #$00                           ;0E84B0|A900    |      ;
						BEQ CODE_0E84A6                      ;0E84B2|F0F2    |0E84A6;
	
			CODE_0E84B4:
						LDA.B r_conveyaerRoomEffect          ;0E84B4|A58B    |00008B;
						CMP.B #$08                           ;0E84B6|C908    |      ;
						BEQ CODE_0E84BE                      ;0E84B8|F004    |0E84BE;
						LDA.B #$0A                           ;0E84BA|A90A    |      ;
						STA.B r_conveyaerRoomEffect          ;0E84BC|858B    |00008B;
	
			CODE_0E84BE:
						SEC                                  ;0E84BE|38      |      ;
						RTS                                  ;0E84BF|60      |      ;
	
	
			CODE_0E84C0:
						LDX.B r_pointerQueue                 ;0E84C0|A608    |000008;
						LDA.B #$FB                           ;0E84C2|A9FB    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E84C4|200B84  |0E840B;
						BNE CODE_0E848C                      ;0E84C7|D0C3    |0E848C;
	
			CODE_0E84C9:
						LDA.B #$07                           ;0E84C9|A907    |      ;
						STA.B r_conveyaerRoomEffect          ;0E84CB|858B    |00008B;
						LDA.W r_entity_FractionalY         ;0E84CD|ADDB04  |0E04DB;
						CLC                                  ;0E84D0|18      |      ;
						ADC.B #$40                           ;0E84D1|6940    |      ;
						STA.W r_entity_FractionalY         ;0E84D3|8DDB04  |0E04DB;
						LDA.W r_entity_YPos                ;0E84D6|AD1C04  |0E041C;
						ADC.B #$00                           ;0E84D9|6900    |      ;
						STA.W r_entity_YPos                ;0E84DB|8D1C04  |0E041C;
						SEC                                  ;0E84DE|38      |      ;
						RTS                                  ;0E84DF|60      |      ;
	
	
			CODE_0E84E0:
						LDX.B r_pointerQueue                 ;0E84E0|A608    |000008;
						LDA.B #$05                           ;0E84E2|A905    |      ;
						db $20                               ;0E84E4|        |      ;
						dw playerCollusionCheck              ;0E84E5|        |0FFCDD;
						BNE CODE_0E84F9                      ;0E84E7|D010    |0E84F9;
						LDX.B r_pointerQueue                 ;0E84E9|A608    |000008;
						LDA.B #$FB                           ;0E84EB|A9FB    |      ;
						db $20                               ;0E84ED|        |      ;
						dw playerCollusionCheck              ;0E84EE|        |0FFCDD;
						BNE CODE_0E84F9                      ;0E84F0|D007    |0E84F9;
						LDX.B r_ConveyorRelated              ;0E84F2|A691    |000091;
						db $20                               ;0E84F4|        |      ;
						dw CODE_0FFE9C                       ;0E84F5|        |0FFE9C;
	
			CODE_0E84F7:
						SEC                                  ;0E84F7|38      |      ;
						RTS                                  ;0E84F8|60      |      ;
	
	
			CODE_0E84F9:
						LDA.B #$00                           ;0E84F9|A900    |      ;
						STA.B r_conveyaerRoomEffect          ;0E84FB|858B    |00008B;
						JSR.W CODE_0E8A02                    ;0E84FD|20028A  |0E8A02;
						LDY.W r_entity_ID         ;0E8500|AC4E05  |0E054E;
						CPY.B #$02                           ;0E8503|C002    |      ;
						BNE CODE_0E84F7                      ;0E8505|D0F0    |0E84F7;
						LDA.W r_entity_YPos                ;0E8507|AD1C04  |0E041C;
						CLC                                  ;0E850A|18      |      ;
						ADC.B #$04                           ;0E850B|6904    |      ;
						STA.W r_entity_YPos                ;0E850D|8D1C04  |0E041C;
						JMP.W CODE_0E84F7                    ;0E8510|4CF784  |0E84F7;
	
	
			CODE_0E8513:
						LDA.W r_entity_YPos                ;0E8513|AD1C04  |0E041C;
						CLC                                  ;0E8516|18      |      ;
						ADC.B r_ConveyorRelated              ;0E8517|6591    |000091;
						STA.W r_entity_YPos                ;0E8519|8D1C04  |0E041C;
						SEC                                  ;0E851C|38      |      ;
						RTS                                  ;0E851D|60      |      ;
	
	
			CODE_0E851E:
						LDA.W r_entity_YPos                ;0E851E|AD1C04  |0E041C;
						CLC                                  ;0E8521|18      |      ;
						ADC.B r_ConveyorRelated              ;0E8522|6591    |000091;
						STA.W r_entity_YPos                ;0E8524|8D1C04  |0E041C;
						SEC                                  ;0E8527|38      |      ;
						RTS                                  ;0E8528|60      |      ;
	
	

	
	mainAutoPlayProcess:
						LDA.B r_roomOrientation              ;0E8570|A568    |000068;
						CMP.B #$82                           ;0E8572|C982    |      ;
						BCS CODE_0E8577                      ;0E8574|B001    |0E8577;
						RTS                                  ;0E8576|60      |      ;
	
	
			CODE_0E8577:
						LDA.W r_entity_YPos                ;0E8577|AD1C04  |0E041C;
						CLC                                  ;0E857A|18      |      ;
						ADC.B r_scrollSpd                    ;0E857B|656E    |00006E;
						STA.W r_entity_YPos                ;0E857D|8D1C04  |0E041C;
						LDA.B r_GrantCurrentYpos             ;0E8580|A5D3    |0000D3;
						CLC                                  ;0E8582|18      |      ;
						ADC.B r_scrollSpd                    ;0E8583|656E    |00006E;
						STA.B r_GrantCurrentYpos             ;0E8585|85D3    |0000D3;
						RTS                                  ;0E8587|60      |      ;
; ----------------------------------------------	
	




;
; transit 0 1 2 
; --------------------------------------------	
	
			CODE_0E86B5:
						LDA.B r_roomOrientation              ;0E86B5|A568    |000068;
						AND.B #$01                           ;0E86B7|2901    |      ;
						BEQ CODE_0E86C3                      ;0E86B9|F008    |0E86C3;
						LDA.B r_sceneScrollOffsetHi          ;0E86BB|A557    |000057;
						ORA.B r_sceneScrollOffsetLo          ;0E86BD|0556    |000056;
						BEQ CODE_0E86D6                      ;0E86BF|F015    |0E86D6;
						BNE CODE_0E86CF                      ;0E86C1|D00C    |0E86CF;
	
			CODE_0E86C3:
						LDA.B r_sceneScrollOffsetHi          ;0E86C3|A557    |000057;
						CMP.B r_scroolLock                   ;0E86C5|C571    |000071;
						BNE CODE_0E86CF                      ;0E86C7|D006    |0E86CF;
						LDA.B r_sceneScrollOffsetLo          ;0E86C9|A556    |000056;
						CMP.B #$30                           ;0E86CB|C930    |      ;
						BEQ CODE_0E86D6                      ;0E86CD|F007    |0E86D6;
	
			CODE_0E86CF:
						JMP.W CODE_0E8716                    ;0E86CF|4C1687  |0E8716;
	
	
	roomVerticleChecks:
						CMP.B #$82                           ;0E86D2|C982    |      ;
						BCS CODE_0E86B5                      ;0E86D4|B0DF    |0E86B5;
	
			CODE_0E86D6:
						LDA.W r_entity_Yspd                ;0E86D6|AD2005  |0E0520;
						BMI CODE_0E86FC                      ;0E86D9|3021    |0E86FC;
						ORA.W r_entity_YsubSpd             ;0E86DB|0D3705  |0E0537;
						BEQ CODE_0E8711                      ;0E86DE|F031    |0E8711;
						LDA.B r_roomOrientation              ;0E86E0|A568    |000068;
						AND.B #$01                           ;0E86E2|2901    |      ;
						BEQ CODE_0E8716                      ;0E86E4|F030    |0E8716;
						LDA.W r_entity_YPos                ;0E86E6|AD1C04  |0E041C;
						BPL CODE_0E8716                      ;0E86E9|102B    |0E8716;
						LDA.B r_scroolLock                   ;0E86EB|A571    |000071;
						CMP.B r_sceneScrollOffsetHi          ;0E86ED|C557    |000057;
						BNE CODE_0E86F7                      ;0E86EF|D006    |0E86F7;
						LDA.B r_sceneScrollOffsetLo          ;0E86F1|A556    |000056;
						CMP.B #$30                           ;0E86F3|C930    |      ;
						BEQ CODE_0E8716                      ;0E86F5|F01F    |0E8716;
	
			CODE_0E86F7:
						LDA.B #$01                           ;0E86F7|A901    |      ;
						STA.B r_scrollDirection              ;0E86F9|8565    |000065;
						RTS                                  ;0E86FB|60      |      ;
	
	
			CODE_0E86FC:
						LDA.B r_roomOrientation              ;0E86FC|A568    |000068;
						AND.B #$01                           ;0E86FE|2901    |      ;
						BNE CODE_0E8716                      ;0E8700|D014    |0E8716;
						LDA.W r_entity_YPos                ;0E8702|AD1C04  |0E041C;
						BMI CODE_0E8716                      ;0E8705|300F    |0E8716;
						LDA.B r_sceneScrollOffsetLo          ;0E8707|A556    |000056;
						ORA.B r_sceneScrollOffsetHi          ;0E8709|0557    |000057;
						BEQ CODE_0E8716                      ;0E870B|F009    |0E8716;
						LDA.B #$00                           ;0E870D|A900    |      ;
						STA.B r_scrollDirection              ;0E870F|8565    |000065;
	
			CODE_0E8711:
						RTS                                  ;0E8711|60      |      ;
	
	
		updateSpeed2Pos:
						LDA.B r_roomOrientation              ;0E8712|A568    |000068;
						BMI roomVerticleChecks               ;0E8714|30BC    |0E86D2;
	
			CODE_0E8716:
						LDA.W r_entity_FractionalY         ;0E8716|ADDB04  |0E04DB;
						CLC                                  ;0E8719|18      |      ;
						ADC.W r_entity_YsubSpd             ;0E871A|6D3705  |0E0537;
						STA.W r_entity_FractionalY         ;0E871D|8DDB04  |0E04DB;
						LDA.W r_entity_YPos                ;0E8720|AD1C04  |0E041C;
						ADC.W r_entity_Yspd                ;0E8723|6D2005  |0E0520;
						STA.W r_entity_YPos                ;0E8726|8D1C04  |0E041C;
	
			someRTS_77:
						RTS                                  ;0E8729|60      |      ;
	
	
			CODE_0E872A:
						LDY.W r_entity_Xspd                ;0E872A|ACF204  |0E04F2;
						BPL CODE_0E8734                      ;0E872D|1005    |0E8734;
						LDA.B r_knockBackDirrection          ;0E872F|A590    |000090;
						BEQ CODE_0E8740                      ;0E8731|F00D    |0E8740;
	
			CODE_0E8733:
						RTS                                  ;0E8733|60      |      ;
	
	
			CODE_0E8734:
						LDA.B r_knockBackDirrection          ;0E8734|A590    |000090;
						BEQ CODE_0E8733                      ;0E8736|F0FB    |0E8733;
						BNE CODE_0E8740                      ;0E8738|D006    |0E8740;
	
	playerKnockback_01:
						LDA.B r_conveyaerRoomEffect          ;0E873A|A58B    |00008B;
						CMP.B #$02                           ;0E873C|C902    |      ;
						BEQ CODE_0E872A                      ;0E873E|F0EA    |0E872A;
	
			CODE_0E8740:
						LDA.B r_bossActiveFlag               ;0E8740|A578    |000078;
						BNE stopScroll_if_boss_87            ;0E8742|D01E    |0E8762;
						if !cv3HorizontalAutoscroll == 1
						JMP.W cv3_horizontal_player_camera   ;0E8744|4C      |      ;
						NOP                                  ;0E8747|EA      |      ;
						else
						LDA.B r_roomOrientation              ;0E8744|A568    |000068;
						BMI stopScroll_if_boss_87            ;0E8746|301A    |0E8762;
						endif

			cv3_horizontal_native_player_scroll_check:
						LDA.W r_entity_Xspd                ;0E8748|ADF204  |0E04F2;
						BMI CODE_0E8782                      ;0E874B|3035    |0E8782;
						ORA.W r_entity_XsubSpd             ;0E874D|0D0905  |0E0509;
						BEQ CODE_0E8781                      ;0E8750|F02F    |0E8781;
						LDA.B r_scroolLock                   ;0E8752|A571    |000071;
						CMP.B r_sceneScrollOffsetHi          ;0E8754|C557    |000057;
						BEQ stopScroll_if_boss_87            ;0E8756|F00A    |0E8762;
						LDA.W r_entity_XPos                ;0E8758|AD3804  |0E0438;
						BPL stopScroll_if_boss_87            ;0E875B|1005    |0E8762;
						LDA.B #$01                           ;0E875D|A901    |      ;
						STA.B r_scrollDirection              ;0E875F|8565    |000065;
	
				someRTS:
						RTS                                  ;0E8761|60      |      ;
	
	
	stopScroll_if_boss_87:
						LDA.W r_entity_FractionalX         ;0E8762|ADC404  |0E04C4;
						CLC                                  ;0E8765|18      |      ;
						ADC.W r_entity_XsubSpd             ;0E8766|6D0905  |0E0509;
						STA.W r_entity_FractionalX         ;0E8769|8DC404  |0E04C4;
						LDA.W r_entity_XPos                ;0E876C|AD3804  |0E0438;
						ADC.W r_entity_Xspd                ;0E876F|6DF204  |0E04F2;
						STA.W r_entity_XPos                ;0E8772|8D3804  |0E0438;
						LDY.B r_roomOrientation              ;0E8775|A468    |000068;
						BMI CODE_0E87A2                      ;0E8777|3029    |0E87A2;
						CMP.B #$18                           ;0E8779|C918    |      ;
						BCC CODE_0E8797                      ;0E877B|901A    |0E8797;
						CMP.B #$E9                           ;0E877D|C9E9    |      ;
						BCS CODE_0E879B                      ;0E877F|B01A    |0E879B;
	
			CODE_0E8781:
						RTS                                  ;0E8781|60      |      ;
	
	
			CODE_0E8782:
						LDA.B r_horizontalScrollLockBridge   ;0E8782|A5C8    |0000C8;
						BNE stopScroll_if_boss_87            ;0E8784|D0DC    |0E8762;
						LDA.B r_sceneScrollOffsetLo          ;0E8786|A556    |000056;
						ORA.B r_sceneScrollOffsetHi          ;0E8788|0557    |000057;
						BEQ stopScroll_if_boss_87            ;0E878A|F0D6    |0E8762;
						LDY.W r_entity_XPos                ;0E878C|AC3804  |0E0438;
						DEY                                  ;0E878F|88      |      ;
						BMI stopScroll_if_boss_87            ;0E8790|30D0    |0E8762;
						LDA.B #$00                           ;0E8792|A900    |      ;
						STA.B r_scrollDirection              ;0E8794|8565    |000065;
						RTS                                  ;0E8796|60      |      ;
	
	
			CODE_0E8797:
						LDX.B #$00                           ;0E8797|A200    |      ;
						BEQ DATA8_0E879D                     ;0E8799|F002    |0E879D;
	
			CODE_0E879B:
						LDX.B #$01                           ;0E879B|A201    |      ;
	
			DATA8_0E879D:
						db $20                               ;0E879D|        |      ;
						dw CODE_0FE69A                       ;0E879E|        |0FE69A;
						BCS CODE_0E87D2                      ;0E87A0|B030    |0E87D2;
	
			CODE_0E87A2:
						LDA.W r_entity_XPos                ;0E87A2|AD3804  |0E0438;
						CMP.B #$10                           ;0E87A5|C910    |      ;
						BCC CODE_0E87B3                      ;0E87A7|900A    |0E87B3;
						CMP.B #$F0                           ;0E87A9|C9F0    |      ;
						BCC CODE_0E87D1                      ;0E87AB|9024    |0E87D1;
						LDX.B #$01                           ;0E87AD|A201    |      ;
						LDA.B #$F0                           ;0E87AF|A9F0    |      ;
						BNE CODE_0E87B7                      ;0E87B1|D004    |0E87B7;
	
			CODE_0E87B3:
						LDX.B #$00                           ;0E87B3|A200    |      ;
						LDA.B #$10                           ;0E87B5|A910    |      ;
	
			CODE_0E87B7:
						STA.W r_entity_XPos                ;0E87B7|8D3804  |0E0438;
						LDA.W r_entity_ID         ;0E87BA|AD4E05  |0E054E;
						CMP.B #$03                           ;0E87BD|C903    |      ;
						BNE CODE_0E87D1                      ;0E87BF|D010    |0E87D1;
						LDA.W r_Player_StateDoubled        ;0E87C1|AD6505  |0E0565;
						CMP.B #$34                           ;0E87C4|C934    |      ;
						BNE CODE_0E87D1                      ;0E87C6|D009    |0E87D1;
						LDA.B #$36                           ;0E87C8|A936    |      ;
						STA.W r_Player_StateDoubled        ;0E87CA|8D6505  |0E0565;
						STX.W r_entity_extra               ;0E87CD|8ED805  |0E05D8;
						RTS                                  ;0E87D0|60      |      ;
	
	
			CODE_0E87D1:
						RTS                                  ;0E87D1|60      |      ;
	
	
			CODE_0E87D2:
						CPX.B #$00                           ;0E87D2|E000    |      ;
						BEQ CODE_0E87DA                      ;0E87D4|F004    |0E87DA;
						LDA.B #$E9                           ;0E87D6|A9E9    |      ;
						BNE CODE_0E87DC                      ;0E87D8|D002    |0E87DC;
	
			CODE_0E87DA:
						LDA.B #$17                           ;0E87DA|A917    |      ;
	
			CODE_0E87DC:
						STA.W r_entity_XPos                ;0E87DC|8D3804  |0E0438;
						RTS                                  ;0E87DF|60      |      ;
	
	
				cog_data:
						dw cog_data_small                    ;0E87E0|        |0E8825;
						dw cog_data_large                    ;0E87E2|        |0E87E4;
	
		cog_data_large:
						db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ;0E87E4|        |      ;
						db $FC,$FC,$FC,$FC,$FC,$FC,$F8,$F8   ;0E87EC|        |      ;
						db $F8,$F8,$F4,$F4,$F4,$F0,$F0,$F0   ;0E87F4|        |      ;
						db $EC,$EC,$E8,$E8,$E8,$E4,$E4,$E0   ;0E87FC|        |      ;
						db $DC,$DC,$D8,$D8,$D4,$D0,$CC,$CC   ;0E8804|        |      ;
						db $C8,$C4,$C0,$BC,$B8,$B8,$B0,$AC   ;0E880C|        |      ;
						db $A8,$A4,$A0,$9C,$94,$90,$88,$84   ;0E8814|        |      ;
						db $7C,$74,$6C,$64,$58,$4C,$40,$2C   ;0E881C|        |      ;
						db $00                               ;0E8824|        |      ;
	
		cog_data_small:
						db $FF,$FF,$FF,$FE,$FD,$FC,$FA,$F9   ;0E8825|        |      ;
						db $F7,$F5,$F2,$F0,$EC,$E9,$E5,$E1   ;0E882D|        |      ;
						db $DD,$D8,$D3,$CD,$C7,$C1,$B9,$B1   ;0E8835|        |      ;
						db $A9,$9F,$95,$89,$7B,$6C,$59,$40   ;0E883D|        |      ;
						db $00                               ;0E8845|        |      ;
	
		cogMovmentData:
						dw cogMovmentData_00                 ;0E8846|        |0E884E;
	
			PTR16_0E8848:
						dw cogMovmentData_01                 ;0E8848|        |0E886F;
						dw cogMovmentData_02                 ;0E884A|        |0E8890;
						dw cogMovmentData_03                 ;0E884C|        |0E88D1;
	
		cogMovmentData_00:
						db $00,$08,$10,$18,$20,$28,$2F,$37   ;0E884E|        |      ;
						db $3E,$45,$4C,$53,$59,$5F,$65,$6A   ;0E8856|        |      ;
						db $6F,$73,$77,$7A,$7D,$7F,$80,$80   ;0E885E|        |      ;
						db $7F,$7D,$79,$74,$6C,$62,$54,$3E   ;0E8866|        |      ;
						db $00                               ;0E886E|        |      ;
	
		cogMovmentData_01:
						db $00,$00,$01,$02,$04,$06,$09,$0C   ;0E886F|        |      ;
						db $10,$14,$19,$1E,$24,$2A,$31,$38   ;0E8877|        |      ;
						db $40,$48,$51,$5A,$64,$6E,$79,$84   ;0E887F|        |      ;
	
						db $90,$9C,$A9,$B6,$C4,$D2,$E1,$F0   ;0E8887|        |      ;
						db $FF                               ;0E888F|        |      ;
	
		cogMovmentData_02:
						db $00,$06,$0C,$12,$18,$1E,$24,$2A   ;0E8890|        |      ;
						db $30,$35,$3B,$41,$47,$4C,$52,$57   ;0E8898|        |      ;
						db $5D,$62,$68,$6D,$72,$77,$7C,$81   ;0E88A0|        |      ;
						db $85,$8A,$8F,$93,$97,$9B,$9F,$A3   ;0E88A8|        |      ;
						db $A6,$AA,$AD,$B0,$B3,$B5,$B7,$BA   ;0E88B0|        |      ;
						db $BB,$BD,$BE,$BF,$C0,$C0,$C0,$BF   ;0E88B8|        |      ;
						db $BE,$BD,$BB,$B9,$B6,$B2,$AE,$A9   ;0E88C0|        |      ;
						db $A3,$9C,$93,$89,$7D,$6F,$5C,$43   ;0E88C8|        |      ;
						db $00                               ;0E88D0|        |      ;
	
		cogMovmentData_03:
						db $00,$00,$00,$01,$02,$02,$03,$05   ;0E88D1|        |      ;
						db $06,$08,$09,$0B,$0E,$10,$12,$15   ;0E88D9|        |      ;
						db $18,$1B,$1E,$22,$26,$29,$2D,$32   ;0E88E1|        |      ;
						db $36,$3B,$3F,$44,$4A,$4F,$54,$5A   ;0E88E9|        |      ;
						db $60,$66,$6C,$73,$7A,$80,$87,$8F   ;0E88F1|        |      ;
						db $96,$9E,$A5,$AD,$B6,$BE,$C6,$CF   ;0E88F9|        |      ;
						db $D8,$E1,$EA,$F4,$FE,$FF,$FF,$FF   ;0E8901|        |      ;
						db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ;0E8909|        |      ;
						db $FF                               ;0E8911|        |      ;
	
			DATA8_0E8912:
						db $00                               ;0E8912|        |      ;
	
			DATA8_0E8913:
						db $01,$00,$01,$10,$01,$20,$01,$20   ;0E8913|        |      ;
						db $01,$30,$01,$40,$01,$40,$01,$50   ;0E891B|        |      ;
						db $01,$60,$01,$70,$01,$70,$01,$80   ;0E8923|        |      ;
						db $01                               ;0E892B|        |      ;
	
			DATA8_0E892C:
						db $00,$04,$08,$0C,$10,$14,$18,$1C   ;0E892C|        |      ;
						db $20,$24,$28,$2C,$30,$34,$38,$3C   ;0E8934|        |      ;
						db $40,$44,$48,$4C,$50,$54,$58,$5C   ;0E893C|        |      ;
						db $60,$64,$68,$6C,$70,$74,$78,$7C   ;0E8944|        |      ;
						db $80                               ;0E894C|        |      ;
	
			DATA8_0E894D:
						db $00,$00,$00,$01,$02,$02,$04,$05   ;0E894D|        |      ;
						db $06,$08,$0A,$0C,$0F,$11,$14,$17   ;0E8955|        |      ;
						db $1B,$1E,$22,$26,$2B,$30,$35,$3A   ;0E895D|        |      ;
						db $40,$47,$4D,$54,$5C,$64,$6D,$76   ;0E8965|        |      ;
	
						db $80                               ;0E896D|        |      ;
	
	

if !removeTimer == 1	  
	
else		
	
		lvlTimerRoutine:
						LDA.B r_lvlTimerLo                   ;0E8996|A57E    |00007E;
						ORA.B r_lvlTimerHi                   ;0E8998|057F    |00007F;
						BNE mainlLvLTimerUpdate              ;0E899A|D007    |0E89A3;
						JSR.W initPlayerDeath                ;0E899C|209883  |0E8398;
						JSR.W getSlot13_resetOamSpec         ;0E899F|20C4BD  |0EBDC4;
						RTS                                  ;0E89A2|60      |      ;
	
	
	mainlLvLTimerUpdate:
						LDA.B r_lvlTimerLo                   ;0E89A3|A57E    |00007E;
						AND.B #$0F                           ;0E89A5|290F    |      ;
						STA.B $01                            ;0E89A7|8501    |000001;
						LDA.B r_lvlTimerLo                   ;0E89A9|A57E    |00007E;
						AND.B #$F0                           ;0E89AB|29F0    |      ;
						STA.B $02                            ;0E89AD|8502    |000002;
						LDA.B r_lvlTimerHi                   ;0E89AF|A57F    |00007F;
						AND.B #$0F                           ;0E89B1|290F    |      ;
						STA.B $03                            ;0E89B3|8503    |000003;
						LDA.B r_lvlTimerHi                   ;0E89B5|A57F    |00007F;
						AND.B #$F0                           ;0E89B7|29F0    |      ;
						STA.B $04                            ;0E89B9|8504    |000004;
						JSR.W lvlCountDownDecimal            ;0E89BB|20CF89  |0E89CF;
						LDA.B $01                            ;0E89BE|A501    |000001;
						AND.B #$0F                           ;0E89C0|290F    |      ;
						ORA.B $02                            ;0E89C2|0502    |000002;
						STA.B r_lvlTimerLo                   ;0E89C4|857E    |00007E;
						LDA.B $03                            ;0E89C6|A503    |000003;
						AND.B #$0F                           ;0E89C8|290F    |      ;
						ORA.B $04                            ;0E89CA|0504    |000004;
						STA.B r_lvlTimerHi                   ;0E89CC|857F    |00007F;
						RTS                                  ;0E89CE|60      |      ;
	
	
	lvlCountDownDecimal:
						LDA.B $01                            ;0E89CF|A501    |000001;
						SEC                                  ;0E89D1|38      |      ;
						SBC.B #$01                           ;0E89D2|E901    |      ;
						STA.B $01                            ;0E89D4|8501    |000001;
						BCS CODE_0E89E6                      ;0E89D6|B00E    |0E89E6;
						SEC                                  ;0E89D8|38      |      ;
						SBC.B #$06                           ;0E89D9|E906    |      ;
						STA.B $01                            ;0E89DB|8501    |000001;
						LDA.B $02                            ;0E89DD|A502    |000002;
						SEC                                  ;0E89DF|38      |      ;
						SBC.B #$10                           ;0E89E0|E910    |      ;
						STA.B $02                            ;0E89E2|8502    |000002;
						BCC CODE_0E89E7                      ;0E89E4|9001    |0E89E7;
	
			CODE_0E89E6:
						RTS                                  ;0E89E6|60      |      ;
	
	
			CODE_0E89E7:
						SEC                                  ;0E89E7|38      |      ;
						SBC.B #$60                           ;0E89E8|E960    |      ;
						STA.B $02                            ;0E89EA|8502    |000002;
						LDA.B $03                            ;0E89EC|A503    |000003;
						SEC                                  ;0E89EE|38      |      ;
						SBC.B #$01                           ;0E89EF|E901    |      ;
						STA.B $03                            ;0E89F1|8503    |000003;
						BCS CODE_0E89E6                      ;0E89F3|B0F1    |0E89E6;
						SEC                                  ;0E89F5|38      |      ;
						SBC.B #$06                           ;0E89F6|E906    |      ;
						STA.B $03                            ;0E89F8|8503    |000003;
						LDA.B $04                            ;0E89FA|A504    |000004;
						SEC                                  ;0E89FC|38      |      ;
						SBC.B #$10                           ;0E89FD|E910    |      ;
						STA.B $04                            ;0E89FF|8504    |000004;
						RTS                                  ;0E8A01|60      |      ;
endif 	

	
			CODE_0E8A02:
						LDA.B r_roomOrientation              ;0E8A02|A568    |000068;
						BMI CODE_0E8A0F                      ;0E8A04|3009    |0E8A0F;
						LDA.W r_entity_YPos                ;0E8A06|AD1C04  |0E041C;
						AND.B #$F0                           ;0E8A09|29F0    |      ;
						STA.W r_entity_YPos                ;0E8A0B|8D1C04  |0E041C;
						RTS                                  ;0E8A0E|60      |      ;
	
	
			CODE_0E8A0F:
						CLC                                  ;0E8A0F|18      |      ;
						LDA.W r_entity_YPos                ;0E8A10|AD1C04  |0E041C;
						ADC.B r_sceneScrollOffsetLo          ;0E8A13|6556    |000056;
						AND.B #$F0                           ;0E8A15|29F0    |      ;
						SEC                                  ;0E8A17|38      |      ;
						SBC.B r_sceneScrollOffsetLo          ;0E8A18|E556    |000056;
						CLC                                  ;0E8A1A|18      |      ;
						ADC.B #$03                           ;0E8A1B|6903    |      ;
						STA.W r_entity_YPos                ;0E8A1D|8D1C04  |0E041C;
	
			CODE_0E8A20:
						RTS                                  ;0E8A20|60      |      ;
	
	
		player_processing:
						
if !removeTimer == 1			   
					   
else 						
						
						LDA.B r_lvlTimerHi                   ;0E8A21|A57F    |00007F; ??
						BNE lvlTimerCountDown                ;0E8A23|D011    |0E8A36;
						LDA.B r_lvlTimerLo                   ;0E8A25|A57E    |00007E;
						CMP.B #$20                           ;0E8A27|C920    |      ;
						BCS lvlTimerCountDown                ;0E8A29|B00B    |0E8A36;
						LDA.B r_frameCount         ;0E8A2B|A51A    |00001A;
						AND.B #$3F                           ;0E8A2D|293F    |      ;
						BNE lvlTimerCountDown                ;0E8A2F|D005    |0E8A36;
						LDA.B #$49                           ;0E8A31|A949    |      ;
						db $20                               ;0E8A33|        |      ;
						dw lunchMusic                        ;0E8A34|        |0FE25F;
	
		lvlTimerCountDown:
						LDA.B r_frameCount         ;0E8A36|A51A    |00001A;
						AND.B #$3F                           ;0E8A38|293F    |      ;
						BNE stopWatchCountDown               ;0E8A3A|D003    |0E8A3F;
						JSR.W lvlTimerRoutine                ;0E8A3C|209689  |0E8996;
endif 

	
	stopWatchCountDown:
						LDA.B r_stopWatchActive              ;0E8A3F|A5AB    |0000AB;
						BEQ generelPlayerChecks              ;0E8A41|F016    |0E8A59;
						DEC.B r_stopWatchTimer               ;0E8A43|C6AC    |0000AC;
						BNE CODE_0E8A4E                      ;0E8A45|D007    |0E8A4E;
						LDA.B #$00                           ;0E8A47|A900    |      ;
						STA.B r_stopWatchActive              ;0E8A49|85AB    |0000AB;
						STA.W r_sound_musicStop            ;0E8A4B|8DC906  |0E06C9;
	
			CODE_0E8A4E:
						LDA.B r_stopWatchTimer               ;0E8A4E|A5AC    |0000AC;
						AND.B #$3F                           ;0E8A50|293F    |      ;
						BNE generelPlayerChecks              ;0E8A52|D005    |0E8A59;
						LDA.B #$3C                           ;0E8A54|A93C    |      ;
						db $20                               ;0E8A56|        |      ;
						dw lunchMusic                        ;0E8A57|        |0FE25F;
	
	generelPlayerChecks:
						JSR.W CODE_0EAE52                    ;0E8A59|2052AE  |0EAE52;
						LDA.W r_Player_StateDoubled        ;0E8A5C|AD6505  |0E0565;
						BMI CODE_0E8A20                      ;0E8A5F|30BF    |0E8A20;
						JSR.W chemberBeforeDrac              ;0E8A61|20D980  |0E80D9;
						LDA.B r_conveyaerRoomEffect          ;0E8A64|A58B    |00008B;
						STA.B r_previousBackup88             ;0E8A66|85CF    |0000CF;
						LDA.B r_damagePlayer                 ;0E8A68|A581    |000081;
						AND.B #$0F                           ;0E8A6A|290F    |      ;
						STA.B r_conveyaerRoomEffect          ;0E8A6C|858B    |00008B;
						LDA.B #$00                           ;0E8A6E|A900    |      ;
						STA.B r_damagePlayer                 ;0E8A70|8581    |000081;
						LDA.B r_roomOrientation              ;0E8A72|A568    |000068;
						BPL selectCurPlayer                  ;0E8A74|1017    |0E8A8D;
						AND.B #$01                           ;0E8A76|2901    |      ;
						BNE CODE_0E8A7E                      ;0E8A78|D004    |0E8A7E;
						LDA.B #$00                           ;0E8A7A|A900    |      ;
						BEQ CODE_0E8A8B                      ;0E8A7C|F00D    |0E8A8B;
	
			CODE_0E8A7E:
						CLC                                  ;0E8A7E|18      |      ;
						LDA.B #$30                           ;0E8A7F|A930    |      ;
						ADC.B r_sceneScrollOffsetLo          ;0E8A81|6556    |000056;
						AND.B #$F0                           ;0E8A83|29F0    |      ;
						SEC                                  ;0E8A85|38      |      ;
						SBC.B r_sceneScrollOffsetLo          ;0E8A86|E556    |000056;
						CLC                                  ;0E8A88|18      |      ;
						ADC.B #$03                           ;0E8A89|6903    |      ;
	
			CODE_0E8A8B:
						STA.B r_HighestTileToCheckForCollisionsInVertRoom;0E8A8B|85D0    |0000D0;
	
		selectCurPlayer:
						LDA.B #$02                           ;0E8A8D|A902    |      ;
						STA.B r_scrollDirection              ;0E8A8F|8565    |000065;
						if !cv3BetterStairs == 1
						JSR.W cv3_stair_controls_tick        ;0E8A91|20CAFF  |0FFFCA;
						else
						LDY.W r_entity_ID           ;0E8A91|AC4E05  |00054E;
						endif
						BEQ trevorStateMain                  ;0E8A94|F00C    |0E8AA2;
						DEY                                  ;0E8A96|88      |      ;
						BEQ symphaStateMain                  ;0E8A97|F017    |0E8AB0;
						DEY                                  ;0E8A99|88      |      ;
						BEQ gramtStateMain                   ;0E8A9A|F01A    |0E8AB6;
						JSR.W alucardStates                  ;0E8A9C|20A8A5  |0EA5A8;
						JMP.W generalPlayerRoutines          ;0E8A9F|4CA58A  |0E8AA5;
	
	
		trevorStateMain:
						JSR.W trevorState                    ;0E8AA2|207B93  |0E937B;
	
	generalPlayerRoutines:
						LDA.W r_Player_StateDoubled          ;0E8AA5|AD6505  |000565;
						BMI endPlayerPrecessing              ;0E8AA8|301A    |0E8AC4;
						JSR.W generalPlayer_00               ;0E8AAA|20C08B  |0E8BC0;
						JMP.W generalPlayer_01               ;0E8AAD|4C138D  |0E8D13;
	
	
		symphaStateMain:
						JSR.W symphaState                    ;0E8AB0|20FC9B  |0E9BFC;
						JMP.W generalPlayerRoutines          ;0E8AB3|4CA58A  |0E8AA5;
	
	
		gramtStateMain:
						JSR.W grantStates                    ;0E8AB6|203B9C  |0E9C3B;
						JMP.W generalPlayerRoutines          ;0E8AB9|4CA58A  |0E8AA5;
	
	
	clearPlayerVertSpeed:
						LDA.B #$00                           ;0E8ABC|A900    |      ;
						STA.W r_entity_Yspd                ;0E8ABE|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0E8AC1|8D3705  |0E0537;
	
	endPlayerPrecessing:
						RTS                                  ;0E8AC4|60      |      ;
	
	
	player_state00_init:
						LDY.W r_entity_ID         ;0E8AC5|AC4E05  |0E054E;
						LDA.W charSpecGroups,Y               ;0E8AC8|B9DA8A  |0E8ADA;
						STA.W r_entity_spriteGroup ;0E8ACB|8D8C04  |0E048C;
						LDA.B #$02                           ;0E8ACE|A902    |      ;
						STA.W r_entity_spriteID          ;0E8AD0|8D0004  |0E0400;
						INC.W r_Player_StateDoubled        ;0E8AD3|EE6505  |0E0565;
						INC.W r_Player_StateDoubled        ;0E8AD6|EE6505  |0E0565;
						RTS                                  ;0E8AD9|60      |      ;
	
	
		charSpecGroups:
						db $00,$02,$04,$06                   ;0E8ADA|        |      ;
	
		player_state2e:
						LDA.B r_deathDelay                   ;0E8ADE|A5BF    |0000BF;
						AND.B #$7F                           ;0E8AE0|297F    |      ;
						db $20                               ;0E8AE2|        |      ;
						dw jumpFromStackYXpreserved          ;0E8AE3|        |0FE86D;
						dw playerDeathState_00               ;0E8AE5|        |0E8AEB;
						dw playerDeathState_01               ;0E8AE7|        |0E8AFF;
						dw playerDeathState_02               ;0E8AE9|        |0E8B48;
	
	playerDeathState_00:
						LDY.B #$00                           ;0E8AEB|A000    |      ;
						STY.W r_entity_OamBaseOffset       ;0E8AED|8C9305  |0E0593;
						STY.W $0413                          ;0E8AF0|8C1304  |0E0413;
						STY.B r_invincableFrames             ;0E8AF3|8480    |000080;
						STY.W r_entity_mask              ;0E8AF5|8C7004  |0E0470;
						INY                                  ;0E8AF8|C8      |      ;
						STY.W r_entity_AnimTimer           ;0E8AF9|8C7C05  |0E057C;
						INC.B r_deathDelay                   ;0E8AFC|E6BF    |0000BF;
						RTS                                  ;0E8AFE|60      |      ;
	
	
	playerDeathState_01:
						JSR.W playerDeathState_anim          ;0E8AFF|201A8B  |0E8B1A;
						LDA.W r_entity_AnimTimer           ;0E8B02|AD7C05  |0E057C;
						CMP.B #$FF                           ;0E8B05|C9FF    |      ;
						BEQ initPlayerReset                  ;0E8B07|F001    |0E8B0A;
						RTS                                  ;0E8B09|60      |      ;
	
	
		initPlayerReset:
						LDA.B #$4E                           ;0E8B0A|A94E    |      ;
						db $20                               ;0E8B0C|        |      ;
						dw lunchMusic                        ;0E8B0D|        |0FE25F;
						db $20                               ;0E8B0F|        |      ;
						dw setAutoPlayFlag                   ;0E8B10|        |0FE5CE;
						LDA.B #$64                           ;0E8B12|A964    |      ;
						STA.W $05D4                          ;0E8B14|8DD405  |0E05D4;
						INC.B r_deathDelay                   ;0E8B17|E6BF    |0000BF;
						RTS                                  ;0E8B19|60      |      ;
	
	
	playerDeathState_anim:
						DEC.W r_entity_AnimTimer           ;0E8B1A|CE7C05  |0E057C;
						BEQ setNextDeathFrame                ;0E8B1D|F001    |0E8B20;
						RTS                                  ;0E8B1F|60      |      ;
	
	
		setNextDeathFrame:
						LDA.W r_entity_OamBaseOffset       ;0E8B20|AD9305  |0E0593;
						ASL A                                ;0E8B23|0A      |      ;
						TAY                                  ;0E8B24|A8      |      ;
						LDA.W deathStateOAM_spec,Y           ;0E8B25|B94B8B  |0E8B4B;
						STA.W r_entity_spriteID          ;0E8B28|8D0004  |0E0400;
						LDA.W DATA8_0E8B4C,Y                 ;0E8B2B|B94C8B  |0E8B4C;
						STA.W r_entity_AnimTimer           ;0E8B2E|8D7C05  |0E057C;
						LDA.W r_entity_ID         ;0E8B31|AD4E05  |0E054E;
						ASL A                                ;0E8B34|0A      |      ;
						CLC                                  ;0E8B35|18      |      ;
						ADC.W r_entity_OamBaseOffset       ;0E8B36|6D9305  |0E0593;
						TAY                                  ;0E8B39|A8      |      ;
						LDA.W playerDeathOffsetFix,Y         ;0E8B3A|B94F8B  |0E8B4F;
						CLC                                  ;0E8B3D|18      |      ;
						ADC.W r_entity_YPos                ;0E8B3E|6D1C04  |0E041C;
						STA.W r_entity_YPos                ;0E8B41|8D1C04  |0E041C;
						INC.W r_entity_OamBaseOffset       ;0E8B44|EE9305  |0E0593;
						RTS                                  ;0E8B47|60      |      ;
	
	
	playerDeathState_02:
						JMP.W playerDeathReset               ;0E8B48|4CA78B  |0E8BA7;
	
	
	deathStateOAM_spec:
						db $12                               ;0E8B4B|        |      ;
	
			DATA8_0E8B4C:
						db $08,$14,$FF                       ;0E8B4C|        |      ;
	
	playerDeathOffsetFix:
						db $06,$F9,$0A,$FC,$04,$FF,$04,$FC   ;0E8B4F|        |      ;
	
	player_state2c_pitFall:
						LDA.B r_deathDelay                   ;0E8B57|A5BF    |0000BF;
						AND.B #$7F                           ;0E8B59|297F    |      ;
						TAY                                  ;0E8B5B|A8      |      ;
						BNE CODE_0E8B8F                      ;0E8B5C|D031    |0E8B8F;
						LDA.W r_entity_YPos                ;0E8B5E|AD1C04  |0E041C;
						LDY.B r_roomOrientation              ;0E8B61|A468    |000068;
						BMI CODE_0E8B6B                      ;0E8B63|3006    |0E8B6B;
						CMP.B #$E0                           ;0E8B65|C9E0    |      ;
						BCC CODE_0E8B71                      ;0E8B67|9008    |0E8B71;
						BCS CODE_0E8B8C                      ;0E8B69|B021    |0E8B8C;
	
			CODE_0E8B6B:
						CMP.B #$E0                           ;0E8B6B|C9E0    |      ;
						BCC CODE_0E8B71                      ;0E8B6D|9002    |0E8B71;
						BCS CODE_0E8B8C                      ;0E8B6F|B01B    |0E8B8C;
	
			CODE_0E8B71:
						LDA.W r_entity_Yspd                ;0E8B71|AD2005  |0E0520;
						CMP.B #$05                           ;0E8B74|C905    |      ;
						BCS CODE_0E8B89                      ;0E8B76|B011    |0E8B89;
						LDA.W r_entity_YsubSpd             ;0E8B78|AD3705  |0E0537;
						CLC                                  ;0E8B7B|18      |      ;
						ADC.B #$40                           ;0E8B7C|6940    |      ;
						STA.W r_entity_YsubSpd             ;0E8B7E|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0E8B81|AD2005  |0E0520;
						ADC.B #$00                           ;0E8B84|6900    |      ;
						STA.W r_entity_Yspd                ;0E8B86|8D2005  |0E0520;
	
			CODE_0E8B89:
						JMP.W updateSpeed2Pos                ;0E8B89|4C1287  |0E8712;
	
	
			CODE_0E8B8C:
						INC.B r_deathDelay                   ;0E8B8C|E6BF    |0000BF;
						RTS                                  ;0E8B8E|60      |      ;
	
	
			CODE_0E8B8F:
						DEY                                  ;0E8B8F|88      |      ;
						BNE playerDeathReset                 ;0E8B90|D015    |0E8BA7;
						LDA.B #$00                           ;0E8B92|A900    |      ;
						STA.W r_entity_spriteID          ;0E8B94|8D0004  |0E0400;
						LDA.B #$80                           ;0E8B97|A980    |      ;
						STA.W $05D4                          ;0E8B99|8DD405  |0E05D4;
						LDA.B #$4E                           ;0E8B9C|A94E    |      ; loseLiveMusic
						db $20                               ;0E8B9E|        |      ;
						dw lunchMusic                        ;0E8B9F|        |0FE25F;
						db $20                               ;0E8BA1|        |      ;
						dw setAutoPlayFlag                   ;0E8BA2|        |0FE5CE;
						INC.B r_deathDelay                   ;0E8BA4|E6BF    |0000BF;
						RTS                                  ;0E8BA6|60      |      ;
	
	
		playerDeathReset:	
						DEC.W $05D4                          ;0E8BA7|CED405  |0E05D4;
						BEQ CODE_0E8BAD                      ;0E8BAA|F001    |0E8BAD;				
						RTS                                  ;0E8BAC|60      |      ;
	
	
			CODE_0E8BAD:
						LDA.B #$05                           ;0E8BAD|A905    |      ;
						STA.B r_gameState                    ;0E8BAF|8518    |000018;
						LDA.B #$00                           ;0E8BB1|A900    |      ;
						STA.B r_gameSubstate                 ;0E8BB3|8519    |000019;
						LDA.W r_Player_StateDoubled        ;0E8BB5|AD6505  |0E0565;
						ORA.B #$80                           ;0E8BB8|0980    |      ;
						STA.W r_Player_StateDoubled        ;0E8BBA|8D6505  |0E0565;
						jmp unsetAutoPlayFlag                 ;0E8BBE|        |0FE5CA;
	
		generalPlayer_00:
						LDA.B r_deathDelay                   ;0E8BC0|A5BF    |0000BF;
						BEQ processRoomEffectIRQ             ;0E8BC2|F001    |0E8BC5;
	
			skipTrans10:
						RTS                                  ;0E8BC4|60      |      ;
	
	
	processRoomEffectIRQ:
						LDA.B r_gameTransition               ;0E8BC5|A52A    |00002A;
						CMP.B #$10                           ;0E8BC7|C910    |      ;
						BEQ skipTrans10                      ;0E8BC9|F0F9    |0E8BC4;
						LDA.B r_roomEffect                   ;0E8BCB|A57D    |00007D;
						AND.B #$F0                           ;0E8BCD|29F0    |      ;
						CMP.B #$50                           ;0E8BCF|C950    |      ;
						BEQ page50_70_roomEffect             ;0E8BD1|F029    |0E8BFC;
						CMP.B #$60                           ;0E8BD3|C960    |      ;
						BEQ page60_roomEffect                ;0E8BD5|F047    |0E8C1E;
						CMP.B #$70                           ;0E8BD7|C970    |      ;
						BEQ page50_70_roomEffect             ;0E8BD9|F021    |0E8BFC;
	
			CODE_0E8BDB:
						LDA.W r_entity_YPos                ;0E8BDB|AD1C04  |0E041C;
						LDY.B r_roomOrientation              ;0E8BDE|A468    |000068;
						BPL checkOutOfBoundDeath             ;0E8BE0|1012    |0E8BF4;
						CMP.B #$E0                           ;0E8BE2|C9E0    |      ;
						BCS CODE_0E8BF1                      ;0E8BE4|B00B    |0E8BF1;
						CPY.B #$83                           ;0E8BE6|C083    |      ;
						BNE CODE_0E8BFB                      ;0E8BE8|D011    |0E8BFB;
						CMP.B #$18                           ;0E8BEA|C918    |      ;
						BCS CODE_0E8BFB                      ;0E8BEC|B00D    |0E8BFB;
						JMP.W initPlayerDeath                ;0E8BEE|4C9883  |0E8398;
	
	
			CODE_0E8BF1:
						JMP.W setPlayerDeath                 ;0E8BF1|4CF98C  |0E8CF9;
	
	
	checkOutOfBoundDeath:
						CMP.B #$E0                           ;0E8BF4|C9E0    |      ;
						BCC CODE_0E8BFB                      ;0E8BF6|9003    |0E8BFB;
            JMP.W setPlayerDeath                 ;0E8BF8|4CF98C  |0E8CF9;
	
	
			CODE_0E8BFB:
						RTS                                  ;0E8BFB|60      |      ;
	
	
	page50_70_roomEffect:
						LDA.B r_roomEffect                   ;0E8BFC|A57D    |00007D;
						AND.B #$0F                           ;0E8BFE|290F    |      ;
						TAY                                  ;0E8C00|A8      |      ;
						LDA.W yPos_data01,Y                  ;0E8C01|B9568C  |0E8C56;
						CMP.W r_entity_YPos                ;0E8C04|CD1C04  |0E041C;
						BCS CODE_0E8BFB                      ;0E8C07|B0F2    |0E8BFB;
	
			CODE_0E8C09:
						LDA.B r_currPartnerID                ;0E8C09|A582    |000082;
						CMP.B #$08                           ;0E8C0B|C908    |      ;
						BNE CODE_0E8C18                      ;0E8C0D|D009    |0E8C18;
						LDA.B r_frameCount         ;0E8C0F|A51A    |00001A;
						AND.B #$03                           ;0E8C11|2903    |      ;
						BNE CODE_0E8BDB                      ;0E8C13|D0C6    |0E8BDB;
						JMP.W waterSplashInit                ;0E8C15|4C588C  |0E8C58;
	
	
			CODE_0E8C18:
						JSR.W waterSplashInit                ;0E8C18|20588C  |0E8C58;
						JMP.W setPlayerDeath                 ;0E8C1B|4CF98C  |0E8CF9;
	
	
		page60_roomEffect:
						LDA.B r_roomEffect                   ;0E8C1E|A57D    |00007D;
						AND.B #$0F                           ;0E8C20|290F    |      ;
						BNE CODE_0E8BDB                      ;0E8C22|D0B7    |0E8BDB;
						LDA.W r_entity_YPos                ;0E8C24|AD1C04  |0E041C;
						CMP.B #$C0                           ;0E8C27|C9C0    |      ;
						BCC CODE_0E8BFB                      ;0E8C29|90D0    |0E8BFB;
						LDA.W r_entity_XPos                ;0E8C2B|AD3804  |0E0438;
						CLC                                  ;0E8C2E|18      |      ;
						ADC.B r_sceneScrollOffsetLo          ;0E8C2F|6556    |000056;
						STA.B r_temp_Xpos                    ;0E8C31|850A    |00000A;
						LDA.B r_sceneScrollOffsetHi          ;0E8C33|A557    |000057;
						ADC.B #$00                           ;0E8C35|6900    |      ;
						STA.B $0B                            ;0E8C37|850B    |00000B;
						CMP.B #$01                           ;0E8C39|C901    |      ;
						BCC CODE_0E8C09                      ;0E8C3B|90CC    |0E8C09;
						BNE CODE_0E8C48                      ;0E8C3D|D009    |0E8C48;
						LDA.B r_temp_Xpos                    ;0E8C3F|A50A    |00000A;
						CMP.B #$20                           ;0E8C41|C920    |      ;
						BCC CODE_0E8C09                      ;0E8C43|90C4    |0E8C09;
						JMP.W CODE_0E8BDB                    ;0E8C45|4CDB8B  |0E8BDB;
	
	
			CODE_0E8C48:
						CMP.B #$02                           ;0E8C48|C902    |      ;
						BCC CODE_0E8BDB                      ;0E8C4A|908F    |0E8BDB;
						BNE CODE_0E8C09                      ;0E8C4C|D0BB    |0E8C09;
						LDA.B r_temp_Xpos                    ;0E8C4E|A50A    |00000A;
						CMP.B #$C0                           ;0E8C50|C9C0    |      ;
						BCC CODE_0E8BDB                      ;0E8C52|9087    |0E8BDB;
						BCS CODE_0E8C09                      ;0E8C54|B0B3    |0E8C09;
	
			yPos_data01:
						db $B0,$D0                           ;0E8C56|        |      ;
	
		waterSplashInit:
						LDA.B #$23                           ;0E8C58|A923    |      ;
						db $20                               ;0E8C5A|        |      ;
						dw lunchMusic                        ;0E8C5B|        |0FE25F;
						LDA.B r_frameCount         ;0E8C5D|A51A    |00001A;
						AND.B #$03                           ;0E8C5F|2903    |      ;
						STA.B $00                            ;0E8C61|8500    |000000;
						ASL A                                ;0E8C63|0A      |      ;
						CLC                                  ;0E8C64|18      |      ;
						ADC.B $00                            ;0E8C65|6500    |000000;
						TAY                                  ;0E8C67|A8      |      ;
						STA.B r_roomSectionChrBanksDataOffset;0E8C68|850F    |00000F;
						LDX.B #$14                           ;0E8C6A|A214    |      ;
	
		writeSpawnData:
						LDY.B r_roomSectionChrBanksDataOffset;0E8C6C|A40F    |00000F;
						LDA.W DATA8_0E8CBD,Y                 ;0E8C6E|B9BD8C  |0E8CBD;
						ASL A                                ;0E8C71|0A      |      ;
						STA.B $00                            ;0E8C72|8500    |000000;
						ASL A                                ;0E8C74|0A      |      ;
						CLC                                  ;0E8C75|18      |      ;
						ADC.B $00                            ;0E8C76|6500    |000000;
						TAY                                  ;0E8C78|A8      |      ;
						LDA.W xPosOffsetData03,Y             ;0E8C79|B9C98C  |0E8CC9;
						CLC                                  ;0E8C7C|18      |      ;
						ADC.W r_entity_XPos                ;0E8C7D|6D3804  |0E0438;
						STA.W r_entity_XPos,X              ;0E8C80|9D3804  |0E0438;
						LDA.W yPosData03,Y                   ;0E8C83|B9CA8C  |0E8CCA;
						CLC                                  ;0E8C86|18      |      ;
						ADC.W r_entity_YPos                ;0E8C87|6D1C04  |0E041C;
						SEC                                  ;0E8C8A|38      |      ;
						SBC.B #$0C                           ;0E8C8B|E90C    |      ;
						STA.W r_entity_YPos,X              ;0E8C8D|9D1C04  |0E041C;
						LDA.W xSpdData03,Y                   ;0E8C90|B9CB8C  |0E8CCB;
						STA.W r_entity_Xspd,X              ;0E8C93|9DF204  |0E04F2;
						LDA.W xSpdSubData03,Y                ;0E8C96|B9CC8C  |0E8CCC;
						STA.W r_entity_XsubSpd,X           ;0E8C99|9D0905  |0E0509;
						LDA.W ySpdData03,Y                   ;0E8C9C|B9CD8C  |0E8CCD;
						STA.W r_entity_Yspd,X              ;0E8C9F|9D2005  |0E0520;
						LDA.W ySpdSubData03,Y                ;0E8CA2|B9CE8C  |0E8CCE;
						STA.W r_entity_YsubSpd,X           ;0E8CA5|9D3705  |0E0537;
						LDA.B #$0C                           ;0E8CA8|A90C    |      ;
						STA.W r_entity_ID,X       ;0E8CAA|9D4E05  |0E054E;
						LDA.B #$00                           ;0E8CAD|A900    |      ;
						STA.W r_entity_mask,X            ;0E8CAF|9D7004  |0E0470;
						STA.W r_Player_StateDoubled,X      ;0E8CB2|9D6505  |0E0565;
						INC.B r_roomSectionChrBanksDataOffset;0E8CB5|E60F    |00000F;
						INX                                  ;0E8CB7|E8      |      ;
						CPX.B #$17                           ;0E8CB8|E017    |      ;
						BNE writeSpawnData                   ;0E8CBA|D0B0    |0E8C6C;
						RTS                                  ;0E8CBC|60      |      ;
	
	
			DATA8_0E8CBD:
						db $00,$03,$04,$05,$01,$02,$02,$05   ;0E8CBD|        |      ;
						db $01,$06,$03,$04                   ;0E8CC5|        |      ;
	
		xPosOffsetData03:
						db $08                               ;0E8CC9|        |      ;
	
			yPosData03:
						db $02                               ;0E8CCA|        |      ;
	
			xSpdData03:
						db $01                               ;0E8CCB|        |      ;
	
			xSpdSubData03:
						db $00                               ;0E8CCC|        |      ;
	
			ySpdData03:
						db $FD                               ;0E8CCD|        |      ;
	
			ySpdSubData03:
						db $C0,$04,$00,$00,$80,$FE,$80,$F8   ;0E8CCE|        |      ;
						db $FC,$FF,$40,$FF,$40,$08,$02,$FE   ;0E8CD6|        |      ;
						db $20,$FE,$C0,$FC,$00,$01,$80,$FF   ;0E8CDE|        |      ;
						db $80,$FD,$02,$FF,$00,$FD,$80,$02   ;0E8CE6|        |      ;
	
						db $FE,$01,$40,$FE,$C0,$FF,$02,$02   ;0E8CEE|        |      ;
						db $00,$FF,$50                       ;0E8CF6|        |      ;
	
		setPlayerDeath:
						JSR.W getSlot13_resetOamSpec         ;0E8CF9|20C4BD  |0EBDC4;
						LDA.W r_entity_Yspd                ;0E8CFC|AD2005  |0E0520;
						BPL CODE_0E8D09                      ;0E8CFF|1008    |0E8D09;
						LDA.B #$00                           ;0E8D01|A900    |      ;
						STA.W r_entity_Yspd                ;0E8D03|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0E8D06|8D3705  |0E0537;
	
			CODE_0E8D09:
						LDA.B #$80                           ;0E8D09|A980    |      ;
						STA.B r_deathDelay                   ;0E8D0B|85BF    |0000BF;
						LDA.B #$2C                           ;0E8D0D|A92C    |      ;
						STA.W r_Player_StateDoubled        ;0E8D0F|8D6505  |0E0565;
						RTS                                  ;0E8D12|60      |      ;
	
	
		generalPlayer_01:
						LDA.B r_gameTransition               ;0E8D13|A52A    |00002A;
						CMP.B #$1B                           ;0E8D15|C91B    |      ;
						BEQ noSomethingEffect                ;0E8D17|F070    |0E8D89;
						LDA.B r_roomEffect                   ;0E8D19|A57D    |00007D;
						CMP.B #$30                           ;0E8D1B|C930    |      ;
						BEQ CODE_0E8D37                      ;0E8D1D|F018    |0E8D37;
						CMP.B #$31                           ;0E8D1F|C931    |      ;
						BEQ CODE_0E8D37                      ;0E8D21|F014    |0E8D37;
						CMP.B #$41                           ;0E8D23|C941    |      ;
						BEQ CODE_0E8D29                      ;0E8D25|F002    |0E8D29;
						BNE CODE_0E8D8E                      ;0E8D27|D065    |0E8D8E;
	
			CODE_0E8D29:
						LDA.B r_frameCount         ;0E8D29|A51A    |00001A;
						AND.B #$0F                           ;0E8D2B|290F    |      ;
						BNE CODE_0E8D8E                      ;0E8D2D|D05F    |0E8D8E;
						LDA.B #$20                           ;0E8D2F|A920    |      ;
						db $20                               ;0E8D31|        |      ;
						dw lunchMusic                        ;0E8D32|        |0FE25F;
						JMP.W CODE_0E8D8E                    ;0E8D34|4C8E8D  |0E8D8E;
	
	
			CODE_0E8D37:
						LDA.B r_frameCount         ;0E8D37|A51A    |00001A;
						AND.B #$0F                           ;0E8D39|290F    |      ;
						BNE CODE_0E8D7B                      ;0E8D3B|D03E    |0E8D7B;
						LDA.B r_sceneScrollOffsetLo          ;0E8D3D|A556    |000056;
						ADC.W r_entity_XPos                ;0E8D3F|6D3804  |0E0438;
						STA.B $00                            ;0E8D42|8500    |000000;
						LDA.B r_sceneScrollOffsetHi          ;0E8D44|A557    |000057;
						ADC.B #$00                           ;0E8D46|6900    |      ;
						STA.B $01                            ;0E8D48|8501    |000001;
						LDA.B r_roomEffect                   ;0E8D4A|A57D    |00007D;
						AND.B #$0F                           ;0E8D4C|290F    |      ;
						ASL A                                ;0E8D4E|0A      |      ;
						TAY                                  ;0E8D4F|A8      |      ;
						LDA.W effectFlag_30_31,Y             ;0E8D50|B9778E  |0E8E77;
						SEC                                  ;0E8D53|38      |      ;
						SBC.B $00                            ;0E8D54|E500    |000000;
						TAX                                  ;0E8D56|AA      |      ;
						LDA.W DATA8_0E8E76,Y                 ;0E8D57|B9768E  |0E8E76;
						SBC.B $01                            ;0E8D5A|E501    |000001;
						BCS CODE_0E8D68                      ;0E8D5C|B00A    |0E8D68;
						CMP.B #$FF                           ;0E8D5E|C9FF    |      ;
						BNE CODE_0E8D76                      ;0E8D60|D014    |0E8D76;
						CPX.B #$80                           ;0E8D62|E080    |      ;
						BCC CODE_0E8D76                      ;0E8D64|9010    |0E8D76;
						BCS CODE_0E8D6E                      ;0E8D66|B006    |0E8D6E;
	
			CODE_0E8D68:
						BNE CODE_0E8D76                      ;0E8D68|D00C    |0E8D76;
						CPX.B #$80                           ;0E8D6A|E080    |      ;
						BCS CODE_0E8D76                      ;0E8D6C|B008    |0E8D76;
	
			CODE_0E8D6E:
						LDA.B #$25                           ;0E8D6E|A925    |      ;
						db $20                               ;0E8D70|        |      ;
						dw lunchMusic                        ;0E8D71|        |0FE25F;
						JMP.W CODE_0E8D7B                    ;0E8D73|4C7B8D  |0E8D7B;
	
	
			CODE_0E8D76:
						LDA.B #$20                           ;0E8D76|A920    |      ;
						db $20                               ;0E8D78|        |      ;
						dw lunchMusic                        ;0E8D79|        |0FE25F;
	
			CODE_0E8D7B:
						LDA.B r_deathDelay                   ;0E8D7B|A5BF    |0000BF;
						BMI noSomethingEffect                ;0E8D7D|300A    |0E8D89;
						LDA.B r_conveyaerRoomEffect          ;0E8D7F|A58B    |00008B;
						CMP.B #$08                           ;0E8D81|C908    |      ;
						BEQ doSomething                      ;0E8D83|F00A    |0E8D8F;
						CMP.B #$09                           ;0E8D85|C909    |      ;
						BEQ doSomething                      ;0E8D87|F006    |0E8D8F;
	
		noSomethingEffect:
						LDA.B #$00                           ;0E8D89|A900    |      ;
						STA.W $041A                          ;0E8D8B|8D1A04  |0E041A;
	
			CODE_0E8D8E:
						RTS                                  ;0E8D8E|60      |      ;
	
	
			doSomething:
						LDA.W r_entity_ID         ;0E8D8F|AD4E05  |0E054E;
						ASL A                                ;0E8D92|0A      |      ;
						TAY                                  ;0E8D93|A8      |      ;
						LDA.W PTR16_0E8DE3,Y                 ;0E8D94|B9E38D  |0E8DE3;
						STA.B r_pointerQueue                 ;0E8D97|8508    |000008;
						LDA.W PTR16_0E8DE3+1,Y                 ;0E8D99|B9E48D  |0E8DE4;
						STA.B $09                            ;0E8D9C|8509    |000009;
						LDY.B #$00                           ;0E8D9E|A000    |      ;
	
			CODE_0E8DA0:
						LDA.B (r_pointerQueue),Y             ;0E8DA0|B108    |000008;
						CMP.B #$FF                           ;0E8DA2|C9FF    |      ;
						BEQ CODE_0E8D8E                      ;0E8DA4|F0E8    |0E8D8E;
						INY                                  ;0E8DA6|C8      |      ;
						CMP.W r_entity_spriteID          ;0E8DA7|CD0004  |0E0400;
						BEQ CODE_0E8DB0                      ;0E8DAA|F004    |0E8DB0;
						INY                                  ;0E8DAC|C8      |      ;
						INY                                  ;0E8DAD|C8      |      ;
						BNE CODE_0E8DA0                      ;0E8DAE|D0F0    |0E8DA0;
	
			CODE_0E8DB0:
						LDA.W r_entity_FacingLeft          ;0E8DB0|ADA804  |0E04A8;
						BEQ CODE_0E8DDA                      ;0E8DB3|F025    |0E8DDA;
						LDA.W r_entity_XPos                ;0E8DB5|AD3804  |0E0438;
						CLC                                  ;0E8DB8|18      |      ;
						ADC.B (r_pointerQueue),Y             ;0E8DB9|7108    |000008;
	
			CODE_0E8DBB:
						STA.W $0452                          ;0E8DBB|8D5204  |0E0452;
						INY                                  ;0E8DBE|C8      |      ;
						LDA.W r_entity_YPos                ;0E8DBF|AD1C04  |0E041C;
						CLC                                  ;0E8DC2|18      |      ;
						ADC.B (r_pointerQueue),Y             ;0E8DC3|7108    |000008;
						CMP.B #$38                           ;0E8DC5|C938    |      ;
						BCC noSomethingEffect                ;0E8DC7|90C0    |0E8D89;
						STA.W $0436                          ;0E8DC9|8D3604  |0E0436;
						LDA.B #$62                           ;0E8DCC|A962    |      ;
						STA.W $041A                          ;0E8DCE|8D1A04  |0E041A;
						LDA.B #$00                           ;0E8DD1|A900    |      ;
						STA.W $046E                          ;0E8DD3|8D6E04  |0E046E;
						STA.W $048A                          ;0E8DD6|8D8A04  |0E048A;
						RTS                                  ;0E8DD9|60      |      ;
	
	
			CODE_0E8DDA:
						LDA.W r_entity_XPos                ;0E8DDA|AD3804  |0E0438;
						SEC                                  ;0E8DDD|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0E8DDE|F108    |000008;
						JMP.W CODE_0E8DBB                    ;0E8DE0|4CBB8D  |0E8DBB;
	
	
			PTR16_0E8DE3:
						dw DATA8_0E8DEB                      ;0E8DE3|        |0E8DEB;
						dw DATA8_0E8E0D                      ;0E8DE5|        |0E8E0D;
						dw DATA8_0E8E35                      ;0E8DE7|        |0E8E35;
						dw DATA8_0E8E4B                      ;0E8DE9|        |0E8E4B;
	
			DATA8_0E8DEB:
						db $02,$FB,$F1,$04,$FE,$F0,$06,$FC   ;0E8DEB|        |      ;
						db $F1,$0E,$FD,$F8,$16,$FD,$F5,$18   ;0E8DF3|        |      ;
						db $03,$F1,$1A,$FE,$F0,$1C,$FB,$F2   ;0E8DFB|        |      ;
						db $1E,$FD,$F9,$20,$FE,$F8,$22,$FB   ;0E8E03|        |      ;
						db $FA,$FF                           ;0E8E0B|        |      ;
	
			DATA8_0E8E0D:
						db $02,$FB,$F1,$04,$FE,$F0,$06,$FC   ;0E8E0D|        |      ;
						db $F1,$0E,$FD,$F8,$16,$FD,$F5,$18   ;0E8E15|        |      ;
						db $FD,$F5,$1A,$FD,$F5,$1C,$FD,$F5   ;0E8E1D|        |      ;
						db $1E,$FD,$F5,$2C,$FD,$F5,$2E,$FD   ;0E8E25|        |      ;
						db $F5,$34,$FD,$F5,$36,$FD,$F5,$FF   ;0E8E2D|        |      ;
	
			DATA8_0E8E35:
						db $02,$FB,$F5,$04,$FE,$F4,$06,$FB   ;0E8E35|        |      ;
						db $F5,$0E,$FE,$00,$16,$FB,$F5,$24   ;0E8E3D|        |      ;
						db $FE,$F0,$26,$F8,$F4,$FF           ;0E8E45|        |      ;
	
			DATA8_0E8E4B:
						db $02,$00,$E9,$04,$00,$E8,$06,$00   ;0E8E4B|        |      ;
						db $E9,$0E,$FD,$F8,$16,$FD,$F5,$18   ;0E8E53|        |      ;
						db $00,$E9,$1A,$00,$E9,$1C,$00,$E9   ;0E8E5B|        |      ;
						db $1E,$FD,$F8,$20,$FD,$F8,$22,$FD   ;0E8E63|        |      ;
						db $F8,$24,$00,$FD,$26,$00,$FF,$28   ;0E8E6B|        |      ;
						db $00,$F8,$FF                       ;0E8E73|        |      ;
	
			DATA8_0E8E76:
						db $02                               ;0E8E76|        |      ;
	
		effectFlag_30_31:
						db $80,$01,$80                       ;0E8E77|        |      ;
	
		setConveyaerSpeed:
						STY.W r_entity_XsubSpd             ;0E8E7A|8C0905  |0E0509;
						STA.W r_entity_Xspd                ;0E8E7D|8DF204  |0E04F2;
						JSR.W clearPlayerVertSpeed           ;0E8E80|20BC8A  |0E8ABC;
						SEC                                  ;0E8E83|38      |      ;
						RTS                                  ;0E8E84|60      |      ;
	
	
	doConveyaerRoomEffect:
						LDA.B r_gameTransition               ;0E8E85|A52A    |00002A;
						CMP.B #$1B                           ;0E8E87|C91B    |      ;
						BEQ NoConveyaer                      ;0E8E89|F02A    |0E8EB5;
						LDA.B r_conveyaerRoomEffect          ;0E8E8B|A58B    |00008B;
						CMP.B #$01                           ;0E8E8D|C901    |      ;
						BEQ conveyaerType_01                 ;0E8E8F|F029    |0E8EBA;
						CMP.B #$0C                           ;0E8E91|C90C    |      ;
						BCS NoConveyaer                      ;0E8E93|B020    |0E8EB5;
						SEC                                  ;0E8E95|38      |      ;
						SBC.B #$05                           ;0E8E96|E905    |      ;
						BCC NoConveyaer                      ;0E8E98|901B    |0E8EB5;
						BNE CODE_0E8E9F                      ;0E8E9A|D003    |0E8E9F;
						JMP.W conveyaer_stuffKnockBack       ;0E8E9C|4C958F  |0E8F95;
	
	
			CODE_0E8E9F:
						TAY                                  ;0E8E9F|A8      |      ;
						DEY                                  ;0E8EA0|88      |      ;
						BNE CODE_0E8EA6                      ;0E8EA1|D003    |0E8EA6;
						JMP.W conveyaerStuffGearCog          ;0E8EA3|4C2390  |0E9023;
	
	
			CODE_0E8EA6:
						DEY                                  ;0E8EA6|88      |      ;
						BEQ doConveyaer__00                  ;0E8EA7|F035    |0E8EDE;
						DEY                                  ;0E8EA9|88      |      ;
						BEQ doConveyaerLeft                  ;0E8EAA|F039    |0E8EE5;
						DEY                                  ;0E8EAC|88      |      ;
						BEQ doConveyaerRight                 ;0E8EAD|F03D    |0E8EEC;
						DEY                                  ;0E8EAF|88      |      ;
						BEQ doConveyaer__01                  ;0E8EB0|F041    |0E8EF3;
						DEY                                  ;0E8EB2|88      |      ;
						BEQ doConveyaer__02                  ;0E8EB3|F045    |0E8EFA;
	
			NoConveyaer:
						JSR.W clearPlayerVertSpeed           ;0E8EB5|20BC8A  |0E8ABC;
						CLC                                  ;0E8EB8|18      |      ;
						RTS                                  ;0E8EB9|60      |      ;
	
	
		conveyaerType_01:
						LDX.B r_ConveyorRelated              ;0E8EBA|A691    |000091;
						STX.B r_platformIDFrozenEnemy        ;0E8EBC|86B8    |0000B8;
						LDA.W r_entity_ID,X       ;0E8EBE|BD4E05  |0E054E;
						CMP.B #$79                           ;0E8EC1|C979    |      ;
						BCC CODE_0E8ED7                      ;0E8EC3|9012    |0E8ED7;
						JSR.W conveyaerStuff_10              ;0E8EC5|20C291  |0E91C2;
						LDA.W r_entity_XsubSpd,X           ;0E8EC8|BD0905  |0E0509; updatePlayerSubSpeed
						CLC                                  ;0E8ECB|18      |      ;
						ADC.B #$00                           ;0E8ECC|6900    |      ;
						TAY                                  ;0E8ECE|A8      |      ;
						LDA.W r_entity_Xspd,X              ;0E8ECF|BDF204  |0E04F2;
						ADC.B #$01                           ;0E8ED2|6901    |      ;
						JMP.W setPlayerSpeed                 ;0E8ED4|4C578F  |0E8F57;
	
	
			CODE_0E8ED7:
						LDY.B #$00                           ;0E8ED7|A000    |      ;
						LDA.B #$01                           ;0E8ED9|A901    |      ;
						JMP.W setPlayerSpeed                 ;0E8EDB|4C578F  |0E8F57;
	
	
		doConveyaer__00:
						LDA.B #$00                           ;0E8EDE|A900    |      ;
						LDY.B #$80                           ;0E8EE0|A080    |      ;
						JMP.W setConveyaerSpeed              ;0E8EE2|4C7A8E  |0E8E7A;
	
	
		doConveyaerLeft:
						LDA.B #$00                           ;0E8EE5|A900    |      ;
						LDY.B #$40                           ;0E8EE7|A040    |      ;
						JMP.W setConveyaerSpeed              ;0E8EE9|4C7A8E  |0E8E7A;
	
	
		doConveyaerRight:
						LDA.B #$01                           ;0E8EEC|A901    |      ;
						LDY.B #$C0                           ;0E8EEE|A0C0    |      ;
						JMP.W setConveyaerSpeed              ;0E8EF0|4C7A8E  |0E8E7A;
	
	
		doConveyaer__01:
						LDA.B #$00                           ;0E8EF3|A900    |      ;
						LDY.B #$80                           ;0E8EF5|A080    |      ;
						JMP.W setConveyaerSpeed              ;0E8EF7|4C7A8E  |0E8E7A;
	
	
		doConveyaer__02:
						LDA.B #$01                           ;0E8EFA|A901    |      ;
						LDY.B #$80                           ;0E8EFC|A080    |      ;
						JMP.W setConveyaerSpeed              ;0E8EFE|4C7A8E  |0E8E7A;
	
	
	gameTransitionChecks:
						LDA.B r_gameTransition               ;0E8F01|A52A    |00002A;
						CMP.B #$1B                           ;0E8F03|C91B    |      ;
						BEQ CODE_0E8F31                      ;0E8F05|F02A    |0E8F31;
						LDA.B r_conveyaerRoomEffect          ;0E8F07|A58B    |00008B;
						CMP.B #$01                           ;0E8F09|C901    |      ;
						BEQ CODE_0E8F36                      ;0E8F0B|F029    |0E8F36;
						CMP.B #$0C                           ;0E8F0D|C90C    |      ;
						BCS CODE_0E8F31                      ;0E8F0F|B020    |0E8F31;
						SEC                                  ;0E8F11|38      |      ;
						SBC.B #$05                           ;0E8F12|E905    |      ;
						BCC CODE_0E8F31                      ;0E8F14|901B    |0E8F31;
						BNE CODE_0E8F1B                      ;0E8F16|D003    |0E8F1B;
						JMP.W conveyaerStuff_11              ;0E8F18|4CCF8F  |0E8FCF;
	
	
			CODE_0E8F1B:
						TAY                                  ;0E8F1B|A8      |      ;
						DEY                                  ;0E8F1C|88      |      ;
						BNE CODE_0E8F22                      ;0E8F1D|D003    |0E8F22;
						JMP.W conveyaerStuff_12              ;0E8F1F|4CB990  |0E90B9;
	
	
			CODE_0E8F22:
						DEY                                  ;0E8F22|88      |      ;
						BEQ CODE_0E8F72                      ;0E8F23|F04D    |0E8F72;
						DEY                                  ;0E8F25|88      |      ;
						BEQ CODE_0E8F79                      ;0E8F26|F051    |0E8F79;
						DEY                                  ;0E8F28|88      |      ;
						BEQ CODE_0E8F80                      ;0E8F29|F055    |0E8F80;
						DEY                                  ;0E8F2B|88      |      ;
						BEQ CODE_0E8F87                      ;0E8F2C|F059    |0E8F87;
						DEY                                  ;0E8F2E|88      |      ;
						BEQ CODE_0E8F8E                      ;0E8F2F|F05D    |0E8F8E;
	
			CODE_0E8F31:
						JSR.W clearPlayerVertSpeed           ;0E8F31|20BC8A  |0E8ABC;
						CLC                                  ;0E8F34|18      |      ;
						RTS                                  ;0E8F35|60      |      ;
	
	
			CODE_0E8F36:
						LDX.B r_ConveyorRelated              ;0E8F36|A691    |000091;
						STX.B r_platformIDFrozenEnemy        ;0E8F38|86B8    |0000B8;
						LDA.W r_entity_ID,X       ;0E8F3A|BD4E05  |0E054E;
						CMP.B #$79                           ;0E8F3D|C979    |      ;
						BCC CODE_0E8F53                      ;0E8F3F|9012    |0E8F53;
						JSR.W conveyaerStuff_10              ;0E8F41|20C291  |0E91C2;
						LDA.W r_entity_XsubSpd,X           ;0E8F44|BD0905  |0E0509;
						CLC                                  ;0E8F47|18      |      ;
						ADC.B #$00                           ;0E8F48|6900    |      ;
						TAY                                  ;0E8F4A|A8      |      ;
						LDA.W r_entity_Xspd,X              ;0E8F4B|BDF204  |0E04F2;
						ADC.B #$FF                           ;0E8F4E|69FF    |      ;
						JMP.W setPlayerSpeed                 ;0E8F50|4C578F  |0E8F57;
	
	
			CODE_0E8F53:
						LDA.B #$FF                           ;0E8F53|A9FF    |      ;
						LDY.B #$00                           ;0E8F55|A000    |      ;
	
		setPlayerSpeed:
						STA.W r_entity_Xspd                ;0E8F57|8DF204  |0E04F2;
						TYA                                  ;0E8F5A|98      |      ;
						STA.W r_entity_XsubSpd             ;0E8F5B|8D0905  |0E0509;
						JSR.W playerKnockback_00             ;0E8F5E|205391  |0E9153;
						BCS CODE_0E8F6C                      ;0E8F61|B009    |0E8F6C;
						LDA.W r_entity_Xspd                ;0E8F63|ADF204  |0E04F2;
						LDY.W r_entity_XsubSpd             ;0E8F66|AC0905  |0E0509;
						JMP.W setConveyaerSpeed              ;0E8F69|4C7A8E  |0E8E7A;
	
	
			CODE_0E8F6C:
						LDA.B #$00                           ;0E8F6C|A900    |      ;
						TAY                                  ;0E8F6E|A8      |      ;
						JMP.W setConveyaerSpeed              ;0E8F6F|4C7A8E  |0E8E7A;
	
	
			CODE_0E8F72:
						LDA.B #$FF                           ;0E8F72|A9FF    |      ;
						LDY.B #$80                           ;0E8F74|A080    |      ;
						JMP.W setConveyaerSpeed              ;0E8F76|4C7A8E  |0E8E7A;
	
	
			CODE_0E8F79:
						LDA.B #$FE                           ;0E8F79|A9FE    |      ;
						LDY.B #$40                           ;0E8F7B|A040    |      ;
						JMP.W setConveyaerSpeed              ;0E8F7D|4C7A8E  |0E8E7A;
	
	
			CODE_0E8F80:
						LDA.B #$FF                           ;0E8F80|A9FF    |      ;
						LDY.B #$C0                           ;0E8F82|A0C0    |      ;
						JMP.W setConveyaerSpeed              ;0E8F84|4C7A8E  |0E8E7A;
	
	
			CODE_0E8F87:
						LDA.B #$FE                           ;0E8F87|A9FE    |      ;
						LDY.B #$80                           ;0E8F89|A080    |      ;
						JMP.W setConveyaerSpeed              ;0E8F8B|4C7A8E  |0E8E7A;
	
	
			CODE_0E8F8E:
						LDA.B #$FF                           ;0E8F8E|A9FF    |      ;
						LDY.B #$80                           ;0E8F90|A080    |      ;
						JMP.W setConveyaerSpeed              ;0E8F92|4C7A8E  |0E8E7A;
	
	
	conveyaer_stuffKnockBack:
						LDA.B r_knockBackDirrection          ;0E8F95|A590    |000090;
						AND.B #$7F                           ;0E8F97|297F    |      ;
						STA.B $00                            ;0E8F99|8500    |000000;
						TAY                                  ;0E8F9B|A8      |      ;
						LDA.B r_knockBackDirrection          ;0E8F9C|A590    |000090;
						BPL CODE_0E8FAD                      ;0E8F9E|100D    |0E8FAD;
						db $B9                               ;0E8FA0|        |      ; lda
						dw entity_YsubSpd_data               ;0E8FA1|        |0FFD81;
						STA.W r_entity_YsubSpd             ;0E8FA3|8D3705  |0E0537;
						LDA.B #$00                           ;0E8FA6|A900    |      ;
						STA.W r_entity_Yspd                ;0E8FA8|8D2005  |0E0520;
						BEQ CODE_0E8FBB                      ;0E8FAB|F00E    |0E8FBB;
	
			CODE_0E8FAD:
						LDA.B #$00                           ;0E8FAD|A900    |      ;
						SEC                                  ;0E8FAF|38      |      ;
						db $F9                               ;0E8FB0|        |      ; sbc
						dw entity_YsubSpd_data               ;0E8FB1|        |0FFD81;
						STA.W r_entity_YsubSpd             ;0E8FB3|8D3705  |0E0537;
						LDA.B #$FF                           ;0E8FB6|A9FF    |      ;
						STA.W r_entity_Yspd                ;0E8FB8|8D2005  |0E0520;
	
			CODE_0E8FBB:
						LDA.B #$40                           ;0E8FBB|A940    |      ;
	
						SEC                                  ;0E8FBD|38      |      ;
						SBC.B $00                            ;0E8FBE|E500    |000000;
						TAY                                  ;0E8FC0|A8      |      ;
						db $B9                               ;0E8FC1|        |      ; lda
						dw entity_YsubSpd_data               ;0E8FC2|        |0FFD81;
						STA.W r_entity_XsubSpd             ;0E8FC4|8D0905  |0E0509;
						LDA.B #$00                           ;0E8FC7|A900    |      ;
						STA.W r_entity_Xspd                ;0E8FC9|8DF204  |0E04F2;
						JMP.W CODE_0E9009                    ;0E8FCC|4C0990  |0E9009;
	
	
		conveyaerStuff_11:
						LDA.B r_knockBackDirrection          ;0E8FCF|A590    |000090;
						AND.B #$7F                           ;0E8FD1|297F    |      ;
						STA.B $00                            ;0E8FD3|8500    |000000;
						TAY                                  ;0E8FD5|A8      |      ;
						LDA.B r_knockBackDirrection          ;0E8FD6|A590    |000090;
						BMI CODE_0E8FE7                      ;0E8FD8|300D    |0E8FE7;
						db $B9                               ;0E8FDA|        |      ; lda
						dw entity_YsubSpd_data               ;0E8FDB|        |0FFD81;
						STA.W r_entity_YsubSpd             ;0E8FDD|8D3705  |0E0537;
						LDA.B #$00                           ;0E8FE0|A900    |      ;
						STA.W r_entity_Yspd                ;0E8FE2|8D2005  |0E0520;
						BEQ CODE_0E8FF5                      ;0E8FE5|F00E    |0E8FF5;
	
			CODE_0E8FE7:
						LDA.B #$00                           ;0E8FE7|A900    |      ;
						SEC                                  ;0E8FE9|38      |      ;
						db $F9                               ;0E8FEA|        |      ; sbc
						dw entity_YsubSpd_data               ;0E8FEB|        |0FFD81;
						STA.W r_entity_YsubSpd             ;0E8FED|8D3705  |0E0537;
						LDA.B #$FF                           ;0E8FF0|A9FF    |      ;
						STA.W r_entity_Yspd                ;0E8FF2|8D2005  |0E0520;
	
			CODE_0E8FF5:
						LDA.B #$40                           ;0E8FF5|A940    |      ;
						SEC                                  ;0E8FF7|38      |      ;
						SBC.B $00                            ;0E8FF8|E500    |000000;
						TAY                                  ;0E8FFA|A8      |      ;
						LDA.B #$00                           ;0E8FFB|A900    |      ;
						SEC                                  ;0E8FFD|38      |      ;
						db $F9                               ;0E8FFE|        |      ; sbc
						dw entity_YsubSpd_data               ;0E8FFF|        |0FFD81;
						STA.W r_entity_XsubSpd             ;0E9001|8D0905  |0E0509;
						LDA.B #$FF                           ;0E9004|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E9006|8DF204  |0E04F2;
	
			CODE_0E9009:
						JSR.W setKnockBackSpd                ;0E9009|207780  |0E8077;
						JSR.W playerKnockback_00             ;0E900C|205391  |0E9153;
						BCS CODE_0E9013                      ;0E900F|B002    |0E9013;
						SEC                                  ;0E9011|38      |      ;
						RTS                                  ;0E9012|60      |      ;
	
	
			CODE_0E9013:
						LDA.B #$00                           ;0E9013|A900    |      ;
						STA.W r_entity_Xspd                ;0E9015|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0E9018|8D0905  |0E0509;
						STA.W r_entity_Yspd                ;0E901B|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0E901E|8D3705  |0E0537;
						SEC                                  ;0E9021|38      |      ;
						RTS                                  ;0E9022|60      |      ;
	
	
	conveyaerStuffGearCog:
						LDX.B r_CogwheelID                   ;0E9023|A6D4    |0000D4;
						STX.B r_CogwheelIDbackup             ;0E9025|86D2    |0000D2;
						LDA.B r_CogSize                      ;0E9027|A595    |000095;
						ASL A                                ;0E9029|0A      |      ;
						TAY                                  ;0E902A|A8      |      ;
						LDA.W cog_data,Y                     ;0E902B|B9E087  |0E87E0;
						STA.B r_pointerQueue                 ;0E902E|8508    |000008;
						LDA.W cog_data+1,Y                 ;0E9030|B9E187  |0E87E1;
						STA.B $09                            ;0E9033|8509    |000009;
						LDY.B r_CogProximity                 ;0E9035|A493    |000093;
						DEY                                  ;0E9037|88      |      ;
						BEQ CODE_0E9071                      ;0E9038|F037    |0E9071;
						DEY                                  ;0E903A|88      |      ;
						BEQ CODE_0E9089                      ;0E903B|F04C    |0E9089;
	
			CODE_0E903D:
						LDA.B r_knockBackDirrection          ;0E903D|A590    |000090;
						AND.B #$7F                           ;0E903F|297F    |      ;
						STA.B $00                            ;0E9041|8500    |000000;
						TAY                                  ;0E9043|A8      |      ;
						LDA.B (r_pointerQueue),Y             ;0E9044|B108    |000008;
						STA.W r_entity_XsubSpd             ;0E9046|8D0905  |0E0509;
						LDA.B #$00                           ;0E9049|A900    |      ;
						STA.W r_entity_Xspd                ;0E904B|8DF204  |0E04F2;
						LDA.B #$40                           ;0E904E|A940    |      ;
						SEC                                  ;0E9050|38      |      ;
						SBC.B $00                            ;0E9051|E500    |000000;
						TAY                                  ;0E9053|A8      |      ;
						LDA.B r_knockBackDirrection          ;0E9054|A590    |000090;
						BMI CODE_0E9061                      ;0E9056|3009    |0E9061;
						LDA.B (r_pointerQueue),Y             ;0E9058|B108    |000008;
						STA.W r_entity_YsubSpd             ;0E905A|8D3705  |0E0537;
						LDA.B #$00                           ;0E905D|A900    |      ;
						BEQ CODE_0E906B                      ;0E905F|F00A    |0E906B;
	
			CODE_0E9061:
						LDA.B #$00                           ;0E9061|A900    |      ;
						SEC                                  ;0E9063|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0E9064|F108    |000008;
						STA.W r_entity_YsubSpd             ;0E9066|8D3705  |0E0537;
						LDA.B #$FF                           ;0E9069|A9FF    |      ;
	
			CODE_0E906B:
						STA.W r_entity_Yspd                ;0E906B|8D2005  |0E0520;
						JMP.W CODE_0E913E                    ;0E906E|4C3E91  |0E913E;
	
	
			CODE_0E9071:
						LDX.B r_CogID                        ;0E9071|A694    |000094;
						LDA.W r_entity_Xspd,X              ;0E9073|BDF204  |0E04F2;
						STA.W r_entity_Xspd                ;0E9076|8DF204  |0E04F2;
						LDA.W r_entity_Yspd,X              ;0E9079|BD2005  |0E0520;
						STA.W r_entity_Yspd                ;0E907C|8D2005  |0E0520;
						LDA.B #$00                           ;0E907F|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9081|8D0905  |0E0509;
						STA.W r_entity_YsubSpd             ;0E9084|8D3705  |0E0537;
						SEC                                  ;0E9087|38      |      ;
						RTS                                  ;0E9088|60      |      ;
	
	
			CODE_0E9089:
						LDA.B r_knockBackDirrection          ;0E9089|A590    |000090;
						BPL CODE_0E903D                      ;0E908B|10B0    |0E903D;
						LDX.B r_CogID                        ;0E908D|A694    |000094;
						LDA.W r_entity_Xspd,X              ;0E908F|BDF204  |0E04F2;
						BPL CODE_0E90A8                      ;0E9092|1014    |0E90A8;
						STA.W r_entity_Xspd                ;0E9094|8DF204  |0E04F2;
						LDA.W r_entity_Yspd,X              ;0E9097|BD2005  |0E0520;
						STA.W r_entity_Yspd                ;0E909A|8D2005  |0E0520;
						LDA.B #$00                           ;0E909D|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E909F|8D0905  |0E0509;
						STA.W r_entity_YsubSpd             ;0E90A2|8D3705  |0E0537;
						JMP.W CODE_0E913E                    ;0E90A5|4C3E91  |0E913E;
	
	
			CODE_0E90A8:
						LDA.B #$00                           ;0E90A8|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E90AA|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E90AD|8DF204  |0E04F2;
						STA.W r_entity_YsubSpd             ;0E90B0|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0E90B3|8D2005  |0E0520;
						JMP.W CODE_0E913E                    ;0E90B6|4C3E91  |0E913E;
	
	
		conveyaerStuff_12:
						LDX.B r_CogwheelID                   ;0E90B9|A6D4    |0000D4;
						STX.B r_CogwheelIDbackup             ;0E90BB|86D2    |0000D2;
						LDA.B r_CogSize                      ;0E90BD|A595    |000095;
						ASL A                                ;0E90BF|0A      |      ;
						TAY                                  ;0E90C0|A8      |      ;
						LDA.W cog_data,Y                     ;0E90C1|B9E087  |0E87E0;
						STA.B r_pointerQueue                 ;0E90C4|8508    |000008;
						LDA.W cog_data+1,Y                 ;0E90C6|B9E187  |0E87E1;
						STA.B $09                            ;0E90C9|8509    |000009;
						LDY.B r_CogProximity                 ;0E90CB|A493    |000093;
						DEY                                  ;0E90CD|88      |      ;
						BEQ CODE_0E910A                      ;0E90CE|F03A    |0E910A;
						DEY                                  ;0E90D0|88      |      ;
						BEQ CODE_0E9122                      ;0E90D1|F04F    |0E9122;
	
			CODE_0E90D3:
						LDA.B r_knockBackDirrection          ;0E90D3|A590    |000090;
						AND.B #$7F                           ;0E90D5|297F    |      ;
						STA.B $00                            ;0E90D7|8500    |000000;
						TAY                                  ;0E90D9|A8      |      ;
						LDA.B #$00                           ;0E90DA|A900    |      ;
						SEC                                  ;0E90DC|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0E90DD|F108    |000008;
						STA.W r_entity_XsubSpd             ;0E90DF|8D0905  |0E0509;
						LDA.B #$FF                           ;0E90E2|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E90E4|8DF204  |0E04F2;
						LDA.B #$40                           ;0E90E7|A940    |      ;
						SEC                                  ;0E90E9|38      |      ;
						SBC.B $00                            ;0E90EA|E500    |000000;
						TAY                                  ;0E90EC|A8      |      ;
						LDA.B r_knockBackDirrection          ;0E90ED|A590    |000090;
						BMI CODE_0E90FD                      ;0E90EF|300C    |0E90FD;
						LDA.B #$00                           ;0E90F1|A900    |      ;
						SEC                                  ;0E90F3|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0E90F4|F108    |000008;
						STA.W r_entity_YsubSpd             ;0E90F6|8D3705  |0E0537;
						LDA.B #$FF                           ;0E90F9|A9FF    |      ;
						BNE CODE_0E9104                      ;0E90FB|D007    |0E9104;
	
			CODE_0E90FD:
						LDA.B (r_pointerQueue),Y             ;0E90FD|B108    |000008;
						STA.W r_entity_YsubSpd             ;0E90FF|8D3705  |0E0537;
						LDA.B #$00                           ;0E9102|A900    |      ;
	
			CODE_0E9104:
						STA.W r_entity_Yspd                ;0E9104|8D2005  |0E0520;
						JMP.W CODE_0E913E                    ;0E9107|4C3E91  |0E913E;
	
	
			CODE_0E910A:
						LDX.B r_CogID                        ;0E910A|A694    |000094;
						LDA.W r_entity_Xspd,X              ;0E910C|BDF204  |0E04F2;
						STA.W r_entity_Xspd                ;0E910F|8DF204  |0E04F2;
						LDA.W r_entity_Yspd,X              ;0E9112|BD2005  |0E0520;
						STA.W r_entity_Yspd                ;0E9115|8D2005  |0E0520;
						LDA.B #$00                           ;0E9118|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E911A|8D0905  |0E0509;
						STA.W r_entity_YsubSpd             ;0E911D|8D3705  |0E0537;
						SEC                                  ;0E9120|38      |      ;
						RTS                                  ;0E9121|60      |      ;
	
	
			CODE_0E9122:
						LDA.B r_knockBackDirrection          ;0E9122|A590    |000090;
						BMI CODE_0E90D3                      ;0E9124|30AD    |0E90D3;
						LDX.B r_CogID                        ;0E9126|A694    |000094;
						LDA.W r_entity_Xspd,X              ;0E9128|BDF204  |0E04F2;
						BMI CODE_0E9143                      ;0E912B|3016    |0E9143;
						STA.W r_entity_Xspd                ;0E912D|8DF204  |0E04F2;
						LDA.W r_entity_Yspd,X              ;0E9130|BD2005  |0E0520;
						STA.W r_entity_Yspd                ;0E9133|8D2005  |0E0520;
						LDA.B #$00                           ;0E9136|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9138|8D0905  |0E0509;
						STA.W r_entity_YsubSpd             ;0E913B|8D3705  |0E0537;
	
			CODE_0E913E:
						JSR.W CODE_0E8001                    ;0E913E|200180  |0E8001;
						SEC                                  ;0E9141|38      |      ;
						RTS                                  ;0E9142|60      |      ;
	
	
			CODE_0E9143:
						LDA.B #$00                           ;0E9143|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9145|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E9148|8DF204  |0E04F2;
						STA.W r_entity_YsubSpd             ;0E914B|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0E914E|8D2005  |0E0520;
						BEQ CODE_0E913E                      ;0E9151|F0EB    |0E913E;
	
	playerKnockback_00:
						LDA.W r_entity_Xspd                ;0E9153|ADF204  |0E04F2;
						BMI CODE_0E915C                      ;0E9156|3004    |0E915C;
						LDA.B #$08                           ;0E9158|A908    |      ;
						BNE CODE_0E915E                      ;0E915A|D002    |0E915E;
	
			CODE_0E915C:
						LDA.B #$F8                           ;0E915C|A9F8    |      ;
	
			CODE_0E915E:
						STA.B $00                            ;0E915E|8500    |000000;
						LDX.B #$00                           ;0E9160|A200    |      ;
						db $20                               ;0E9162|        |      ;
						dw playerCollusionCheck              ;0E9163|        |0FFCDD;
						BEQ CODE_0E9169                      ;0E9165|F002    |0E9169;
	
			CODE_0E9167:
						SEC                                  ;0E9167|38      |      ;
						RTS                                  ;0E9168|60      |      ;
	
	
			CODE_0E9169:
						LDY.B r_currPartnerID                ;0E9169|A482    |000082;
	
			CODE_0E916B:
						STY.B $01                            ;0E916B|8401    |000001;
						LDA.W currPartnerData,Y              ;0E916D|B98691  |0E9186;
						TAX                                  ;0E9170|AA      |      ;
						LDA.B $00                            ;0E9171|A500    |000000;
						db $20                               ;0E9173|        |      ;
						dw playerCollusionCheck              ;0E9174|        |0FFCDD;
						BNE CODE_0E9167                      ;0E9176|D0EF    |0E9167;
						LDA.B $01                            ;0E9178|A501    |000001;
						CLC                                  ;0E917A|18      |      ;
						ADC.B #$04                           ;0E917B|6904    |      ;
						CMP.B #$08                           ;0E917D|C908    |      ;
						BCS CODE_0E9184                      ;0E917F|B003    |0E9184;
						TAY                                  ;0E9181|A8      |      ;
						BNE CODE_0E916B                      ;0E9182|D0E7    |0E916B;
	
			CODE_0E9184:
						CLC                                  ;0E9184|18      |      ;
						RTS                                  ;0E9185|60      |      ;
	
	
		currPartnerData:
						db $F0,$F0,$F4,$F0,$0F,$0F,$0B,$0F   ;0E9186|        |      ;
	
	playerConveyaerCheck:
						LDA.B r_conveyaerRoomEffect          ;0E918E|A58B    |00008B;
						BNE playerIsOnCanveyaer              ;0E9190|D001    |0E9193;
	
			CODE_0E9192:
						RTS                                  ;0E9192|60      |      ;
	
	
	playerIsOnCanveyaer:
						CMP.B #$01                           ;0E9193|C901    |      ;
						BEQ CODE_0E91F9                      ;0E9195|F062    |0E91F9;
						SEC                                  ;0E9197|38      |      ;
						SBC.B #$05                           ;0E9198|E905    |      ;
						BCC CODE_0E9192                      ;0E919A|90F6    |0E9192;
						BNE CODE_0E91A1                      ;0E919C|D003    |0E91A1;
						JMP.W do_playerKnockback             ;0E919E|4C1493  |0E9314;
	
	
			CODE_0E91A1:
						TAY                                  ;0E91A1|A8      |      ;
						DEY                                  ;0E91A2|88      |      ;
						BNE CODE_0E91A8                      ;0E91A3|D003    |0E91A8;
						JMP.W CODE_0E9340                    ;0E91A5|4C4093  |0E9340;
	
	
			CODE_0E91A8:
						DEY                                  ;0E91A8|88      |      ;
						DEY                                  ;0E91A9|88      |      ;
						BNE CODE_0E91AF                      ;0E91AA|D003    |0E91AF;
						JMP.W CODE_0E9242                    ;0E91AC|4C4292  |0E9242;
	
	
			CODE_0E91AF:
						DEY                                  ;0E91AF|88      |      ;
						BNE CODE_0E91B5                      ;0E91B0|D003    |0E91B5;
						JMP.W CODE_0E9288                    ;0E91B2|4C8892  |0E9288;
	
	
			CODE_0E91B5:
						DEY                                  ;0E91B5|88      |      ;
						BNE CODE_0E91BB                      ;0E91B6|D003    |0E91BB;
						JMP.W CODE_0E92BB                    ;0E91B8|4CBB92  |0E92BB;
	
	
			CODE_0E91BB:
						DEY                                  ;0E91BB|88      |      ;
						BNE CODE_0E91C1                      ;0E91BC|D003    |0E91C1;
						JMP.W CODE_0E92EE                    ;0E91BE|4CEE92  |0E92EE;
	
	
			CODE_0E91C1:
						RTS                                  ;0E91C1|60      |      ;
	
	
		conveyaerStuff_10:
						CMP.B #$6E                           ;0E91C2|C96E    |      ;
						BEQ CODE_0E91F2                      ;0E91C4|F02C    |0E91F2;
						CMP.B #$74                           ;0E91C6|C974    |      ;
						BEQ CODE_0E91F2                      ;0E91C8|F028    |0E91F2;
						CMP.B #$76                           ;0E91CA|C976    |      ;
						BEQ CODE_0E91D5                      ;0E91CC|F007    |0E91D5;
						CMP.B #$78                           ;0E91CE|C978    |      ;
						BEQ CODE_0E91D5                      ;0E91D0|F003    |0E91D5;
	
			CODE_0E91D2:
						LDX.B r_ConveyorRelated              ;0E91D2|A691    |000091;
						RTS                                  ;0E91D4|60      |      ;
	
	
			CODE_0E91D5:
						LDA.W r_entity_Yspd,X              ;0E91D5|BD2005  |0E0520;
						BPL CODE_0E91D2                      ;0E91D8|10F8    |0E91D2;
	
			CODE_0E91DA:
						LDA.B #$FB                           ;0E91DA|A9FB    |      ;
						LDX.B #$F8                           ;0E91DC|A2F8    |      ;
						db $20                               ;0E91DE|        |      ;
						dw playerCollusionCheck              ;0E91DF|        |0FFCDD;
						BNE CODE_0E91EC                      ;0E91E1|D009    |0E91EC;
						LDA.B #$05                           ;0E91E3|A905    |      ;
						LDX.B #$F8                           ;0E91E5|A2F8    |      ;
						db $20                               ;0E91E7|        |      ;
						dw playerCollusionCheck              ;0E91E8|        |0FFCDD;
						BEQ CODE_0E91D2                      ;0E91EA|F0E6    |0E91D2;
	
			CODE_0E91EC:
						LDA.B #$10                           ;0E91EC|A910    |      ;
						STA.B r_delayElevators               ;0E91EE|85AF    |0000AF;
						BNE CODE_0E91D2                      ;0E91F0|D0E0    |0E91D2;
	
			CODE_0E91F2:
						LDA.W r_damagActionFlag,X       ;0E91F2|BD1D06  |0E061D;
						BEQ CODE_0E91D2                      ;0E91F5|F0DB    |0E91D2;
						BNE CODE_0E91DA                      ;0E91F7|D0E1    |0E91DA;
	
			CODE_0E91F9:
						LDX.B r_ConveyorRelated              ;0E91F9|A691    |000091;
						STX.B r_platformIDFrozenEnemy        ;0E91FB|86B8    |0000B8;
						LDA.W r_entity_ID,X       ;0E91FD|BD4E05  |0E054E;
						CMP.B #$79                           ;0E9200|C979    |      ;
						BCC CODE_0E9237                      ;0E9202|9033    |0E9237;
						JSR.W conveyaerStuff_10              ;0E9204|20C291  |0E91C2;
						LDA.B r_currPartnerID                ;0E9207|A582    |000082;
						CMP.B #$04                           ;0E9209|C904    |      ;
						BCS CODE_0E9226                      ;0E920B|B019    |0E9226;
						LDA.W r_entity_Xspd,X              ;0E920D|BDF204  |0E04F2;
						BPL CODE_0E921D                      ;0E9210|100B    |0E921D;
						LDA.B #$F8                           ;0E9212|A9F8    |      ;
						LDX.B #$F0                           ;0E9214|A2F0    |      ;
						db $20                               ;0E9216|        |      ;
						dw playerCollusionCheck              ;0E9217|        |0FFCDD;
						BNE CODE_0E9237                      ;0E9219|D01C    |0E9237;
						BEQ CODE_0E9226                      ;0E921B|F009    |0E9226;
	
			CODE_0E921D:
						LDA.B #$08                           ;0E921D|A908    |      ;
						LDX.B #$F0                           ;0E921F|A2F0    |      ;
						db $20                               ;0E9221|        |      ;
						dw playerCollusionCheck              ;0E9222|        |0FFCDD;
						BNE CODE_0E9237                      ;0E9224|D011    |0E9237;
	
			CODE_0E9226:
						LDX.B r_ConveyorRelated              ;0E9226|A691    |000091;
						LDA.W r_entity_XsubSpd,X           ;0E9228|BD0905  |0E0509;
						STA.W r_entity_XsubSpd             ;0E922B|8D0905  |0E0509;
						LDA.W r_entity_Xspd,X              ;0E922E|BDF204  |0E04F2;
						STA.W r_entity_Xspd                ;0E9231|8DF204  |0E04F2;
						JMP.W playerKnockback_01             ;0E9234|4C3A87  |0E873A;
	
	
			CODE_0E9237:
						LDA.B #$00                           ;0E9237|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9239|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E923C|8DF204  |0E04F2;
						JMP.W playerKnockback_01             ;0E923F|4C3A87  |0E873A;
	
	
			CODE_0E9242:
						LDA.B r_gameTransition               ;0E9242|A52A    |00002A;
						CMP.B #$1B                           ;0E9244|C91B    |      ;
						BEQ CODE_0E925A                      ;0E9246|F012    |0E925A;
						LDX.B #$01                           ;0E9248|A201    |      ;
						LDA.B #$F8                           ;0E924A|A9F8    |      ;
						db $20                               ;0E924C|        |      ;
						dw playerCollusionCheck              ;0E924D|        |0FFCDD;
						BNE CODE_0E925A                      ;0E924F|D009    |0E925A;
						LDX.B #$F0                           ;0E9251|A2F0    |      ;
						LDA.B #$F8                           ;0E9253|A9F8    |      ;
						db $20                               ;0E9255|        |      ;
						dw playerCollusionCheck              ;0E9256|        |0FFCDD;
						BEQ CODE_0E925B                      ;0E9258|F001    |0E925B;
	
			CODE_0E925A:
						RTS                                  ;0E925A|60      |      ;
	
	
			CODE_0E925B:
						LDA.B r_currPartnerID                ;0E925B|A582    |000082;
						AND.B #$0C                           ;0E925D|290C    |      ;
						BNE CODE_0E926E                      ;0E925F|D00D    |0E926E;
						LDA.B #$FF                           ;0E9261|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E9263|8DF204  |0E04F2;
						LDA.B #$40                           ;0E9266|A940    |      ;
						STA.W r_entity_XsubSpd             ;0E9268|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E926B|4C3A87  |0E873A;
	
	
			CODE_0E926E:
						LDA.B #$FF                           ;0E926E|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E9270|8DF204  |0E04F2;
						LDA.B #$A0                           ;0E9273|A9A0    |      ;
						STA.W r_entity_XsubSpd             ;0E9275|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E9278|4C3A87  |0E873A;
	
	
			CODE_0E927B:
						LDA.B #$00                           ;0E927B|A900    |      ;
						STA.W r_entity_Xspd                ;0E927D|8DF204  |0E04F2;
						LDA.B #$60                           ;0E9280|A960    |      ;
						STA.W r_entity_XsubSpd             ;0E9282|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E9285|4C3A87  |0E873A;
	
	
			CODE_0E9288:
						LDX.B #$01                           ;0E9288|A201    |      ;
						LDA.B #$08                           ;0E928A|A908    |      ;
						db $20                               ;0E928C|        |      ;
						dw playerCollusionCheck              ;0E928D|        |0FFCDD;
						BNE CODE_0E929A                      ;0E928F|D009    |0E929A;
						LDX.B #$F0                           ;0E9291|A2F0    |      ;
						LDA.B #$08                           ;0E9293|A908    |      ;
						db $20                               ;0E9295|        |      ;
						dw playerCollusionCheck              ;0E9296|        |0FFCDD;
						BEQ CODE_0E929B                      ;0E9298|F001    |0E929B;
	
			CODE_0E929A:
						RTS                                  ;0E929A|60      |      ;
	
	
			CODE_0E929B:
						LDA.B r_currPartnerID                ;0E929B|A582    |000082;
						AND.B #$0C                           ;0E929D|290C    |      ;
						BNE CODE_0E927B                      ;0E929F|D0DA    |0E927B;
						LDA.B #$00                           ;0E92A1|A900    |      ;
						STA.W r_entity_Xspd                ;0E92A3|8DF204  |0E04F2;
						LDA.B #$C0                           ;0E92A6|A9C0    |      ;
						STA.W r_entity_XsubSpd             ;0E92A8|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E92AB|4C3A87  |0E873A;
	
	
			CODE_0E92AE:
						LDA.B #$FF                           ;0E92AE|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E92B0|8DF204  |0E04F2;
						LDA.B #$C0                           ;0E92B3|A9C0    |      ;
						STA.W r_entity_XsubSpd             ;0E92B5|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E92B8|4C3A87  |0E873A;
	
	
			CODE_0E92BB:
						LDX.B #$01                           ;0E92BB|A201    |      ;
						LDA.B #$F8                           ;0E92BD|A9F8    |      ;
						db $20                               ;0E92BF|        |      ;
						dw playerCollusionCheck              ;0E92C0|        |0FFCDD;
						BNE CODE_0E92CD                      ;0E92C2|D009    |0E92CD;
						LDX.B #$F0                           ;0E92C4|A2F0    |      ;
						LDA.B #$F8                           ;0E92C6|A9F8    |      ;
						db $20                               ;0E92C8|        |      ;
						dw playerCollusionCheck              ;0E92C9|        |0FFCDD;
						BEQ CODE_0E92CE                      ;0E92CB|F001    |0E92CE;
	
			CODE_0E92CD:
						RTS                                  ;0E92CD|60      |      ;
	
	
			CODE_0E92CE:
						LDA.B r_currPartnerID                ;0E92CE|A582    |000082;
						AND.B #$0C                           ;0E92D0|290C    |      ;
						BNE CODE_0E92AE                      ;0E92D2|D0DA    |0E92AE;
						LDA.B #$FF                           ;0E92D4|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E92D6|8DF204  |0E04F2;
						LDA.B #$80                           ;0E92D9|A980    |      ;
						STA.W r_entity_XsubSpd             ;0E92DB|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E92DE|4C3A87  |0E873A;
	
	
			CODE_0E92E1:
						LDA.B #$00                           ;0E92E1|A900    |      ;
						STA.W r_entity_Xspd                ;0E92E3|8DF204  |0E04F2;
						LDA.B #$40                           ;0E92E6|A940    |      ;
						STA.W r_entity_XsubSpd             ;0E92E8|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E92EB|4C3A87  |0E873A;
	
	
			CODE_0E92EE:
						LDX.B #$01                           ;0E92EE|A201    |      ;
						LDA.B #$08                           ;0E92F0|A908    |      ;
						db $20                               ;0E92F2|        |      ;
						dw playerCollusionCheck              ;0E92F3|        |0FFCDD;
						BNE CODE_0E9300                      ;0E92F5|D009    |0E9300;
						LDX.B #$F0                           ;0E92F7|A2F0    |      ;
						LDA.B #$08                           ;0E92F9|A908    |      ;
						db $20                               ;0E92FB|        |      ;
						dw playerCollusionCheck              ;0E92FC|        |0FFCDD;
						BEQ CODE_0E9301                      ;0E92FE|F001    |0E9301;
	
			CODE_0E9300:
						RTS                                  ;0E9300|60      |      ;
	
	
			CODE_0E9301:
						LDA.B r_currPartnerID                ;0E9301|A582    |000082;
						AND.B #$0C                           ;0E9303|290C    |      ;
						BNE CODE_0E92E1                      ;0E9305|D0DA    |0E92E1;
						LDA.B #$00                           ;0E9307|A900    |      ;
						STA.W r_entity_Xspd                ;0E9309|8DF204  |0E04F2;
						LDA.B #$80                           ;0E930C|A980    |      ;
						STA.W r_entity_XsubSpd             ;0E930E|8D0905  |0E0509;
						JMP.W playerKnockback_01             ;0E9311|4C3A87  |0E873A;
	
	
	do_playerKnockback:
						LDA.B #$00                           ;0E9314|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9316|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E9319|8DF204  |0E04F2;
						STA.W r_entity_YsubSpd             ;0E931C|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0E931F|8D2005  |0E0520;
						JSR.W setKnockBackSpd                ;0E9322|207780  |0E8077;
						JSR.W playerKnockback_00             ;0E9325|205391  |0E9153;
						BCS CODE_0E9330                      ;0E9328|B006    |0E9330;
	
			CODE_0E932A:
						JSR.W playerKnockback_01             ;0E932A|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0E932D|4C1287  |0E8712;
	
	
			CODE_0E9330:
						LDA.B #$00                           ;0E9330|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9332|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E9335|8DF204  |0E04F2;
						STA.W r_entity_YsubSpd             ;0E9338|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0E933B|8D2005  |0E0520;
						BEQ CODE_0E932A                      ;0E933E|F0EA    |0E932A;
	
			CODE_0E9340:
						LDX.B r_CogwheelID                   ;0E9340|A6D4    |0000D4;
						STX.B r_CogwheelIDbackup             ;0E9342|86D2    |0000D2;
						LDY.B r_CogProximity                 ;0E9344|A493    |000093;
						DEY                                  ;0E9346|88      |      ;
						BEQ CODE_0E9363                      ;0E9347|F01A    |0E9363;
						DEY                                  ;0E9349|88      |      ;
						BEQ CODE_0E9363                      ;0E934A|F017    |0E9363;
						LDA.B #$00                           ;0E934C|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E934E|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E9351|8DF204  |0E04F2;
						STA.W r_entity_YsubSpd             ;0E9354|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0E9357|8D2005  |0E0520;
						JSR.W CODE_0E8001                    ;0E935A|200180  |0E8001;
	
			CODE_0E935D:
						JSR.W playerKnockback_01             ;0E935D|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0E9360|4C1287  |0E8712;
	
	
			CODE_0E9363:
						LDX.B r_CogID                        ;0E9363|A694    |000094;
						LDA.W r_entity_Xspd,X              ;0E9365|BDF204  |0E04F2;
						STA.W r_entity_Xspd                ;0E9368|8DF204  |0E04F2;
						LDA.W r_entity_Yspd,X              ;0E936B|BD2005  |0E0520;
						STA.W r_entity_Yspd                ;0E936E|8D2005  |0E0520;
						LDA.B #$00                           ;0E9371|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9373|8D0905  |0E0509;
						STA.W r_entity_YsubSpd             ;0E9376|8D3705  |0E0537;
						BEQ CODE_0E935D                      ;0E9379|F0E2    |0E935D;

}
	

{ ; trevor 		
			trevorState:
						LDY.W r_Player_StateDoubled        ;0E937B|AC6505  |0E0565;
						db $20                               ;0E937E|        |      ;
						dw jumpFromStack                     ;0E937F|        |0FE886;
						dw player_state00_init               ;0E9381|        |0E8AC5;
						dw player_state02_standIdle          ;0E9383|        |0E9538;
						dw player_state04_walking_exceptGrant;0E9385|        |0E9660;
						dw player_state06_jumpStart_exceptGrant;0E9387|        |0E961D;
						dw player_state08_0c_jump            ;0E9389|        |0E9770;
						dw player_state0a_ducking_exceptGrant;0E938B|        |0E9919;
						dw player_state08_0c_jump            ;0E938D|        |0E9770;
						dw player_state0e_walkToStair        ;0E938F|        |0E9953;
						dw player_state10_startClimb         ;0E9391|        |0E9967;
						dw player_state12_stairIdle          ;0E9393|        |0E998E;
						dw player_state14_stairClimb         ;0E9395|        |0E9A93;
						dw player_state16_transition         ;0E9397|        |0E9942;
						dw player_state18_attack_trevor_sypha;0E9399|        |0E9418;
						dw player_state1a_airAttack_trevor_sypha;0E939B|        |0E943A;
						dw player_state1c_duckAttack_trevor_sypha;0E939D|        |0E9465;
						dw player_state1e_stairAttack_exceptAlucard;0E939F|        |0E949E;
						dw player_subWe_state20              ;0E93A1|        |0E94B8;
						dw player_subW_air_state22_exceptGrant;0E93A3|        |0E94D4;
						dw player_SubWeStair_state24          ;0E93A5|        |0E94FF;
						dw player_state26_hit                ;0E93A7|        |0E831C;
						dw player_state28_2a                 ;0E93A9|        |0E93B1;
						dw player_state28_2a                 ;0E93AB|        |0E93B1;
						dw player_state2c_pitFall            ;0E93AD|        |0E8B57;
						dw player_state2e                    ;0E93AF|        |0E8ADE;
	
		player_state28_2a:
						LDA.B #$02                           ;0E93B1|A902    |      ;
						STA.W r_entity_spriteID          ;0E93B3|8D0004  |0E0400;
						DEC.W $05D4                          ;0E93B6|CED405  |0E05D4;
						BEQ CODE_0E93DB                      ;0E93B9|F020    |0E93DB;
						LDA.B #$02                           ;0E93BB|A902    |      ;
						STA.W r_entity_PaletteOverride     ;0E93BD|8D5404  |0E0454;
						LDA.W r_stairsStuneTimer           ;0E93C0|ADEB05  |0E05EB;
						BNE doStairStuneTimer                ;0E93C3|D021    |0E93E6;
						JSR.W playerCollusion                ;0E93C5|202184  |0E8421;
						BCC CODE_0E93CB                      ;0E93C8|9001    |0E93CB;
						RTS                                  ;0E93CA|60      |      ;
	
	
			CODE_0E93CB:
						LDA.B #$01                           ;0E93CB|A901    |      ;
						STA.W r_stairsStuneTimer           ;0E93CD|8DEB05  |0E05EB;
						LDA.B #$0C                           ;0E93D0|A90C    |      ;
						STA.W r_entity_extra               ;0E93D2|8DD805  |0E05D8;
						LDA.B #$01                           ;0E93D5|A901    |      ;
						STA.W r_entity_AI_IDX          ;0E93D7|8DC105  |0E05C1;
						RTS                                  ;0E93DA|60      |      ;
	
	
			CODE_0E93DB:
						LDA.B #$00                           ;0E93DB|A900    |      ;
						STA.W r_entity_PaletteOverride     ;0E93DD|8D5404  |0E0454;
						LDA.B #$02                           ;0E93E0|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E93E2|8D6505  |0E0565;
	
			CODE_0E93E5:
						RTS                                  ;0E93E5|60      |      ;
	
	
		doStairStuneTimer:
						JSR.W doStairStuneTimer__00          ;0E93E6|204F98  |0E984F;
						LDA.W r_entity_AI_IDX          ;0E93E9|ADC105  |0E05C1;
						BEQ CODE_0E93E5                      ;0E93EC|F0F7    |0E93E5;
						LDX.B #$10                           ;0E93EE|A210    |      ;
						LDA.B #$FB                           ;0E93F0|A9FB    |      ;
						db $20                               ;0E93F2|        |      ;
						dw playerCollusionCheck              ;0E93F3|        |0FFCDD;
						BNE CODE_0E9401                      ;0E93F5|D00A    |0E9401;
						LDX.B #$10                           ;0E93F7|A210    |      ;
						LDA.B #$05                           ;0E93F9|A905    |      ;
						db $20                               ;0E93FB|        |      ;
						dw playerCollusionCheck              ;0E93FC|        |0FFCDD;
						BNE CODE_0E9401                      ;0E93FE|D001    |0E9401;
						RTS                                  ;0E9400|60      |      ;
	
	
			CODE_0E9401:
						JSR.W CODE_0E8A02                    ;0E9401|20028A  |0E8A02;
						LDA.B #$00                           ;0E9404|A900    |      ;
						STA.W r_stairsStuneTimer           ;0E9406|8DEB05  |0E05EB;
						RTS                                  ;0E9409|60      |      ;
	
	
		storeAttackState_slashSound:
						
				if !grantNinjaStar == 1 	
						STA.W r_Player_StateDoubled  							
						txa 
						pha 
						
						lda #$02
						cmp.w r_entity_ID
						bne notGrant
						jsr initGrantNewAxe
						bcs +
						
					notGrant:
						LDA.B #$72                      
						jsr lunchMusic                  
					
					+	LDA.B #$00           			; attack flag.. freezes if unset            
						STA.W $0578                     
						
						pla 
						tax 	
						rts 	
				
				else  							
						STA.W r_Player_StateDoubled        ;0E940A|8D6505  |0E0565;
						LDA.B #$72                           ;0E940D|A972    |      ;
						jsr lunchMusic                        ;0E9410|        |0FE25F;
						LDA.B #$00                           ;0E9412|A900    |      ;
						STA.W $0578                          ;0E9414|8D7805  |0E0578;
						RTS                                  ;0E9417|60      |      ;
				endif 
	
	player_state18_attack_trevor_sypha:
						JSR.W playerCollusion                ;0E9418|202184  |0E8421;
						BCS CODE_0E9425                      ;0E941B|B008    |0E9425;
	
			CODE_0E941D:
						LDA.B #$00                           ;0E941D|A900    |      ;
						STA.W $0413                          ;0E941F|8D1304  |0E0413;
						JMP.W playerFallingJuming               ;0E9422|4C3A97  |0E973A;
	
	
			CODE_0E9425:
						JSR.W playerConveyaerCheck           ;0E9425|208E91  |0E918E;
	
			playerAttackRoutine:
						JSR.W playerAttackAnim_routine       ;0E9428|2089BC  |0EBC89;
						BCS CODE_0E942E                      ;0E942B|B001    |0E942E;
						RTS                                  ;0E942D|60      |      ;
	
	
			CODE_0E942E:
						LDA.B #$02                           ;0E942E|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E9430|8D6505  |0E0565;
						LDA.B #$02                           ;0E9433|A902    |      ;
						STA.W r_entity_spriteID          ;0E9435|8D0004  |0E0400;
						SEC                                  ;0E9438|38      |      ;
						RTS                                  ;0E9439|60      |      ;
	
	
	player_state1a_airAttack_trevor_sypha:
						if !jumpControllDirection == 1					
							jsr jumpControll
							
						endif                      
						
						JSR.W playerJump_init_00             ;0E943A|209C97  |0E979C;
						LDA.W r_Player_StateDoubled        ;0E943D|AD6505  |0E0565;
						CMP.B #$26                           ;0E9440|C926    |      ;
						BEQ CODE_0E9459                      ;0E9442|F015    |0E9459;
						CMP.B #$02                           ;0E9444|C902    |      ;
						BNE CODE_0E9454                      ;0E9446|D00C    |0E9454;
						LDA.B #$00                           ;0E9448|A900    |      ;
						STA.B r_timerClunk_drop              ;0E944A|85B9    |0000B9;
						LDA.B #$18                           ;0E944C|A918    |      ;
						STA.W r_Player_StateDoubled        ;0E944E|8D6505  |0E0565;
						JMP.W playerAttackRoutine                    ;0E9451|4C2894  |0E9428;
	
	
			CODE_0E9454:
						JSR.W playerAttackAnim_routine       ;0E9454|2089BC  |0EBC89;
						BCS CODE_0E945A                      ;0E9457|B001    |0E945A;
	
			CODE_0E9459:
						RTS                                  ;0E9459|60      |      ;
	
	
			CODE_0E945A:
						LDA.B #$08                           ;0E945A|A908    |      ;
						STA.W r_Player_StateDoubled        ;0E945C|8D6505  |0E0565;
						LDA.B #$02                           ;0E945F|A902    |      ;
						STA.W r_entity_spriteID          ;0E9461|8D0004  |0E0400;
						RTS                                  ;0E9464|60      |      ;
	
	
	player_state1c_duckAttack_trevor_sypha:
						JSR.W playerCollusion                ;0E9465|202184  |0E8421;
						BCS CODE_0E946D                      ;0E9468|B003    |0E946D;
						JMP.W CODE_0E941D                    ;0E946A|4C1D94  |0E941D;
	
	
			CODE_0E946D:
						JSR.W playerConveyaerCheck           ;0E946D|208E91  |0E918E;
						JSR.W checkPlayerHoldDown            ;0E9470|203699  |0E9936;
						
				if !jumpControllMovment == 1	
						LDA.W r_Player_StateDoubled     
						CMP.B #$02                      
						BNE CODE_0E948D                 
						LDA.B #$1C                      
						STA.W r_Player_StateDoubled     
						jmp playerAttackRoutine       																
				else 		
						LDA.W r_Player_StateDoubled        ;0E9473|AD6505  |0E0565;
						CMP.B #$02                           ;0E9476|C902    |      ;
						BNE CODE_0E948D                      ;0E9478|D013    |0E948D;
						LDA.B #$18                           ;0E947A|A918    |      ;
						STA.W r_Player_StateDoubled        ;0E947C|8D6505  |0E0565;
						JSR.W playerAttackRoutine                    ;0E947F|202894  |0E9428;
						LDA.W r_Player_StateDoubled        ;0E9482|AD6505  |0E0565;
						CMP.B #$18                           ;0E9485|C918    |      ;
						BNE CODE_0E948C                      ;0E9487|D003    |0E948C;
						JSR.W characterThrowAnim                    ;0E9489|20CBBE  |0EBECB;
	
			CODE_0E948C:
						RTS                                  ;0E948C|60      |      ;
				endif 
	
			CODE_0E948D:
						JSR.W playerAttackAnim_routine       ;0E948D|2089BC  |0EBC89;
						BCS CODE_0E9493                      ;0E9490|B001    |0E9493;
						RTS                                  ;0E9492|60      |      ;
	
	
			CODE_0E9493:
						LDA.B #$0A                           ;0E9493|A90A    |      ;
						STA.W r_Player_StateDoubled        ;0E9495|8D6505  |0E0565;
						LDA.B #$0E                           ;0E9498|A90E    |      ;
						STA.W r_entity_spriteID          ;0E949A|8D0004  |0E0400;
						RTS                                  ;0E949D|60      |      ;
	
	
	player_state1e_stairAttack_exceptAlucard:						
						
						JSR.W playerAttackAnim_routine       ;0E949E|2089BC  |0EBC89;
						BCS CODE_0E94A4                      ;0E94A1|B001    |0E94A4;
						RTS                                  ;0E94A3|60      |      ;
		
						
	
	
			CODE_0E94A4:
						LDA.B #$12                           ;0E94A4|A912    |      ;
						STA.W r_Player_StateDoubled        ;0E94A6|8D6505  |0E0565;
						RTS                                  ;0E94A9|60      |      ;
	
	
		initPlayerState_A:
						STA.W r_Player_StateDoubled        ;0E94AA|8D6505  |0E0565;
						LDA.B #$00                           ;0E94AD|A900    |      ;
						STA.W r_entity_OamBaseOffset       ;0E94AF|8D9305  |0E0593;
						LDA.B #$01                           ;0E94B2|A901    |      ;
						STA.W r_entity_AnimTimer           ;0E94B4|8D7C05  |0E057C;
						RTS                                  ;0E94B7|60      |      ;
	
	
	player_subWe_state20:
						JSR.W playerCollusion                ;0E94B8|202184  |0E8421;
						BCS CODE_0E94C0                      ;0E94BB|B003    |0E94C0;
						JMP.W playerFallingJuming               ;0E94BD|4C3A97  |0E973A;
	
	
			CODE_0E94C0:
						JSR.W playerConveyaerCheck           ;0E94C0|208E91  |0E918E;
	
			CODE_0E94C3:
						JSR.W player_animCountDown           ;0E94C3|20F2BA  |0EBAF2;
						BCS CODE_0E94C9                      ;0E94C6|B001    |0E94C9;
						RTS                                  ;0E94C8|60      |      ;
	
	
			CODE_0E94C9:
						LDA.B #$02                           ;0E94C9|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E94CB|8D6505  |0E0565;
						LDA.B #$02                           ;0E94CE|A902    |      ;
						STA.W r_entity_spriteID          ;0E94D0|8D0004  |0E0400;
						RTS                                  ;0E94D3|60      |      ;
	
	
	player_subW_air_state22_exceptGrant:
						JSR.W playerJump_init_00             ;0E94D4|209C97  |0E979C;
						LDA.W r_Player_StateDoubled        ;0E94D7|AD6505  |0E0565;
						CMP.B #$26                           ;0E94DA|C926    |      ;
						BEQ CODE_0E94F3                      ;0E94DC|F015    |0E94F3;
						CMP.B #$02                           ;0E94DE|C902    |      ;
						BNE CODE_0E94EE                      ;0E94E0|D00C    |0E94EE;
						LDA.B #$00                           ;0E94E2|A900    |      ;
						STA.B r_timerClunk_drop              ;0E94E4|85B9    |0000B9;
						LDA.B #$20                           ;0E94E6|A920    |      ;
						STA.W r_Player_StateDoubled        ;0E94E8|8D6505  |0E0565;
						JMP.W CODE_0E94C3                    ;0E94EB|4CC394  |0E94C3;
	
	
			CODE_0E94EE:
						JSR.W player_animCountDown           ;0E94EE|20F2BA  |0EBAF2;
						BCS CODE_0E94F4                      ;0E94F1|B001    |0E94F4;
	
			CODE_0E94F3:
						RTS                                  ;0E94F3|60      |      ;
	
	
			CODE_0E94F4:
						LDA.B #$08                           ;0E94F4|A908    |      ;
						STA.W r_Player_StateDoubled        ;0E94F6|8D6505  |0E0565;
						LDA.B #$02                           ;0E94F9|A902    |      ;
						STA.W r_entity_spriteID          ;0E94FB|8D0004  |0E0400;
						RTS                                  ;0E94FE|60      |      ;
	
	
	player_SubWeStair_state24:
						
			if !alucardStairAttack == 1 
						jsr alucardAttackStairs 
			else 			
						JSR.W player_animCountDown                    ;0E94FF|20F2BA  |0EBAF2;
			endif							
						
						BCS continueStair                    ;0E9502|B001    |0E9505;
						RTS                                  ;0E9504|60      |      ;
	
	
			continueStair:
						LDA.B #$12                           ;0E9505|A912    |      ;
						STA.W r_Player_StateDoubled        ;0E9507|8D6505  |0E0565;
						RTS                                  ;0E950A|60      |      ;
	
	
			CODE_0E950B:
						LDA.W r_entity_ID         ;0E950B|AD4E05  |0E054E;
						CMP.B #$02                           ;0E950E|C902    |      ;
						BEQ CODE_0E9534                      ;0E9510|F022    |0E9534;
						LDX.B #$E8                           ;0E9512|A2E8    |      ;
						LDA.B #$FB                           ;0E9514|A9FB    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9516|200B84  |0E840B;
						BEQ CODE_0E9523                      ;0E9519|F008    |0E9523;
						CMP.B #$05                           ;0E951B|C905    |      ;
						BEQ CODE_0E9523                      ;0E951D|F004    |0E9523;
						CMP.B #$07                           ;0E951F|C907    |      ;
						BNE CODE_0E9536                      ;0E9521|D013    |0E9536;
	
			CODE_0E9523:
						LDX.B #$E8                           ;0E9523|A2E8    |      ;
						LDA.B #$05                           ;0E9525|A905    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9527|200B84  |0E840B;
						BEQ CODE_0E9534                      ;0E952A|F008    |0E9534;
						CMP.B #$05                           ;0E952C|C905    |      ;
						BEQ CODE_0E9534                      ;0E952E|F004    |0E9534;
						CMP.B #$07                           ;0E9530|C907    |      ;
						BNE CODE_0E9536                      ;0E9532|D002    |0E9536;
	
			CODE_0E9534:
						CLC                                  ;0E9534|18      |      ;
						RTS                                  ;0E9535|60      |      ;
	
	
			CODE_0E9536:
						SEC                                  ;0E9536|38      |      ;
	
			CODE_0E9537:
						RTS                                  ;0E9537|60      |      ;
	
	
	player_state02_standIdle:
						JSR.W playerCollusion                ;0E9538|202184  |0E8421;
						BCS CODE_0E9540                      ;0E953B|B003    |0E9540;
						JMP.W playerFallingJuming               ;0E953D|4C3A97  |0E973A;
	
	
			CODE_0E9540:
						LDA.B r_timerClunk_drop              ;0E9540|A5B9    |0000B9;
						BEQ CODE_0E954D                      ;0E9542|F009    |0E954D;
						DEC.B r_timerClunk_drop              ;0E9544|C6B9    |0000B9;
						BNE CODE_0E9537                      ;0E9546|D0EF    |0E9537;
						LDA.B #$02                           ;0E9548|A902    |      ;
						STA.W r_entity_spriteID          ;0E954A|8D0004  |0E0400;
	
			CODE_0E954D:
						LDA.B r_Joy1_t                       ;0E954D|A526    |000026;
						ASL A                                ;0E954F|0A      |      ;
						BCS CODE_0E9594                      ;0E9550|B042    |0E9594;
						ASL A                                ;0E9552|0A      |      ;
						BCS CODE_0E9571                      ;0E9553|B01C    |0E9571;
	
			CODE_0E9555:
						LDA.B r_Joy1Held_t                   ;0E9555|A528    |000028;
						LSR A                                ;0E9557|4A      |      ;
						BCC CODE_0E955D                      ;0E9558|9003    |0E955D;
						JMP.W playerPressRight               ;0E955A|4C0296  |0E9602;
	
	
			CODE_0E955D:
						LSR A                                ;0E955D|4A      |      ;
						BCC CODE_0E9563                      ;0E955E|9003    |0E9563;
						JMP.W playerPressLeft                ;0E9560|4C0696  |0E9606;
	
	
			CODE_0E9563:
						LSR A                                ;0E9563|4A      |      ;
						BCS DATA8_0E95AA                     ;0E9564|B044    |0E95AA;
						LSR A                                ;0E9566|4A      |      ;
						BCS DATA8_0E95B8                     ;0E9567|B04F    |0E95B8;
	
			CODE_0E9569:
						LDA.B #$02                           ;0E9569|A902    |      ;
						STA.W r_entity_spriteID          ;0E956B|8D0004  |0E0400;
						JMP.W playerConveyaerCheck           ;0E956E|4C8E91  |0E918E;
	
	
			CODE_0E9571:
						LDA.B r_Joy1Held_t                   ;0E9571|A528    |000028;
						AND.B #$08                           ;0E9573|2908    |      ;
						BNE playerHoldsUp                    ;0E9575|D013    |0E958A;
	
			CODE_0E9577:
						LDA.W r_entity_ID         ;0E9577|AD4E05  |0E054E;
						CMP.B #$03                           ;0E957A|C903    |      ;
						BEQ CODE_0E9583                      ;0E957C|F005    |0E9583;
						LDA.B #$18                           ;0E957E|A918    |      ; attackState
						JMP.W storeAttackState_slashSound               ;0E9580|4C0A94  |0E940A;
	
	
			CODE_0E9583:
						JSR.W alucardBaseAttack              ;0E9583|2069BA  |0EBA69;
						BCS CODE_0E958F                      ;0E9586|B007    |0E958F;
						BCC CODE_0E9555                      ;0E9588|90CB    |0E9555;
	
			playerHoldsUp:
						JSR.W initSubwAttack_CC                 ;0E958A|20F5B9  |0EB9F5;
						BCC CODE_0E9577                      ;0E958D|90E8    |0E9577;
	
			CODE_0E958F:
						LDA.B #$20                           ;0E958F|A920    |      ;
						JMP.W initPlayerState_A               ;0E9591|4CAA94  |0E94AA;
	
	
			CODE_0E9594:
						JSR.W CODE_0E950B                    ;0E9594|200B95  |0E950B;
						BCS CODE_0E959E                      ;0E9597|B005    |0E959E;
						LDA.B #$06                           ;0E9599|A906    |      ;
						STA.W r_Player_StateDoubled        ;0E959B|8D6505  |0E0565;

			if !jumpControllMovment == 1
						lda.w r_entity_ID
						cmp #$02
						beq +
						jmp player_state06_jumpStart_exceptGrant
					+	jmp grant_state06 
			endif 

			CODE_0E959E:
						RTS                                  ;0E959E|60      |      ;
	
	
			CODE_0E959F:
						LDA.B #$0A                           ;0E959F|A90A    |      ;
						STA.W r_Player_StateDoubled        ;0E95A1|8D6505  |0E0565;
						LDA.B #$0E                           ;0E95A4|A90E    |      ;
						STA.W r_entity_spriteID          ;0E95A6|8D0004  |0E0400;
						RTS                                  ;0E95A9|60      |      ;
	
	
			DATA8_0E95AA:
						                               ;0E95AA|        |      ;
						JSR.W CODE_0FE6D4                       ;0E95AB|        |0FE6D4;
						BCC CODE_0E959F                      ;0E95AD|90F0    |0E959F;
						LDA.B #$00                           ;0E95AF|A900    |      ;
						STA.W r_entity_AI_IDX          ;0E95B1|8DC105  |0E05C1;
						LDX.B #$01                           ;0E95B4|A201    |      ;
						BNE CODE_0E95C4                      ;0E95B6|D00C    |0E95C4;
	
			DATA8_0E95B8:
						                               ;0E95B8|        |      ;
						JSR.W CODE_0FE6DF                       ;0E95B9|        |0FE6DF;
						BCC CODE_0E9569                      ;0E95BB|90AC    |0E9569;
						LDA.B #$01                           ;0E95BD|A901    |      ;
						STA.W r_entity_AI_IDX          ;0E95BF|8DC105  |0E05C1;
						LDX.B #$00                           ;0E95C2|A200    |      ;
	
			CODE_0E95C4:
						LDY.B #$00                           ;0E95C4|A000    |      ;
						LDA.B r_temp_Xpos                    ;0E95C6|A50A    |00000A;
						ASL A                                ;0E95C8|0A      |      ;
						BCC CODE_0E95D0                      ;0E95C9|9005    |0E95D0;
						TXA                                  ;0E95CB|8A      |      ;
						EOR.B #$01                           ;0E95CC|4901    |      ;
						TAX                                  ;0E95CE|AA      |      ;
						INY                                  ;0E95CF|C8      |      ;
	
			CODE_0E95D0:
						STY.W r_entity_AI              ;0E95D0|8CEF05  |0E05EF;
						STX.W r_entity_FacingLeft          ;0E95D3|8EA804  |0E04A8;
						LDA.B $0B                            ;0E95D6|A50B    |00000B;
						STA.W r_damagActionFlag         ;0E95D8|8D1D06  |0E061D;
						LDY.B #$00                           ;0E95DB|A000    |      ;
						ASL A                                ;0E95DD|0A      |      ;
						BCC CODE_0E95E1                      ;0E95DE|9001    |0E95E1;
						INY                                  ;0E95E0|C8      |      ;
	
			CODE_0E95E1:
						STY.W r_entity_target          ;0E95E1|8C0606  |0E0606;
						LDA.B r_tempCurrSection              ;0E95E4|A50D    |00000D;
						BEQ CODE_0E95EE                      ;0E95E6|F006    |0E95EE;
						LDA.B #$FF                           ;0E95E8|A9FF    |      ;
						LDY.B #$00                           ;0E95EA|A000    |      ;
						BEQ CODE_0E95F2                      ;0E95EC|F004    |0E95F2;
	
			CODE_0E95EE:
						LDA.B #$01                           ;0E95EE|A901    |      ;
						LDY.B #$00                           ;0E95F0|A000    |      ;
	
			CODE_0E95F2:
						STY.W r_entity_XsubSpd             ;0E95F2|8C0905  |0E0509;
						STA.W r_entity_Xspd                ;0E95F5|8DF204  |0E04F2;
						LDA.B #$0E                           ;0E95F8|A90E    |      ;
						STA.W r_Player_StateDoubled        ;0E95FA|8D6505  |0E0565;
						LDA.B #$00                           ;0E95FD|A900    |      ;
						db $4C                               ;0E95FF|        |      ;
	
						dw updateAnimGroupSetOneFrame        ;0E9600|        |0FEF4A;
	
		playerPressRight:
						LDA.B #$00                           ;0E9602|A900    |      ;
						BEQ CODE_0E9608                      ;0E9604|F002    |0E9608;
	
		playerPressLeft:
						LDA.B #$01                           ;0E9606|A901    |      ;
	
			CODE_0E9608:
						STA.W r_entity_FacingLeft          ;0E9608|8DA804  |0E04A8;
						LDA.B #$00                           ;0E960B|A900    |      ;
						STA.W r_entity_Xspd                ;0E960D|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0E9610|8D0905  |0E0509;
						LDA.B #$04                           ;0E9613|A904    |      ;
						STA.W r_Player_StateDoubled        ;0E9615|8D6505  |0E0565;
						LDA.B #$00                           ;0E9618|A900    |      ;	
						
					if !jumpControllMovment == 1
						cpx #$00 
						jsr updateAnimGroupSetOneFrame       
						jmp player_state04_walking_exceptGrant
					else 
						jmp updateAnimGroupSetOneFrame        ;0E961B|        |0FEF4A;
					endif 
	
	
	player_state06_jumpStart_exceptGrant:
						LDA.B #$08                           ;0E961D|A908    |      ;
						STA.W r_Player_StateDoubled        ;0E961F|8D6505  |0E0565;
						LDA.B r_Joy1Held_t                   ;0E9622|A528    |000028;
						STA.B r_index                        ;0E9624|8510    |000010;
						LDX.B #$00                           ;0E9626|A200    |      ;
						
				bossDoupleGanger_jump_00:		
						LDA.B #$16                           ;0E9628|A916    |      ;
						STA.W r_entity_spriteID,X        ;0E962A|9D0004  |0E0400;
						LDA.B #$00                           ;0E962D|A900    |      ;
						STA.W r_entity_AI_IDX,X        ;0E962F|9DC105  |0E05C1;
						LDA.B #$09                           ;0E9632|A909    |      ;
						STA.W r_entity_extra,X             ;0E9634|9DD805  |0E05D8;
						LDA.B r_index                        ;0E9637|A510    |000010;
						LSR A                                ;0E9639|4A      |      ;
						BCS CODE_0E9644                      ;0E963A|B008    |0E9644;
						LSR A                                ;0E963C|4A      |      ;
						BCS CODE_0E964F                      ;0E963D|B010    |0E964F;
						LDA.B #$00                           ;0E963F|A900    |      ;
						TAY                                  ;0E9641|A8      |      ;
						BEQ CODE_0E9658                      ;0E9642|F014    |0E9658;
	
			CODE_0E9644:
						LDA.B #$00                           ;0E9644|A900    |      ;
						STA.W r_entity_FacingLeft,X        ;0E9646|9DA804  |0E04A8;
						LDA.B #$01                           ;0E9649|A901    |      ;
						LDY.B #$00                           ;0E964B|A000    |      ;
						BEQ CODE_0E9658                      ;0E964D|F009    |0E9658;
	
			CODE_0E964F:
						LDA.B #$01                           ;0E964F|A901    |      ;
						STA.W r_entity_FacingLeft,X        ;0E9651|9DA804  |0E04A8;
						LDA.B #$FF                           ;0E9654|A9FF    |      ;
						LDY.B #$00                           ;0E9656|A000    |      ;
	
			CODE_0E9658:
						STA.W r_entity_Xspd,X              ;0E9658|9DF204  |0E04F2;
						TYA                                  ;0E965B|98      |      ;
						STA.W r_entity_XsubSpd,X           ;0E965C|9D0905  |0E0509;
		if !jumpControllMovment == 1                       				   
					   cpx #$00
					   bne weAreDopelGangerBoss
					   jmp playerJump_init_00 			; CODE_0E979C 
			weAreDopelGangerBoss:	
					   rts 
		else 									 
					   RTS                                  ;0E965F|60      |      ;
		endif 
	
	
	player_state04_walking_exceptGrant:
						JSR.W playerCollusion                ;0E9660|202184  |0E8421;
						BCS CODE_0E9668                      ;0E9663|B003    |0E9668;
						JMP.W CODE_0E9734                    ;0E9665|4C3497  |0E9734;
	
	
			CODE_0E9668:
						LDA.B r_Joy1_t                       ;0E9668|A526    |000026;
						ASL A                                ;0E966A|0A      |      ;
						BCC CODE_0E9670                      ;0E966B|9003    |0E9670;
						JMP.W CODE_0E9594                    ;0E966D|4C9495  |0E9594;
	
	
			CODE_0E9670:
						ASL A                                ;0E9670|0A      |      ;
						BCS CODE_0E968F                      ;0E9671|B01C    |0E968F;
	
			CODE_0E9673:
						LDA.B r_Joy1Held_t                   ;0E9673|A528    |000028;
						LSR A                                ;0E9675|4A      |      ;
						BCS CODE_0E96BA                      ;0E9676|B042    |0E96BA;
						LSR A                                ;0E9678|4A      |      ;
						BCC CODE_0E967E                      ;0E9679|9003    |0E967E;
						JMP.W CODE_0E96F6                    ;0E967B|4CF696  |0E96F6;
	
	
			CODE_0E967E:
						LDA.B #$02                           ;0E967E|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E9680|8D6505  |0E0565;
	
			CODE_0E9683:
						JSR.W clearPlayerVertSpeed           ;0E9683|20BC8A  |0E8ABC;
	
			DATA8_0E9686:
						                               ;0E9686|        |      ;
						JSR.W updateSpriteAnimFrame             ;0E9687|        |0FEF73;
	
			CODE_0E9689:
						JSR.W playerKnockback_01             ;0E9689|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0E968C|4C1287  |0E8712;
	
	
			CODE_0E968F:
						LDA.B r_Joy1Held_t                   ;0E968F|A528    |000028;
						AND.B #$08                           ;0E9691|2908    |      ;
						BEQ CODE_0E96A4                      ;0E9693|F00F    |0E96A4;
						JSR.W initSubwAttack_CC                 ;0E9695|20F5B9  |0EB9F5;
						BCC CODE_0E96A4                      ;0E9698|900A    |0E96A4;
	
			CODE_0E969A:
						LDA.B #$20                           ;0E969A|A920    |      ;
						JSR.W initPlayerState_A               ;0E969C|20AA94  |0E94AA;
						JSR.W clearPlayerVertSpeed           ;0E969F|20BC8A  |0E8ABC;
						BEQ CODE_0E9689                      ;0E96A2|F0E5    |0E9689;
	
			CODE_0E96A4:
						LDA.W r_entity_ID         ;0E96A4|AD4E05  |0E054E;
						CMP.B #$03                           ;0E96A7|C903    |      ;
						BEQ CODE_0E96B3                      ;0E96A9|F008    |0E96B3;
						LDA.B #$18                           ;0E96AB|A918    |      ;
						JSR.W storeAttackState_slashSound               ;0E96AD|200A94  |0E940A;
						JMP.W CODE_0E9683                    ;0E96B0|4C8396  |0E9683;
	
	
			CODE_0E96B3:
						JSR.W alucardBaseAttack              ;0E96B3|2069BA  |0EBA69;
						BCC CODE_0E9673                      ;0E96B6|90BB    |0E9673;
						BCS CODE_0E969A                      ;0E96B8|B0E0    |0E969A;
	
			CODE_0E96BA:
						LDA.B #$00                           ;0E96BA|A900    |      ;
						STA.W r_entity_FacingLeft          ;0E96BC|8DA804  |0E04A8;
						JSR.W doConveyaerRoomEffect          ;0E96BF|20858E  |0E8E85;
						BCC CODE_0E96D9                      ;0E96C2|9015    |0E96D9;
						LDX.B #$00                           ;0E96C4|A200    |      ;
						LDA.B #$08                           ;0E96C6|A908    |      ;
						                               ;0E96C8|        |      ;
						JSR.W playerCollusionCheck              ;0E96C9|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E96CB|D024    |0E96F1;
						LDX.B #$F0                           ;0E96CD|A2F0    |      ;
						LDA.B #$08                           ;0E96CF|A908    |      ;
						                               ;0E96D1|        |      ;
						JSR.W playerCollusionCheck              ;0E96D2|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E96D4|D01B    |0E96F1;
						JMP.W DATA8_0E9686                   ;0E96D6|4C8696  |0E9686;
	
	
			CODE_0E96D9:
						LDX.B #$00                           ;0E96D9|A200    |      ;
						LDA.B #$08                           ;0E96DB|A908    |      ;
						                               ;0E96DD|        |      ;
						JSR.W playerCollusionCheck              ;0E96DE|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E96E0|D00F    |0E96F1;
						LDX.B #$F0                           ;0E96E2|A2F0    |      ;
						LDA.B #$08                           ;0E96E4|A908    |      ;
						                               ;0E96E6|        |      ;
						JSR.W playerCollusionCheck              ;0E96E7|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E96E9|D006    |0E96F1;
						LDA.B #playerX_r_spd                           ;0E96EB|A901    |      ;
						LDY.B #playerX_r_subSpd                           ;0E96ED|A000    |      ;
						jmp CODE_0E972B                      ;0E96EF|F03A    |0E972B;
	
			CODE_0E96F1:
						LDA.B #$00                           ;0E96F1|A900    |      ;
						TAY                                  ;0E96F3|A8      |      ;
						BEQ CODE_0E972B                      ;0E96F4|F035    |0E972B;
	
			CODE_0E96F6:
						LDA.B #$01                           ;0E96F6|A901    |      ;
						STA.W r_entity_FacingLeft          ;0E96F8|8DA804  |0E04A8;
						JSR.W gameTransitionChecks           ;0E96FB|20018F  |0E8F01;
						BCC CODE_0E9715                      ;0E96FE|9015    |0E9715;
						LDX.B #$00                           ;0E9700|A200    |      ;
						LDA.B #$F8                           ;0E9702|A9F8    |      ;
						                               ;0E9704|        |      ;
						JSR.W playerCollusionCheck              ;0E9705|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E9707|D0E8    |0E96F1;
						LDX.B #$F0                           ;0E9709|A2F0    |      ;
						LDA.B #$F8                           ;0E970B|A9F8    |      ;
						                               ;0E970D|        |      ;
						JSR.W playerCollusionCheck              ;0E970E|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E9710|D0DF    |0E96F1;
						JMP.W DATA8_0E9686                   ;0E9712|4C8696  |0E9686;
	
	
			CODE_0E9715:
						LDX.B #$00                           ;0E9715|A200    |      ;
						LDA.B #$F8                           ;0E9717|A9F8    |      ;
						                               ;0E9719|        |      ;
						JSR.W playerCollusionCheck              ;0E971A|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E971C|D0D3    |0E96F1;
						LDX.B #$F0                           ;0E971E|A2F0    |      ;
						LDA.B #$F8                           ;0E9720|A9F8    |      ;
						                               ;0E9722|        |      ;
						JSR.W playerCollusionCheck              ;0E9723|        |0FFCDD;
						BNE CODE_0E96F1                      ;0E9725|D0CA    |0E96F1;
						LDA.B #playerX_l_spd                           ;0E9727|A9FF    |      ;
						LDY.B #playerX_l_subSpd                         ;0E9729|A000    |      ;
	
			CODE_0E972B:
						STY.W r_entity_XsubSpd             ;0E972B|8C0905  |0E0509;
						STA.W r_entity_Xspd                ;0E972E|8DF204  |0E04F2;
						JMP.W CODE_0E9683                    ;0E9731|4C8396  |0E9683;
	
	
			CODE_0E9734:
						JSR.W playerFallingJuming               ;0E9734|203A97  |0E973A;
						JMP.W DATA8_0E9686                   ;0E9737|4C8696  |0E9686;
	
	
		playerFallingJuming:
						LDA.B r_previousBackup88             ;0E973A|A5CF    |0000CF;
						CMP.B #$01                           ;0E973C|C901    |      ;
						BEQ CODE_0E9744                      ;0E973E|F004    |0E9744;
						CMP.B #$06                           ;0E9740|C906    |      ;
						BNE CODE_0E9748                      ;0E9742|D004    |0E9748;
	
			CODE_0E9744:
						LDA.B #$08                           ;0E9744|A908    |      ;
						STA.B r_delayElevators               ;0E9746|85AF    |0000AF;
	
			CODE_0E9748:
						LDA.B #$0C                           ;0E9748|A90C    |      ;
						STA.W r_Player_StateDoubled        ;0E974A|8D6505  |0E0565;
						LDX.B #$00                           ;0E974D|A200    |      ;
			
			bossDoupleGanger_duck_02:
						LDA.B #$0C                           ;0E974F|A90C    |      ;
						STA.W r_entity_extra,X             ;0E9751|9DD805  |0E05D8;
						LDA.B #$01                           ;0E9754|A901    |      ;
						STA.W r_entity_AI_IDX,X        ;0E9756|9DC105  |0E05C1;
						LDA.W r_entity_FacingLeft,X        ;0E9759|BDA804  |0E04A8;
						BNE CODE_0E976A                      ;0E975C|D00C    |0E976A;
						LDA.B #$00                           ;0E975E|A900    |      ;
						LDY.B #$20                           ;0E9760|A020    |      ;
	
			CODE_0E9762:
						STA.W r_entity_Xspd,X              ;0E9762|9DF204  |0E04F2;
						TYA                                  ;0E9765|98      |      ;
						STA.W r_entity_XsubSpd,X           ;0E9766|9D0905  |0E0509;
	
			CODE_0E9769:
						RTS                                  ;0E9769|60      |      ;
	
	
			CODE_0E976A:
						LDA.B #$FF                           ;0E976A|A9FF    |      ;
						LDY.B #$E0                           ;0E976C|A0E0    |      ;
						BNE CODE_0E9762                      ;0E976E|D0F2    |0E9762;
	
	player_state08_0c_jump:
		if !jumpControllDirection == 1 
						jsr jumpControll
		endif                       
						
						LDA.B r_Joy1_t                       ;0E9770|A526    |000026;
						AND.B #$40                           ;0E9772|2940    |      ;
						BEQ playerJump_init_00               ;0E9774|F026    |0E979C;
						LDA.B r_Joy1Held_t                   ;0E9776|A528    |000028;
						AND.B #$08                           ;0E9778|2908    |      ;
						BEQ CODE_0E9790                      ;0E977A|F014    |0E9790;
						JSR.W initSubwAttack_CC                 ;0E977C|20F5B9  |0EB9F5;
						BCC CODE_0E9790                      ;0E977F|900F    |0E9790;
	
			CODE_0E9781:
						LDA.B #$22                           ;0E9781|A922    |      ;
						JSR.W initPlayerState_A               ;0E9783|20AA94  |0E94AA;
						JMP.W playerJump_init_00             ;0E9786|4C9C97  |0E979C;
	
	
			CODE_0E9789:
						JSR.W alucardBaseAttack              ;0E9789|2069BA  |0EBA69;
						BCC playerJump_init_00               ;0E978C|900E    |0E979C;
						BCS CODE_0E9781                      ;0E978E|B0F1    |0E9781;
	
			CODE_0E9790:
						LDA.W r_entity_ID         ;0E9790|AD4E05  |0E054E;
						CMP.B #$03                           ;0E9793|C903    |      ;
						BEQ CODE_0E9789                      ;0E9795|F0F2    |0E9789;
						LDA.B #$1A                           ;0E9797|A91A    |      ;
						JSR.W storeAttackState_slashSound               ;0E9799|200A94  |0E940A;
	
	playerJump_init_00:
						JSR.W do_invincableFrames            ;0E979C|20AA83  |0E83AA;
						BCS CODE_0E9769                      ;0E979F|B0C8    |0E9769;
	
			CODE_0E97A1:
						LDA.W r_entity_Xspd                ;0E97A1|ADF204  |0E04F2;
						BPL CODE_0E97BA                      ;0E97A4|1014    |0E97BA;
						LDX.B #$10                           ;0E97A6|A210    |      ;
						LDA.B #$F8                           ;0E97A8|A9F8    |      ;
						                               ;0E97AA|        |      ;
						JSR.W playerCollusionCheck              ;0E97AB|        |0FFCDD;
						BNE CODE_0E97CF                      ;0E97AD|D020    |0E97CF;
						LDX.B #$08                           ;0E97AF|A208    |      ;
						LDA.B #$F8                           ;0E97B1|A9F8    |      ;
						                               ;0E97B3|        |      ;
						JSR.W playerCollusionCheck              ;0E97B4|        |0FFCDD;
						BNE CODE_0E97CF                      ;0E97B6|D017    |0E97CF;
						BEQ CODE_0E97CC                      ;0E97B8|F012    |0E97CC;
	
			CODE_0E97BA:
						LDX.B #$10                           ;0E97BA|A210    |      ;
						LDA.B #$08                           ;0E97BC|A908    |      ;
						                               ;0E97BE|        |      ;
						JSR.W playerCollusionCheck              ;0E97BF|        |0FFCDD;
						BNE CODE_0E97CF                      ;0E97C1|D00C    |0E97CF;
						LDX.B #$08                           ;0E97C3|A208    |      ;
						LDA.B #$08                           ;0E97C5|A908    |      ;
						                               ;0E97C7|        |      ;
						JSR.W playerCollusionCheck              ;0E97C8|        |0FFCDD;
						BNE CODE_0E97CF                      ;0E97CA|D003    |0E97CF;
	
			CODE_0E97CC:
						JSR.W playerKnockback_01             ;0E97CC|203A87  |0E873A;
	
			CODE_0E97CF:
						LDA.W r_entity_YPos                ;0E97CF|AD1C04  |0E041C;
						STA.B $06                            ;0E97D2|8506    |000006;
						JSR.W doStairStuneTimer__00          ;0E97D4|204F98  |0E984F;
						LDA.W r_entity_AI_IDX          ;0E97D7|ADC105  |0E05C1;
						BEQ CODE_0E9841                      ;0E97DA|F065    |0E9841;
						LDX.B #$10                           ;0E97DC|A210    |      ;
						LDA.B #$FB                           ;0E97DE|A9FB    |      ;
						                               ;0E97E0|        |      ;
						JSR.W playerCollusionCheck              ;0E97E1|        |0FFCDD;
						BEQ CODE_0E97F1                      ;0E97E3|F00C    |0E97F1;
						LDX.B #$08                           ;0E97E5|A208    |      ;
						LDA.B #$FB                           ;0E97E7|A9FB    |      ;
						JSR.W DATA8_0E83FF                   ;0E97E9|20FF83  |0E83FF;
						BEQ CODE_0E981E                      ;0E97EC|F030    |0E981E;
						JMP.W CODE_0E9841                    ;0E97EE|4C4198  |0E9841;
	
	
			CODE_0E97F1:
						LDX.B #$10                           ;0E97F1|A210    |      ;
						LDA.B #$05                           ;0E97F3|A905    |      ;
						                               ;0E97F5|        |      ;
						JSR.W playerCollusionCheck              ;0E97F6|        |0FFCDD;
						BEQ CODE_0E9806                      ;0E97F8|F00C    |0E9806;
						LDX.B #$08                           ;0E97FA|A208    |      ;
						LDA.B #$05                           ;0E97FC|A905    |      ;
						JSR.W DATA8_0E83FF                   ;0E97FE|20FF83  |0E83FF;
						BEQ CODE_0E981E                      ;0E9801|F01B    |0E981E;
						JMP.W CODE_0E9841                    ;0E9803|4C4198  |0E9841;
	
	
			CODE_0E9806:
						LDA.B r_conveyaerRoomEffect          ;0E9806|A58B    |00008B;
						CMP.B #$01                           ;0E9808|C901    |      ;
						BEQ CODE_0E9816                      ;0E980A|F00A    |0E9816;
						CMP.B #$05                           ;0E980C|C905    |      ;
						BEQ CODE_0E9844                      ;0E980E|F034    |0E9844;
						CMP.B #$06                           ;0E9810|C906    |      ;
						BEQ CODE_0E9844                      ;0E9812|F030    |0E9844;
						BNE CODE_0E9841                      ;0E9814|D02B    |0E9841;
	
			CODE_0E9816:
						LDX.B r_ConveyorRelated              ;0E9816|A691    |000091;
						                               ;0E9818|        |      ;
						JSR.W CODE_0FFE9C                       ;0E9819|        |0FFE9C;
						JMP.W CODE_0E983B                    ;0E981B|4C3B98  |0E983B;
	
	
			CODE_0E981E:
						LDA.W r_entity_extra               ;0E981E|ADD805  |0E05D8;
						BNE CODE_0E9838                      ;0E9821|D015    |0E9838;
						LDA.W r_Player_StateDoubled        ;0E9823|AD6505  |0E0565;
						CMP.B #$26                           ;0E9826|C926    |      ;
						BEQ CODE_0E9838                      ;0E9828|F00E    |0E9838;
						LDA.B #$0B                           ;0E982A|A90B    |      ;
						                               ;0E982C|        |      ;
						JSR.W lunchMusic                        ;0E982D|        |0FE25F;
						LDA.B #$0C                           ;0E982F|A90C    |      ;
						STA.B r_timerClunk_drop              ;0E9831|85B9    |0000B9;
						LDA.B #$0E                           ;0E9833|A90E    |      ;
						STA.W r_entity_spriteID          ;0E9835|8D0004  |0E0400;
	
			CODE_0E9838:
						JSR.W CODE_0E8A02                    ;0E9838|20028A  |0E8A02;
	
			CODE_0E983B:
						LDA.B #$02                           ;0E983B|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E983D|8D6505  |0E0565;

				if !jumpControllMovment == 1 			; entering walking routine to not be stuck at the ground for 1 frame 
						lda.w r_Player_StateDoubled
						cmp #$26 
						bcc +
						jmp player_state02_standIdle
					+
				endif						
						
						RTS                                  ;0E9840|60      |      ;
	
	
			CODE_0E9841:
						JMP.W updateSpeed2Pos                ;0E9841|4C1287  |0E8712;
	
	
			CODE_0E9844:
						LDA.B $06                            ;0E9844|A506    |000006;
						CLC                                  ;0E9846|18      |      ;
						ADC.B r_ConveyorRelated              ;0E9847|6591    |000091;
						STA.W r_entity_YPos                ;0E9849|8D1C04  |0E041C;
						JMP.W CODE_0E983B                    ;0E984C|4C3B98  |0E983B;
	
	
	doStairStuneTimer__00:
						LDA.W r_entity_YPos                ;0E984F|AD1C04  |0E041C;
						CMP.B #$08                           ;0E9852|C908    |      ;
						BCS CODE_0E9867                      ;0E9854|B011    |0E9867;
						LDA.W r_entity_AI_IDX          ;0E9856|ADC105  |0E05C1;
						BNE CODE_0E9867                      ;0E9859|D00C    |0E9867;
						LDA.W r_Player_StateDoubled        ;0E985B|AD6505  |0E0565;
						CMP.B #$26                           ;0E985E|C926    |      ;
						BEQ CODE_0E986A                      ;0E9860|F008    |0E986A;
						LDX.B #$00                           ;0E9862|A200    |      ;
						JSR.W bossDoupleGanger_duck_02                    ;0E9864|204F97  |0E974F;
	
			CODE_0E9867:
						JMP.W checkPlayer_HitOnStair         ;0E9867|4CBF98  |0E98BF;
	
	
			CODE_0E986A:
						LDA.B #$00                           ;0E986A|A900    |      ;
						STA.W r_entity_Yspd                ;0E986C|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0E986F|8D3705  |0E0537;
						BEQ CODE_0E9867                      ;0E9872|F0F3    |0E9867;
	
			DATA8_0E9874:
						db $80                               ;0E9874|        |      ;
	
	
			DATA8_0E9875:
						db $FA,$FA,$FA,$FA,$FA,$FB,$FB,$FB   ;0E9875|        |      ;
						db $FB,$FB,$FD,$FD,$FD,$FD,$FD,$FE   ;0E987D|        |      ;
						db $FE,$FE,$FF,$FF,$FF,$FF,$00,$FF   ;0E9885|        |      ;
						db $00,$00,$00,$00,$81               ;0E988D|        |      ;
	
	playerStairFallDeath:
						LDA.W r_entity_YsubSpd             ;0E9892|AD3705  |0E0537;
						CLC                                  ;0E9895|18      |      ;
						ADC.B #$20                           ;0E9896|6920    |      ;
						STA.W r_entity_YsubSpd             ;0E9898|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0E989B|AD2005  |0E0520;
						ADC.B #$00                           ;0E989E|6900    |      ;
						STA.W r_entity_Yspd                ;0E98A0|8D2005  |0E0520;
						BPL CODE_0E98AB                      ;0E98A3|1006    |0E98AB;
						LDA.B #$00                           ;0E98A5|A900    |      ;
						STA.W r_entity_AI_IDX          ;0E98A7|8DC105  |0E05C1;
						RTS                                  ;0E98AA|60      |      ;
	
	
			CODE_0E98AB:
						CMP.B #$05                           ;0E98AB|C905    |      ;
						BCC CODE_0E98B9                      ;0E98AD|900A    |0E98B9;
						LDA.B #$05                           ;0E98AF|A905    |      ;
						STA.W r_entity_Yspd                ;0E98B1|8D2005  |0E0520;
						LDA.B #$00                           ;0E98B4|A900    |      ;
						STA.W r_entity_YsubSpd             ;0E98B6|8D3705  |0E0537;
	
			CODE_0E98B9:
						LDA.B #$01                           ;0E98B9|A901    |      ;
						STA.W r_entity_AI_IDX          ;0E98BB|8DC105  |0E05C1;
						RTS                                  ;0E98BE|60      |      ;
	
	
	checkPlayer_HitOnStair:
						LDA.W r_Player_StateDoubled        ;0E98BF|AD6505  |0E0565;
						CMP.B #$26                           ;0E98C2|C926    |      ;
						BEQ playerStairFallDeath             ;0E98C4|F0CC    |0E9892;
						LDX.B #$00                           ;0E98C6|A200    |      ;
						
				bossDoupleGanger_hurt_01:		
						LDA.B #$00                           ;0E98C8|A900    |      ;
						STA.W r_entity_YsubSpd,X           ;0E98CA|9D3705  |0E0537;
						STA.W r_entity_FractionalY,X       ;0E98CD|9DDB04  |0E04DB;
						LDY.W r_entity_extra,X             ;0E98D0|BCD805  |0E05D8;
						LDA.W r_entity_AI_IDX,X        ;0E98D3|BDC105  |0E05C1;
						BNE CODE_0E98F4                      ;0E98D6|D01C    |0E98F4;
						LDA.W DATA8_0E9874,Y                 ;0E98D8|B97498  |0E9874;
						CMP.B #$81                           ;0E98DB|C981    |      ;
						BEQ jumpPeakInitDecend               ;0E98DD|F007    |0E98E6;
						STA.W r_entity_Yspd,X              ;0E98DF|9D2005  |0E0520;
						INC.W r_entity_extra,X             ;0E98E2|FED805  |0E05D8;
						RTS                                  ;0E98E5|60      |      ;
	
	
	jumpPeakInitDecend:
						LDA.B #$00                           ;0E98E6|A900    |      ;
						STA.W r_entity_Yspd,X              ;0E98E8|9D2005  |0E0520;
						DEC.W r_entity_extra,X             ;0E98EB|DED805  |0E05D8;
						LDA.B #$01                           ;0E98EE|A901    |      ;
						STA.W r_entity_AI_IDX,X        ;0E98F0|9DC105  |0E05C1;
						RTS                                  ;0E98F3|60      |      ;
	
	
			CODE_0E98F4:
						LDA.W DATA8_0E9874,Y                 ;0E98F4|B97498  |0E9874;
						CMP.B #$80                           ;0E98F7|C980    |      ;
						BEQ CODE_0E9907                      ;0E98F9|F00C    |0E9907;
						DEC.W r_entity_extra,X             ;0E98FB|DED805  |0E05D8;
	
			CODE_0E98FE:
						EOR.B #$FF                           ;0E98FE|49FF    |      ;
						CLC                                  ;0E9900|18      |      ;
						ADC.B #$01                           ;0E9901|6901    |      ;
						STA.W r_entity_Yspd,X              ;0E9903|9D2005  |0E0520;
						RTS                                  ;0E9906|60      |      ;
	
	
			CODE_0E9907:
						LDA.W DATA8_0E9875,Y                 ;0E9907|B97598  |0E9875;
						BNE CODE_0E98FE                      ;0E990A|D0F2    |0E98FE;
	
		playerIsAlucard:
						JSR.W alucardBaseAttack              ;0E990C|2069BA  |0EBA69;
						BCC checkPlayerHoldDown              ;0E990F|9025    |0E9936;
						LDA.B #$1C                           ;0E9911|A91C    |      ;
						JSR.W initPlayerState_A               ;0E9913|20AA94  |0E94AA;
						JMP.W checkPlayerHoldDown            ;0E9916|4C3699  |0E9936;
	
	
	player_state0a_ducking_exceptGrant:

			if !jumpControllDirection == 1
						jsr newDuckRoutine
			endif 						
						
						JSR.W playerCollusion                ;0E9919|202184  |0E8421;
						BCS CODE_0E9921                      ;0E991C|B003    |0E9921;
						JMP.W playerFallingJuming               ;0E991E|4C3A97  |0E973A;
	
	
			CODE_0E9921:
						JSR.W playerConveyaerCheck           ;0E9921|208E91  |0E918E;
						LDA.B r_Joy1_t                       ;0E9924|A526    |000026;
						AND.B #$40                           ;0E9926|2940    |      ;
						BEQ checkPlayerHoldDown              ;0E9928|F00C    |0E9936;
						LDA.W r_entity_ID         ;0E992A|AD4E05  |0E054E;
						CMP.B #$03                           ;0E992D|C903    |      ;
						BEQ playerIsAlucard                  ;0E992F|F0DB    |0E990C;
						LDA.B #$1C                           ;0E9931|A91C    |      ;
						JSR.W storeAttackState_slashSound               ;0E9933|200A94  |0E940A;
	
	checkPlayerHoldDown:
						LDA.B r_Joy1Held_t                   ;0E9936|A528    |000028;
						AND.B #$04                           ;0E9938|2904    |      ;
						BNE CODE_0E9941                      ;0E993A|D005    |0E9941;
						LDA.B #$02                           ;0E993C|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E993E|8D6505  |0E0565;
	
			CODE_0E9941:
						RTS                                  ;0E9941|60      |      ;
	
	
	player_state16_transition:
						                               ;0E9942|        |      ;
						JSR.W CODE_0FFB89                       ;0E9943|        |0FFB89;
						LDA.W r_entity_Yspd                ;0E9945|AD2005  |0E0520;
						BMI CODE_0E994D                      ;0E9948|3003    |0E994D;
						JMP.W updatePlayerFacingSpeed_01     ;0E994A|4C9A9B  |0E9B9A;
	
	
			CODE_0E994D:
						JMP.W updateWeaponFacingSpeed_00     ;0E994D|4C8E9B  |0E9B8E;
	
						JMP.W updateWeaponFacingSpeed_00     ;0E9950|4C8E9B  |0E9B8E;
	
	
	player_state0e_walkToStair:
						LDA.W r_damagActionFlag         ;0E9953|AD1D06  |0E061D;
						BEQ CODE_0E9961                      ;0E9956|F009    |0E9961;
						DEC.W r_damagActionFlag         ;0E9958|CE1D06  |0E061D;
						                               ;0E995B|        |      ;
						JSR.W updateSpriteAnimFrame             ;0E995C|        |0FEF73;
						JMP.W playerKnockback_01             ;0E995E|4C3A87  |0E873A;
	
	
			CODE_0E9961:
						LDA.B #$10                           ;0E9961|A910    |      ;
						STA.W r_Player_StateDoubled        ;0E9963|8D6505  |0E0565;
						RTS                                  ;0E9966|60      |      ;
	
	
	player_state10_startClimb:
						LDA.W r_entity_AI_IDX          ;0E9967|ADC105  |0E05C1;
						BNE CODE_0E996F                      ;0E996A|D003    |0E996F;
						JMP.W updatePlayerFacingSpeed_01     ;0E996C|4C9A9B  |0E9B9A;
	
	
			CODE_0E996F:
						JMP.W updateWeaponFacingSpeed_00     ;0E996F|4C8E9B  |0E9B8E;
	
	
			CODE_0E9972:
						LDA.B r_Joy1Held_t                   ;0E9972|A528    |000028;
						AND.B #$08                           ;0E9974|2908    |      ;
						BNE CODE_0E9984                      ;0E9976|D00C    |0E9984;

		if !alucardStairAttack == 1
					-	lda.b r_partner						; 17
						jsr characterCheckAluSt
						bne +
						lda #$1e
						jmp storeAttackState_slashSound
				CODE_0E9984:		
						jsr initSubwAttack_CC
						bcc -
					+
		else
					-	LDA.W r_entity_ID         		;0E9978|AD4E05  |0E054E;
						CMP.B #$03                          	;0E997B|C903    |      ;
						BEQ CODE_0E9994                      	;0E997D|F015    |0E9994;
						LDA.B #$1E                           	;0E997F|A91E    |      ;
						JMP.W storeAttackState_slashSound                  ;0E9981|4C0A94  |0E940A;
				CODE_0E9984: 
						JSR.W initSubwAttack_CC                    ;0E9984|20F5B9  |0EB9F5;
						BCC -
  		endif  

						LDA.B #$24                           ;0E9989|A924    |      ;
						JMP.W initPlayerState_A               ;0E998B|4CAA94  |0E94AA;
	
	
	player_state12_stairIdle:
						LDA.B r_Joy1Held_t                   ;0E998E|A528    |000028;
						AND.B #$40                           ;0E9990|2940    |      ;
						BNE CODE_0E9972                      ;0E9992|D0DE    |0E9972;	
			
			if !jumpControllDirection == 1					
						jsr dislunchFromStairs
			endif 						
			
			CODE_0E9994:			
						LDA.B r_Joy1Held_t                   ;0E9994|A528    |000028;
						LSR A                                ;0E9996|4A      |      ;
						BCS CODE_0E99B3                      ;0E9997|B01A    |0E99B3;
						LSR A                                ;0E9999|4A      |      ;
						BCS CODE_0E99D5                      ;0E999A|B039    |0E99D5;
						LSR A                                ;0E999C|4A      |      ;
						BCC CODE_0E99A7                      ;0E999D|9008    |0E99A7;
						JSR.W CODE_0E99F7                    ;0E999F|20F799  |0E99F7;
						BCS endStairIdle                     ;0E99A2|B00E    |0E99B2;
						JMP.W updatePlayerFacingSpeed_01     ;0E99A4|4C9A9B  |0E9B9A;
	
	
			CODE_0E99A7:
						LSR A                                ;0E99A7|4A      |      ;
						BCC endStairIdle                     ;0E99A8|9008    |0E99B2;
						JSR.W CODE_0E9A16                    ;0E99AA|20169A  |0E9A16;
						BCS endStairIdle                     ;0E99AD|B003    |0E99B2;
						JMP.W updateWeaponFacingSpeed_00     ;0E99AF|4C8E9B  |0E9B8E;
	
	
			endStairIdle:
						RTS                                  ;0E99B2|60      |      ;
	
	
			CODE_0E99B3:
						LDA.B #$00                           ;0E99B3|A900    |      ;
						STA.W r_entity_FacingLeft          ;0E99B5|8DA804  |0E04A8;
						LDA.W r_entity_AI              ;0E99B8|ADEF05  |0E05EF;
						BEQ CODE_0E99C9                      ;0E99BB|F00C    |0E99C9;
						JSR.W CODE_0E99F7                    ;0E99BD|20F799  |0E99F7;
						BCS endStairIdle                     ;0E99C0|B0F0    |0E99B2;
						LDX.B #$00                           ;0E99C2|A200    |      ;
						LDY.B #$00                           ;0E99C4|A000    |      ;
						JMP.W updatePlayerSpeed              ;0E99C6|4CAF9B  |0E9BAF;
	
	
			CODE_0E99C9:
						JSR.W CODE_0E9A16                    ;0E99C9|20169A  |0E9A16;
						BCS endStairIdle                     ;0E99CC|B0E4    |0E99B2;
						LDX.B #$02                           ;0E99CE|A202    |      ;
						LDY.B #$08                           ;0E99D0|A008    |      ;
						JMP.W updatePlayerSpeed              ;0E99D2|4CAF9B  |0E9BAF;
	
	
			CODE_0E99D5:
						LDA.B #$01                           ;0E99D5|A901    |      ;
						STA.W r_entity_FacingLeft          ;0E99D7|8DA804  |0E04A8;
						LDA.W r_entity_AI              ;0E99DA|ADEF05  |0E05EF;
						BEQ CODE_0E99EB                      ;0E99DD|F00C    |0E99EB;
						JSR.W CODE_0E9A16                    ;0E99DF|20169A  |0E9A16;
						BCS endStairIdle                     ;0E99E2|B0CE    |0E99B2;
						LDX.B #$02                           ;0E99E4|A202    |      ;
						LDY.B #$0C                           ;0E99E6|A00C    |      ;
						JMP.W updatePlayerSpeed              ;0E99E8|4CAF9B  |0E9BAF;
	
	
			CODE_0E99EB:
						JSR.W CODE_0E99F7                    ;0E99EB|20F799  |0E99F7;
						BCS endStairIdle                     ;0E99EE|B0C2    |0E99B2;
						LDX.B #$00                           ;0E99F0|A200    |      ;
						LDY.B #$04                           ;0E99F2|A004    |      ;
						JMP.W updatePlayerSpeed              ;0E99F4|4CAF9B  |0E9BAF;
	
	
			CODE_0E99F7:
						LDA.W r_entity_YPos                ;0E99F7|AD1C04  |0E041C;
						CMP.B #$D7                           ;0E99FA|C9D7    |      ;
						BCC CODE_0E9A14                      ;0E99FC|9016    |0E9A14;
						LDY.B r_roomOrientation              ;0E99FE|A468    |000068;
						BPL CODE_0E9A14                      ;0E9A00|1012    |0E9A14;
						LDA.B r_sceneScrollOffsetHi          ;0E9A02|A557    |000057;
						CMP.B r_scroolLock                   ;0E9A04|C571    |000071;
						BNE CODE_0E9A0E                      ;0E9A06|D006    |0E9A0E;
						LDA.B r_sceneScrollOffsetLo          ;0E9A08|A556    |000056;
						CMP.B #$30                           ;0E9A0A|C930    |      ;
						BEQ CODE_0E9A14                      ;0E9A0C|F006    |0E9A14;
	
			CODE_0E9A0E:
						CPY.B #$82                           ;0E9A0E|C082    |      ;
						BCS CODE_0E9A14                      ;0E9A10|B002    |0E9A14;
						SEC                                  ;0E9A12|38      |      ;
						RTS                                  ;0E9A13|60      |      ;
	
	
			CODE_0E9A14:
						CLC                                  ;0E9A14|18      |      ;
						RTS                                  ;0E9A15|60      |      ;
	
	
			CODE_0E9A16:
						LDA.W r_entity_YPos                ;0E9A16|AD1C04  |0E041C;
						CMP.B #$37                           ;0E9A19|C937    |      ;
						BCS CODE_0E9A14                      ;0E9A1B|B0F7    |0E9A14;
						LDY.B r_roomOrientation              ;0E9A1D|A468    |000068;
						BPL CODE_0E9A14                      ;0E9A1F|10F3    |0E9A14;
						LDA.B r_sceneScrollOffsetHi          ;0E9A21|A557    |000057;
						ORA.B r_sceneScrollOffsetLo          ;0E9A23|0556    |000056;
						BEQ CODE_0E9A14                      ;0E9A25|F0ED    |0E9A14;
						CPY.B #$82                           ;0E9A27|C082    |      ;
						BCS CODE_0E9A14                      ;0E9A29|B0E9    |0E9A14;
						SEC                                  ;0E9A2B|38      |      ;
						RTS                                  ;0E9A2C|60      |      ;
	
	
			CODE_0E9A2D:
						LDA.W r_entity_YPos                ;0E9A2D|AD1C04  |0E041C;
						LDX.W r_entity_Yspd                ;0E9A30|AE2005  |0E0520;
						BMI CODE_0E9A45                      ;0E9A33|3010    |0E9A45;
						LDX.B r_roomOrientation              ;0E9A35|A668    |000068;
						BMI CODE_0E9A3F                      ;0E9A37|3006    |0E9A3F;
						CMP.B #$D3                           ;0E9A39|C9D3    |      ;
						BCS CODE_0E9A5F                      ;0E9A3B|B022    |0E9A5F;
						CLC                                  ;0E9A3D|18      |      ;
						RTS                                  ;0E9A3E|60      |      ;
	
	
			CODE_0E9A3F:
						CMP.B #$D6                           ;0E9A3F|C9D6    |      ;
						BCS CODE_0E9A6D                      ;0E9A41|B02A    |0E9A6D;
						CLC                                  ;0E9A43|18      |      ;
						RTS                                  ;0E9A44|60      |      ;
	
	
			CODE_0E9A45:
						LDX.B r_roomOrientation              ;0E9A45|A668    |000068;
						BMI CODE_0E9A4F                      ;0E9A47|3006    |0E9A4F;
						CMP.B #$29                           ;0E9A49|C929    |      ;
						BCC CODE_0E9A55                      ;0E9A4B|9008    |0E9A55;
						CLC                                  ;0E9A4D|18      |      ;
						RTS                                  ;0E9A4E|60      |      ;
	
	
			CODE_0E9A4F:
						CMP.B #$34                           ;0E9A4F|C934    |      ;
						BCC CODE_0E9A81                      ;0E9A51|902E    |0E9A81;
	
			CODE_0E9A53:
						CLC                                  ;0E9A53|18      |      ;
						RTS                                  ;0E9A54|60      |      ;
	
	
			CODE_0E9A55:
						LDA.B r_gameTransition               ;0E9A55|A52A    |00002A;
						CMP.B #$10                           ;0E9A57|C910    |      ;
						BNE CODE_0E9A5F                      ;0E9A59|D004    |0E9A5F;
						INC.B r_menuSelectIdx                ;0E9A5B|E66B    |00006B;
						BNE CODE_0E9A63                      ;0E9A5D|D004    |0E9A63;
	
			CODE_0E9A5F:
						LDA.B #$06                           ;0E9A5F|A906    |      ;
						STA.B r_gameTransition               ;0E9A61|852A    |00002A;
	
			CODE_0E9A63:
						LDA.B #$96                           ;0E9A63|A996    |      ;
						STA.W r_Player_StateDoubled        ;0E9A65|8D6505  |0E0565;
						                               ;0E9A68|        |      ;
						JSR.W CODE_0FFB85                       ;0E9A69|        |0FFB85;
						SEC                                  ;0E9A6B|38      |      ;
						RTS                                  ;0E9A6C|60      |      ;
	
	
			CODE_0E9A6D:
						LDA.B r_sceneScrollOffsetHi          ;0E9A6D|A557    |000057;
						CMP.B r_scroolLock                   ;0E9A6F|C571    |000071;
						BNE CODE_0E9A79                      ;0E9A71|D006    |0E9A79;
						LDA.B r_sceneScrollOffsetLo          ;0E9A73|A556    |000056;
						CMP.B #$30                           ;0E9A75|C930    |      ;
						BEQ CODE_0E9A5F                      ;0E9A77|F0E6    |0E9A5F;
	
			CODE_0E9A79:
						LDA.B r_roomOrientation              ;0E9A79|A568    |000068;
						CMP.B #$83                           ;0E9A7B|C983    |      ;
						BNE CODE_0E9A53                      ;0E9A7D|D0D4    |0E9A53;
						SEC                                  ;0E9A7F|38      |      ;
						RTS                                  ;0E9A80|60      |      ;
	
	
			CODE_0E9A81:
						LDA.B r_sceneScrollOffsetLo          ;0E9A81|A556    |000056;
						ORA.B r_sceneScrollOffsetHi          ;0E9A83|0557    |000057;
						BEQ CODE_0E9A5F                      ;0E9A85|F0D8    |0E9A5F;
						LDA.B r_roomOrientation              ;0E9A87|A568    |000068;
						CMP.B #$82                           ;0E9A89|C982    |      ;
						BEQ CODE_0E9A91                      ;0E9A8B|F004    |0E9A91;
						CMP.B #$84                           ;0E9A8D|C984    |      ;
						BNE CODE_0E9A53                      ;0E9A8F|D0C2    |0E9A53;
	
			CODE_0E9A91:
						SEC                                  ;0E9A91|38      |      ;
						RTS                                  ;0E9A92|60      |      ;
	
	
	player_state14_stairClimb:
						JSR.W CODE_0E9A2D                    ;0E9A93|202D9A  |0E9A2D;
						BCC CODE_0E9A99                      ;0E9A96|9001    |0E9A99;
						RTS                                  ;0E9A98|60      |      ;
	
	
			CODE_0E9A99:
				if !jumpControllDirection == 1			
						jsr dislunchFromStairs
				endif 																	
						JSR.W CODE_0E8740                    ;0E9A99|204087  |0E8740;
						JSR.W updateSpeed2Pos                ;0E9A9C|201287  |0E8712;
						LDA.W r_damagActionFlag         ;0E9A9F|AD1D06  |0E061D;
						BEQ CODE_0E9AF0                      ;0E9AA2|F04C    |0E9AF0;
						DEC.W r_damagActionFlag         ;0E9AA4|CE1D06  |0E061D;
						LDA.W r_entity_AnimTimer           ;0E9AA7|AD7C05  |0E057C;
						BEQ mainPlayerAnimStuff              ;0E9AAA|F004    |0E9AB0;
						DEC.W r_entity_AnimTimer           ;0E9AAC|CE7C05  |0E057C;
						RTS                                  ;0E9AAF|60      |      ;
	
	
	mainPlayerAnimStuff:
						LDA.W r_entity_ID           ;0E9AB0|AD4E05  |00054E;
						CMP.B #$02                           ;0E9AB3|C902    |      ;
						BEQ CODE_0E9ACC                      ;0E9AB5|F015    |0E9ACC;
						LDA.W r_entity_OamBaseOffset         ;0E9AB7|AD9305  |000593;
						ASL A                                ;0E9ABA|0A      |      ;
						TAY                                  ;0E9ABB|A8      |      ;
						LDA.W DATA8_0E9BEC,Y                 ;0E9ABC|B9EC9B  |0E9BEC;
						STA.W r_entity_spriteID            ;0E9ABF|8D0004  |000400;
						LDA.W DATA8_0E9BED,Y                 ;0E9AC2|B9ED9B  |0E9BED;
						STA.W r_entity_AnimTimer           ;0E9AC5|8D7C05  |0E057C;
						INC.W r_entity_OamBaseOffset       ;0E9AC8|EE9305  |0E0593;
						RTS                                  ;0E9ACB|60      |      ;
	
	
			CODE_0E9ACC:
						LDA.W r_entity_OamBaseOffset       ;0E9ACC|AD9305  |0E0593;
						ASL A                                ;0E9ACF|0A      |      ;
						TAY                                  ;0E9AD0|A8      |      ;
						LDA.W DATA8_0E9BF4,Y                 ;0E9AD1|B9F49B  |0E9BF4;
						STA.W r_entity_spriteID          ;0E9AD4|8D0004  |0E0400;
						LDA.W DATA8_0E9BF5,Y                 ;0E9AD7|B9F59B  |0E9BF5;
						STA.W r_entity_AnimTimer           ;0E9ADA|8D7C05  |0E057C;
						INC.W r_entity_OamBaseOffset       ;0E9ADD|EE9305  |0E0593;
						RTS                                  ;0E9AE0|60      |      ;
	
	
			CODE_0E9AE1:
						LDA.W r_entity_YPos                ;0E9AE1|AD1C04  |0E041C;
						SEC                                  ;0E9AE4|38      |      ;
						SBC.B #$04                           ;0E9AE5|E904    |      ;
						JMP.W CODE_0E9B06                    ;0E9AE7|4C069B  |0E9B06;
	
	
			CODE_0E9AEA:
						CLC                                  ;0E9AEA|18      |      ;
						ADC.B #$07                           ;0E9AEB|6907    |      ;
						JMP.W CODE_0E9B18                    ;0E9AED|4C189B  |0E9B18;
	
	
			CODE_0E9AF0:
						LDA.B #$00                           ;0E9AF0|A900    |      ;
						STA.W r_entity_FractionalX         ;0E9AF2|8DC404  |0E04C4;
						STA.W r_entity_FractionalY         ;0E9AF5|8DDB04  |0E04DB;
						LDY.B r_roomOrientation              ;0E9AF8|A468    |000068;
						BPL CODE_0E9B1B                      ;0E9AFA|101F    |0E9B1B;
						LDY.W r_entity_ID         ;0E9AFC|AC4E05  |0E054E;
						CPY.B #$02                           ;0E9AFF|C002    |      ;
						BEQ CODE_0E9AE1                      ;0E9B01|F0DE    |0E9AE1;
						LDA.W r_entity_YPos                ;0E9B03|AD1C04  |0E041C;
	
			CODE_0E9B06:
						CLC                                  ;0E9B06|18      |      ;
						ADC.B #$03                           ;0E9B07|6903    |      ;
						CLC                                  ;0E9B09|18      |      ;
						ADC.B r_sceneScrollOffsetLo          ;0E9B0A|6556    |000056;
						AND.B #$F8                           ;0E9B0C|29F8    |      ;
						SEC                                  ;0E9B0E|38      |      ;
						SBC.B r_sceneScrollOffsetLo          ;0E9B0F|E556    |000056;
						CPY.B #$02                           ;0E9B11|C002    |      ;
						BEQ CODE_0E9AEA                      ;0E9B13|F0D5    |0E9AEA;
						CLC                                  ;0E9B15|18      |      ;
						ADC.B #$03                           ;0E9B16|6903    |      ;
	
			CODE_0E9B18:
						STA.W r_entity_YPos                ;0E9B18|8D1C04  |0E041C;
	
			CODE_0E9B1B:
						LDA.W r_entity_Yspd                ;0E9B1B|AD2005  |0E0520;
						BMI CODE_0E9B64                      ;0E9B1E|3044    |0E9B64;
						LDX.B #$12                           ;0E9B20|A212    |      ;
						LDA.B #$02                           ;0E9B22|A902    |      ;
						                               ;0E9B24|        |      ;
						JSR.W playerCollusionCheck              ;0E9B25|        |0FFCDD;
						BNE CODE_0E9B3D                      ;0E9B27|D014    |0E9B3D;
						LDX.B #$12                           ;0E9B29|A212    |      ;
						LDA.B #$FE                           ;0E9B2B|A9FE    |      ;
						                               ;0E9B2D|        |      ;
						JSR.W playerCollusionCheck              ;0E9B2E|        |0FFCDD;
						BEQ CODE_0E9B88                      ;0E9B30|F056    |0E9B88;
						LDX.B #$1A                           ;0E9B32|A21A    |      ;
						LDA.B #$FE                           ;0E9B34|A9FE    |      ;
						                               ;0E9B36|        |      ;
						JSR.W playerCollusionCheck              ;0E9B37|        |0FFCDD;
						BEQ CODE_0E9B88                      ;0E9B39|F04D    |0E9B88;
						BNE CODE_0E9B46                      ;0E9B3B|D009    |0E9B46;
	
			CODE_0E9B3D:
						LDX.B #$1A                           ;0E9B3D|A21A    |      ;
						LDA.B #$02                           ;0E9B3F|A902    |      ;
						                               ;0E9B41|        |      ;
						JSR.W playerCollusionCheck              ;0E9B42|        |0FFCDD;
						BEQ CODE_0E9B88                      ;0E9B44|F042    |0E9B88;
	
			CODE_0E9B46:
						JSR.W CODE_0E8A02                    ;0E9B46|20028A  |0E8A02;
						LDA.W r_entity_ID         ;0E9B49|AD4E05  |0E054E;
						CMP.B #$02                           ;0E9B4C|C902    |      ;
						BNE CODE_0E9B59                      ;0E9B4E|D009    |0E9B59;
						LDA.W r_entity_YPos                ;0E9B50|AD1C04  |0E041C;
						CLC                                  ;0E9B53|18      |      ;
						ADC.B #$04                           ;0E9B54|6904    |      ;
						STA.W r_entity_YPos                ;0E9B56|8D1C04  |0E041C;
	
			CODE_0E9B59:
						LDA.B #$02                           ;0E9B59|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E9B5B|8D6505  |0E0565;
						LDA.B #$02                           ;0E9B5E|A902    |      ;
						STA.W r_entity_spriteID          ;0E9B60|8D0004  |0E0400;
						RTS                                  ;0E9B63|60      |      ;
	
	
			CODE_0E9B64:
						LDX.B #$12                           ;0E9B64|A212    |      ;
						LDA.B #$02                           ;0E9B66|A902    |      ;
						                               ;0E9B68|        |      ;
						JSR.W playerCollusionCheck              ;0E9B69|        |0FFCDD;
						BNE CODE_0E9B7F                      ;0E9B6B|D012    |0E9B7F;
						LDX.B #$12                           ;0E9B6D|A212    |      ;
						LDA.B #$FE                           ;0E9B6F|A9FE    |      ;
						                               ;0E9B71|        |      ;
						JSR.W playerCollusionCheck              ;0E9B72|        |0FFCDD;
						BEQ CODE_0E9B88                      ;0E9B74|F012    |0E9B88;
						LDX.B #$0A                           ;0E9B76|A20A    |      ;
						LDA.B #$FE                           ;0E9B78|A9FE    |      ;
						                               ;0E9B7A|        |      ;
						JSR.W playerCollusionCheck              ;0E9B7B|        |0FFCDD;
						BEQ CODE_0E9B46                      ;0E9B7D|F0C7    |0E9B46;
	
			CODE_0E9B7F:
						LDX.B #$0A                           ;0E9B7F|A20A    |      ;
						LDA.B #$02                           ;0E9B81|A902    |      ;
						                               ;0E9B83|        |      ;
						JSR.W playerCollusionCheck              ;0E9B84|        |0FFCDD;
						BEQ CODE_0E9B46                      ;0E9B86|F0BE    |0E9B46;
	
			CODE_0E9B88:
						LDA.B #$12                           ;0E9B88|A912    |      ;
						STA.W r_Player_StateDoubled        ;0E9B8A|8D6505  |0E0565;
						RTS                                  ;0E9B8D|60      |      ;
	
	
	updateWeaponFacingSpeed_00:
						LDX.B #$02                           ;0E9B8E|A202    |      ;
						LDA.W r_entity_AI              ;0E9B90|ADEF05  |0E05EF;
						STA.W r_entity_FacingLeft          ;0E9B93|8DA804  |0E04A8;
						LDY.B #$08                           ;0E9B96|A008    |      ;
						BNE CODE_0E9BA6                      ;0E9B98|D00C    |0E9BA6;
	
	updatePlayerFacingSpeed_01:
						LDX.B #$00                           ;0E9B9A|A200    |      ;
						LDA.W r_entity_AI              ;0E9B9C|ADEF05  |0E05EF;
						EOR.B #$01                           ;0E9B9F|4901    |      ;
						STA.W r_entity_FacingLeft          ;0E9BA1|8DA804  |0E04A8;
						LDY.B #$00                           ;0E9BA4|A000    |      ;
	
			CODE_0E9BA6:
						LDA.W r_entity_FacingLeft          ;0E9BA6|ADA804  |0E04A8;
						BEQ updatePlayerSpeed                ;0E9BA9|F004    |0E9BAF;
						INY                                  ;0E9BAB|C8      |      ;
						INY                                  ;0E9BAC|C8      |      ;
						INY                                  ;0E9BAD|C8      |      ;
						INY                                  ;0E9BAE|C8      |      ;
	
		updatePlayerSpeed:
						STX.W r_entity_OamBaseOffset       ;0E9BAF|8E9305  |0E0593;
						LDA.W DATA8_0E9BDC,Y                 ;0E9BB2|B9DC9B  |0E9BDC;
						STA.W r_entity_Xspd                ;0E9BB5|8DF204  |0E04F2;
						LDA.W DATA8_0E9BDD,Y                 ;0E9BB8|B9DD9B  |0E9BDD;
						STA.W r_entity_XsubSpd             ;0E9BBB|8D0905  |0E0509;
						LDA.W DATA8_0E9BDE,Y                 ;0E9BBE|B9DE9B  |0E9BDE;
						STA.W r_entity_Yspd                ;0E9BC1|8D2005  |0E0520;
						LDA.W DATA8_0E9BDF,Y                 ;0E9BC4|B9DF9B  |0E9BDF;
						STA.W r_entity_YsubSpd             ;0E9BC7|8D3705  |0E0537;
						LDA.B #$01                           ;0E9BCA|A901    |      ;
						STA.W r_entity_AnimTimer           ;0E9BCC|8D7C05  |0E057C;
						LDA.W DATA8_0E9BDB                   ;0E9BCF|ADDB9B  |0E9BDB;
						STA.W r_damagActionFlag         ;0E9BD2|8D1D06  |0E061D;
						LDA.B #$14                           ;0E9BD5|A914    |      ;
						STA.W r_Player_StateDoubled        ;0E9BD7|8D6505  |0E0565;
						RTS                                  ;0E9BDA|60      |      ;
	
	
			DATA8_0E9BDB:
						db $0F                               ;0E9BDB|        |      ;
	
			DATA8_0E9BDC:
						db $00                               ;0E9BDC|        |      ;
	
			DATA8_0E9BDD:
						db $80                               ;0E9BDD|        |      ;
	
			DATA8_0E9BDE:
						db $00                               ;0E9BDE|        |      ;
	
			DATA8_0E9BDF:
						db $80,$FF,$80,$00,$80,$00,$80,$FF   ;0E9BDF|        |      ;
	
						db $80,$FF,$80,$FF,$80               ;0E9BE7|        |      ;
	
	
			DATA8_0E9BEC:
						db $04                               ;0E9BEC|        |      ;
	
			DATA8_0E9BED:
						db $07,$0A,$FF,$04,$07,$0C,$FF       ;0E9BED|        |      ;
	
			DATA8_0E9BF4:
						db $48                               ;0E9BF4|        |      ;
	
			DATA8_0E9BF5:
						db $07,$0A,$FF,$48,$07,$0C,$FF       ;0E9BF5|        |      ;

}


{ ; helper 
	
			symphaState:
						LDY.W r_Player_StateDoubled        ;0E9BFC|AC6505  |0E0565;
						JSR.W jumpFromStack                     ;0E9C00|        |0FE886;
						dw player_state00_init               ;0E9C02|        |0E8AC5;
						dw player_state02_standIdle          ;0E9C04|        |0E9538;
						dw player_state04_walking_exceptGrant;0E9C06|        |0E9660;
						dw player_state06_jumpStart_exceptGrant;0E9C08|        |0E961D;
						dw player_state08_0c_jump            ;0E9C0A|        |0E9770;
						dw player_state0a_ducking_exceptGrant;0E9C0C|        |0E9919;
						dw player_state08_0c_jump            ;0E9C0E|        |0E9770;
						dw player_state0e_walkToStair        ;0E9C10|        |0E9953;
						dw player_state10_startClimb         ;0E9C12|        |0E9967;
						dw player_state12_stairIdle          ;0E9C14|        |0E998E;
						dw player_state14_stairClimb         ;0E9C16|        |0E9A93;
						dw player_state16_transition         ;0E9C18|        |0E9942;
						dw player_state18_attack_trevor_sypha;0E9C1A|        |0E9418;
						dw player_state1a_airAttack_trevor_sypha;0E9C1C|        |0E943A;
						dw player_state1c_duckAttack_trevor_sypha;0E9C1E|        |0E9465;
						dw player_state1e_stairAttack_exceptAlucard;0E9C20|        |0E949E;
						dw player_subWe_state20                    ;0E9C22|        |0E9C32;
						dw player_subW_air_state22_exceptGrant                    ;0E9C24|        |0E9C35;
						dw player_SubWeStair_state24               
						dw player_state26_hit                ;0E9C28|        |0E831C;
						dw player_state28_2a                 ;0E9C2A|        |0E93B1;
						dw player_state28_2a                 ;0E9C2C|        |0E93B1;
						dw player_state2c_pitFall            ;0E9C2E|        |0E8B57;
						dw player_state2e                    ;0E9C30|        |0E8ADE;	
	
			grantStates:
				
				if !grantNinjaStar == 1	
						lda.b r_trevorWhipLevel+1 
						cmp.b #ninjaGrantWeponDelay
						bcs +
						inc.b r_trevorWhipLevel+1 	
					+ 							
				endif 		
						
						LDY.W r_Player_StateDoubled        ;0E9C3B|AC6505  |0E0565;
						JSR.W jumpFromStack                     ;0E9C3F|        |0FE886;
						dw player_state00_init               ;0E9C41|        |0E8AC5;
						dw player_state02_standIdle          ;0E9C43|        |0E9538;
						dw grant_walk_state04                ;0E9C45|        |0E9D3B;
						dw grant_state06                     ;0E9C47|        |0E9E92;
						dw grant_jump_state08_0c             ;0E9C49|        |0E9F3C;
						dw grant_duck_state0a                ;0E9C4B|        |0E9CD5;
						dw grant_jump_state08_0c             ;0E9C4D|        |0E9F3C;
						dw player_state0e_walkToStair        ;0E9C4F|        |0E9953;
						dw player_state10_startClimb         ;0E9C51|        |0E9967;
						dw player_state12_stairIdle          ;0E9C53|        |0E998E;
						dw player_state14_stairClimb         ;0E9C55|        |0E9A93;
						dw player_state16_transition         ;0E9C57|        |0E9942;
						dw grant_stab_state18                ;0E9C59|        |0E9C8B;
						dw grant_stabAir_state1a           ;0E9C5B|        |0E9EEB;
						dw grant_stabDuck1c                     ;0E9C5D|        |0E9C9F;
						dw player_state1e_stairAttack_exceptAlucard;0E9C5F|        |0E949E;
						dw player_subWe_state20              ;0E9C61|        |0E94B8;
						dw grant_subW_air_state22            ;0E9C63|        |0E9EC0;
						dw player_SubWeStair_state24          ;0E9C65|        |0E94FF;
						dw player_state26_hit                ;0E9C67|        |0E831C;
						dw player_state28_2a                 ;0E9C69|        |0E93B1;
						dw player_state28_2a                 ;0E9C6B|        |0E93B1;
						dw player_state2c_pitFall            ;0E9C6D|        |0E8B57;
						dw player_state2e                    ;0E9C6F|        |0E8ADE;
						dw grant_climbWall_state30           ;0E9C71|        |0EA23B;
						dw grant_climbCelling_state32        ;0E9C73|        |0EA365;
						dw grant_climbBot_findCorner_state34 ;0E9C75|        |0EA42E;
						dw grant_climbBottmUp_state36        ;0E9C77|        |0EA441;
						dw grant_climbWallLeft_cornerBottom_state38;0E9C79|        |0EA464;
						dw grant_climbWall2Bottom_state3a    ;0E9C7B|        |0EA477;
						dw grant_climbWallRight_cornerBottom_state3c;0E9C7D|        |0EA480;
						dw grant_climbCorner2Top_state3e     ;0E9C7F|        |0EA493;
						dw grant_climbTop_state40            ;0E9C81|        |0EA49F;
						dw grant_climbTop2Wall_state42       ;0E9C83|        |0EA4B2;
						dw grant_fastClimb_state44                     ;0E9C85|        |0EA188;
						dw grant_subW_wallThrow_state46      ;0E9C87|        |0EA226;
						dw grant_subW_cellingThrow_state48   ;0E9C89|        |0EA333;
			
			alucardStates:
						JSR.W alucardBat_flag                ;0EA5A8|20A7A6  |0EA6A7;
						JSR.W playerChecks                   ;0EA5AB|204FA6  |0EA64F;
						LDY.W r_Player_StateDoubled          ;0EA5AE|AC6505  |000565;
						JSR.W jumpFromStack                     ;0EA5B2|        |0FE886;
						dw player_state00_init               ;0EA5B4|        |0E8AC5;
						dw player_state02_standIdle          ;0EA5B6|        |0E9538;
						dw player_state04_walking_exceptGrant;0EA5B8|        |0E9660;
						dw player_state06_jumpStart_exceptGrant;0EA5BA|        |0E961D;
						dw player_state08_0c_jump            ;0EA5BC|        |0E9770;
						dw player_state0a_ducking_exceptGrant;0EA5BE|        |0E9919;
						dw player_state08_0c_jump            ;0EA5C0|        |0E9770;
						dw player_state0e_walkToStair        ;0EA5C2|        |0E9953;
						dw player_state10_startClimb         ;0EA5C4|        |0E9967;
						dw player_state12_stairIdle          ;0EA5C6|        |0E998E;
						dw player_state14_stairClimb         ;0EA5C8|        |0E9A93;
						dw player_state16_transition         ;0EA5CA|        |0E9942;
						dw alucard_state18_1a_1e_RTS         ;0EA5CC|        |0EA5F8;
						dw alucard_state18_1a_1e_RTS         ;0EA5CE|        |0EA5F8;
						dw alucard_state1c                   ;0EA5D0|        |0EA5F9;
						dw alucard_state18_1a_1e_RTS         ;0EA5D2|        |0EA5F8;
						dw player_subWe_state20              ;0EA5D4|        |0E94B8;
						dw player_subW_air_state22_exceptGrant;0EA5D6|        |0E94D4;
						dw player_SubWeStair_state24          ;0EA5D8|        |0E94FF;
						dw player_state26_hit                ;0EA5DA|        |0E831C;
						dw player_state28_2a                 ;0EA5DC|        |0E93B1;
						dw player_state28_2a                 ;0EA5DE|        |0E93B1;
						dw player_state2c_pitFall            ;0EA5E0|        |0E8B57;
						dw player_state2e                    ;0EA5E2|        |0E8ADE;
						dw alucard_batTransform_state30      ;0EA5E4|        |0EA6BB;
						dw alucard_batTransform_state32      ;0EA5E6|        |0EA6D3;
						dw alucard_bat_fly_state34           ;0EA5E8|        |0EA856;
						dw alucard_batColSolit_state36       ;0EA5EA|        |0EAC8F;
						dw alucard_batColSolit_state38       ;0EA5EC|        |0EACC7;
						dw alucard_batQuickRise_state3a      ;0EA5EE|        |0EAD07;
						dw alucard_batHurt_state3c           ;0EA5F0|        |0EA726;
						dw alucard_batHurt_state3e           ;0EA5F2|        |0EA737;
						dw alucard_state40                   ;0EA5F4|        |0EA7ED;
						dw alucard_state42                   ;0EA5F6|        |0EA78B;
	
	alucard_state18_1a_1e_RTS:
						RTS                                  ;0EA5F8|60      |      ;
		
	grant_stab_state18:
						
						JSR.W CODE_0E841D                    ;0E9C8B|201D84  |0E841D;
						BCS CODE_0E9C98                      ;0E9C8E|B008    |0E9C98;
				
			CODE_0E9C90:
						LDA.B #$00                           ;0E9C90|A900    |      ;
						STA.W $0413                          ;0E9C92|8D1304  |0E0413;
						JMP.W grantStartStopClimb            ;0E9C95|4C8DA0  |0EA08D;
	
	
			CODE_0E9C98:
						JSR.W playerConveyaerCheck           ;0E9C98|208E91  |0E918E;
						JMP.W playerAttackRoutine                    ;0E9C9B|4C2894  |0E9428;
						RTS                                  ;0E9C9E|60      |      ;
	
	
			grant_stabDuck1c:
						JSR.W CODE_0E841D                    ;0E9C9F|201D84  |0E841D;
						BCC CODE_0E9C90                      ;0E9CA2|90EC    |0E9C90;
						JSR.W playerConveyaerCheck           ;0E9CA4|208E91  |0E918E;
						JSR.W CODE_0E9CEB                    ;0E9CA7|20EB9C  |0E9CEB;

				if !jumpControllMovment == 1						
						LDA.W r_Player_StateDoubled     
						CMP.B #$02                      
						BNE CODE_0E9CC4                 
						LDA.B #$1C                      
						STA.W r_Player_StateDoubled     
						jmp playerAttackRoutine                                   
				else 				
						LDA.W r_Player_StateDoubled        ;0E9CAA|AD6505  |0E0565;
						CMP.B #$02                           ;0E9CAD|C902    |      ;
						BNE CODE_0E9CC4                      ;0E9CAF|D013    |0E9CC4;
						LDA.B #$18                           ;0E9CB1|A918    |      ;
						STA.W r_Player_StateDoubled        ;0E9CB3|8D6505  |0E0565;
						JSR.W playerAttackRoutine                    ;0E9CB6|202894  |0E9428;
						LDA.W r_Player_StateDoubled        ;0E9CB9|AD6505  |0E0565;
						CMP.B #$18                           ;0E9CBC|C918    |      ;
						BNE CODE_0E9CC3                      ;0E9CBE|D003    |0E9CC3;
						JSR.W characterThrowAnim                    ;0E9CC0|20CBBE  |0EBECB;
	
			CODE_0E9CC3:
						RTS                                  ;0E9CC3|60      |      ;
				endif 
	
			CODE_0E9CC4:

						JSR.W playerAttackAnim_routine       ;0E9CC4|2089BC  |0EBC89;
						BCS CODE_0E9CCA                      ;0E9CC7|B001    |0E9CCA;	
						RTS                                  ;0E9CC9|60      |      ;
	
	
			CODE_0E9CCA:
						LDA.B #$0A                           ;0E9CCA|A90A    |      ;
						STA.W r_Player_StateDoubled        ;0E9CCC|8D6505  |0E0565;
						LDA.B #$0E                           ;0E9CCF|A90E    |      ;
						STA.W r_entity_spriteID          ;0E9CD1|8D0004  |0E0400;
						RTS                                  ;0E9CD4|60      |      ;
	
	
	grant_duck_state0a:
						JSR.W CODE_0E841D                    ;0E9CD5|201D84  |0E841D;
						BCS CODE_0E9CDD                      ;0E9CD8|B003    |0E9CDD;
						JMP.W grantStartStopClimb            ;0E9CDA|4C8DA0  |0EA08D;
	
	
			CODE_0E9CDD:
						JSR.W playerConveyaerCheck           ;0E9CDD|208E91  |0E918E;
						LDA.B r_Joy1_t                       ;0E9CE0|A526    |000026;
						AND.B #$40                           ;0E9CE2|2940    |      ;
						BEQ CODE_0E9CEB                      ;0E9CE4|F005    |0E9CEB;
						LDA.B #$1C                           ;0E9CE6|A91C    |      ;
						JSR.W storeAttackState_slashSound               ;0E9CE8|200A94  |0E940A;
	
			CODE_0E9CEB:
						LDA.B r_Joy1Held_t                   ;0E9CEB|A528    |000028;
						AND.B #$04                           ;0E9CED|2904    |      ;
						BNE CODE_0E9CF7                      ;0E9CEF|D006    |0E9CF7;
						LDA.B #$02                           ;0E9CF1|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E9CF3|8D6505  |0E0565;
	
			CODE_0E9CF6:
						RTS                                  ;0E9CF6|60      |      ;
	
	
			CODE_0E9CF7:
						LDA.W r_Player_StateDoubled        ;0E9CF7|AD6505  |0E0565;
						CMP.B #$0A                           ;0E9CFA|C90A    |      ;
						BNE CODE_0E9CF6                      ;0E9CFC|D0F8    |0E9CF6;
						JSR.W CODE_0E83C4                    ;0E9CFE|20C483  |0E83C4;
						BCC CODE_0E9CF6                      ;0E9D01|90F3    |0E9CF6;
						JSR.W CODE_0E9D28                    ;0E9D03|20289D  |0E9D28;
						BNE CODE_0E9CF6                      ;0E9D06|D0EE    |0E9CF6;
						LDA.W r_entity_FacingLeft          ;0E9D08|ADA804  |0E04A8;
						STA.W r_entity_AI_IDX          ;0E9D0B|8DC105  |0E05C1;
						JSR.W CODE_0EA527                    ;0E9D0E|2027A5  |0EA527;
						LDA.W r_entity_YPos                ;0E9D11|AD1C04  |0E041C;
						CLC                                  ;0E9D14|18      |      ;
						ADC.B #$0C                           ;0E9D15|690C    |      ;
						STA.B r_GrantCurrentYpos             ;0E9D17|85D3    |0000D3;
						LDA.B #$40                           ;0E9D19|A940    |      ;
						STA.W r_Player_StateDoubled        ;0E9D1B|8D6505  |0E0565;
						LDY.B #$00                           ;0E9D1E|A000    |      ;
						STY.W r_entity_OamBaseOffset       ;0E9D20|8C9305  |0E0593;
						INY                                  ;0E9D23|C8      |      ;
						STY.W r_entity_AnimTimer           ;0E9D24|8C7C05  |0E057C;
						RTS                                  ;0E9D27|60      |      ;
	
	
			CODE_0E9D28:
						LDA.B #$05                           ;0E9D28|A905    |      ;
						LDX.B #$0C                           ;0E9D2A|A20C    |      ;
						                               ;0E9D2C|        |      ;
						JSR.W playerCollusionCheck              ;0E9D2D|        |0FFCDD;
						BEQ CODE_0E9D35                      ;0E9D2F|F004    |0E9D35;
						LDA.B #$01                           ;0E9D31|A901    |      ;
						BNE CODE_0E9D37                      ;0E9D33|D002    |0E9D37;
	
			CODE_0E9D35:
						LDA.B #$00                           ;0E9D35|A900    |      ;
	
			CODE_0E9D37:
						CMP.W r_entity_FacingLeft          ;0E9D37|CDA804  |0E04A8;
						RTS                                  ;0E9D3A|60      |      ;
	
	
	grant_walk_state04:
						JSR.W CODE_0E841D                    ;0E9D3B|201D84  |0E841D;
						BCS CODE_0E9D43                      ;0E9D3E|B003    |0E9D43;
						JMP.W grantStartStopClimb            ;0E9D40|4C8DA0  |0EA08D;
	
	
			CODE_0E9D43:
						LDA.B r_Joy1_t                       ;0E9D43|A526    |000026;
						ASL A                                ;0E9D45|0A      |      ;
						BCC CODE_0E9D4B                      ;0E9D46|9003    |0E9D4B;
						JMP.W CODE_0E9DFF                    ;0E9D48|4CFF9D  |0E9DFF;
	
	
			CODE_0E9D4B:
						ASL A                                ;0E9D4B|0A      |      ;
						BCS CODE_0E9D67                      ;0E9D4C|B019    |0E9D67;
						LDA.B r_Joy1Held_t                   ;0E9D4E|A528    |000028;
						LSR A                                ;0E9D50|4A      |      ;
						BCS CODE_0E9D85                      ;0E9D51|B032    |0E9D85;
						LSR A                                ;0E9D53|4A      |      ;
						BCS CODE_0E9DBC                      ;0E9D54|B066    |0E9DBC;
						
						LDA.B #$02                           ;0E9D56|A902    |      ;
						STA.W r_Player_StateDoubled        ;0E9D58|8D6505  |0E0565;
	
			grantClearSpeedUpdateAnim:
						JSR.W clearPlayerVertSpeed           ;0E9D5B|20BC8A  |0E8ABC;
	
			updateSpriteAnim:
						JSR.W updateSpriteAnimFrame             ;0E9D5F|        |0FEF73;
	
			grantUpdateSpeed:
						JSR.W playerKnockback_01             ;0E9D61|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0E9D64|4C1287  |0E8712;
	
	
			CODE_0E9D67:
						LDA.B r_Joy1Held_t                   ;0E9D67|A528    |000028;
						AND.B #$08                           ;0E9D69|2908    |      ;
						BNE CODE_0E9D75                      ;0E9D6B|D008    |0E9D75;
	
			subweaponInitWhileWalk:	    				; !!FIXME !grantDaggerSpiderSilkFreez bug when attacking on celling. Shoots wrong direction                    						
						LDA.B #$18                           ;0E9D6D|A918    |      ;
						JSR.W storeAttackState_slashSound             
						JMP.W grantClearSpeedUpdateAnim               
	
			CODE_0E9D75:
						JSR.W initSubwAttack_CC                 ;0E9D75|20F5B9  |0EB9F5;
						BCC subweaponInitWhileWalk                
						LDA.B #$20                           ;0E9D7A|A920    |      ;
						JSR.W initPlayerState_A               ;0E9D7C|20AA94  |0E94AA;
						JSR.W clearPlayerVertSpeed           ;0E9D7F|20BC8A  |0E8ABC;
						JMP.W grantUpdateSpeed                    ;0E9D82|4C619D  |0E9D61;
	
	
			CODE_0E9D85:
						LDA.B #$00                           ;0E9D85|A900    |      ;
						STA.W r_entity_FacingLeft          ;0E9D87|8DA804  |0E04A8;
						JSR.W doConveyaerRoomEffect          ;0E9D8A|20858E  |0E8E85;
						BCC CODE_0E9DA4                      ;0E9D8D|9015    |0E9DA4;
						LDX.B #$00                           ;0E9D8F|A200    |      ;
						LDA.B #$08                           ;0E9D91|A908    |      ;
						                               ;0E9D93|        |      ;
						JSR.W playerCollusionCheck              ;0E9D94|        |0FFCDD;
						BNE CODE_0E9DFA                      ;0E9D96|D062    |0E9DFA;
						LDX.B #$F4                           ;0E9D98|A2F4    |      ;
						LDA.B #$08                           ;0E9D9A|A908    |      ;
						                               ;0E9D9C|        |      ;
						JSR.W playerCollusionCheck              ;0E9D9D|        |0FFCDD;
						BNE CODE_0E9DFA                      ;0E9D9F|D059    |0E9DFA;
						JMP.W updateSpriteAnim               ;0E9DA1|4C5E9D  |0E9D5E;
	
	
			CODE_0E9DA4:
						LDX.B #$00                           ;0E9DA4|A200    |      ;
						LDA.B #$08                           ;0E9DA6|A908    |      ;
						                               ;0E9DA8|        |      ;
						JSR.W playerCollusionCheck              ;0E9DA9|        |0FFCDD;
						BNE CODE_0E9E1B                      ;0E9DAB|D06E    |0E9E1B;
						LDX.B #$F4                           ;0E9DAD|A2F4    |      ;
						LDA.B #$08                           ;0E9DAF|A908    |      ;
						                               ;0E9DB1|        |      ;
						JSR.W playerCollusionCheck              ;0E9DB2|        |0FFCDD;
						BNE CODE_0E9DFA                      ;0E9DB4|D044    |0E9DFA;
						LDA.B #$01                           ;0E9DB6|A901    |      ;
						LDY.B #$40                           ;0E9DB8|A040    |      ;
						BNE CODE_0E9DF1                      ;0E9DBA|D035    |0E9DF1;
	
			CODE_0E9DBC:
						LDA.B #$01                           ;0E9DBC|A901    |      ;
						STA.W r_entity_FacingLeft          ;0E9DBE|8DA804  |0E04A8;
						JSR.W gameTransitionChecks           ;0E9DC1|20018F  |0E8F01;
						BCC CODE_0E9DDB                      ;0E9DC4|9015    |0E9DDB;
						LDX.B #$00                           ;0E9DC6|A200    |      ;
						LDA.B #$F8                           ;0E9DC8|A9F8    |      ;
						db $20                               ;0E9DCA|        |      ;
						dw playerCollusionCheck              ;0E9DCB|        |0FFCDD;
						BNE CODE_0E9DFA                      ;0E9DCD|D02B    |0E9DFA;
						LDX.B #$F4                           ;0E9DCF|A2F4    |      ;
						LDA.B #$F8                           ;0E9DD1|A9F8    |      ;
						db $20                               ;0E9DD3|        |      ;
						dw playerCollusionCheck              ;0E9DD4|        |0FFCDD;
						BNE CODE_0E9DFA                      ;0E9DD6|D022    |0E9DFA;
						JMP.W updateSpriteAnim               ;0E9DD8|4C5E9D  |0E9D5E;
	
	
			CODE_0E9DDB:
						LDX.B #$00                           ;0E9DDB|A200    |      ;
						LDA.B #$F8                           ;0E9DDD|A9F8    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9DDF|200B84  |0E840B;
						BNE CODE_0E9E0B                      ;0E9DE2|D027    |0E9E0B;
						LDX.B #$F4                           ;0E9DE4|A2F4    |      ;
						LDA.B #$F8                           ;0E9DE6|A9F8    |      ;
						db $20                               ;0E9DE8|        |      ;
						dw playerCollusionCheck              ;0E9DE9|        |0FFCDD;
						BNE CODE_0E9DFA                      ;0E9DEB|D00D    |0E9DFA;
						LDA.B #$FE                           ;0E9DED|A9FE    |      ;
						LDY.B #$C0                           ;0E9DEF|A0C0    |      ;
	
			CODE_0E9DF1:
						STY.W r_entity_XsubSpd             ;0E9DF1|8C0905  |0E0509;
						STA.W r_entity_Xspd                ;0E9DF4|8DF204  |0E04F2;
						JMP.W grantClearSpeedUpdateAnim                    ;0E9DF7|4C5B9D  |0E9D5B;
	
	
			CODE_0E9DFA:
						LDA.B #$00                           ;0E9DFA|A900    |      ;
						TAY                                  ;0E9DFC|A8      |      ;
						BEQ CODE_0E9DF1                      ;0E9DFD|F0F2    |0E9DF1;
	
			CODE_0E9DFF:
						LDA.B #$06                           ;0E9DFF|A906    |      ;
						STA.W r_Player_StateDoubled        ;0E9E01|8D6505  |0E0565;
						JMP.W grantClearSpeedUpdateAnim                    ;0E9E04|4C5B9D  |0E9D5B;
	
	
			CODE_0E9E07:
						LDA.B #$36                           ;0E9E07|A936    |      ;
						BNE CODE_0E9E0D                      ;0E9E09|D002    |0E9E0D;
	
			CODE_0E9E0B:
						LDA.B #$18                           ;0E9E0B|A918    |      ;
	
			CODE_0E9E0D:
						STA.W r_entity_spriteID          ;0E9E0D|8D0004  |0E0400;
						JSR.W CODE_0E9E36                    ;0E9E10|20369E  |0E9E36;
						LDA.B #$01                           ;0E9E13|A901    |      ;
						BNE CODE_0E9E25                      ;0E9E15|D00E    |0E9E25;
	
			CODE_0E9E17:
						LDA.B #$36                           ;0E9E17|A936    |      ;
						BNE CODE_0E9E1D                      ;0E9E19|D002    |0E9E1D;
	
			CODE_0E9E1B:
						LDA.B #$18                           ;0E9E1B|A918    |      ;
	
			CODE_0E9E1D:
						STA.W r_entity_spriteID          ;0E9E1D|8D0004  |0E0400;
						JSR.W CODE_0E9E3F                    ;0E9E20|203F9E  |0E9E3F;
						LDA.B #$00                           ;0E9E23|A900    |      ;
	
			CODE_0E9E25:
						STA.W r_entity_AI_IDX          ;0E9E25|8DC105  |0E05C1;
						LDA.B #$00                           ;0E9E28|A900    |      ;
						STA.W r_entity_extra               ;0E9E2A|8DD805  |0E05D8;
						STA.W r_entity_OamBaseOffset       ;0E9E2D|8D9305  |0E0593;
						LDA.B #$30                           ;0E9E30|A930    |      ;
						STA.W r_Player_StateDoubled        ;0E9E32|8D6505  |0E0565;
						RTS                                  ;0E9E35|60      |      ;
	
	
			CODE_0E9E36:
						LDA.W r_entity_XPos                ;0E9E36|AD3804  |0E0438;
						CLC                                  ;0E9E39|18      |      ;
						ADC.B #$07                           ;0E9E3A|6907    |      ;
						JMP.W CODE_0E9E42                    ;0E9E3C|4C429E  |0E9E42;
	
	
			CODE_0E9E3F:
						LDA.W r_entity_XPos                ;0E9E3F|AD3804  |0E0438;
	
			CODE_0E9E42:
						LDY.B r_roomOrientation              ;0E9E42|A468    |000068;
						BMI CODE_0E9E52                      ;0E9E44|300C    |0E9E52;
						CLC                                  ;0E9E46|18      |      ;
						ADC.B r_sceneScrollOffsetLo          ;0E9E47|6556    |000056;
						AND.B #$F8                           ;0E9E49|29F8    |      ;
						SEC                                  ;0E9E4B|38      |      ;
						SBC.B r_sceneScrollOffsetLo          ;0E9E4C|E556    |000056;
						STA.W r_entity_XPos                ;0E9E4E|8D3804  |0E0438;
						RTS                                  ;0E9E51|60      |      ;
	
	
			CODE_0E9E52:
						AND.B #$F8                           ;0E9E52|29F8    |      ;
						STA.W r_entity_XPos                ;0E9E54|8D3804  |0E0438;
						RTS                                  ;0E9E57|60      |      ;
	
	
	playerFallSpeedTable:
						db $80                               ;0E9E58|        |      ;
	
	
			DATA8_0E9E59:
						db $F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9   ;0E9E59|        |      ;
						db $F9,$F9,$F9,$F9,$F9,$F9,$F9,$F9   ;0E9E61|        |      ;
						db $F9,$F9,$F9,$FA,$FA,$FA,$FA,$FA   ;0E9E69|        |      ;
						db $FA,$FB,$FB,$FB,$FB,$FB,$FC,$FC   ;0E9E71|        |      ;
						db $FC,$FC,$FC,$FD,$FD,$FD,$FD,$FD   ;0E9E79|        |      ;
						db $FD,$FE,$FE,$FE,$FE,$FE,$FF,$FF   ;0E9E81|        |      ;
						db $FF,$FF,$FF,$00,$00,$00,$00,$00   ;0E9E89|        |      ;
						db $81                               ;0E9E91|        |      ;
	
			grant_state06:
						LDA.B #$0E                           ;0E9E92|A90E    |      ;
						STA.W r_entity_spriteID          ;0E9E94|8D0004  |0E0400;
						LDA.B #$04                           ;0E9E97|A904    |      ;
						STA.B r_timerClunk_drop              ;0E9E99|85B9    |0000B9;
						LDA.B #$00                           ;0E9E9B|A900    |      ;
						STA.W r_entity_AI_IDX          ;0E9E9D|8DC105  |0E05C1;
						LDA.B #$1E                           ;0E9EA0|A91E    |      ;
						STA.W r_entity_extra               ;0E9EA2|8DD805  |0E05D8;
						LDA.B #$00                           ;0E9EA5|A900    |      ;
						STA.W r_entity_AI              ;0E9EA7|8DEF05  |0E05EF;
						STA.W r_entity_target          ;0E9EAA|8D0606  |0E0606;
						STA.W r_entity_XsubSpd             ;0E9EAD|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0E9EB0|8DF204  |0E04F2;
						STA.B $9D                            ;0E9EB3|859D    |00009D;
						LDA.B #$01                           ;0E9EB5|A901    |      ;
						STA.W r_damagActionFlag         ;0E9EB7|8D1D06  |0E061D;
						LDA.B #$08                           ;0E9EBA|A908    |      ;
						STA.W r_Player_StateDoubled        ;0E9EBC|8D6505  |0E0565;
						RTS                                  ;0E9EBF|60      |      ;
	
	
	grant_subW_air_state22:
						JSR.W grantFreeAirMovement           ;0E9EC0|205A9F  |0E9F5A;
						LDA.W r_Player_StateDoubled        ;0E9EC3|AD6505  |0E0565;
						CMP.B #$26                           ;0E9EC6|C926    |      ;
						BEQ CODE_0E9F0A                      ;0E9EC8|F040    |0E9F0A;
						CMP.B #$02                           ;0E9ECA|C902    |      ;
						BNE CODE_0E9EDA                      ;0E9ECC|D00C    |0E9EDA;
						LDA.B #$00                           ;0E9ECE|A900    |      ;
						STA.B r_timerClunk_drop              ;0E9ED0|85B9    |0000B9;
						LDA.B #$20                           ;0E9ED2|A920    |      ;
						STA.W r_Player_StateDoubled        ;0E9ED4|8D6505  |0E0565;
						JMP.W CODE_0E94C3                    ;0E9ED7|4CC394  |0E94C3;
	
	
			CODE_0E9EDA:
						JSR.W player_animCountDown           ;0E9EDA|20F2BA  |0EBAF2;
						BCS CODE_0E9EE0                      ;0E9EDD|B001    |0E9EE0;
						RTS                                  ;0E9EDF|60      |      ;
	
	
			CODE_0E9EE0:
						LDA.B #$08                           ;0E9EE0|A908    |      ;
						STA.W r_Player_StateDoubled        ;0E9EE2|8D6505  |0E0565;
						LDA.B #$02                           ;0E9EE5|A902    |      ;
						STA.W r_entity_spriteID          ;0E9EE7|8D0004  |0E0400;
						RTS                                  ;0E9EEA|60      |      ;
	
	
	grant_stabAir_state1a:
						JSR.W grantFreeAirMovement           ;0E9EEB|205A9F  |0E9F5A;
						LDA.W r_Player_StateDoubled        ;0E9EEE|AD6505  |0E0565;
						CMP.B #$26                           ;0E9EF1|C926    |      ;
						BEQ CODE_0E9F0A                      ;0E9EF3|F015    |0E9F0A;
						CMP.B #$02                           ;0E9EF5|C902    |      ;
						BNE CODE_0E9F05                      ;0E9EF7|D00C    |0E9F05;
						LDA.B #$00                           ;0E9EF9|A900    |      ;
						STA.B r_timerClunk_drop              ;0E9EFB|85B9    |0000B9;
						LDA.B #$18                           ;0E9EFD|A918    |      ;
						STA.W r_Player_StateDoubled        ;0E9EFF|8D6505  |0E0565;
						JMP.W playerAttackRoutine                    ;0E9F02|4C2894  |0E9428;
	
	
			CODE_0E9F05:						
						
						JSR.W playerAttackAnim_routine       ;0E9F05|2089BC  |0EBC89;
						BCS CODE_0E9EE0                      ;0E9F08|B0D6    |0E9EE0;
				
			CODE_0E9F0A:
						RTS                                  ;0E9F0A|60      |      ;
	
	
			CODE_0E9F0B:
						LDA.W r_entity_YPos                ;0E9F0B|AD1C04  |0E041C;
						CLC                                  ;0E9F0E|18      |      ;
						ADC.B #$01                           ;0E9F0F|6901    |      ;
						STA.W r_entity_YPos                ;0E9F11|8D1C04  |0E041C;
						JSR.W CODE_0E8A02                    ;0E9F14|20028A  |0E8A02;
						LDA.W r_entity_YPos                ;0E9F17|AD1C04  |0E041C;
						CLC                                  ;0E9F1A|18      |      ;
						ADC.B #$05                           ;0E9F1B|6905    |      ;
						STA.W r_entity_YPos                ;0E9F1D|8D1C04  |0E041C;
						LDA.B #$02                           ;0E9F20|A902    |      ;
						                               ;0E9F22|        |      ;
						JSR.W clearSpriteAndAnimGroup              ;0E9F23|        |0FEF57;
						LDA.B #$32                           ;0E9F25|A932    |      ;
						STA.W r_Player_StateDoubled        ;0E9F27|8D6505  |0E0565;
						RTS                                  ;0E9F2A|60      |      ;
	
	
			CODE_0E9F2B:
						LDA.B #$00                           ;0E9F2B|A900    |      ;
						BEQ CODE_0E9F31                      ;0E9F2D|F002    |0E9F31;
	
			CODE_0E9F2F:
						LDA.B #$FF                           ;0E9F2F|A9FF    |      ;
	
			CODE_0E9F31:
						LDX.B #$00                           ;0E9F31|A200    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9F33|200B84  |0E840B;
						BEQ CODE_0E9F3A                      ;0E9F36|F002    |0E9F3A;
						CLC                                  ;0E9F38|18      |      ;
						RTS                                  ;0E9F39|60      |      ;
	
	
			CODE_0E9F3A:
						SEC                                  ;0E9F3A|38      |      ;
	
			CODE_0E9F3B:
						RTS                                  ;0E9F3B|60      |      ;
	
	
	grant_jump_state08_0c:
						LDA.B r_Joy1_t                       ;0E9F3C|A526    |000026;
						AND.B #$40                           ;0E9F3E|2940    |      ;
						BEQ grantFreeAirMovement             ;0E9F40|F018    |0E9F5A;
						LDA.B r_Joy1Held_t                   ;0E9F42|A528    |000028;
						AND.B #$08                           ;0E9F44|2908    |      ;
						BNE CODE_0E9F50                      ;0E9F46|D008    |0E9F50;
	
			CODE_0E9F48:
						LDA.B #$1A                           ;0E9F48|A91A    |      ;
						JSR.W storeAttackState_slashSound               ;0E9F4A|200A94  |0E940A;
						JMP.W grantFreeAirMovement           ;0E9F4D|4C5A9F  |0E9F5A;
	
	
			CODE_0E9F50:
						JSR.W initSubwAttack_CC                 ;0E9F50|20F5B9  |0EB9F5;
						BCC CODE_0E9F48                      ;0E9F53|90F3    |0E9F48;
						LDA.B #$22                           ;0E9F55|A922    |      ;
						JSR.W initPlayerState_A               ;0E9F57|20AA94  |0E94AA;
	
	grantFreeAirMovement:
						JSR.W do_invincableFrames            ;0E9F5A|20AA83  |0E83AA;
						BCS CODE_0E9F3B                      ;0E9F5D|B0DC    |0E9F3B;
						LDA.B r_Joy1Held_t                   ;0E9F5F|A528    |000028;
						LSR A                                ;0E9F61|4A      |      ;
						BCS CODE_0E9F87                      ;0E9F62|B023    |0E9F87;
						LSR A                                ;0E9F64|4A      |      ;
						BCC CODE_0E9FA7                      ;0E9F65|9040    |0E9FA7;
						LDA.B #$01                           ;0E9F67|A901    |      ;
	
						STA.W r_entity_FacingLeft          ;0E9F69|8DA804  |0E04A8;
						LDA.B #$FF                           ;0E9F6C|A9FF    |      ;
						STA.W r_entity_Xspd                ;0E9F6E|8DF204  |0E04F2;
						LDA.B #$00                           ;0E9F71|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9F73|8D0905  |0E0509;
						LDX.B #$00                           ;0E9F76|A200    |      ;
						LDA.B #$F8                           ;0E9F78|A9F8    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9F7A|200B84  |0E840B;
						BEQ CODE_0E9FA7                      ;0E9F7D|F028    |0E9FA7;
						JSR.W CODE_0E9F2F                    ;0E9F7F|202F9F  |0E9F2F;
						BCC CODE_0E9FA7                      ;0E9F82|9023    |0E9FA7;
						JMP.W CODE_0E9E0B                    ;0E9F84|4C0B9E  |0E9E0B;
	
	
			CODE_0E9F87:
						LDA.B #$00                           ;0E9F87|A900    |      ;
						STA.W r_entity_FacingLeft          ;0E9F89|8DA804  |0E04A8;
						LDA.B #$01                           ;0E9F8C|A901    |      ;
						STA.W r_entity_Xspd                ;0E9F8E|8DF204  |0E04F2;
						LDA.B #$00                           ;0E9F91|A900    |      ;
						STA.W r_entity_XsubSpd             ;0E9F93|8D0905  |0E0509;
						LDX.B #$00                           ;0E9F96|A200    |      ;
						LDA.B #$08                           ;0E9F98|A908    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9F9A|200B84  |0E840B;
						BEQ CODE_0E9FA7                      ;0E9F9D|F008    |0E9FA7;
						JSR.W CODE_0E9F2B                    ;0E9F9F|202B9F  |0E9F2B;
						BCC CODE_0E9FA7                      ;0E9FA2|9003    |0E9FA7;
						JMP.W CODE_0E9E1B                    ;0E9FA4|4C1B9E  |0E9E1B;
	
	
			CODE_0E9FA7:
						LDA.B r_Joy1Held_t                   ;0E9FA7|A528    |000028;
						AND.B #$08                           ;0E9FA9|2908    |      ;
						BEQ CODE_0E9FC1                      ;0E9FAB|F014    |0E9FC1;
						LDX.B #$F8                           ;0E9FAD|A2F8    |      ;
						LDA.B #$00                           ;0E9FAF|A900    |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9FB1|200B84  |0E840B;
						BEQ CODE_0E9FC1                      ;0E9FB4|F00B    |0E9FC1;
						LDX.B #$00                           ;0E9FB6|A200    |      ;
						TXA                                  ;0E9FB8|8A      |      ;
						JSR.W checkCollusion_CMP_01                   ;0E9FB9|200B84  |0E840B;
						BNE CODE_0E9FC1                      ;0E9FBC|D003    |0E9FC1;
						JMP.W CODE_0E9F0B                    ;0E9FBE|4C0B9F  |0E9F0B;
	
	
			CODE_0E9FC1:
						LDA.W r_entity_Xspd                  ;0E9FC1|ADF204  |0004F2;
						BPL CODE_0E9FE3                      ;0E9FC4|101D    |0E9FE3;
						LDX.B #$0C                           ;0E9FC6|A20C    |      ;
						LDA.B #$F8                           ;0E9FC8|A9F8    |      ;
						                               ;0E9FCA|        |      ;
						JSR.W playerCollusionCheck              ;0E9FCB|        |0FFCDD;
						BNE CODE_0E9FFE                      ;0E9FCD|D02F    |0E9FFE;
						LDX.B #$00                           ;0E9FCF|A200    |      ;
						LDA.B #$F8                           ;0E9FD1|A9F8    |      ;
						                               ;0E9FD3|        |      ;
						JSR.W playerCollusionCheck              ;0E9FD4|        |0FFCDD;
						BNE CODE_0E9FFE                      ;0E9FD6|D026    |0E9FFE;
						LDX.B #$F4                           ;0E9FD8|A2F4    |      ;
						LDA.B #$F8                           ;0E9FDA|A9F8    |      ;
						                               ;0E9FDC|        |      ;
						JSR.W playerCollusionCheck              ;0E9FDD|        |0FFCDD;
						BEQ CODE_0EA006                      ;0E9FDF|F025    |0EA006;
						BNE CODE_0E9FFE                      ;0E9FE1|D01B    |0E9FFE;
	
			CODE_0E9FE3:
						LDX.B #$0C                           ;0E9FE3|A20C    |      ;
						LDA.B #$08                           ;0E9FE5|A908    |      ;
						                               ;0E9FE7|        |      ;
						JSR.W playerCollusionCheck              ;0E9FE8|        |0FFCDD;
						BNE CODE_0E9FFE                      ;0E9FEA|D012    |0E9FFE;
						LDX.B #$00                           ;0E9FEC|A200    |      ;
						LDA.B #$08                           ;0E9FEE|A908    |      ;
						                               ;0E9FF0|        |      ;
						JSR.W playerCollusionCheck              ;0E9FF1|        |0FFCDD;
						BNE CODE_0E9FFE                      ;0E9FF3|D009    |0E9FFE;
						LDX.B #$F4                           ;0E9FF5|A2F4    |      ;
						LDA.B #$08                           ;0E9FF7|A908    |      ;
						                               ;0E9FF9|        |      ;
						JSR.W playerCollusionCheck              ;0E9FFA|        |0FFCDD;
						BEQ CODE_0EA006                      ;0E9FFC|F008    |0EA006;
	
			CODE_0E9FFE:
						LDA.B #$00                           ;0E9FFE|A900    |      ;
						STA.W r_entity_Xspd                ;0EA000|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EA003|8D0905  |0E0509;
	
			CODE_0EA006:
						LDA.W r_entity_YPos                ;0EA006|AD1C04  |0E041C;
						STA.B $06                            ;0EA009|8506    |000006;
						JSR.W CODE_0EA0D1                    ;0EA00B|20D1A0  |0EA0D1;
						LDA.W r_entity_AI_IDX          ;0EA00E|ADC105  |0E05C1;
						BEQ CODE_0EA06A                      ;0EA011|F057    |0EA06A;
						LDX.B #$0C                           ;0EA013|A20C    |      ;
						LDA.B #$FB                           ;0EA015|A9FB    |      ;
						                               ;0EA017|        |      ;
						JSR.W playerCollusionCheck              ;0EA018|        |0FFCDD;
						BNE CODE_0EA03E                      ;0EA01A|D022    |0EA03E;
						LDX.B #$0C                           ;0EA01C|A20C    |      ;
						LDA.B #$05                           ;0EA01E|A905    |      ;
						                               ;0EA020|        |      ;
						JSR.W playerCollusionCheck              ;0EA021|        |0FFCDD;
						BNE CODE_0EA03E                      ;0EA023|D019    |0EA03E;
						LDA.B r_conveyaerRoomEffect          ;0EA025|A58B    |00008B;
						CMP.B #$01                           ;0EA027|C901    |      ;
						BEQ CODE_0EA036                      ;0EA029|F00B    |0EA036;
						CMP.B #$05                           ;0EA02B|C905    |      ;
						BEQ CODE_0EA082                      ;0EA02D|F053    |0EA082;
						CMP.B #$06                           ;0EA02F|C906    |      ;
						BEQ CODE_0EA082                      ;0EA031|F04F    |0EA082;
						JMP.W CODE_0EA064                    ;0EA033|4C64A0  |0EA064;
	
	
			CODE_0EA036:
						LDX.B r_ConveyorRelated              ;0EA036|A691    |000091;
						                               ;0EA038|        |      ;
						JSR.W CODE_0FFE9C                       ;0EA039|        |0FFE9C;
						JMP.W CODE_0EA05D                    ;0EA03B|4C5DA0  |0EA05D;
	
	
			CODE_0EA03E:
						LDA.W r_entity_extra               ;0EA03E|ADD805  |0E05D8;
						BNE CODE_0EA051                      ;0EA041|D00E    |0EA051;
						LDA.B #$0B                           ;0EA043|A90B    |      ;
						                               ;0EA045|        |      ;
						JSR.W lunchMusic                        ;0EA046|        |0FE25F;
						LDA.B #$0C                           ;0EA048|A90C    |      ;
						STA.B r_timerClunk_drop              ;0EA04A|85B9    |0000B9;
						LDA.B #$0E                           ;0EA04C|A90E    |      ;
						STA.W r_entity_spriteID            ;0EA04E|8D0004  |000400;
	
			CODE_0EA051:
						JSR.W CODE_0E8A02                    ;0EA051|20028A  |0E8A02;
						LDA.W r_entity_YPos                  ;0EA054|AD1C04  |00041C;
						CLC                                  ;0EA057|18      |      ;
						ADC.B #$04                           ;0EA058|6904    |      ;
						STA.W r_entity_YPos                ;0EA05A|8D1C04  |0E041C;
	
			CODE_0EA05D:
						LDA.B #$02                           ;0EA05D|A902    |      ;
						STA.W r_Player_StateDoubled        ;0EA05F|8D6505  |0E0565;
						BNE CODE_0EA067                      ;0EA062|D003    |0EA067;
	
			CODE_0EA064:
						JSR.W updateSpeed2Pos                ;0EA064|201287  |0E8712;
	
			CODE_0EA067:
						JMP.W playerKnockback_01             ;0EA067|4C3A87  |0E873A;
	
	
			CODE_0EA06A:
						LDX.B #$00                           ;0EA06A|A200    |      ;
						LDA.B #$05                           ;0EA06C|A905    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA06E|200B84  |0E840B;
						BNE CODE_0EA07C                      ;0EA071|D009    |0EA07C;
						LDX.B #$00                           ;0EA073|A200    |      ;
						LDA.B #$FB                           ;0EA075|A9FB    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA077|200B84  |0E840B;
						BEQ CODE_0EA064                      ;0EA07A|F0E8    |0EA064;
	
			CODE_0EA07C:
						JSR.W grantStartStopClimb            ;0EA07C|208DA0  |0EA08D;
						JMP.W CODE_0EA064                    ;0EA07F|4C64A0  |0EA064;
	
	
			CODE_0EA082:
						LDA.B $06                            ;0EA082|A506    |000006;
						CLC                                  ;0EA084|18      |      ;
						ADC.B r_ConveyorRelated              ;0EA085|6591    |000091;
						STA.W r_entity_YPos                ;0EA087|8D1C04  |0E041C;
						JMP.W CODE_0EA05D                    ;0EA08A|4C5DA0  |0EA05D;
	
	
		grantStartStopClimb:	
						
					if !jumpControllMovment == 1	
						lda.w r_entity_spriteID
						cmp #$16
						beq grantStartStopClimb_checkless	; diseable in jump frame to not get stuck 						
						
						lda.w r_Player_StateDoubled			; hold A to not fall 
						cmp #$30
						bcc grantStartStopClimb_checkless
						lda.b r_Joy1Held
						and #$80
						beq grantStartStopClimb_checkless
						rts								
					grantStartStopClimb_checkless:
					endif 
						
						
						LDA.B #$0C                           ;0EA08D|A90C    |      ;
						STA.W r_Player_StateDoubled        ;0EA08F|8D6505  |0E0565;
						LDA.B r_previousBackup88             ;0EA092|A5CF    |0000CF;
						CMP.B #$01                           ;0EA094|C901    |      ;
						BEQ CODE_0EA09C                      ;0EA096|F004    |0EA09C;
						CMP.B #$06                           ;0EA098|C906    |      ;
						BNE CODE_0EA0A0                      ;0EA09A|D004    |0EA0A0;
	
			CODE_0EA09C:
						LDA.B #$10                           ;0EA09C|A910    |      ;
						STA.B r_delayElevators               ;0EA09E|85AF    |0000AF;
	
			CODE_0EA0A0:
						LDA.B #$01                           ;0EA0A0|A901    |      ;
						STA.W r_entity_AI_IDX          ;0EA0A2|8DC105  |0E05C1;
						LDA.B #$38                           ;0EA0A5|A938    |      ;
						STA.W r_entity_extra               ;0EA0A7|8DD805  |0E05D8;
						LDA.B #$00                           ;0EA0AA|A900    |      ;
						STA.W r_entity_AI              ;0EA0AC|8DEF05  |0E05EF;
						STA.W r_entity_target          ;0EA0AF|8D0606  |0E0606;
						STA.B $9D                            ;0EA0B2|859D    |00009D;
						STA.B r_timerClunk_drop              ;0EA0B4|85B9    |0000B9;
						LDA.B #$01                           ;0EA0B6|A901    |      ;
						STA.W r_damagActionFlag         ;0EA0B8|8D1D06  |0E061D;
						LDA.W r_entity_FacingLeft          ;0EA0BB|ADA804  |0E04A8;
						BNE CODE_0EA0C6                      ;0EA0BE|D006    |0EA0C6;
						LDA.B #$00                           ;0EA0C0|A900    |      ;
						LDY.B #$20                           ;0EA0C2|A020    |      ;
						BNE CODE_0EA0CA                      ;0EA0C4|D004    |0EA0CA;
	
			CODE_0EA0C6:
						LDA.B #$FF                           ;0EA0C6|A9FF    |      ;
						LDY.B #$E0                           ;0EA0C8|A0E0    |      ;
	
			CODE_0EA0CA:
						STA.W r_entity_Xspd                ;0EA0CA|8DF204  |0E04F2;
						STY.W r_entity_XsubSpd             ;0EA0CD|8C0905  |0E0509;
						RTS                                  ;0EA0D0|60      |      ;
	
	
			CODE_0EA0D1:
						LDA.W r_Player_StateDoubled        ;0EA0D1|AD6505  |0E0565;
						CMP.B #$08                           ;0EA0D4|C908    |      ;
	
						BNE CODE_0EA0E5                      ;0EA0D6|D00D    |0EA0E5;
						LDA.B r_timerClunk_drop              ;0EA0D8|A5B9    |0000B9;
						BEQ CODE_0EA0E5                      ;0EA0DA|F009    |0EA0E5;
						DEC.B r_timerClunk_drop              ;0EA0DC|C6B9    |0000B9;
						BNE CODE_0EA0E5                      ;0EA0DE|D005    |0EA0E5;
				
						
						
						LDA.B #$16                           ;0EA0E0|A916    |      ;
						STA.W r_entity_spriteID          ;0EA0E2|8D0004  |0E0400;
	
			CODE_0EA0E5:
						LDA.W r_entity_AI_IDX          ;0EA0E5|ADC105  |0E05C1;
						BNE CODE_0EA0F6                      ;0EA0E8|D00C    |0EA0F6;
						LDA.B $9D                            ;0EA0EA|A59D    |00009D;
						BNE CODE_0EA100                      ;0EA0EC|D012    |0EA100;
						LDA.B r_Joy1Held_t                   ;0EA0EE|A528    |000028;
						AND.B #$80                           ;0EA0F0|2980    |      ;
						BNE CODE_0EA100                      ;0EA0F2|D00C    |0EA100;
						INC.B $9D                            ;0EA0F4|E69D    |00009D;
	
			CODE_0EA0F6:
						LDA.B #$02                           ;0EA0F6|A902    |      ;
						STA.W r_damagActionFlag         ;0EA0F8|8D1D06  |0E061D;
						LDA.B #$00                           ;0EA0FB|A900    |      ;
						STA.W r_entity_target          ;0EA0FD|8D0606  |0E0606;
	
			CODE_0EA100:
						LDA.W r_entity_YPos                ;0EA100|AD1C04  |0E041C;
						CMP.B #$08                           ;0EA103|C908    |      ;
						BCS CODE_0EA10F                      ;0EA105|B008    |0EA10F;
						LDA.W r_entity_AI_IDX          ;0EA107|ADC105  |0E05C1;
						BNE CODE_0EA10F                      ;0EA10A|D003    |0EA10F;
						JSR.W CODE_0EA0A0                    ;0EA10C|20A0A0  |0EA0A0;
	
			CODE_0EA10F:	
			CODE_0EA112:
						LDA.B #$00                           ;0EA112|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EA114|8D3705  |0E0537;
						STA.W r_entity_FractionalY         ;0EA117|8DDB04  |0E04DB;
						LDY.W r_entity_extra               ;0EA11A|ACD805  |0E05D8;
						LDA.W r_entity_AI_IDX          ;0EA11D|ADC105  |0E05C1;
						BNE CODE_0EA159                      ;0EA120|D037    |0EA159;
						LDA.W playerFallSpeedTable,Y         ;0EA122|B9589E  |0E9E58;
						CMP.B #$81                           ;0EA125|C981    |      ;
						BEQ CODE_0EA146                      ;0EA127|F01D    |0EA146;
						STA.W r_entity_Yspd                ;0EA129|8D2005  |0E0520;
						CLC                                  ;0EA12C|18      |      ;
						LDA.W r_entity_AI              ;0EA12D|ADEF05  |0E05EF;
						ADC.W r_entity_target          ;0EA130|6D0606  |0E0606;
						STA.W r_entity_AI              ;0EA133|8DEF05  |0E05EF;
						LDA.W r_entity_extra               ;0EA136|ADD805  |0E05D8;
						ADC.W r_damagActionFlag         ;0EA139|6D1D06  |0E061D;
						CMP.B #$39                           ;0EA13C|C939    |      ;
						BCC CODE_0EA142                      ;0EA13E|9002    |0EA142;
						LDA.B #$39                           ;0EA140|A939    |      ;
	
			CODE_0EA142:
						STA.W r_entity_extra               ;0EA142|8DD805  |0E05D8;
						RTS                                  ;0EA145|60      |      ;
	
	
			CODE_0EA146:
						LDA.B #$00                           ;0EA146|A900    |      ;
						STA.W r_entity_Yspd                ;0EA148|8D2005  |0E0520;
						LDY.B #$01                           ;0EA14B|A001    |      ;
						STY.W r_entity_AI_IDX          ;0EA14D|8CC105  |0E05C1;
						DEC.W r_entity_extra               ;0EA150|CED805  |0E05D8;
						LDA.B #$00                           ;0EA153|A900    |      ;
						STA.W r_entity_AI              ;0EA155|8DEF05  |0E05EF;
						RTS                                  ;0EA158|60      |      ;
	
	
			CODE_0EA159:
						LDA.W playerFallSpeedTable,Y         ;0EA159|B9589E  |0E9E58;
						CMP.B #$80                           ;0EA15C|C980    |      ;
						BEQ CODE_0EA183                      ;0EA15E|F023    |0EA183;
						SEC                                  ;0EA160|38      |      ;
						LDA.W r_entity_AI              ;0EA161|ADEF05  |0E05EF;
						SBC.W r_entity_target          ;0EA164|ED0606  |0E0606;
						STA.W r_entity_AI              ;0EA167|8DEF05  |0E05EF;
						LDA.W r_entity_extra               ;0EA16A|ADD805  |0E05D8;
						SBC.W r_damagActionFlag         ;0EA16D|ED1D06  |0E061D;
						BPL CODE_0EA174                      ;0EA170|1002    |0EA174;
						LDA.B #$00                           ;0EA172|A900    |      ;
	
			CODE_0EA174:
						STA.W r_entity_extra               ;0EA174|8DD805  |0E05D8;
						LDA.W playerFallSpeedTable,Y         ;0EA177|B9589E  |0E9E58;
	
			CODE_0EA17A:
						EOR.B #$FF                           ;0EA17A|49FF    |      ;
						CLC                                  ;0EA17C|18      |      ;
						ADC.B #$01                           ;0EA17D|6901    |      ;
						STA.W r_entity_Yspd                ;0EA17F|8D2005  |0E0520;
						RTS                                  ;0EA182|60      |      ;
	
	
			CODE_0EA183:
						LDA.W DATA8_0E9E59,Y                 ;0EA183|B9599E  |0E9E59;
						BNE CODE_0EA17A                      ;0EA186|D0F2    |0EA17A;
	
			grant_fastClimb_state44:
						DEC.W r_entity_extra               ;0EA188|CED805  |0E05D8;
						BEQ CODE_0EA1B5                      ;0EA18B|F028    |0EA1B5;
						LDX.B #$F8                           ;0EA18D|A2F8    |      ;
						LDA.B #$00                           ;0EA18F|A900    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA191|200B84  |0E840B;
						BNE CODE_0EA1B5                      ;0EA194|D01F    |0EA1B5;
						LDA.W r_entity_YPos                ;0EA196|AD1C04  |0E041C;
						CMP.B #$08                           ;0EA199|C908    |      ;
						BCC CODE_0EA1B0                      ;0EA19B|9013    |0EA1B0;
						LDA.B #$08                           ;0EA19D|A908    |      ;
						LDX.W r_entity_FacingLeft          ;0EA19F|AEA804  |0E04A8;
						BEQ CODE_0EA1A6                      ;0EA1A2|F002    |0EA1A6;
						LDA.B #$F7                           ;0EA1A4|A9F7    |      ;
	
			CODE_0EA1A6:
						LDX.B #$00                           ;0EA1A6|A200    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA1A8|200B84  |0E840B;
						BEQ CODE_0EA1C5                      ;0EA1AB|F018    |0EA1C5;
						JMP.W updateSpeed2Pos                ;0EA1AD|4C1287  |0E8712;
	
	
			CODE_0EA1B0:
						LDA.B #$08                           ;0EA1B0|A908    |      ;
						STA.W r_entity_YPos                ;0EA1B2|8D1C04  |0E041C;
	
			CODE_0EA1B5:
						LDA.B #$00                           ;0EA1B5|A900    |      ;
						STA.W r_entity_extra               ;0EA1B7|8DD805  |0E05D8;
						LDA.B #$18                           ;0EA1BA|A918    |      ;
						STA.W r_entity_spriteID          ;0EA1BC|8D0004  |0E0400;
						LDA.B #$30                           ;0EA1BF|A930    |      ;
						STA.W r_Player_StateDoubled        ;0EA1C1|8D6505  |0E0565;
						RTS                                  ;0EA1C4|60      |      ;
	
	
			CODE_0EA1C5:
						LDA.B #$06                           ;0EA1C5|A906    |      ;
						STA.W r_Player_StateDoubled        ;0EA1C7|8D6505  |0E0565;
						RTS                                  ;0EA1CA|60      |      ;
	
	
			CODE_0EA1CB:
						LDA.B #$00                           ;0EA1CB|A900    |      ;
						STA.W r_entity_AI_IDX          ;0EA1CD|8DC105  |0E05C1;
						LDA.W r_entity_XPos                ;0EA1D0|AD3804  |0E0438;
						CLC                                  ;0EA1D3|18      |      ;
						ADC.B #$08                           ;0EA1D4|6908    |      ;
						JMP.W CODE_0EA1E4                    ;0EA1D6|4CE4A1  |0EA1E4;
	
	
			CODE_0EA1D9:
						LDA.B #$01                           ;0EA1D9|A901    |      ;
						STA.W r_entity_AI_IDX          ;0EA1DB|8DC105  |0E05C1;
						LDA.W r_entity_XPos                ;0EA1DE|AD3804  |0E0438;
						SEC                                  ;0EA1E1|38      |      ;
						SBC.B #$08                           ;0EA1E2|E908    |      ;
	
			CODE_0EA1E4:
						STA.W r_entity_extra               ;0EA1E4|8DD805  |0E05D8;
						JSR.W CODE_0EA53B                    ;0EA1E7|203BA5  |0EA53B;
						LDA.B #$3C                           ;0EA1EA|A93C    |      ;
	
			CODE_0EA1EC:
						STA.W r_Player_StateDoubled        ;0EA1EC|8D6505  |0E0565;
						LDY.B #$00                           ;0EA1EF|A000    |      ;
						STY.W r_entity_OamBaseOffset       ;0EA1F1|8C9305  |0E0593;
						INY                                  ;0EA1F4|C8      |      ;
						STY.W r_entity_AnimTimer           ;0EA1F5|8C7C05  |0E057C;
						RTS                                  ;0EA1F8|60      |      ;
	
	
			CODE_0EA1F9:
						LDA.B #$00                           ;0EA1F9|A900    |      ;
						STA.W r_entity_AI_IDX          ;0EA1FB|8DC105  |0E05C1;
						LDA.W r_entity_XPos                ;0EA1FE|AD3804  |0E0438;
						CLC                                  ;0EA201|18      |      ;
						ADC.B #$08                           ;0EA202|6908    |      ;
						JMP.W CODE_0EA212                    ;0EA204|4C12A2  |0EA212;
	
	
			CODE_0EA207:
						LDA.B #$01                           ;0EA207|A901    |      ;
						STA.W r_entity_AI_IDX          ;0EA209|8DC105  |0E05C1;
						LDA.W r_entity_XPos                ;0EA20C|AD3804  |0E0438;
						SEC                                  ;0EA20F|38      |      ;
						SBC.B #$08                           ;0EA210|E908    |      ;
	
			CODE_0EA212:
						STA.W r_entity_extra               ;0EA212|8DD805  |0E05D8;
						CLC                                  ;0EA215|18      |      ;
						LDA.B #$01                           ;0EA216|A901    |      ;
						ADC.W r_entity_YPos                ;0EA218|6D1C04  |0E041C;
						STA.W r_entity_YPos                ;0EA21B|8D1C04  |0E041C;
						JSR.W CODE_0EA535                    ;0EA21E|2035A5  |0EA535;
						LDA.B #$38                           ;0EA221|A938    |      ;
						JMP.W CODE_0EA1EC                    ;0EA223|4CECA1  |0EA1EC;
	
	
	grant_subW_wallThrow_state46:
						JSR.W player_animCountDown           ;0EA226|20F2BA  |0EBAF2;
						BCS CODE_0EA22C                      ;0EA229|B001    |0EA22C;
						RTS                                  ;0EA22B|60      |      ;
	
	
			CODE_0EA22C:
						LDY.B #$00                           ;0EA22C|A000    |      ;
						STY.W r_entity_OamBaseOffset       ;0EA22E|8C9305  |0E0593;
						INY                                  ;0EA231|C8      |      ;
						STY.W r_entity_AnimTimer           ;0EA232|8C7C05  |0E057C;
						LDA.B #$30                           ;0EA235|A930    |      ;
						STA.W r_Player_StateDoubled        ;0EA237|8D6505  |0E0565;
						RTS                                  ;0EA23A|60      |      ;
	
	
	grant_climbWall_state30:
						LDA.B r_Joy1_t                       ;0EA23B|A526    |000026;
						AND.B #$40                           ;0EA23D|2940    |      ;
						BEQ CODE_0EA24B                      ;0EA23F|F00A    |0EA24B;
						JSR.W initSubwAttack_CC                 ;0EA241|20F5B9  |0EB9F5;
						BCC CODE_0EA24B                      ;0EA244|9005    |0EA24B;
						LDA.B #$46                           ;0EA246|A946    |      ;
						JMP.W initPlayerState_A               ;0EA248|4CAA94  |0E94AA;
	
	
			CODE_0EA24B:						
						LDA.B r_Joy1_t                       ;0EA24B|A526    |000026;
						AND.B #$80                           ;0EA24D|2980    |      ;
						BEQ CODE_0EA26B                      ;0EA24F|F01A    |0EA26B;
						LDA.B #$44                           ;0EA251|A944    |      ;
						STA.W r_Player_StateDoubled        ;0EA253|8D6505  |0E0565;
						LDA.B #$08                           ;0EA256|A908    |      ;
						STA.W r_entity_extra               ;0EA258|8DD805  |0E05D8;
						LDA.B #$1A                           ;0EA25B|A91A    |      ;
						STA.W r_entity_spriteID          ;0EA25D|8D0004  |0E0400;
						LDA.B #$FE                           ;0EA260|A9FE    |      ;
						STA.W r_entity_Yspd                ;0EA262|8D2005  |0E0520;
						LDA.B #$00                           ;0EA265|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EA267|8D3705  |0E0537;
						RTS                                  ;0EA26A|60      |      ;
	
			CODE_0EA26B:
						LDA.W r_entity_extra               ;0EA26B|ADD805  |0E05D8;
						BEQ CODE_0EA274                      ;0EA26E|F004    |0EA274;
						DEC.W r_entity_extra               ;0EA270|CED805  |0E05D8;
						RTS                                  ;0EA273|60      |      ;
	
	
			CODE_0EA274:
						LDA.W r_entity_AI_IDX          ;0EA274|ADC105  |0E05C1;
						BEQ CODE_0EA2BD                      ;0EA277|F044    |0EA2BD;
						
						
				if !jumpControllMovment == 1					
					; 	grant is on the right side of wall 
					
						LDA.B r_Joy1Held_t                   ;0EA279|A528    |000028;
						AND.B #$01                           ;0EA27B|2902    |      ;
						bne grantLetGoOfWall             
						
						LDX.B #$00                           ;0EA27F|A200    |      ;
						LDA.B #$F7                           ;0EA281|A9F7    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA283|200B84  |0E840B;
						BEQ CODE_0EA2BA                      ;0EA286|F032    |0EA2BA;
						LDX.B #$01                           ;0EA288|A201    |      ;
						LDA.B #$F7                           ;0EA28A|A9F7    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA28C|200B84  |0E840B;
						BNE CODE_0EA294                      ;0EA28F|D003    |0EA294;
						JMP.W CODE_0EA207                    ;0EA291|4C07A2  |0EA207;					
;					+ 	JMP.W grantStartStopClimb_checkless				;	grantLetGoOfWall
				else 
				
						LDA.B r_Joy1Held_t                   ;0EA279|A528    |000028;
						AND.B #$02                           ;0EA27B|2902    |      ;
						BEQ grantLetGoOfWall                      ;0EA27D|F021    |0EA2A0;
						LDX.B #$00                           ;0EA27F|A200    |      ;
						LDA.B #$F7                           ;0EA281|A9F7    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA283|200B84  |0E840B;
						BEQ CODE_0EA2BA                      ;0EA286|F032    |0EA2BA;
						LDX.B #$01                           ;0EA288|A201    |      ;
						LDA.B #$F7                           ;0EA28A|A9F7    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA28C|200B84  |0E840B;
						BNE CODE_0EA294                      ;0EA28F|D003    |0EA294;
						JMP.W CODE_0EA207                    ;0EA291|4C07A2  |0EA207;
				endif 
	
			CODE_0EA294:
						LDX.B #$FF                           ;0EA294|A2FF    |      ;
						LDA.B #$F7                           ;0EA296|A9F7    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA298|200B84  |0E840B;
						BNE CODE_0EA2E4                      ;0EA29B|D047    |0EA2E4;
						JMP.W CODE_0EA1D9                    ;0EA29D|4CD9A1  |0EA1D9;
	
	
			grantLetGoOfWall:

				if !jumpControllMovment == 1						
						lda #$16 				; make it a jumpFrame 
						sta.w r_entity_spriteID						
				endif 		
						
						
						LDA.B r_Joy1Held_t                   ;0EA2A0|A528    |000028;
						AND.B #$08                           ;0EA2A2|2908    |      ;
						BEQ CODE_0EA2BA                      ;0EA2A4|F014    |0EA2BA;
						LDX.B #$F8                           ;0EA2A6|A2F8    |      ;
						LDA.B #$00                           ;0EA2A8|A900    |      ;
						                               ;0EA2AA|        |      ;
						JSR.W playerCollusionCheck              ;0EA2AB|        |0FFCDD;
						BEQ CODE_0EA2BA                      ;0EA2AD|F00B    |0EA2BA;
						LDA.W r_entity_FacingLeft          ;0EA2AF|ADA804  |0E04A8;
						EOR.B #$01                           ;0EA2B2|4901    |      ;
						STA.W r_entity_FacingLeft          ;0EA2B4|8DA804  |0E04A8;
						JMP.W CODE_0E9F0B                    ;0EA2B7|4C0B9F  |0E9F0B;
	
	
			CODE_0EA2BA:
						JMP.W grantStartStopClimb            ;0EA2BA|4C8DA0  |0EA08D;
	
	
			CODE_0EA2BD:
				
				if !jumpControllMovment == 1							
					; 	grant is on the left side of wall 						
						
						LDA.B r_Joy1Held_t                   ;0EA2BD|A528    |000028;
						AND.B #$02                           ;0EA2BF|2901    |      ;
						bne grantLetGoOfWall                      ;0EA2C1|F0DD    |0EA2A0;
						
						LDX.B #$00                           ;0EA2C3|A200    |      ;
						LDA.B #$08                           ;0EA2C5|A908    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA2C7|200B84  |0E840B;
						BEQ CODE_0EA2BA                      ;0EA2CA|F0EE    |0EA2BA;
						LDX.B #$01                           ;0EA2CC|A201    |      ;
						LDA.B #$08                           ;0EA2CE|A908    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA2D0|200B84  |0E840B;
						BNE CODE_0EA2D8                      ;0EA2D3|D003    |0EA2D8;
						JMP.W CODE_0EA1F9                    ;0EA2D5|4CF9A1  |0EA1F9;

				else 		
						LDA.B r_Joy1Held_t                   ;0EA2BD|A528    |000028;
						AND.B #$01                           ;0EA2BF|2901    |      ;
						BEQ grantLetGoOfWall                      ;0EA2C1|F0DD    |0EA2A0;
						LDX.B #$00                           ;0EA2C3|A200    |      ;
						LDA.B #$08                           ;0EA2C5|A908    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA2C7|200B84  |0E840B;
						BEQ CODE_0EA2BA                      ;0EA2CA|F0EE    |0EA2BA;
						LDX.B #$01                           ;0EA2CC|A201    |      ;
						LDA.B #$08                           ;0EA2CE|A908    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA2D0|200B84  |0E840B;
						BNE CODE_0EA2D8                      ;0EA2D3|D003    |0EA2D8;
						JMP.W CODE_0EA1F9                    ;0EA2D5|4CF9A1  |0EA1F9;
				
				endif 	
	
			CODE_0EA2D8:
						LDX.B #$FF                           ;0EA2D8|A2FF    |      ;
						LDA.B #$08                           ;0EA2DA|A908    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA2DC|200B84  |0E840B;
						BNE CODE_0EA2E4                      ;0EA2DF|D003    |0EA2E4;
						JMP.W CODE_0EA1CB                    ;0EA2E1|4CCBA1  |0EA1CB;
	
	
			CODE_0EA2E4:
						LDA.B r_Joy1Held_t                   ;0EA2E4|A528    |000028;
						AND.B #$04                           ;0EA2E6|2904    |      ;
						BNE CODE_0EA2F1                      ;0EA2E8|D007    |0EA2F1;
						LDA.B r_Joy1Held_t                   ;0EA2EA|A528    |000028;
						AND.B #$08                           ;0EA2EC|2908    |      ;
						BNE CODE_0EA30F                      ;0EA2EE|D01F    |0EA30F;
						RTS                                  ;0EA2F0|60      |      ;
	
	
			CODE_0EA2F1:
						LDA.B #$0D                           ;0EA2F1|A90D    |      ;
						STA.W r_entity_AnimGroup           ;0EA2F3|8DAA05  |0E05AA;
						LDX.B #$0C                           ;0EA2F6|A20C    |      ;
						LDA.B #$00                           ;0EA2F8|A900    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA2FA|200B84  |0E840B;
						BNE DATA8_0EA30C                     ;0EA2FD|D00D    |0EA30C;
						LDA.B #$01                           ;0EA2FF|A901    |      ;
						STA.W r_entity_Yspd                ;0EA301|8D2005  |0E0520;
	
			CODE_0EA304:
						LDA.B #$00                           ;0EA304|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EA306|8D3705  |0E0537;
						JSR.W updateSpeed2Pos                ;0EA309|201287  |0E8712;
	
			DATA8_0EA30C:
						db $4C                               ;0EA30C|        |      ;
	
						dw updateSpriteAnimFrame             ;0EA30D|        |0FEF73;
	
			CODE_0EA30F:
						LDA.B #$01                           ;0EA30F|A901    |      ;
						STA.W r_entity_AnimGroup           ;0EA311|8DAA05  |0E05AA;
						LDA.W r_entity_YPos                ;0EA314|AD1C04  |0E041C;
						CMP.B #$08                           ;0EA317|C908    |      ;
						BCS CODE_0EA322                      ;0EA319|B007    |0EA322;
						LDA.B #$08                           ;0EA31B|A908    |      ;
						STA.W r_entity_YPos                ;0EA31D|8D1C04  |0E041C;
						BNE DATA8_0EA30C                     ;0EA320|D0EA    |0EA30C;
	
			CODE_0EA322:
						LDX.B #$F8                           ;0EA322|A2F8    |      ;
						LDA.B #$00                           ;0EA324|A900    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA326|200B84  |0E840B;
						BNE DATA8_0EA30C                     ;0EA329|D0E1    |0EA30C;
						LDA.B #$FF                           ;0EA32B|A9FF    |      ;
						STA.W r_entity_Yspd                ;0EA32D|8D2005  |0E0520;
						JMP.W CODE_0EA304                    ;0EA330|4C04A3  |0EA304;
	
	
	grant_subW_cellingThrow_state48:
						JSR.W player_animCountDown           ;0EA333|20F2BA  |0EBAF2;
						BCS CODE_0EA339                      ;0EA336|B001    |0EA339;
						RTS                                  ;0EA338|60      |      ;
	
	
			CODE_0EA339:
						LDA.B #$02                           ;0EA339|A902    |      ;
						                               ;0EA33B|        |      ;
						JSR.W clearSpriteAndAnimGroup              ;0EA33C|        |0FEF57;
						LDA.B #$32                           ;0EA33E|A932    |      ;
						STA.W r_Player_StateDoubled        ;0EA340|8D6505  |0E0565;
						RTS                                  ;0EA343|60      |      ;
	
	
			CODE_0EA344:
						JSR.W grantStartStopClimb            ;0EA344|208DA0  |0EA08D;
						SEC                                  ;0EA347|38      |      ;
						RTS                                  ;0EA348|60      |      ;
	
	
			CODE_0EA349:
						LDX.B #$F8                           ;0EA349|A2F8    |      ;
						LDA.B #$00                           ;0EA34B|A900    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA34D|200B84  |0E840B;
						BEQ CODE_0EA344                      ;0EA350|F0F2    |0EA344;
						CMP.B #$05                           ;0EA352|C905    |      ;
						BEQ CODE_0EA35C                      ;0EA354|F006    |0EA35C;
						CMP.B #$07                           ;0EA356|C907    |      ;
						BEQ CODE_0EA35C                      ;0EA358|F002    |0EA35C;
	
			CODE_0EA35A:
						CLC                                  ;0EA35A|18      |      ;
						RTS                                  ;0EA35B|60      |      ;
	
	
			CODE_0EA35C:
						LDA.B r_invincableFrames             ;0EA35C|A580    |000080;
						BNE CODE_0EA35A                      ;0EA35E|D0FA    |0EA35A;
						JSR.W player_death_routine           ;0EA360|20F483  |0E83F4;
						SEC                                  ;0EA363|38      |      ;
						RTS                                  ;0EA364|60      |      ;
	
	
	grant_climbCelling_state32:
						LDA.B r_Joy1_t                       ;0EA365|A526    |000026;
						AND.B #$40                           ;0EA367|2940    |      ;
						BEQ CODE_0EA375                      ;0EA369|F00A    |0EA375;
						JSR.W initSubwAttack_CC                 ;0EA36B|20F5B9  |0EB9F5;
						BCC CODE_0EA375                      ;0EA36E|9005    |0EA375;
						LDA.B #$48                           ;0EA370|A948    |      ;
						JMP.W initPlayerState_A               ;0EA372|4CAA94  |0E94AA;
	
	
			CODE_0EA375:
						
		if !jumpControllMovment == 1				
						LDA.B r_Joy1Held_t                
						AND.B #$08                              
						LDA.B r_Joy1Held_t                
						LSR A                             
						BCS checkRightWall                   
						LSR A                             
						BCS checkLeftWall                   
						lda #$1e 				; make it a climb frame when not pressing directions 
						sta r_entity_spriteID
						JMP.W grantStartStopClimb         
		
					checkRightWall:				; check for wall ahead to initiate surface change 
							
							LDX.B #$FB          ; X = YposOffset
							LDA.B #$0C          ; A = XposOffset         
							JSR.W checkCollusion_CMP_01  	
							beq ++
							lda.w r_entity_XPos
							clc 
							adc #$04
							sta.w r_entity_XPos							
							jmp +
					
					checkLeftWall:	
							LDX.B #$FB                  
							LDA.B #$F4                    
							JSR.W checkCollusion_CMP_01  
							beq ++													
							lda.w r_entity_XPos
							sec 
							sbc #$04
							sta.w r_entity_XPos
						+	jmp grantStartStopClimb_checkless					 	
						++	jmp grantStick2_surface
		
		
		else 	
						LDA.B r_Joy1Held_t                   ;0EA375|A528    |000028;
						AND.B #$08                           ;0EA377|2908    |      ;
						BNE grantStick2_surface                      ;0EA379|D03B    |0EA3B6;
						LDA.B r_Joy1Held_t                   ;0EA37B|A528    |000028;
						LSR A                                ;0EA37D|4A      |      ;
						BCS CODE_0EA39E                      ;0EA37E|B01E    |0EA39E;
						LSR A                                ;0EA380|4A      |      ;
						BCS CODE_0EA386                      ;0EA381|B003    |0EA386;	
						JMP.W grantStartStopClimb            ;0EA383|4C8DA0  |0EA08D;
		endif 	
	
			CODE_0EA386:
						LDX.B #$00                           ;0EA386|A200    |      ;
						LDA.B #$F4                           ;0EA388|A9F4    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA38A|200B84  |0E840B;
						BNE CODE_0EA392                      ;0EA38D|D003    |0EA392;
						JMP.W grantStartStopClimb            ;0EA38F|4C8DA0  |0EA08D;
	
	
			CODE_0EA392:
						LDA.W r_entity_XPos                ;0EA392|AD3804  |0E0438;
						SEC                                  ;0EA395|38      |      ;
						SBC.B #$04                           ;0EA396|E904    |      ;
						STA.W r_entity_XPos                ;0EA398|8D3804  |0E0438;
						JMP.W CODE_0E9E0B                    ;0EA39B|4C0B9E  |0E9E0B;
	
	
			CODE_0EA39E:
						LDX.B #$00                           ;0EA39E|A200    |      ;
						LDA.B #$0C                           ;0EA3A0|A90C    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA3A2|200B84  |0E840B;
						BNE CODE_0EA3AA                      ;0EA3A5|D003    |0EA3AA;
						JMP.W grantStartStopClimb            ;0EA3A7|4C8DA0  |0EA08D;
	
	
			CODE_0EA3AA:
						LDA.W r_entity_XPos                ;0EA3AA|AD3804  |0E0438;
						CLC                                  ;0EA3AD|18      |      ;
						ADC.B #$04                           ;0EA3AE|6904    |      ;
						STA.W r_entity_XPos                ;0EA3B0|8D3804  |0E0438;
						JMP.W CODE_0E9E1B                    ;0EA3B3|4C1B9E  |0E9E1B;
	
	
			grantStick2_surface:
						JSR.W CODE_0EA349                    ;0EA3B6|2049A3  |0EA349;
						BCS CODE_0EA3F6                      ;0EA3B9|B03B    |0EA3F6;
						LDX.B #$F8                           ;0EA3BB|A2F8    |      ;
						LDA.B #$FF                           ;0EA3BD|A9FF    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA3BF|200B84  |0E840B;
						BEQ CODE_0EA3D0                      ;0EA3C2|F00C    |0EA3D0;
						LDX.B #$F8                           ;0EA3C4|A2F8    |      ;
						LDA.B #$01                           ;0EA3C6|A901    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA3C8|200B84  |0E840B;
						BEQ CODE_0EA3D4                      ;0EA3CB|F007    |0EA3D4;
						JMP.W CODE_0EA3E9                    ;0EA3CD|4CE9A3  |0EA3E9;
	
	
			CODE_0EA3D0:
						LDA.B #$01                           ;0EA3D0|A901    |      ;
						BNE CODE_0EA3D6                      ;0EA3D2|D002    |0EA3D6;
	
			CODE_0EA3D4:
						LDA.B #$00                           ;0EA3D4|A900    |      ;
	
			CODE_0EA3D6:
						STA.W r_entity_AI_IDX          ;0EA3D6|8DC105  |0E05C1;
						JSR.W CODE_0EA54A                    ;0EA3D9|204AA5  |0EA54A;
						LDA.W r_entity_YPos                ;0EA3DC|AD1C04  |0E041C;
						SEC                                  ;0EA3DF|38      |      ;
						SBC.B #$08                           ;0EA3E0|E908    |      ;
						STA.B r_GrantCurrentYpos             ;0EA3E2|85D3    |0000D3;
						LDA.B #$34                           ;0EA3E4|A934    |      ;
						JMP.W CODE_0EA1EC                    ;0EA3E6|4CECA1  |0EA1EC;
	
	
			CODE_0EA3E9:
						LDA.B r_Joy1Held_t                   ;0EA3E9|A528    |000028;
						LSR A                                ;0EA3EB|4A      |      ;
						BCS CODE_0EA3F7                      ;0EA3EC|B009    |0EA3F7;
						LSR A                                ;0EA3EE|4A      |      ;
						BCS CODE_0EA40B                      ;0EA3EF|B01A    |0EA40B;
						LDA.B #$1E                           ;0EA3F1|A91E    |      ;
						STA.W r_entity_spriteID          ;0EA3F3|8D0004  |0E0400;
	
			CODE_0EA3F6:
						RTS                                  ;0EA3F6|60      |      ;
	
	
			CODE_0EA3F7:
						LDA.B #$00                           ;0EA3F7|A900    |      ;
						STA.W r_entity_FacingLeft          ;0EA3F9|8DA804  |0E04A8;
						LDX.B #$00                           ;0EA3FC|A200    |      ;
						LDA.B #$0C                           ;0EA3FE|A90C    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA400|200B84  |0E840B;
						BNE CODE_0EA419                      ;0EA403|D014    |0EA419;

						lda.b #grant_climb_X_r_spd	
						ldy.b #grant_climb_X_r_subSpd 
 
						jmp CODE_0EA422                      ;0EA409|D017    |0EA422;
	
			CODE_0EA40B:
						LDA.B #$01                           ;0EA40B|A901    |      ;
						STA.W r_entity_FacingLeft          ;0EA40D|8DA804  |0E04A8;
						LDX.B #$00                           ;0EA410|A200    |      ;
						LDA.B #$F4                           ;0EA412|A9F4    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA414|200B84  |0E840B;
						BEQ CODE_0EA41E                      ;0EA417|F005    |0EA41E;
	
			CODE_0EA419:
						LDA.B #$00                           ;0EA419|A900    |      ;
						TAY                                  ;0EA41B|A8      |      ;
						BEQ CODE_0EA422                      ;0EA41C|F004    |0EA422;
	
			CODE_0EA41E:
						lda.b #grant_climb_X_l_spd	
						ldy.b #grant_climb_X_l_subSpd
	
			CODE_0EA422:
						STA.W r_entity_Xspd                ;0EA422|8DF204  |0E04F2;
						STY.W r_entity_XsubSpd             ;0EA425|8C0905  |0E0509;
						                               ;0EA428|        |      ;
						JSR.W updateSpriteAnimFrame             ;0EA429|        |0FEF73;
						JMP.W playerKnockback_01             ;0EA42B|4C3A87  |0E873A;
	
	
	grant_climbBot_findCorner_state34:
						LDY.B #$00                           ;0EA42E|A000    |      ;
						JSR.W grantCornerClimbRoutine        ;0EA430|20CCA4  |0EA4CC;
						BCS CODE_0EA436                      ;0EA433|B001    |0EA436;
						RTS                                  ;0EA435|60      |      ;
	
	
			CODE_0EA436:
						LDA.B #$36                           ;0EA436|A936    |      ;
						STA.W r_Player_StateDoubled        ;0EA438|8D6505  |0E0565;
						LDA.B #$08                           ;0EA43B|A908    |      ;
						STA.W r_entity_AnimTimer           ;0EA43D|8D7C05  |0E057C;
						RTS                                  ;0EA440|60      |      ;
	
	
	grant_climbBottmUp_state36:
						DEC.W r_entity_AnimTimer           ;0EA441|CE7C05  |0E057C;
						BEQ CODE_0EA447                      ;0EA444|F001    |0EA447;
						RTS                                  ;0EA446|60      |      ;
	
	
			CODE_0EA447:
						LDA.W r_entity_AI_IDX          ;0EA447|ADC105  |0E05C1;
						BEQ CODE_0EA452                      ;0EA44A|F006    |0EA452;
						JSR.W CODE_0E9E1B                    ;0EA44C|201B9E  |0E9E1B;
						JMP.W CODE_0EA455                    ;0EA44F|4C55A4  |0EA455;
	
	
			CODE_0EA452:
						JSR.W CODE_0E9E0B                    ;0EA452|200B9E  |0E9E0B;
	
			CODE_0EA455:
						LDY.B #$00                           ;0EA455|A000    |      ;
						STY.W r_entity_OamBaseOffset       ;0EA457|8C9305  |0E0593;
						INY                                  ;0EA45A|C8      |      ;
						STY.W r_entity_AnimTimer           ;0EA45B|8C7C05  |0E057C;
						LDA.B #$00                           ;0EA45E|A900    |      ;
						STA.W r_entity_extra               ;0EA460|8DD805  |0E05D8;
						RTS                                  ;0EA463|60      |      ;
	
	
	grant_climbWallLeft_cornerBottom_state38:
						LDY.B #$02                           ;0EA464|A002    |      ;
						JSR.W grantCornerClimbRoutine        ;0EA466|20CCA4  |0EA4CC;
						BCS CODE_0EA46C                      ;0EA469|B001    |0EA46C;
						RTS                                  ;0EA46B|60      |      ;
	
	
			CODE_0EA46C:
						LDA.B #$3A                           ;0EA46C|A93A    |      ;
						STA.W r_Player_StateDoubled        ;0EA46E|8D6505  |0E0565;
						LDA.B #$10                           ;0EA471|A910    |      ;
						STA.W r_entity_AnimTimer           ;0EA473|8D7C05  |0E057C;
						RTS                                  ;0EA476|60      |      ;
	
	
	grant_climbWall2Bottom_state3a:
						DEC.W r_entity_AnimTimer           ;0EA477|CE7C05  |0E057C;
						BEQ CODE_0EA47D                      ;0EA47A|F001    |0EA47D;
						RTS                                  ;0EA47C|60      |      ;
	
	
			CODE_0EA47D:
						JMP.W CODE_0E9F0B                    ;0EA47D|4C0B9F  |0E9F0B;
	
	
	grant_climbWallRight_cornerBottom_state3c:
						LDY.B #$04                           ;0EA480|A004    |      ;
						JSR.W grantCornerClimbRoutine        ;0EA482|20CCA4  |0EA4CC;
						BCS CODE_0EA488                      ;0EA485|B001    |0EA488;
						RTS                                  ;0EA487|60      |      ;
	
	
			CODE_0EA488:
						LDA.B #$3E                           ;0EA488|A93E    |      ;
						STA.W r_Player_StateDoubled        ;0EA48A|8D6505  |0E0565;
						LDA.B #$08                           ;0EA48D|A908    |      ;
						STA.W r_entity_AnimTimer           ;0EA48F|8D7C05  |0E057C;
						RTS                                  ;0EA492|60      |      ;
	
	
	grant_climbCorner2Top_state3e:
						DEC.W r_entity_AnimTimer           ;0EA493|CE7C05  |0E057C;
						BEQ CODE_0EA499                      ;0EA496|F001    |0EA499;
						RTS                                  ;0EA498|60      |      ;
	
	
			CODE_0EA499:
						LDA.B #$02                           ;0EA499|A902    |      ;
						STA.W r_Player_StateDoubled        ;0EA49B|8D6505  |0E0565;
						RTS                                  ;0EA49E|60      |      ;
	
	
	grant_climbTop_state40:
						LDY.B #$06                           ;0EA49F|A006    |      ; press down near corner
						JSR.W grantCornerClimbRoutine        ;0EA4A1|20CCA4  |0EA4CC;
						BCS CODE_0EA4A7                      ;0EA4A4|B001    |0EA4A7;
						RTS                                  ;0EA4A6|60      |      ;
	
	
			CODE_0EA4A7:
						LDA.B #$42                           ;0EA4A7|A942    |      ;
						STA.W r_Player_StateDoubled        ;0EA4A9|8D6505  |0E0565;
						LDA.B #$08                           ;0EA4AC|A908    |      ;
						STA.W r_entity_AnimTimer           ;0EA4AE|8D7C05  |0E057C;
						RTS                                  ;0EA4B1|60      |      ;
	
	
	grant_climbTop2Wall_state42:
						DEC.W r_entity_AnimTimer           ;0EA4B2|CE7C05  |0E057C;
						BEQ CODE_0EA4B8                      ;0EA4B5|F001    |0EA4B8;
						RTS                                  ;0EA4B7|60      |      ;
	
	
			CODE_0EA4B8:
						LDA.W r_entity_AI_IDX          ;0EA4B8|ADC105  |0E05C1;
						BEQ CODE_0EA4C3                      ;0EA4BB|F006    |0EA4C3;
						JSR.W CODE_0E9E17                    ;0EA4BD|20179E  |0E9E17;
						JMP.W CODE_0EA4C6                    ;0EA4C0|4CC6A4  |0EA4C6;
	
	
			CODE_0EA4C3:
						JSR.W CODE_0E9E07                    ;0EA4C3|20079E  |0E9E07;
	
			CODE_0EA4C6:
						LDA.B #$00                           ;0EA4C6|A900    |      ;
						STA.W r_entity_extra               ;0EA4C8|8DD805  |0E05D8;
						RTS                                  ;0EA4CB|60      |      ;
	
	
	grantCornerClimbRoutine:
						DEC.W r_entity_AnimTimer           ;0EA4CC|CE7C05  |0E057C;
						BEQ CODE_0EA4D5                      ;0EA4CF|F004    |0EA4D5;
						CLC                                  ;0EA4D1|18      |      ;
						RTS                                  ;0EA4D2|60      |      ;
	
	
			CODE_0EA4D3:
						SEC                                  ;0EA4D3|38      |      ;
						RTS                                  ;0EA4D4|60      |      ;
	
	
			CODE_0EA4D5:
						LDA.W grantCimbAroundCorner,Y        ;0EA4D5|B974A5  |0EA574;
						STA.B r_pointerQueue                 ;0EA4D8|8508    |000008;
						LDA.W grantCimbAroundCorner+1,Y                 ;0EA4DA|B975A5  |0EA575;
						STA.B $09                            ;0EA4DD|8509    |000009;
						LDA.W r_entity_OamBaseOffset       ;0EA4DF|AD9305  |0E0593;
						ASL A                                ;0EA4E2|0A      |      ;
						ASL A                                ;0EA4E3|0A      |      ;
						CLC                                  ;0EA4E4|18      |      ;
						ADC.W r_entity_OamBaseOffset       ;0EA4E5|6D9305  |0E0593;
						TAY                                  ;0EA4E8|A8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EA4E9|B108    |000008;
						CMP.B #$FF                           ;0EA4EB|C9FF    |      ;
						BEQ CODE_0EA4D3                      ;0EA4ED|F0E4    |0EA4D3;
						STA.W r_entity_spriteID          ;0EA4EF|8D0004  |0E0400;
						INY                                  ;0EA4F2|C8      |      ;
						LDA.W r_entity_AI_IDX          ;0EA4F3|ADC105  |0E05C1;
						BEQ CODE_0EA501                      ;0EA4F6|F009    |0EA501;
						LDA.W r_entity_extra               ;0EA4F8|ADD805  |0E05D8;
						SEC                                  ;0EA4FB|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0EA4FC|F108    |000008;
						JMP.W CODE_0EA507                    ;0EA4FE|4C07A5  |0EA507;
	
	
			CODE_0EA501:
						LDA.W r_entity_extra               ;0EA501|ADD805  |0E05D8;
						CLC                                  ;0EA504|18      |      ;
						ADC.B (r_pointerQueue),Y             ;0EA505|7108    |000008;
	
			CODE_0EA507:
						STA.W r_entity_XPos                ;0EA507|8D3804  |0E0438;
						INY                                  ;0EA50A|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EA50B|B108    |000008;
						CLC                                  ;0EA50D|18      |      ;
						ADC.B r_GrantCurrentYpos             ;0EA50E|65D3    |0000D3;
						STA.W r_entity_YPos                ;0EA510|8D1C04  |0E041C;
						INY                                  ;0EA513|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EA514|B108    |000008;
						STA.W r_entity_AnimTimer           ;0EA516|8D7C05  |0E057C;
						INY                                  ;0EA519|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EA51A|B108    |000008;
						EOR.W r_entity_AI_IDX          ;0EA51C|4DC105  |0E05C1;
						STA.W r_entity_FacingLeft          ;0EA51F|8DA804  |0E04A8;
						INC.W r_entity_OamBaseOffset       ;0EA522|EE9305  |0E0593;
						CLC                                  ;0EA525|18      |      ;
						RTS                                  ;0EA526|60      |      ;
	
	
			CODE_0EA527:
						LDA.W r_entity_AI_IDX          ;0EA527|ADC105  |0E05C1;
						BEQ CODE_0EA558                      ;0EA52A|F02C    |0EA558;
						LDA.B #$07                           ;0EA52C|A907    |      ;
						CLC                                  ;0EA52E|18      |      ;
						ADC.W r_entity_XPos                ;0EA52F|6D3804  |0E0438;
						JMP.W CODE_0EA55E                    ;0EA532|4C5EA5  |0EA55E;
	
	
			CODE_0EA535:
						JSR.W CODE_0E8A02                    ;0EA535|20028A  |0E8A02;
						STA.B r_GrantCurrentYpos             ;0EA538|85D3    |0000D3;
						RTS                                  ;0EA53A|60      |      ;
	
	
			CODE_0EA53B:
						LDA.W r_entity_YPos                ;0EA53B|AD1C04  |0E041C;
						CLC                                  ;0EA53E|18      |      ;
						ADC.B #$01                           ;0EA53F|6901    |      ;
						STA.W r_entity_YPos                ;0EA541|8D1C04  |0E041C;
						JSR.W CODE_0E8A02                    ;0EA544|20028A  |0E8A02;
						STA.B r_GrantCurrentYpos             ;0EA547|85D3    |0000D3;
						RTS                                  ;0EA549|60      |      ;
	
	
			CODE_0EA54A:
						LDA.W r_entity_AI_IDX          ;0EA54A|ADC105  |0E05C1;
						BEQ CODE_0EA558                      ;0EA54D|F009    |0EA558;
						LDA.B #$02                           ;0EA54F|A902    |      ;
						CLC                                  ;0EA551|18      |      ;
						ADC.W r_entity_XPos                ;0EA552|6D3804  |0E0438;
						JMP.W CODE_0EA55E                    ;0EA555|4C5EA5  |0EA55E;
	
	
			CODE_0EA558:
						CLC                                  ;0EA558|18      |      ;
						LDA.B #$01                           ;0EA559|A901    |      ;
						ADC.W r_entity_XPos                ;0EA55B|6D3804  |0E0438;
	
			CODE_0EA55E:
						LDY.B r_roomOrientation              ;0EA55E|A468    |000068;
						BMI CODE_0EA56E                      ;0EA560|300C    |0EA56E;
						CLC                                  ;0EA562|18      |      ;
						ADC.B r_sceneScrollOffsetLo          ;0EA563|6556    |000056;
						AND.B #$F8                           ;0EA565|29F8    |      ;
						SEC                                  ;0EA567|38      |      ;
						SBC.B r_sceneScrollOffsetLo          ;0EA568|E556    |000056;
						STA.W r_entity_extra               ;0EA56A|8DD805  |0E05D8;
						RTS                                  ;0EA56D|60      |      ;
	
	
			CODE_0EA56E:
						AND.B #$F8                           ;0EA56E|29F8    |      ;
						STA.W r_entity_extra               ;0EA570|8DD805  |0E05D8;
						RTS                                  ;0EA573|60      |      ;
	
	
	grantCimbAroundCorner:
						dw DATA8_0EA57C                      ;0EA574|        |0EA57C;
	
						dw DATA8_0EA587                      ;0EA576|        |0EA587;
						dw DATA8_0EA592                      ;0EA578|        |0EA592;
						dw DATA8_0EA59D                      ;0EA57A|        |0EA59D;
	
			DATA8_0EA57C:
						db $3C,$00,$00,$08,$00,$18,$08,$F8   ;0EA57C|        |      ;
						db $01,$01,$FF                       ;0EA584|        |      ;
	
			DATA8_0EA587:
						db $42,$00,$00,$08,$00,$1E,$08,$04   ;0EA587|        |      ;
						db $01,$00,$FF                       ;0EA58F|        |      ;
	
			DATA8_0EA592:
						db $40,$00,$00,$08,$00,$0E,$00,$F4   ;0EA592|        |      ;
	
						db $01,$00,$FF                       ;0EA59A|        |      ;
	
			DATA8_0EA59D:
						db $3E,$00,$00,$08,$00,$36,$08,$08   ;0EA59D|        |      ;
						db $01,$01,$FF                       ;0EA5A5|        |      ;
	
	
		alucard_state1c:
						JSR.W playerCollusion                ;0EA5F9|202184  |0E8421;
						BCS CODE_0EA601                      ;0EA5FC|B003    |0EA601;
						JMP.W playerFallingJuming               ;0EA5FE|4C3A97  |0E973A;
	
	
			CODE_0EA601:
						JSR.W playerConveyaerCheck           ;0EA601|208E91  |0E918E;
						JSR.W checkPlayerHoldDown            ;0EA604|203699  |0E9936;
						LDA.W r_Player_StateDoubled        ;0EA607|AD6505  |0E0565;
						CMP.B #$02                           ;0EA60A|C902    |      ;
						BNE CODE_0EA616                      ;0EA60C|D008    |0EA616;
						LDA.B #$20                           ;0EA60E|A920    |      ;
						STA.W r_Player_StateDoubled        ;0EA610|8D6505  |0E0565;
						JMP.W player_subWe_state20           ;0EA613|4CB894  |0E94B8;
	
	
			CODE_0EA616:
						JSR.W player_animCountDown           ;0EA616|20F2BA  |0EBAF2;
						BCS CODE_0EA61C                      ;0EA619|B001    |0EA61C;
						RTS                                  ;0EA61B|60      |      ;
	
	
			CODE_0EA61C:
						LDA.B #$0A                           ;0EA61C|A90A    |      ;
						STA.W r_Player_StateDoubled        ;0EA61E|8D6505  |0E0565;
						LDA.B #$0E                           ;0EA621|A90E    |      ;
						STA.W r_entity_spriteID          ;0EA623|8D0004  |0E0400;
						RTS                                  ;0EA626|60      |      ;
	
	
			CODE_0EA627:
						LDA.B #$05                           ;0EA627|A905    |      ;
						LDX.B #$F0                           ;0EA629|A2F0    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA62B|200B84  |0E840B;
						BEQ CODE_0EA64D                      ;0EA62E|F01D    |0EA64D;
						LDA.B #$05                           ;0EA630|A905    |      ;
						LDX.B #$10                           ;0EA632|A210    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA634|200B84  |0E840B;
						BEQ CODE_0EA64D                      ;0EA637|F014    |0EA64D;
						LDA.B #$FB                           ;0EA639|A9FB    |      ;
						LDX.B #$F0                           ;0EA63B|A2F0    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA63D|200B84  |0E840B;
						BEQ CODE_0EA64D                      ;0EA640|F00B    |0EA64D;
						LDA.B #$FB                           ;0EA642|A9FB    |      ;
						LDX.B #$10                           ;0EA644|A210    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA646|200B84  |0E840B;
						BEQ CODE_0EA64D                      ;0EA649|F002    |0EA64D;
						SEC                                  ;0EA64B|38      |      ;
						RTS                                  ;0EA64C|60      |      ;
	
	
			CODE_0EA64D:
						CLC                                  ;0EA64D|18      |      ;
						RTS                                  ;0EA64E|60      |      ;
	
	
			playerChecks:
						LDA.B r_HUD_healthPlayer             ;0EA64F|A53C    |00003C;
						BEQ CODE_0EA674                      ;0EA651|F021    |0EA674;
						LDA.B r_hearts                       ;0EA653|A584    |000084;
						BEQ CODE_0EA674                      ;0EA655|F01D    |0EA674;
						LDA.B r_Joy1_t                       ;0EA657|A526    |000026;
						AND.B #$80                           ;0EA659|2980    |      ;
						BEQ CODE_0EA674                      ;0EA65B|F017    |0EA674;
						LDA.B r_Joy1Held_t                   ;0EA65D|A528    |000028;
						AND.B #$04                           ;0EA65F|2904    |      ;
						BEQ CODE_0EA674                      ;0EA661|F011    |0EA674;
						LDY.B #$00                           ;0EA663|A000    |      ;
	
			CODE_0EA665:
						LDA.W DATA8_0EA697,Y                 ;0EA665|B997A6  |0EA697;
						CMP.B #$FF                           ;0EA668|C9FF    |      ;
						BEQ CODE_0EA675                      ;0EA66A|F009    |0EA675;
						CMP.W r_Player_StateDoubled        ;0EA66C|CD6505  |0E0565;
						BEQ CODE_0EA674                      ;0EA66F|F003    |0EA674;
						INY                                  ;0EA671|C8      |      ;
						BNE CODE_0EA665                      ;0EA672|D0F1    |0EA665;
	
			CODE_0EA674:
						RTS                                  ;0EA674|60      |      ;
	
	
			CODE_0EA675:
						LDY.B #$00                           ;0EA675|A000    |      ;
	
			CODE_0EA677:
						LDA.W alucardBatStates,Y        ;0EA677|B9A2A6  |0EA6A2;
						CMP.B #$FF                           ;0EA67A|C9FF    |      ;
						BEQ CODE_0EA691                      ;0EA67C|F013    |0EA691;
						CMP.W r_Player_StateDoubled        ;0EA67E|CD6505  |0E0565;
						BEQ CODE_0EA686                      ;0EA681|F003    |0EA686;
						INY                                  ;0EA683|C8      |      ;
						BNE CODE_0EA677                      ;0EA684|D0F1    |0EA677;
	
			CODE_0EA686:
						JSR.W CODE_0EA627                    ;0EA686|2027A6  |0EA627;
						BCS CODE_0EA674                      ;0EA689|B0E9    |0EA674;
						LDA.B #$3C                           ;0EA68B|A93C    |      ;
						STA.W r_Player_StateDoubled        ;0EA68D|8D6505  |0E0565;
						RTS                                  ;0EA690|60      |      ;
	
	
			CODE_0EA691:
						LDA.B #$30                           ;0EA691|A930    |      ;
						STA.W r_Player_StateDoubled        ;0EA693|8D6505  |0E0565;
						RTS                                  ;0EA696|60      |      ;
	
	
			DATA8_0EA697:
						db $00,$16,$30,$32,$3C,$3E,$28,$2A   ;0EA697|        |      ;
						db $2C,$2E,$FF                       ;0EA69F|        |      ;
	
	alucardBatStates:
						db $34,$36,$38,$3A,$FF               ;0EA6A2|        |      ;
	
		alucardBat_flag:
						LDY.B #$00                           ;0EA6A7|A000    |      ;
	
			CODE_0EA6A9:
						LDA.W alucardBatStates,Y        ;0EA6A9|B9A2A6  |0EA6A2;
						BMI CODE_0EA6BA                      ;0EA6AC|300C    |0EA6BA;
						CMP.W r_Player_StateDoubled        ;0EA6AE|CD6505  |0E0565;
						BEQ CODE_0EA6B6                      ;0EA6B1|F003    |0EA6B6;
						INY                                  ;0EA6B3|C8      |      ;
						BNE CODE_0EA6A9                      ;0EA6B4|D0F3    |0EA6A9;
	
			CODE_0EA6B6:
			if !jumpControllMovment == 1
						lda.b r_HUD_healthPlayer
						bne not_s_deadBat
						
						lda #$2e 
						sta.w r_Player_StateDoubled
				not_s_deadBat:
			endif 	
												
						LDA.B #$08                           ;0EA6B6|A908    |      ; partnerID 8 is bat
						STA.B r_currPartnerID                ;0EA6B8|8582    |000082;
	
			CODE_0EA6BA:
						RTS                                  ;0EA6BA|60      |      ;
	
	
	alucard_batTransform_state30:
						LDA.B #$2F                           ;0EA6BB|A92F    |      ;
						                               ;0EA6BD|        |      ;
						JSR.W lunchMusic                        ;0EA6BE|        |0FE25F;
						LDA.B #$05                           ;0EA6C0|A905    |      ;
						                               ;0EA6C2|        |      ;
						JSR.W clearSpriteAndAnimGroup              ;0EA6C3|        |0FEF57;
						LDA.B #$01                           ;0EA6C5|A901    |      ;
						STA.W r_entity_AI_IDX          ;0EA6C7|8DC105  |0E05C1;
						STA.B r_alucardBatTimer              ;0EA6CA|85AE    |0000AE;
						INC.W r_Player_StateDoubled        ;0EA6CC|EE6505  |0E0565;
						INC.W r_Player_StateDoubled        ;0EA6CF|EE6505  |0E0565;
						RTS                                  ;0EA6D2|60      |      ;
	
	
	alucard_batTransform_state32:
						LDA.W r_entity_AI_IDX          ;0EA6D3|ADC105  |0E05C1;
						BEQ CODE_0EA6DE                      ;0EA6D6|F006    |0EA6DE;
						DEC.W r_entity_AI_IDX          ;0EA6D8|CEC105  |0E05C1;
						JMP.W DATA8_0EA6EA                   ;0EA6DB|4CEAA6  |0EA6EA;
	
	
			CODE_0EA6DE:
						LDA.W r_entity_OamBaseOffset       ;0EA6DE|AD9305  |0E0593;
						BNE DATA8_0EA6EA                     ;0EA6E1|D007    |0EA6EA;
						LDA.W r_entity_AnimTimer           ;0EA6E3|AD7C05  |0E057C;
						CMP.B #$01                           ;0EA6E6|C901    |      ;
						BEQ CODE_0EA6ED                      ;0EA6E8|F003    |0EA6ED;
	
			DATA8_0EA6EA:
						db $4C                               ;0EA6EA|        |      ;
	
						dw updateSpriteAnimFrame             ;0EA6EB|        |0FEF73;
	
			CODE_0EA6ED:
						LDA.B #$03                           ;0EA6ED|A903    |      ;
						db $20                               ;0EA6EF|        |      ;
						dw clearSpriteAndAnimGroup              ;0EA6F0|        |0FEF57;
						JSR.W CODE_0EA70A                    ;0EA6F2|200AA7  |0EA70A;
						LDA.B #$00                           ;0EA6F5|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EA6F7|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0EA6FA|8D2005  |0E0520;
						STA.W r_entity_Xspd                ;0EA6FD|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EA700|8D0905  |0E0509;
						INC.W r_Player_StateDoubled        ;0EA703|EE6505  |0E0565;
						INC.W r_Player_StateDoubled        ;0EA706|EE6505  |0E0565;
						RTS                                  ;0EA709|60      |      ;
	
	
			CODE_0EA70A:
						LDA.B #$00                           ;0EA70A|A900    |      ;
						TAX                                  ;0EA70C|AA      |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA70D|200B84  |0E840B;
						BNE CODE_0EA713                      ;0EA710|D001    |0EA713;
	
			CODE_0EA712:
						RTS                                  ;0EA712|60      |      ;
	
	
			CODE_0EA713:
						LDA.B #$00                           ;0EA713|A900    |      ;
						LDX.B #$08                           ;0EA715|A208    |      ;
						JSR.W checkCollusion_CMP_01                   ;0EA717|200B84  |0E840B;
						BNE CODE_0EA712                      ;0EA71A|D0F6    |0EA712;
						LDA.W r_entity_YPos                ;0EA71C|AD1C04  |0E041C;
						CLC                                  ;0EA71F|18      |      ;
						ADC.B #$08                           ;0EA720|6908    |      ;
						STA.W r_entity_YPos                ;0EA722|8D1C04  |0E041C;
						RTS                                  ;0EA725|60      |      ;
	
	
	alucard_batHurt_state3c:
						LDA.B #$06                           ;0EA726|A906    |      ; pop sprite?
						db $20                               ;0EA728|        |      ;
						dw clearSpriteAndAnimGroup              ;0EA729|        |0FEF57;
						LDA.B #$01                           ;0EA72B|A901    |      ;
						STA.W r_entity_AI_IDX          ;0EA72D|8DC105  |0E05C1;
						INC.W r_Player_StateDoubled        ;0EA730|EE6505  |0E0565;
						INC.W r_Player_StateDoubled        ;0EA733|EE6505  |0E0565;
						RTS                                  ;0EA736|60      |      ;
	
	
	alucard_batHurt_state3e:
						LDA.W r_entity_AI_IDX          ;0EA737|ADC105  |0E05C1;
						BEQ CODE_0EA742                      ;0EA73A|F006    |0EA742;
						DEC.W r_entity_AI_IDX          ;0EA73C|CEC105  |0E05C1;
						JMP.W DATA8_0EA74E                   ;0EA73F|4C4EA7  |0EA74E;
	
	
			CODE_0EA742:
						LDA.W r_entity_OamBaseOffset       ;0EA742|AD9305  |0E0593;
						BNE DATA8_0EA74E                     ;0EA745|D007    |0EA74E;
						LDA.W r_entity_AnimTimer           ;0EA747|AD7C05  |0E057C;
						CMP.B #$01                           ;0EA74A|C901    |      ;
						BEQ CODE_0EA751                      ;0EA74C|F003    |0EA751;
	
			DATA8_0EA74E:
						db $4C                               ;0EA74E|        |      ;
	
						dw updateSpriteAnimFrame             ;0EA74F|        |0FEF73;
	
			CODE_0EA751:
						LDA.B #$05                           ;0EA751|A905    |      ;
						LDX.B #$10                           ;0EA753|A210    |      ;
						db $20                               ;0EA755|        |      ;
						dw playerCollusionCheck              ;0EA756|        |0FFCDD;
						BNE CODE_0EA76C                      ;0EA758|D012    |0EA76C;
						LDA.B #$FB                           ;0EA75A|A9FB    |      ;
						LDX.B #$10                           ;0EA75C|A210    |      ;
						db $20                               ;0EA75E|        |      ;
						dw playerCollusionCheck              ;0EA75F|        |0FFCDD;
						BNE CODE_0EA76C                      ;0EA761|D009    |0EA76C;
	
			CODE_0EA763:
						JSR.W playerFallingJuming               ;0EA763|203A97  |0E973A;
						LDA.B #$0E                           ;0EA766|A90E    |      ;
						STA.W r_entity_spriteID          ;0EA768|8D0004  |0E0400;
						RTS                                  ;0EA76B|60      |      ;
	
	
			CODE_0EA76C:
						JSR.W CODE_0E8A02                    ;0EA76C|20028A  |0E8A02;
						JMP.W CODE_0EA763                    ;0EA76F|4C63A7  |0EA763;
	
	
			CODE_0EA772:
						STA.W r_entity_AnimGroup           ;0EA772|8DAA05  |0E05AA;
						RTS                                  ;0EA775|60      |      ;
	
	
	alucardBatRiseFast:
						LDA.B #$FC                           ;0EA776|A9FC    |      ;
						STA.W r_entity_Yspd                ;0EA778|8D2005  |0E0520;
						LDA.B #$00                           ;0EA77B|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EA77D|8D3705  |0E0537;
						LDA.B #$15                           ;0EA780|A915    |      ;
						STA.W r_entity_AI_IDX          ;0EA782|8DC105  |0E05C1;
						LDA.B #$3A                           ;0EA785|A93A    |      ;
						STA.W r_Player_StateDoubled        ;0EA787|8D6505  |0E0565;
						RTS                                  ;0EA78A|60      |      ;
	
	
		alucard_state42:
						LDA.B r_Joy1Held_t                   ;0EA78B|A528    |000028;
						AND.B #$08                           ;0EA78D|2908    |      ;
						BNE CODE_0EA7AB                      ;0EA78F|D01A    |0EA7AB;
						LDA.B r_Joy1Held_t                   ;0EA791|A528    |000028;
						BEQ CODE_0EA7C8                      ;0EA793|F033    |0EA7C8;
						LDX.B #$06                           ;0EA795|A206    |      ;
						LDA.B #$00                           ;0EA797|A900    |      ;
						db $20                               ;0EA799|        |      ;
						dw playerCollusionCheck              ;0EA79A|        |0FFCDD;
						BNE CODE_0EA7C8                      ;0EA79C|D02A    |0EA7C8;
						LDA.B #$40                           ;0EA79E|A940    |      ;
						STA.W r_entity_YsubSpd             ;0EA7A0|8D3705  |0E0537;
						LDA.B #$00                           ;0EA7A3|A900    |      ;
						STA.W r_entity_Yspd                ;0EA7A5|8D2005  |0E0520;
						JMP.W CODE_0EA7B5                    ;0EA7A8|4CB5A7  |0EA7B5;
	
	
			CODE_0EA7AB:
						LDA.B #$C0                           ;0EA7AB|A9C0    |      ;
						STA.W r_entity_YsubSpd             ;0EA7AD|8D3705  |0E0537;
						LDA.B #$FF                           ;0EA7B0|A9FF    |      ;
						STA.W r_entity_Yspd                ;0EA7B2|8D2005  |0E0520;
	
			CODE_0EA7B5:
						CLC                                  ;0EA7B5|18      |      ;
						LDA.W r_entity_FractionalY         ;0EA7B6|ADDB04  |0E04DB;
						ADC.W r_entity_YsubSpd             ;0EA7B9|6D3705  |0E0537;
						STA.W r_entity_FractionalY         ;0EA7BC|8DDB04  |0E04DB;
						LDA.W r_entity_YPos                ;0EA7BF|AD1C04  |0E041C;
						ADC.W r_entity_Yspd                ;0EA7C2|6D2005  |0E0520;
						STA.W r_entity_YPos                ;0EA7C5|8D1C04  |0E041C;
	
			CODE_0EA7C8:
						LDX.B #$10                           ;0EA7C8|A210    |      ;
						LDA.B #$00                           ;0EA7CA|A900    |      ;
						db $20                               ;0EA7CC|        |      ;
						dw playerCollusionCheck              ;0EA7CD|        |0FFCDD;
						CMP.B #$02                           ;0EA7CF|C902    |      ;
						BEQ CODE_0EA7DD                      ;0EA7D1|F00A    |0EA7DD;
						CMP.B #$03                           ;0EA7D3|C903    |      ;
						BNE CODE_0EA82A                      ;0EA7D5|D053    |0EA82A;
						LDA.B #$FE                           ;0EA7D7|A9FE    |      ;
						LDY.B #$80                           ;0EA7D9|A080    |      ;
						BNE CODE_0EA7E1                      ;0EA7DB|D004    |0EA7E1;
	
			CODE_0EA7DD:
						LDA.B #$01                           ;0EA7DD|A901    |      ;
						LDY.B #$80                           ;0EA7DF|A080    |      ;
	
			CODE_0EA7E1:
						STA.W r_entity_Xspd                ;0EA7E1|8DF204  |0E04F2;
						STY.W r_entity_XsubSpd             ;0EA7E4|8C0905  |0E0509;
						db $20                               ;0EA7E7|        |      ;
						dw updateSpriteAnimFrame             ;0EA7E8|        |0FEF73;
						JMP.W playerKnockback_01             ;0EA7EA|4C3A87  |0E873A;
	
	
		alucard_state40:
						LDX.B #$10                           ;0EA7ED|A210    |      ;
						LDA.B #$00                           ;0EA7EF|A900    |      ;
						db $20                               ;0EA7F1|        |      ;
						dw playerCollusionCheck              ;0EA7F2|        |0FFCDD;
						CMP.B #$02                           ;0EA7F4|C902    |      ;
						BEQ CODE_0EA802                      ;0EA7F6|F00A    |0EA802;
						CMP.B #$03                           ;0EA7F8|C903    |      ;
						BNE CODE_0EA82A                      ;0EA7FA|D02E    |0EA82A;
						LDA.B #$FE                           ;0EA7FC|A9FE    |      ;
						LDY.B #$80                           ;0EA7FE|A080    |      ;
						BNE CODE_0EA806                      ;0EA800|D004    |0EA806;
	
			CODE_0EA802:
						LDA.B #$01                           ;0EA802|A901    |      ;
						LDY.B #$80                           ;0EA804|A080    |      ;
	
			CODE_0EA806:
						STA.W r_entity_Xspd                ;0EA806|8DF204  |0E04F2;
						STY.W r_entity_XsubSpd             ;0EA809|8C0905  |0E0509;
						LDA.W r_entity_YPos                ;0EA80C|AD1C04  |0E041C;
						CLC                                  ;0EA80F|18      |      ;
						ADC.B #$01                           ;0EA810|6901    |      ;
						STA.W r_entity_YPos                ;0EA812|8D1C04  |0E041C;
						LDX.B #$06                           ;0EA815|A206    |      ;
						LDA.B #$00                           ;0EA817|A900    |      ;
						db $20                               ;0EA819|        |      ;
						dw playerCollusionCheck              ;0EA81A|        |0FFCDD;
						BNE CODE_0EA821                      ;0EA81C|D003    |0EA821;
						JMP.W playerKnockback_01             ;0EA81E|4C3A87  |0E873A;
	
	
			CODE_0EA821:
						INC.W r_Player_StateDoubled        ;0EA821|EE6505  |0E0565;
						INC.W r_Player_StateDoubled        ;0EA824|EE6505  |0E0565;
						JMP.W playerKnockback_01             ;0EA827|4C3A87  |0E873A;
	
	
			CODE_0EA82A:
						LDA.B #$34                           ;0EA82A|A934    |      ;
						STA.W r_Player_StateDoubled        ;0EA82C|8D6505  |0E0565;
						RTS                                  ;0EA82F|60      |      ;
	
	
			CODE_0EA830:
						LDA.B #$40                           ;0EA830|A940    |      ;
						STA.W r_Player_StateDoubled        ;0EA832|8D6505  |0E0565;
						RTS                                  ;0EA835|60      |      ;
	
	
	alucard_bat_fly_00:
						LDA.B r_hearts                       ;0EA836|A584    |000084;
						BEQ CODE_0EA849                      ;0EA838|F00F    |0EA849;
						DEC.B r_alucardBatTimer              ;0EA83A|C6AE    |0000AE;
						BNE CODE_0EA847                      ;0EA83C|D009    |0EA847;
						LDA.B #$3C                           ;0EA83E|A93C    |      ;
						STA.B r_alucardBatTimer              ;0EA840|85AE    |0000AE;
						LDA.B #$01                           ;0EA842|A901    |      ;
						db $20                               ;0EA844|        |      ;
						dw addHeart_A                        ;0EA845|        |0FE753;
	
			CODE_0EA847:
						CLC                                  ;0EA847|18      |      ;
						RTS                                  ;0EA848|60      |      ;
	
	
			CODE_0EA849:
						JSR.W CODE_0EA627                    ;0EA849|2027A6  |0EA627;
						BCS CODE_0EA847                      ;0EA84C|B0F9    |0EA847;
						SEC                                  ;0EA84E|38      |      ;
						RTS                                  ;0EA84F|60      |      ;
	
	
		batQuickRise_0:
						LDA.B #$3C                           ;0EA850|A93C    |      ;
						STA.W r_Player_StateDoubled        ;0EA852|8D6505  |0E0565;
						RTS                                  ;0EA855|60      |      ;
	
	
	alucard_bat_fly_state34:
						JSR.W alucard_bat_fly_00             ;0EA856|2036A8  |0EA836;
						BCS batQuickRise_0                   ;0EA859|B0F5    |0EA850;
						LDX.B #$10                           ;0EA85B|A210    |      ;
						LDA.B #$00                           ;0EA85D|A900    |      ;
						db $20                               ;0EA85F|        |      ;
						dw playerCollusionCheck              ;0EA860|        |0FFCDD;
						CMP.B #$02                           ;0EA862|C902    |      ;
						BEQ CODE_0EA830                      ;0EA864|F0CA    |0EA830;
						CMP.B #$03                           ;0EA866|C903    |      ;
						BEQ CODE_0EA830                      ;0EA868|F0C6    |0EA830;
						LDA.W r_entity_Xspd                ;0EA86A|ADF204  |0E04F2;
						ORA.W r_entity_XsubSpd             ;0EA86D|0D0905  |0E0509;
						BEQ CODE_0EA880                      ;0EA870|F00E    |0EA880;
						LDA.W r_entity_Xspd                ;0EA872|ADF204  |0E04F2;
						BPL CODE_0EA87B                      ;0EA875|1004    |0EA87B;
						LDY.B #$01                           ;0EA877|A001    |      ;
						BNE CODE_0EA87D                      ;0EA879|D002    |0EA87D;
	
			CODE_0EA87B:
						LDY.B #$00                           ;0EA87B|A000    |      ;
	
			CODE_0EA87D:
						STY.W r_entity_FacingLeft          ;0EA87D|8CA804  |0E04A8;
	
			CODE_0EA880:
						LDA.B r_Joy1_t                       ;0EA880|A526    |000026;
						AND.B #$80                           ;0EA882|2980    |      ;
						BEQ CODE_0EA889                      ;0EA884|F003    |0EA889;
						JMP.W alucardBatRiseFast             ;0EA886|4C76A7  |0EA776;
	
	
			CODE_0EA889:
						LDA.B r_Joy1Held_t                   ;0EA889|A528    |000028;
						LSR A                                ;0EA88B|4A      |      ;
						BCS CODE_0EA8D5                      ;0EA88C|B047    |0EA8D5;
						LSR A                                ;0EA88E|4A      |      ;
						BCS CODE_0EA8FC                      ;0EA88F|B06B    |0EA8FC;
						LDA.W r_entity_Xspd                ;0EA891|ADF204  |0E04F2;
						BMI CODE_0EA8B7                      ;0EA894|3021    |0EA8B7;
						LDA.W r_entity_XsubSpd             ;0EA896|AD0905  |0E0509;
						SEC                                  ;0EA899|38      |      ;
						SBC.W batSpeedSub08_alucard_00       ;0EA89A|EDF9A9  |0EA9F9;
						STA.W r_entity_XsubSpd             ;0EA89D|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EA8A0|ADF204  |0E04F2;
						SBC.B #$00                           ;0EA8A3|E900    |      ;
						STA.W r_entity_Xspd                ;0EA8A5|8DF204  |0E04F2;
						BCC CODE_0EA8AD                      ;0EA8A8|9003    |0EA8AD;
						JMP.W CODE_0EA929                    ;0EA8AA|4C29A9  |0EA929;
	
	
			CODE_0EA8AD:
						LDA.B #$00                           ;0EA8AD|A900    |      ;
						STA.W r_entity_Xspd                ;0EA8AF|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EA8B2|8D0905  |0E0509;
						BEQ CODE_0EA929                      ;0EA8B5|F072    |0EA929;
	
			CODE_0EA8B7:
						LDA.W r_entity_XsubSpd             ;0EA8B7|AD0905  |0E0509;
						CLC                                  ;0EA8BA|18      |      ;
						ADC.W batSpeedSub08_alucard_00       ;0EA8BB|6DF9A9  |0EA9F9;
						STA.W r_entity_XsubSpd             ;0EA8BE|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EA8C1|ADF204  |0E04F2;
						ADC.B #$00                           ;0EA8C4|6900    |      ;
						STA.W r_entity_Xspd                ;0EA8C6|8DF204  |0E04F2;
						BCC CODE_0EA929                      ;0EA8C9|905E    |0EA929;
						LDA.B #$00                           ;0EA8CB|A900    |      ;
						STA.W r_entity_Xspd                ;0EA8CD|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EA8D0|8D0905  |0E0509;
						BEQ CODE_0EA929                      ;0EA8D3|F054    |0EA929;
	
			CODE_0EA8D5:
						LDA.W r_entity_XsubSpd             ;0EA8D5|AD0905  |0E0509;
						CLC                                  ;0EA8D8|18      |      ;
						ADC.W batSpeedSub10_alucard_02       ;0EA8D9|6DFBA9  |0EA9FB;
						STA.W r_entity_XsubSpd             ;0EA8DC|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EA8DF|ADF204  |0E04F2;
						ADC.B #$00                           ;0EA8E2|6900    |      ;
						STA.W r_entity_Xspd                ;0EA8E4|8DF204  |0E04F2;
						BMI CODE_0EA929                      ;0EA8E7|3040    |0EA929;
						CMP.W batSpeed01_alucard_04          ;0EA8E9|CDFDA9  |0EA9FD;
						BNE CODE_0EA929                      ;0EA8EC|D03B    |0EA929;
						LDA.W batSpeedSub40_alucard_05       ;0EA8EE|ADFEA9  |0EA9FE;
						CMP.W r_entity_XsubSpd             ;0EA8F1|CD0905  |0E0509;
						BCS CODE_0EA929                      ;0EA8F4|B033    |0EA929;
						STA.W r_entity_XsubSpd             ;0EA8F6|8D0905  |0E0509;
						JMP.W CODE_0EA929                    ;0EA8F9|4C29A9  |0EA929;
	
	
			CODE_0EA8FC:
						LDA.W r_entity_XsubSpd             ;0EA8FC|AD0905  |0E0509;
						SEC                                  ;0EA8FF|38      |      ;
						SBC.W batSpeedSub10_alucard_02       ;0EA900|EDFBA9  |0EA9FB;
						STA.W r_entity_XsubSpd             ;0EA903|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EA906|ADF204  |0E04F2;
						SBC.B #$00                           ;0EA909|E900    |      ;
						STA.W r_entity_Xspd                ;0EA90B|8DF204  |0E04F2;
						BPL CODE_0EA929                      ;0EA90E|1019    |0EA929;
						LDA.W batSpeedFE_alucard_08          ;0EA910|AD01AA  |0EAA01;
						CMP.W r_entity_Xspd                ;0EA913|CDF204  |0E04F2;
						BCC CODE_0EA929                      ;0EA916|9011    |0EA929;
						LDA.W batSpeedSubC0_alucard_09       ;0EA918|AD02AA  |0EAA02;
						CMP.W r_entity_XsubSpd             ;0EA91B|CD0905  |0E0509;
						BCC CODE_0EA929                      ;0EA91E|9009    |0EA929;
						STA.W r_entity_XsubSpd             ;0EA920|8D0905  |0E0509;
						LDA.W batSpeedFE_alucard_08          ;0EA923|AD01AA  |0EAA01;
						STA.W r_entity_Xspd                ;0EA926|8DF204  |0E04F2;
	
			CODE_0EA929:
						LDA.B r_Joy1Held_t                   ;0EA929|A528    |000028;
						AND.B #$04                           ;0EA92B|2904    |      ;
						BEQ CODE_0EA932                      ;0EA92D|F003    |0EA932;
						JMP.W CODE_0EA9B7                    ;0EA92F|4CB7A9  |0EA9B7;
	
	
			CODE_0EA932:
						LDA.B r_Joy1Held_t                   ;0EA932|A528    |000028;
						AND.B #$08                           ;0EA934|2908    |      ;
						BNE CODE_0EA97D                      ;0EA936|D045    |0EA97D;
						LDA.W r_entity_Yspd                ;0EA938|AD2005  |0E0520;
						BMI CODE_0EA95F                      ;0EA93B|3022    |0EA95F;
						LDA.W r_entity_YsubSpd             ;0EA93D|AD3705  |0E0537;
						SEC                                  ;0EA940|38      |      ;
						SBC.W batSpeedSub08_alucard_01       ;0EA941|EDFAA9  |0EA9FA;
						STA.W r_entity_YsubSpd             ;0EA944|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0EA947|AD2005  |0E0520;
						SBC.B #$00                           ;0EA94A|E900    |      ;
						STA.W r_entity_Yspd                ;0EA94C|8D2005  |0E0520;
						BCC CODE_0EA954                      ;0EA94F|9003    |0EA954;
						JMP.W CODE_0EA9DB                    ;0EA951|4CDBA9  |0EA9DB;
	
	
			CODE_0EA954:
						LDA.B #$00                           ;0EA954|A900    |      ;
						STA.W r_entity_Yspd                ;0EA956|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0EA959|8D3705  |0E0537;
						JMP.W CODE_0EA9DB                    ;0EA95C|4CDBA9  |0EA9DB;
	
	
			CODE_0EA95F:
						LDA.W r_entity_YsubSpd             ;0EA95F|AD3705  |0E0537;
						CLC                                  ;0EA962|18      |      ;
						ADC.W batSpeedSub08_alucard_01       ;0EA963|6DFAA9  |0EA9FA;
						STA.W r_entity_YsubSpd             ;0EA966|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0EA969|AD2005  |0E0520;
						ADC.B #$00                           ;0EA96C|6900    |      ;
						STA.W r_entity_Yspd                ;0EA96E|8D2005  |0E0520;
						BCC CODE_0EA9DB                      ;0EA971|9068    |0EA9DB;
						LDA.B #$00                           ;0EA973|A900    |      ;
						STA.W r_entity_Yspd                ;0EA975|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0EA978|8D3705  |0E0537;
						BEQ CODE_0EA9DB                      ;0EA97B|F05E    |0EA9DB;
	
			CODE_0EA97D:
						LDA.W r_entity_YsubSpd             ;0EA97D|AD3705  |0E0537;
						SEC                                  ;0EA980|38      |      ;
						SBC.W batSpeedSub10_alucard_03       ;0EA981|EDFCA9  |0EA9FC;
						STA.W r_entity_YsubSpd             ;0EA984|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0EA987|AD2005  |0E0520;
	
						SBC.B #$00                           ;0EA98A|E900    |      ;
						STA.W r_entity_Yspd                ;0EA98C|8D2005  |0E0520;
						BPL CODE_0EA9DB                      ;0EA98F|104A    |0EA9DB;
						LDA.W batSpeedFF_alucard_0a          ;0EA991|AD03AA  |0EAA03;
						CMP.W r_entity_Yspd                ;0EA994|CD2005  |0E0520;
						BCC CODE_0EA9DB                      ;0EA997|9042    |0EA9DB;
						BEQ CODE_0EA99D                      ;0EA999|F002    |0EA99D;
						BCS CODE_0EA9B1                      ;0EA99B|B014    |0EA9B1;
	
			CODE_0EA99D:
						LDA.W batSpeedSub00_alucard_0b       ;0EA99D|AD04AA  |0EAA04;
						CMP.W r_entity_YsubSpd             ;0EA9A0|CD3705  |0E0537;
						BCC CODE_0EA9DB                      ;0EA9A3|9036    |0EA9DB;
	
			CODE_0EA9A5:
						STA.W r_entity_YsubSpd             ;0EA9A5|8D3705  |0E0537;
						LDA.W batSpeedFF_alucard_0a          ;0EA9A8|AD03AA  |0EAA03;
						STA.W r_entity_Yspd                ;0EA9AB|8D2005  |0E0520;
						JMP.W CODE_0EA9DB                    ;0EA9AE|4CDBA9  |0EA9DB;
	
	
			CODE_0EA9B1:
						LDA.W batSpeedSub00_alucard_0b       ;0EA9B1|AD04AA  |0EAA04;
						JMP.W CODE_0EA9A5                    ;0EA9B4|4CA5A9  |0EA9A5;
	
	
			CODE_0EA9B7:
						LDA.W r_entity_YsubSpd             ;0EA9B7|AD3705  |0E0537;
						CLC                                  ;0EA9BA|18      |      ;
						ADC.W batSpeedSub10_alucard_03       ;0EA9BB|6DFCA9  |0EA9FC;
						STA.W r_entity_YsubSpd             ;0EA9BE|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0EA9C1|AD2005  |0E0520;
						ADC.B #$00                           ;0EA9C4|6900    |      ;
						STA.W r_entity_Yspd                ;0EA9C6|8D2005  |0E0520;
						BMI CODE_0EA9DB                      ;0EA9C9|3010    |0EA9DB;
						CMP.W batSpeed01_alucard_06          ;0EA9CB|CDFFA9  |0EA9FF;
						BNE CODE_0EA9DB                      ;0EA9CE|D00B    |0EA9DB;
						LDA.W batSpeedSub00_alucard_07       ;0EA9D0|AD00AA  |0EAA00;
						CMP.W r_entity_YsubSpd             ;0EA9D3|CD3705  |0E0537;
						BCS CODE_0EA9DB                      ;0EA9D6|B003    |0EA9DB;
						STA.W r_entity_YsubSpd             ;0EA9D8|8D3705  |0E0537;
	
			CODE_0EA9DB:
						LDA.B r_Joy1Held_t                   ;0EA9DB|A528    |000028;
						AND.B #$0F                           ;0EA9DD|290F    |      ;
						BEQ CODE_0EA9E5                      ;0EA9DF|F004    |0EA9E5;
						LDA.B #$04                           ;0EA9E1|A904    |      ;
						BNE CODE_0EA9E7                      ;0EA9E3|D002    |0EA9E7;
	
			CODE_0EA9E5:
						LDA.B #$03                           ;0EA9E5|A903    |      ;
	
			CODE_0EA9E7:
						JSR.W CODE_0EA772                    ;0EA9E7|2072A7  |0EA772;
						JSR.W CODE_0EAA05                    ;0EA9EA|2005AA  |0EAA05;
						JSR.W CODE_0EAB26                    ;0EA9ED|2026AB  |0EAB26;
						db $20                               ;0EA9F0|        |      ;
						dw updateSpriteAnimFrame             ;0EA9F1|        |0FEF73;
						JSR.W playerKnockback_01             ;0EA9F3|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0EA9F6|4C1287  |0E8712;
	
	
	batSpeedSub08_alucard_00:
						db $08                               ;0EA9F9|        |      ;
	
	batSpeedSub08_alucard_01:
						db $08                               ;0EA9FA|        |      ;
	
	batSpeedSub10_alucard_02:
						db $10                               ;0EA9FB|        |      ;
	
	batSpeedSub10_alucard_03:
						db $10                               ;0EA9FC|        |      ;
	
	batSpeed01_alucard_04:
						db $01                               ;0EA9FD|        |      ;
	
	batSpeedSub40_alucard_05:
						db $40                               ;0EA9FE|        |      ;
	
	batSpeed01_alucard_06:
						db $01                               ;0EA9FF|        |      ;
	
	batSpeedSub00_alucard_07:
						db $00                               ;0EAA00|        |      ;
	
	batSpeedFE_alucard_08:
						db $FE                               ;0EAA01|        |      ;
	
	batSpeedSubC0_alucard_09:
						db $C0                               ;0EAA02|        |      ;
	
	batSpeedFF_alucard_0a:
						db $FF                               ;0EAA03|        |      ;
	
	batSpeedSub00_alucard_0b:
						db $00                               ;0EAA04|        |      ;
	
			CODE_0EAA05:
						LDA.W r_Player_StateDoubled        ;0EAA05|AD6505  |0E0565;
						CMP.B #$36                           ;0EAA08|C936    |      ;
						BEQ CODE_0EAA56                      ;0EAA0A|F04A    |0EAA56;
						LDA.W r_entity_Xspd                ;0EAA0C|ADF204  |0E04F2;
						BMI CODE_0EAA2F                      ;0EAA0F|301E    |0EAA2F;
						ORA.W r_entity_XsubSpd             ;0EAA11|0D0905  |0E0509;
						BEQ CODE_0EAA56                      ;0EAA14|F040    |0EAA56;
						LDA.B r_roomEffect                   ;0EAA16|A57D    |00007D;
						CMP.B #$60                           ;0EAA18|C960    |      ;
						BEQ CODE_0EAA84                      ;0EAA1A|F068    |0EAA84;
	
			CODE_0EAA1C:
						LDX.B #$FA                           ;0EAA1C|A2FA    |      ;
						LDA.B #$08                           ;0EAA1E|A908    |      ;
						db $20                               ;0EAA20|        |      ;
						dw playerCollusionCheck              ;0EAA21|        |0FFCDD;
						BNE CODE_0EAA48                      ;0EAA23|D023    |0EAA48;
						LDX.B #$06                           ;0EAA25|A206    |      ;
						LDA.B #$08                           ;0EAA27|A908    |      ;
						db $20                               ;0EAA29|        |      ;
						dw playerCollusionCheck              ;0EAA2A|        |0FFCDD;
						BNE CODE_0EAA48                      ;0EAA2C|D01A    |0EAA48;
						RTS                                  ;0EAA2E|60      |      ;
	
	
			CODE_0EAA2F:
						LDA.B r_roomEffect                   ;0EAA2F|A57D    |00007D;
						CMP.B #$60                           ;0EAA31|C960    |      ;
						BEQ CODE_0EAA57                      ;0EAA33|F022    |0EAA57;
	
			CODE_0EAA35:
						LDX.B #$FA                           ;0EAA35|A2FA    |      ;
						LDA.B #$F8                           ;0EAA37|A9F8    |      ;
						db $20                               ;0EAA39|        |      ;
						dw playerCollusionCheck              ;0EAA3A|        |0FFCDD;
						BNE CODE_0EAA4C                      ;0EAA3C|D00E    |0EAA4C;
						LDX.B #$06                           ;0EAA3E|A206    |      ;
						LDA.B #$F8                           ;0EAA40|A9F8    |      ;
						db $20                               ;0EAA42|        |      ;
						dw playerCollusionCheck              ;0EAA43|        |0FFCDD;
						BNE CODE_0EAA4C                      ;0EAA45|D005    |0EAA4C;
			CODE_0EAA56:						
						RTS                                  ;0EAA47|60      |      ;
	
	
			CODE_0EAA48:
						LDA.B #$01                           ;0EAA48|A901    |      ;
						BNE CODE_0EAA4E                      ;0EAA4A|D002    |0EAA4E;
	
			CODE_0EAA4C:
						LDA.B #$00                           ;0EAA4C|A900    |      ;	
			CODE_0EAA4E:

						STA.W r_entity_extra               ;0EAA4E|8DD805  |0E05D8;
						LDA.B #$36                           ;0EAA51|A936    |      ;
						STA.W r_Player_StateDoubled        ;0EAA53|8D6505  |0E0565;
						RTS                                  ;0EAA56|60      |      ;
	
	
			CODE_0EAA57:
						LDA.W r_entity_YPos                ;0EAA57|AD1C04  |0E041C;
						CMP.B #$B0                           ;0EAA5A|C9B0    |      ;
						BCC CODE_0EAA35                      ;0EAA5C|90D7    |0EAA35;
						JSR.W CODE_0EAADD                    ;0EAA5E|20DDAA  |0EAADD;
						LDA.B r_temp_Xpos                    ;0EAA61|A50A    |00000A;
						SEC                                  ;0EAA63|38      |      ;
						SBC.B #$3E                           ;0EAA64|E93E    |      ;
						STA.B r_tempCurrGroup                ;0EAA66|850C    |00000C;
						LDA.B $0B                            ;0EAA68|A50B    |00000B;
						SBC.B #$01                           ;0EAA6A|E901    |      ;
						BMI CODE_0EAA78                      ;0EAA6C|300A    |0EAA78;
						BNE CODE_0EAA35                      ;0EAA6E|D0C5    |0EAA35;
						LDA.B r_tempCurrGroup                ;0EAA70|A50C    |00000C;
						CMP.B #$04                           ;0EAA72|C904    |      ;
						BCS CODE_0EAA35                      ;0EAA74|B0BF    |0EAA35;
						BCC CODE_0EAA4C                      ;0EAA76|90D4    |0EAA4C;
	
			CODE_0EAA78:
						CMP.B #$FF                           ;0EAA78|C9FF    |      ;
						BNE CODE_0EAA35                      ;0EAA7A|D0B9    |0EAA35;
						LDA.B r_tempCurrGroup                ;0EAA7C|A50C    |00000C;
						CMP.B #$FC                           ;0EAA7E|C9FC    |      ;
						BCS CODE_0EAA4C                      ;0EAA80|B0CA    |0EAA4C;
						BCC CODE_0EAA35                      ;0EAA82|90B1    |0EAA35;
	
			CODE_0EAA84:
						LDA.W r_entity_YPos                ;0EAA84|AD1C04  |0E041C;
						CMP.B #$B0                           ;0EAA87|C9B0    |      ;
						BCC CODE_0EAA1C                      ;0EAA89|9091    |0EAA1C;
						JSR.W CODE_0EAADD                    ;0EAA8B|20DDAA  |0EAADD;
						LDA.B r_temp_Xpos                    ;0EAA8E|A50A    |00000A;
						SEC                                  ;0EAA90|38      |      ;
						SBC.B #$20                           ;0EAA91|E920    |      ;
						STA.B r_tempCurrGroup                ;0EAA93|850C    |00000C;
						LDA.B $0B                            ;0EAA95|A50B    |00000B;
						SBC.B #$01                           ;0EAA97|E901    |      ;
						BMI CODE_0EAAA5                      ;0EAA99|300A    |0EAAA5;
						BNE CODE_0EAAAF                      ;0EAA9B|D012    |0EAAAF;
						LDA.B r_tempCurrGroup                ;0EAA9D|A50C    |00000C;
						CMP.B #$04                           ;0EAA9F|C904    |      ;
						BCS CODE_0EAAAF                      ;0EAAA1|B00C    |0EAAAF;
						BCC CODE_0EAA48                      ;0EAAA3|90A3    |0EAA48;
	
			CODE_0EAAA5:
						CMP.B #$FF                           ;0EAAA5|C9FF    |      ;
						BNE CODE_0EAA35                      ;0EAAA7|D08C    |0EAA35;
						LDA.B r_tempCurrGroup                ;0EAAA9|A50C    |00000C;
						CMP.B #$FC                           ;0EAAAB|C9FC    |      ;
						BCS CODE_0EAA48                      ;0EAAAD|B099    |0EAA48;
	
			CODE_0EAAAF:
						LDA.B r_temp_Xpos                    ;0EAAAF|A50A    |00000A;
						SEC                                  ;0EAAB1|38      |      ;
						SBC.B #$C0                           ;0EAAB2|E9C0    |      ;
						STA.B r_tempCurrGroup                ;0EAAB4|850C    |00000C;
						LDA.B $0B                            ;0EAAB6|A50B    |00000B;
						SBC.B #$02                           ;0EAAB8|E902    |      ;
						BMI CODE_0EAACA                      ;0EAABA|300E    |0EAACA;
						BEQ CODE_0EAAC1                      ;0EAABC|F003    |0EAAC1;
						JMP.W CODE_0EAA1C                    ;0EAABE|4C1CAA  |0EAA1C;
	
	
			CODE_0EAAC1:
						LDA.B r_tempCurrGroup                ;0EAAC1|A50C    |00000C;
						CMP.B #$04                           ;0EAAC3|C904    |      ;
						BCC +
						JMP.W CODE_0EAA1C                    ;0EAAC7|4C1CAA  |0EAA1C;
	
	
			CODE_0EAACA:
						CMP.B #$FF                           ;0EAACA|C9FF    |      ;
						BEQ CODE_0EAAD1                      ;0EAACC|F003    |0EAAD1;
						JMP.W CODE_0EAA35                    ;0EAACE|4C35AA  |0EAA35;
	
	
			CODE_0EAAD1:
						LDA.B r_tempCurrGroup                ;0EAAD1|A50C    |00000C;
						CMP.B #$FC                           ;0EAAD3|C9FC    |      ;
						BCC CODE_0EAADA                      ;0EAAD5|9003    |0EAADA;
					+	JMP.W CODE_0EAA48                    ;0EAAD7|4C48AA  |0EAA48;
	
	
			CODE_0EAADA:
						JMP.W CODE_0EAA1C                    ;0EAADA|4C1CAA  |0EAA1C;
	
	
			CODE_0EAADD:
						LDA.W r_entity_XPos                ;0EAADD|AD3804  |0E0438;
						CLC                                  ;0EAAE0|18      |      ;
						ADC.B r_sceneScrollOffsetLo          ;0EAAE1|6556    |000056;
						STA.B r_temp_Xpos                    ;0EAAE3|850A    |00000A;
						LDA.B r_sceneScrollOffsetHi          ;0EAAE5|A557    |000057;
						ADC.B #$00                           ;0EAAE7|6900    |      ;
						STA.B $0B                            ;0EAAE9|850B    |00000B;
						RTS                                  ;0EAAEB|60      |      ;
	
	
			CODE_0EAAEC:
						LDA.B r_conveyaerRoomEffect          ;0EAAEC|A58B    |00008B;
						AND.B #$0F                           ;0EAAEE|290F    |      ;
						CMP.B #$01                           ;0EAAF0|C901    |      ;
						BEQ CODE_0EAAFB                      ;0EAAF2|F007    |0EAAFB;
						CMP.B #$0C                           ;0EAAF4|C90C    |      ;
						BEQ CODE_0EAAFB                      ;0EAAF6|F003    |0EAAFB;
	
			CODE_0EAAF8:
						LDA.B #$80                           ;0EAAF8|A980    |      ;
						RTS                                  ;0EAAFA|60      |      ;
	
	
			CODE_0EAAFB:
						LDX.B r_ConveyorRelated              ;0EAAFB|A691    |000091;
						LDA.W r_entity_ID,X       ;0EAAFD|BD4E05  |0E054E;
						CMP.B #$7D                           ;0EAB00|C97D    |      ;
						BEQ CODE_0EAB08                      ;0EAB02|F004    |0EAB08;
						CMP.B #$82                           ;0EAB04|C982    |      ;
						BNE CODE_0EAAF8                      ;0EAB06|D0F0    |0EAAF8;
	
			CODE_0EAB08:
						LDA.W r_entity_YPos,X              ;0EAB08|BD1C04  |0E041C;
						SEC                                  ;0EAB0B|38      |      ;
						SBC.W r_entity_YPos                ;0EAB0C|ED1C04  |0E041C;
						RTS                                  ;0EAB0F|60      |      ;
	
	
			CODE_0EAB10:
						JSR.W initPlayerDeath                ;0EAB10|209883  |0E8398;
						CLC                                  ;0EAB13|18      |      ;
						RTS                                  ;0EAB14|60      |      ;
	
	
			DATA8_0EAB15:
						db $20                               ;0EAB15|        |      ;
						dw playerCollusionCheck              ;0EAB16|        |0FFCDD;
						BEQ CODE_0EAB24                      ;0EAB18|F00A    |0EAB24;
						CMP.B #$05                           ;0EAB1A|C905    |      ;
						BEQ CODE_0EAB10                      ;0EAB1C|F0F2    |0EAB10;
						CMP.B #$07                           ;0EAB1E|C907    |      ;
						BEQ CODE_0EAB10                      ;0EAB20|F0EE    |0EAB10;
						SEC                                  ;0EAB22|38      |      ;
						RTS                                  ;0EAB23|60      |      ;
	
	
			CODE_0EAB24:
						CLC                                  ;0EAB24|18      |      ;
						RTS                                  ;0EAB25|60      |      ;
	
	
			CODE_0EAB26:
						LDA.W r_Player_StateDoubled        ;0EAB26|AD6505  |0E0565;
						CMP.B #$36                           ;0EAB29|C936    |      ;
						BEQ CODE_0EAB9F                      ;0EAB2B|F072    |0EAB9F;
						LDA.W r_entity_Yspd                ;0EAB2D|AD2005  |0E0520;
						BMI CODE_0EAB62                      ;0EAB30|3030    |0EAB62;
						ORA.W r_entity_YsubSpd             ;0EAB32|0D3705  |0E0537;
						BEQ CODE_0EAB9F                      ;0EAB35|F068    |0EAB9F;
						LDA.B r_roomEffect                   ;0EAB37|A57D    |00007D;
						AND.B #$F0                           ;0EAB39|29F0    |      ;
						CMP.B #$50                           ;0EAB3B|C950    |      ;
						BEQ +
						CMP.B #$60                           ;0EAB3F|C960    |      ;
						BNE CODE_0EAB46                      ;0EAB41|D003    |0EAB46;
						JMP.W CODE_0EABCB                    ;0EAB43|4CCBAB  |0EABCB;
					+   jmp CODE_0EABB8
	
			CODE_0EAB46:
						JSR.W CODE_0EAAEC                    ;0EAB46|20ECAA  |0EAAEC;
						CMP.B #$80                           ;0EAB49|C980    |      ;
						BEQ CODE_0EAB4F                      ;0EAB4B|F002    |0EAB4F;
						BCC CODE_0EABA0                      ;0EAB4D|9051    |0EABA0;
	
			CODE_0EAB4F:
						LDX.B #$06                           ;0EAB4F|A206    |      ;
						LDA.B #$FA                           ;0EAB51|A9FA    |      ;
						JSR.W DATA8_0EAB15                   ;0EAB53|2015AB  |0EAB15;
						BCS CODE_0EABA0                      ;0EAB56|B048    |0EABA0;
						LDX.B #$06                           ;0EAB58|A206    |      ;
						LDA.B #$06                           ;0EAB5A|A906    |      ;
						JSR.W DATA8_0EAB15                   ;0EAB5C|2015AB  |0EAB15;
						BCS CODE_0EABA0                      ;0EAB5F|B03F    |0EABA0;
						
			CODE_0EAB9F:			
						RTS                                  ;0EAB61|60      |      ;
	
	
			CODE_0EAB62:
						LDA.W r_entity_YPos                ;0EAB62|AD1C04  |0E041C;
						CMP.B #$40                           ;0EAB65|C940    |      ;
						BCC CODE_0EAB84                      ;0EAB67|901B    |0EAB84;
						JSR.W CODE_0EAAEC                    ;0EAB69|20ECAA  |0EAAEC;
						CMP.B #$80                           ;0EAB6C|C980    |      ;
						BEQ CODE_0EAB72                      ;0EAB6E|F002    |0EAB72;
						BCS CODE_0EAB84                      ;0EAB70|B012    |0EAB84;
	
			CODE_0EAB72:
						LDX.B #$FA                           ;0EAB72|A2FA    |      ;
						LDA.B #$FA                           ;0EAB74|A9FA    |      ;
						JSR.W DATA8_0EAB15                   ;0EAB76|2015AB  |0EAB15;
						BCS CODE_0EAB84                      ;0EAB79|B009    |0EAB84;
						LDX.B #$FA                           ;0EAB7B|A2FA    |      ;
						LDA.B #$06                           ;0EAB7D|A906    |      ;
						JSR.W DATA8_0EAB15                   ;0EAB7F|2015AB  |0EAB15;
						BCC CODE_0EAB9F                      ;0EAB82|901B    |0EAB9F;
	
			CODE_0EAB84:
						JSR.W CODE_0E8A02                    ;0EAB84|20028A  |0E8A02;
						CLC                                  ;0EAB87|18      |      ;
						ADC.B #$06                           ;0EAB88|6906    |      ;
						STA.W r_entity_YPos                ;0EAB8A|8D1C04  |0E041C;
						LDA.B #$02                           ;0EAB8D|A902    |      ;
	
			CODE_0EAB8F:
						STA.W r_entity_extra               ;0EAB8F|8DD805  |0E05D8;
						LDA.B #$00                           ;0EAB92|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EAB94|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0EAB97|8D2005  |0E0520;
						LDA.B #$36                           ;0EAB9A|A936    |      ;
						STA.W r_Player_StateDoubled        ;0EAB9C|8D6505  |0E0565;				
					-	RTS                                  ;0EAB9F|60      |      ;
	
	
			CODE_0EABA0:
						LDA.W r_Player_StateDoubled        ;0EABA0|AD6505  |0E0565;
						CMP.B #$2E                           ;0EABA3|C92E    |      ;
						BEQ -
						JSR.W CODE_0E8A02                    ;0EABA7|20028A  |0E8A02;
						LDA.W r_entity_YPos                ;0EABAA|AD1C04  |0E041C;
						CLC                                  ;0EABAD|18      |      ;
						ADC.B #$02                           ;0EABAE|6902    |      ;
						STA.W r_entity_YPos                ;0EABB0|8D1C04  |0E041C;
						LDA.B #$03                           ;0EABB3|A903    |      ;
						JMP.W CODE_0EAB8F                    ;0EABB5|4C8FAB  |0EAB8F;
	
	
			CODE_0EABB8:
						LDA.B r_roomEffect                   ;0EABB8|A57D    |00007D;
						AND.B #$0F                           ;0EABBA|290F    |      ;
						TAY                                  ;0EABBC|A8      |      ;
						LDA.W r_entity_YPos                ;0EABBD|AD1C04  |0E041C;
						CMP.W DATA8_0EAC0D,Y                 ;0EABC0|D90DAC  |0EAC0D;
						BCC +
	
			CODE_0EABC5:
						JSR.W waterSplashInit                ;0EABC5|20588C  |0E8C58;
						JMP.W CODE_0EABA0                    ;0EABC8|4CA0AB  |0EABA0;
	
	
			CODE_0EABCB:
						LDA.B r_roomEffect                   ;0EABCB|A57D    |00007D;
						AND.B #$0F                           ;0EABCD|290F    |      ;
						BEQ CODE_0EABD4                      ;0EABCF|F003    |0EABD4;
					+	JMP.W CODE_0EAB46                    ;0EABD1|4C46AB  |0EAB46;
	
	
			CODE_0EABD4:
						LDA.W r_entity_YPos                ;0EABD4|AD1C04  |0E041C;
						CMP.B #$BC                           ;0EABD7|C9BC    |      ;
						BCS CODE_0EABDE                      ;0EABD9|B003    |0EABDE;
						JMP.W CODE_0EAB46                    ;0EABDB|4C46AB  |0EAB46;
	
	
			CODE_0EABDE:
						LDA.W r_entity_XPos                ;0EABDE|AD3804  |0E0438;
						CLC                                  ;0EABE1|18      |      ;
						ADC.B r_sceneScrollOffsetLo          ;0EABE2|6556    |000056;
						STA.B r_temp_Xpos                    ;0EABE4|850A    |00000A;
						LDA.B r_sceneScrollOffsetHi          ;0EABE6|A557    |000057;
						ADC.B #$00                           ;0EABE8|6900    |      ;
						STA.B $0B                            ;0EABEA|850B    |00000B;
						CMP.B #$01                           ;0EABEC|C901    |      ;
						BCC CODE_0EABC5                      ;0EABEE|90D5    |0EABC5;
						BNE CODE_0EABFB                      ;0EABF0|D009    |0EABFB;
						LDA.B r_temp_Xpos                    ;0EABF2|A50A    |00000A;
						CMP.B #$20                           ;0EABF4|C920    |      ;
						BCC CODE_0EABC5                      ;0EABF6|90CD    |0EABC5;
						JMP.W CODE_0EAB46                    ;0EABF8|4C46AB  |0EAB46;
	
	
			CODE_0EABFB:
						CMP.B #$02                           ;0EABFB|C902    |      ;
						BCS CODE_0EAC02                      ;0EABFD|B003    |0EAC02;
						JMP.W CODE_0EAB46                    ;0EABFF|4C46AB  |0EAB46;
	
	
			CODE_0EAC02:
						BNE CODE_0EABC5                      ;0EAC02|D0C1    |0EABC5;
						LDA.B r_temp_Xpos                    ;0EAC04|A50A    |00000A;
						CMP.B #$C0                           ;0EAC06|C9C0    |      ;
						BCS CODE_0EABC5                      ;0EAC08|B0BB    |0EABC5;
						JMP.W CODE_0EAB46                    ;0EAC0A|4C46AB  |0EAB46;
	
	
			DATA8_0EAC0D:
						db $9C,$BC,$BC,$BC                   ;0EAC0D|        |      ;
	
			DATA8_0EAC11:
						db $AD,$F2,$04,$30,$13,$A2           ;0EAC11|        |      ;
						PLX                                  ;0EAC17|FA      |      ;
						LDA.B #$08                           ;0EAC18|A908    |      ;
						db $20                               ;0EAC1A|        |      ;
						dw playerCollusionCheck              ;0EAC1B|        |0FFCDD;
						BNE CODE_0EAC3B                      ;0EAC1D|D01C    |0EAC3B;
						LDX.B #$06                           ;0EAC1F|A206    |      ;
						LDA.B #$08                           ;0EAC21|A908    |      ;
						db $20                               ;0EAC23|        |      ;
						dw playerCollusionCheck              ;0EAC24|        |0FFCDD;
						BNE CODE_0EAC3B                      ;0EAC26|D013    |0EAC3B;
						RTS                                  ;0EAC28|60      |      ;
	
						LDX.B #$FA                           ;0EAC29|A2FA    |      ;
						LDA.B #$F8                           ;0EAC2B|A9F8    |      ;
						db $20                               ;0EAC2D|        |      ;
						dw playerCollusionCheck              ;0EAC2E|        |0FFCDD;
						BNE CODE_0EAC3B                      ;0EAC30|D009    |0EAC3B;
						LDX.B #$06                           ;0EAC32|A206    |      ;
						LDA.B #$F8                           ;0EAC34|A9F8    |      ;
						db $20                               ;0EAC36|        |      ;
						dw playerCollusionCheck              ;0EAC37|        |0FFCDD;
						BEQ CODE_0EAC43                      ;0EAC39|F008    |0EAC43;
	
			CODE_0EAC3B:
						LDA.B #$00                           ;0EAC3B|A900    |      ;
						STA.W r_entity_XsubSpd             ;0EAC3D|8D0905  |0E0509;
						STA.W r_entity_Xspd                ;0EAC40|8DF204  |0E04F2;
	
			CODE_0EAC43:
						RTS                                  ;0EAC43|60      |      ;
	
	
			CODE_0EAC44:
						LDA.W r_entity_Yspd                ;0EAC44|AD2005  |0E0520;
						BMI CODE_0EAC5C                      ;0EAC47|3013    |0EAC5C;
						LDX.B #$06                           ;0EAC49|A206    |      ;
						LDA.B #$FA                           ;0EAC4B|A9FA    |      ;
						db $20                               ;0EAC4D|        |      ;
						dw playerCollusionCheck              ;0EAC4E|        |0FFCDD;
						BNE CODE_0EAC80                      ;0EAC50|D02E    |0EAC80;
						LDX.B #$06                           ;0EAC52|A206    |      ;
						LDA.B #$06                           ;0EAC54|A906    |      ;
						db $20                               ;0EAC56|        |      ;
						dw playerCollusionCheck              ;0EAC57|        |0FFCDD;
						BNE CODE_0EAC80                      ;0EAC59|D025    |0EAC80;
						RTS                                  ;0EAC5B|60      |      ;
	
	
			CODE_0EAC5C:
						LDX.B #$FA                           ;0EAC5C|A2FA    |      ;
						LDA.B #$FA                           ;0EAC5E|A9FA    |      ;
						db $20                               ;0EAC60|        |      ;
						dw playerCollusionCheck              ;0EAC61|        |0FFCDD;
						BNE CODE_0EAC6E                      ;0EAC63|D009    |0EAC6E;
						LDX.B #$FA                           ;0EAC65|A2FA    |      ;
						LDA.B #$06                           ;0EAC67|A906    |      ;
						db $20                               ;0EAC69|        |      ;
						dw playerCollusionCheck              ;0EAC6A|        |0FFCDD;
						BEQ CODE_0EAC7F                      ;0EAC6C|F011    |0EAC7F;
	
			CODE_0EAC6E:
						JSR.W CODE_0E8A02                    ;0EAC6E|20028A  |0E8A02;
						CLC                                  ;0EAC71|18      |      ;
						ADC.B #$06                           ;0EAC72|6906    |      ;
						STA.W r_entity_YPos                ;0EAC74|8D1C04  |0E041C;
	
			CODE_0EAC77:
						LDA.B #$00                           ;0EAC77|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EAC79|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0EAC7C|8D2005  |0E0520;
	
			CODE_0EAC7F:
						RTS                                  ;0EAC7F|60      |      ;
	
	
			CODE_0EAC80:
						JSR.W CODE_0E8A02                    ;0EAC80|20028A  |0E8A02;
						LDA.W r_entity_YPos                ;0EAC83|AD1C04  |0E041C;
						CLC                                  ;0EAC86|18      |      ;
						ADC.B #$02                           ;0EAC87|6902    |      ;
						STA.W r_entity_YPos                ;0EAC89|8D1C04  |0E041C;
						JMP.W CODE_0EAC77                    ;0EAC8C|4C77AC  |0EAC77;
	
	
	alucard_batColSolit_state36:
						INC.W r_Player_StateDoubled        ;0EAC8F|EE6505  |0E0565;
						INC.W r_Player_StateDoubled        ;0EAC92|EE6505  |0E0565;
						LDA.B #$03                           ;0EAC95|A903    |      ;
						STA.W r_entity_AI_IDX          ;0EAC97|8DC105  |0E05C1;
						LDA.W r_entity_extra               ;0EAC9A|ADD805  |0E05D8;
						CMP.B #$02                           ;0EAC9D|C902    |      ;
						BCS CODE_0EACB0                      ;0EAC9F|B00F    |0EACB0;
						ASL A                                ;0EACA1|0A      |      ;
						TAY                                  ;0EACA2|A8      |      ;
						LDA.W batColSpd_alucard_00,Y         ;0EACA3|B9BFAC  |0EACBF;
						STA.W r_entity_Xspd                ;0EACA6|8DF204  |0E04F2;
						LDA.W batColSpd_alucard_01,Y         ;0EACA9|B9C0AC  |0EACC0;
						STA.W r_entity_XsubSpd             ;0EACAC|8D0905  |0E0509;
						RTS                                  ;0EACAF|60      |      ;
	
	
			CODE_0EACB0:
						ASL A                                ;0EACB0|0A      |      ;
						TAY                                  ;0EACB1|A8      |      ;
						LDA.W batColSpd_alucard_00,Y         ;0EACB2|B9BFAC  |0EACBF;
						STA.W r_entity_Yspd                ;0EACB5|8D2005  |0E0520;
						LDA.W batColSpd_alucard_01,Y         ;0EACB8|B9C0AC  |0EACC0;
						STA.W r_entity_YsubSpd             ;0EACBB|8D3705  |0E0537;
						RTS                                  ;0EACBE|60      |      ;
	
	
	batColSpd_alucard_00:
						db $01                               ;0EACBF|        |      ;
	
	batColSpd_alucard_01:
						db $00                               ;0EACC0|        |      ;
	
	batColSpd_alucard_02:
						db $FF                               ;0EACC1|        |      ;
	
	batColSpd_alucard_03:
						db $00                               ;0EACC2|        |      ;
	
	batColSpd_alucard_04:
						db $01                               ;0EACC3|        |      ;
	
	batColSpd_alucard_05:
						db $00                               ;0EACC4|        |      ;
	
	batColSpd_alucard_06:
						db $FF                               ;0EACC5|        |      ;
	
	batColSpd_alucard_07:
						db $00                               ;0EACC6|        |      ;
	
	alucard_batColSolit_state38:
						JSR.W alucard_bat_fly_00             ;0EACC7|2036A8  |0EA836;
						BCC CODE_0EACCF                      ;0EACCA|9003    |0EACCF;
						JMP.W batQuickRise_0                 ;0EACCC|4C50A8  |0EA850;
	
	
			CODE_0EACCF:
						DEC.W r_entity_AI_IDX          ;0EACCF|CEC105  |0E05C1;
						BEQ CODE_0EACE8                      ;0EACD2|F014    |0EACE8;
						LDA.B #$04                           ;0EACD4|A904    |      ;
						JSR.W CODE_0EA772                    ;0EACD6|2072A7  |0EA772;
						JSR.W DATA8_0EAC11                   ;0EACD9|2011AC  |0EAC11;
						JSR.W CODE_0EAC44                    ;0EACDC|2044AC  |0EAC44;
						db $20                               ;0EACDF|        |      ;
						dw updateSpriteAnimFrame             ;0EACE0|        |0FEF73;
						JSR.W playerKnockback_01             ;0EACE2|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0EACE5|4C1287  |0E8712;
	
	
			CODE_0EACE8:
						LDA.W r_entity_extra               ;0EACE8|ADD805  |0E05D8;
						CMP.B #$02                           ;0EACEB|C902    |      ;
						BCS CODE_0EACF9                      ;0EACED|B00A    |0EACF9;
						LDA.B #$00                           ;0EACEF|A900    |      ;
						STA.W r_entity_Xspd                ;0EACF1|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EACF4|8D0905  |0E0509;
						BEQ CODE_0EAD01                      ;0EACF7|F008    |0EAD01;
	
			CODE_0EACF9:
						LDA.B #$00                           ;0EACF9|A900    |      ;
						STA.W r_entity_Yspd                ;0EACFB|8D2005  |0E0520;
						STA.W r_entity_YsubSpd             ;0EACFE|8D3705  |0E0537;
	
			CODE_0EAD01:
						LDA.B #$34                           ;0EAD01|A934    |      ;
						STA.W r_Player_StateDoubled        ;0EAD03|8D6505  |0E0565;
						RTS                                  ;0EAD06|60      |      ;
	
	
	alucard_batQuickRise_state3a:
						JSR.W alucard_bat_fly_00             ;0EAD07|2036A8  |0EA836;
						BCC CODE_0EAD0F                      ;0EAD0A|9003    |0EAD0F;
						JMP.W batQuickRise_0                 ;0EAD0C|4C50A8  |0EA850;
	
	
			CODE_0EAD0F:
						DEC.W r_entity_AI_IDX          ;0EAD0F|CEC105  |0E05C1;
						BNE CODE_0EAD1A                      ;0EAD12|D006    |0EAD1A;
						LDA.B #$34                           ;0EAD14|A934    |      ;
						STA.W r_Player_StateDoubled        ;0EAD16|8D6505  |0E0565;
						RTS                                  ;0EAD19|60      |      ;
	
	
			CODE_0EAD1A:
						LDA.W r_entity_Xspd                ;0EAD1A|ADF204  |0E04F2;
						ORA.W r_entity_XsubSpd             ;0EAD1D|0D0905  |0E0509;
						BEQ CODE_0EAD30                      ;0EAD20|F00E    |0EAD30;
						LDA.W r_entity_Xspd                ;0EAD22|ADF204  |0E04F2;
						BPL CODE_0EAD2B                      ;0EAD25|1004    |0EAD2B;
						LDY.B #$01                           ;0EAD27|A001    |      ;
						BNE CODE_0EAD2D                      ;0EAD29|D002    |0EAD2D;
	
			CODE_0EAD2B:
						LDY.B #$00                           ;0EAD2B|A000    |      ;
	
			CODE_0EAD2D:
						STY.W r_entity_FacingLeft          ;0EAD2D|8CA804  |0E04A8;
	
			CODE_0EAD30:
						LDA.B r_Joy1Held_t                   ;0EAD30|A528    |000028;
						LSR A                                ;0EAD32|4A      |      ;
						BCS CODE_0EAD7C                      ;0EAD33|B047    |0EAD7C;
						LSR A                                ;0EAD35|4A      |      ;
						BCS CODE_0EADA3                      ;0EAD36|B06B    |0EADA3;
						LDA.W r_entity_Xspd                ;0EAD38|ADF204  |0E04F2;
						BMI CODE_0EAD5E                      ;0EAD3B|3021    |0EAD5E;
						LDA.W r_entity_XsubSpd             ;0EAD3D|AD0905  |0E0509;
						SEC                                  ;0EAD40|38      |      ;
						SBC.W batSpeedSub08_alucard_00       ;0EAD41|EDF9A9  |0EA9F9;
						STA.W r_entity_XsubSpd             ;0EAD44|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EAD47|ADF204  |0E04F2;
						SBC.B #$00                           ;0EAD4A|E900    |      ;
						STA.W r_entity_Xspd                ;0EAD4C|8DF204  |0E04F2;
						BCC CODE_0EAD54                      ;0EAD4F|9003    |0EAD54;
						JMP.W CODE_0EADD0                    ;0EAD51|4CD0AD  |0EADD0;
	
	
			CODE_0EAD54:
						LDA.B #$00                           ;0EAD54|A900    |      ;
						STA.W r_entity_Xspd                ;0EAD56|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EAD59|8D0905  |0E0509;
						BEQ CODE_0EADD0                      ;0EAD5C|F072    |0EADD0;
	
			CODE_0EAD5E:
						LDA.W r_entity_XsubSpd             ;0EAD5E|AD0905  |0E0509;
						CLC                                  ;0EAD61|18      |      ;
						ADC.W batSpeedSub08_alucard_00       ;0EAD62|6DF9A9  |0EA9F9;
						STA.W r_entity_XsubSpd             ;0EAD65|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EAD68|ADF204  |0E04F2;
						ADC.B #$00                           ;0EAD6B|6900    |      ;
						STA.W r_entity_Xspd                ;0EAD6D|8DF204  |0E04F2;
						BCC CODE_0EADD0                      ;0EAD70|905E    |0EADD0;
						LDA.B #$00                           ;0EAD72|A900    |      ;
						STA.W r_entity_Xspd                ;0EAD74|8DF204  |0E04F2;
						STA.W r_entity_XsubSpd             ;0EAD77|8D0905  |0E0509;
						BEQ CODE_0EADD0                      ;0EAD7A|F054    |0EADD0;
	
			CODE_0EAD7C:
						LDA.W r_entity_XsubSpd             ;0EAD7C|AD0905  |0E0509;
						CLC                                  ;0EAD7F|18      |      ;
						ADC.W batSpeedSub10_alucard_02       ;0EAD80|6DFBA9  |0EA9FB;
						STA.W r_entity_XsubSpd             ;0EAD83|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EAD86|ADF204  |0E04F2;
						ADC.B #$00                           ;0EAD89|6900    |      ;
						STA.W r_entity_Xspd                ;0EAD8B|8DF204  |0E04F2;
						BMI CODE_0EADD0                      ;0EAD8E|3040    |0EADD0;
						CMP.W batSpeed01_alucard_04          ;0EAD90|CDFDA9  |0EA9FD;
						BNE CODE_0EADD0                      ;0EAD93|D03B    |0EADD0;
						LDA.W batSpeedSub40_alucard_05       ;0EAD95|ADFEA9  |0EA9FE;
						CMP.W r_entity_XsubSpd             ;0EAD98|CD0905  |0E0509;
						BCS CODE_0EADD0                      ;0EAD9B|B033    |0EADD0;
						STA.W r_entity_XsubSpd             ;0EAD9D|8D0905  |0E0509;
						JMP.W CODE_0EADD0                    ;0EADA0|4CD0AD  |0EADD0;
	
	
			CODE_0EADA3:
						LDA.W r_entity_XsubSpd             ;0EADA3|AD0905  |0E0509;
						SEC                                  ;0EADA6|38      |      ;
						SBC.W batSpeedSub10_alucard_02       ;0EADA7|EDFBA9  |0EA9FB;
						STA.W r_entity_XsubSpd             ;0EADAA|8D0905  |0E0509;
						LDA.W r_entity_Xspd                ;0EADAD|ADF204  |0E04F2;
						SBC.B #$00                           ;0EADB0|E900    |      ;
						STA.W r_entity_Xspd                ;0EADB2|8DF204  |0E04F2;
						BPL CODE_0EADD0                      ;0EADB5|1019    |0EADD0;
						LDA.W batSpeedFE_alucard_08          ;0EADB7|AD01AA  |0EAA01;
						CMP.W r_entity_Xspd                ;0EADBA|CDF204  |0E04F2;
						BCC CODE_0EADD0                      ;0EADBD|9011    |0EADD0;
						LDA.W batSpeedSubC0_alucard_09       ;0EADBF|AD02AA  |0EAA02;
						CMP.W r_entity_XsubSpd             ;0EADC2|CD0905  |0E0509;
						BCC CODE_0EADD0                      ;0EADC5|9009    |0EADD0;
						STA.W r_entity_XsubSpd             ;0EADC7|8D0905  |0E0509;
						LDA.W batSpeedFE_alucard_08          ;0EADCA|AD01AA  |0EAA01;
						STA.W r_entity_Xspd                ;0EADCD|8DF204  |0E04F2;
	
			CODE_0EADD0:
						LDA.W r_entity_YsubSpd             ;0EADD0|AD3705  |0E0537;
						CLC                                  ;0EADD3|18      |      ;
						ADC.B #$40                           ;0EADD4|6940    |      ;
						STA.W r_entity_YsubSpd             ;0EADD6|8D3705  |0E0537;
						LDA.W r_entity_Yspd                ;0EADD9|AD2005  |0E0520;
						ADC.B #$00                           ;0EADDC|6900    |      ;
						STA.W r_entity_Yspd                ;0EADDE|8D2005  |0E0520;
						LDA.B #$04                           ;0EADE1|A904    |      ;
						JSR.W CODE_0EA772                    ;0EADE3|2072A7  |0EA772;
						JSR.W CODE_0EAB26                    ;0EADE6|2026AB  |0EAB26;
						JSR.W CODE_0EAA05                    ;0EADE9|2005AA  |0EAA05;
						LDA.W r_Player_StateDoubled        ;0EADEC|AD6505  |0E0565;
						CMP.B #$36                           ;0EADEF|C936    |      ;
						BEQ CODE_0EADFC                      ;0EADF1|F009    |0EADFC;
	
			DATA8_0EADF3:
						db $20                               ;0EADF3|        |      ;
						dw updateSpriteAnimFrame             ;0EADF4|        |0FEF73;
						JSR.W playerKnockback_01             ;0EADF6|203A87  |0E873A;
						JMP.W updateSpeed2Pos                ;0EADF9|4C1287  |0E8712;
	
	
			CODE_0EADFC:
						LDA.W r_entity_extra               ;0EADFC|ADD805  |0E05D8;
						CMP.B #$02                           ;0EADFF|C902    |      ;
						BCS DATA8_0EADF3                     ;0EAE01|B0F0    |0EADF3;
						LDA.B #$00                           ;0EAE03|A900    |      ;
						STA.W r_entity_YsubSpd             ;0EAE05|8D3705  |0E0537;
						STA.W r_entity_Yspd                ;0EAE08|8D2005  |0E0520;
						BEQ DATA8_0EADF3                     ;0EAE0B|F0E6    |0EADF3;
	
			CODE_0EAE0D:
						STA.B $02                            ;0EAE0D|8502    |000002;
						STY.B $03                            ;0EAE0F|8403    |000003;
						LDA.B #$00                           ;0EAE11|A900    |      ;
						STA.B $04                            ;0EAE13|8504    |000004;
						STA.B $05                            ;0EAE15|8505    |000005;
						LDY.B #$10                           ;0EAE17|A010    |      ;
	
			CODE_0EAE19:
						ASL.B $00                            ;0EAE19|0600    |000000;
						ROL.B $01                            ;0EAE1B|2601    |000001;
						ROL.B $04                            ;0EAE1D|2604    |000004;
						ROL.B $05                            ;0EAE1F|2605    |000005;
						LDA.B $05                            ;0EAE21|A505    |000005;
						CMP.B $03                            ;0EAE23|C503    |000003;
						BNE CODE_0EAE2B                      ;0EAE25|D004    |0EAE2B;
						LDA.B $04                            ;0EAE27|A504    |000004;
						CMP.B $02                            ;0EAE29|C502    |000002;
	
			CODE_0EAE2B:
						BCC CODE_0EAE3B                      ;0EAE2B|900E    |0EAE3B;
						LDA.B $04                            ;0EAE2D|A504    |000004;
						SBC.B $02                            ;0EAE2F|E502    |000002;
						STA.B $04                            ;0EAE31|8504    |000004;
						LDA.B $05                            ;0EAE33|A505    |000005;
						SBC.B $03                            ;0EAE35|E503    |000003;
						STA.B $05                            ;0EAE37|8505    |000005;
						INC.B $00                            ;0EAE39|E600    |000000;
	
			CODE_0EAE3B:
						DEY                                  ;0EAE3B|88      |      ;
						BNE CODE_0EAE19                      ;0EAE3C|D0DB    |0EAE19;
						RTS                                  ;0EAE3E|60      |      ;
	
				bossDoupleGanger_collusion_04:
						LDA.B #$01                           ;0EAE3F|A901    |      ;
						STA.B r_index                        ;0EAE41|8510    |000010;
						LDA.W r_bossPieces     ;0EAE43|ADEC07  |0E07EC;
						STA.B r_collisionPointXvalDiv32      ;0EAE46|8512    |000012;
						LDA.B #$01                           ;0EAE48|A901    |      ;
						STA.B $17                            ;0EAE4A|8517    |000017;
						LDA.W r_entity_ID,X       ;0EAE4C|BD4E05  |0E054E;
						JMP.W CODE_0EAE6D                    ;0EAE4F|4C6DAE  |0EAE6D;
	
	
			CODE_0EAE52:
						LDA.B #$00                           ;0EAE52|A900    |      ;
						STA.B r_index                        ;0EAE54|8510    |000010;
						LDX.B #$14                           ;0EAE56|A214    |      ;
						LDA.B r_currPartnerID                ;0EAE58|A582    |000082;
						STA.B r_collisionPointXvalDiv32      ;0EAE5A|8512    |000012;
						LDA.B #$03                           ;0EAE5C|A903    |      ;
						STA.B $17                            ;0EAE5E|8517    |000017;
	
			CODE_0EAE60:
						LDA.W r_entity_ID,X       ;0EAE60|BD4E05  |0E054E;
						BNE CODE_0EAE6D                      ;0EAE63|D008    |0EAE6D;
	
			startSubwe_checks:
						DEC.B $17                            ;0EAE65|C617    |000017;
						BEQ endLoop_AE6C                     ;0EAE67|F003    |0EAE6C;
						INX                                  ;0EAE69|E8      |      ;
						BNE CODE_0EAE60                      ;0EAE6A|D0F4    |0EAE60;
	
			endLoop_AE6C:
						RTS                                  ;0EAE6C|60      |      ;
	
	
			CODE_0EAE6D:
						CMP.B #$0C                           ;0EAE6D|C90C    |      ;
						BEQ CODE_0EAE75                      ;0EAE6F|F004    |0EAE75;
						LDA.B r_deathDelay                   ;0EAE71|A5BF    |0000BF;
						BMI endLoop_AE6C                     ;0EAE73|30F7    |0EAE6C;
	
			CODE_0EAE75:
						LDA.W mainSubweaponPointer+1                   ;0EAE75|ADFDAE  |0EAEFD;
						PHA                                  ;0EAE78|48      |      ;
						LDA.W mainSubweaponPointer                   ;0EAE79|ADFCAE  |0EAEFC;
						PHA                                  ;0EAE7C|48      |      ;
						LDA.W r_entity_ID,X       ;0EAE7D|BD4E05  |0E054E;
						ASL A                                ;0EAE80|0A      |      ;
						TAY                                  ;0EAE81|A8      |      ;
						LDA.W subWeaponRoutines,Y            ;0EAE82|B9E0AE  |0EAEE0;
						STA.B $00                            ;0EAE85|8500    |000000;
						LDA.W subWeaponRoutines+1,Y                 ;0EAE87|B9E1AE  |0EAEE1;
						STA.B $01                            ;0EAE8A|8501    |000001;
						LDY.W r_Player_StateDoubled,X      ;0EAE8C|BC6505  |0E0565;
						LDA.B ($00),Y                        ;0EAE8F|B100    |000000;
						STA.B $02                            ;0EAE91|8502    |000002;
						INY                                  ;0EAE93|C8      |      ;
						LDA.B ($00),Y                        ;0EAE94|B100    |000000;
						STA.B $03                            ;0EAE96|8503    |000003;
						JMP.W ($0002)                        ;0EAE98|6C0200  |000002;
			
}			


{ ; subweapons 			
			
			
			mainSubweapon:
						LDA.W r_Player_StateDoubled,X         ; 0EAE9B|BD6505  |0E0565;
						CMP.B #$02                           
						BEQ startSubwe_checks                
						
            LDA.W r_entity_XPos,X         
						CMP.B #$09                    
						BCC subWe_borderCross         
						CMP.B #$F8                    
						BCS subWe_borderCross         
						LDA.W r_entity_YPos,X         
						CMP.B #$10                    
						BCC subWe_borderCross         
            CMP.B #$E0                    
						BCS subWe_borderCross         					
            
            JMP.W startSubwe_checks       
	
			subWe_borderCross:
            LDA.W r_entity_ID,X                    ;0EAEBB|BD4E05  |0E054E;
						CMP.B #SUBWE_FREEZ                     ;0EAEA5|C909    |      ;          
            BEQ hideSprite_subWe                  
						
            LDA.B #$00                       
						STA.W r_entity_ID,X              
						STA.W r_entity_spriteID,X        
						STA.W r_entity_XPos,X            
						STA.W r_entity_YPos,X            
	
            JMP.W startSubwe_checks          
	
			hideSprite_subWe:
						LDA.B #$00                             ;0EAED3|A900    |      ;
						STA.W r_entity_XPos,X            
						LDA.B #$80                       
						STA.W r_entity_mask,X            
						
            JMP.W startSubwe_checks          

  
  { ;  ending place sprites?? 
			
      donno_01_state_00:
					LDA.B #$0E                           ;0EB984|A90E    |      ;
					STA.W r_entity_spriteGroup,X        ;0EB986|9D8C04  |0E048C;
					LDA.B #$18                           ;0EB989|A918    |      ;
					STA.W r_entity_spriteID,X           ;0EB98B|9D0004  |0E0400;
					LDA.B #$00                           ;0EB98E|A900    |      ;
					STA.W r_entity_mask,X                ;0EB990|9D7004  |0E0470;
					LDA.B #$20                           ;0EB993|A920    |      ;
					STA.W r_entity_AI_IDX,X               ;0EB995|9DC105  |0E05C1;
					INC.W r_Player_StateDoubled,X      ;0EB998|FE6505  |0E0565;
					INC.W r_Player_StateDoubled,X      ;0EB99B|FE6505  |0E0565;
					RTS                                  ;0EB99E|60      |      ;
	
	
        donno_00_state_00:
						LDA.B #$0E                           ;0EB99F|A90E    |      ;
						STA.W r_entity_spriteGroup,X        ;0EB9A1|9D8C04  |0E048C;
						LDA.B #$1A                           ;0EB9A4|A91A    |      ;
						STA.W r_entity_spriteID,X        ;0EB9A6|9D0004  |0E0400;
						LDA.B #$00                           ;0EB9A9|A900    |      ;
						STA.W r_entity_mask,X            ;0EB9AB|9D7004  |0E0470;
						LDA.B #$20                           ;0EB9AE|A920    |      ;
						STA.W r_entity_AI_IDX,X        ;0EB9B0|9DC105  |0E05C1;
						INC.W r_Player_StateDoubled,X      ;0EB9B3|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB9B6|FE6505  |0E0565;
						RTS                                  ;0EB9B9|60      |      ;
	
	
		donno_state_01:
						INC.W r_Player_StateDoubled,X      ;0EB9BA|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB9BD|FE6505  |0E0565;
	
		donno_state_03:
						DEC.W r_entity_AI_IDX,X        ;0EB9C0|DEC105  |0E05C1;
						BNE CODE_0EB9CE                      ;0EB9C3|D009    |0EB9CE;
						LDA.B #$00                           ;0EB9C5|A900    |      ;
						STA.W r_entity_spriteID,X        ;0EB9C7|9D0004  |0E0400;
						STA.W r_entity_ID,X       ;0EB9CA|9D4E05  |0E054E;
						RTS                                  ;0EB9CD|60      |      ;
	
	
			CODE_0EB9CE:
						LDA.W r_damagActionFlag,X       ;0EB9CE|BD1D06  |0E061D;
						BNE CODE_0EB9ED                      ;0EB9D1|D01A    |0EB9ED;
						LDA.W r_entity_YsubSpd,X           ;0EB9D3|BD3705  |0E0537;
						CLC                                  ;0EB9D6|18      |      ;
						ADC.B #$40                           ;0EB9D7|6940    |      ;
						STA.W r_entity_YsubSpd,X           ;0EB9D9|9D3705  |0E0537;
						LDA.W r_entity_Yspd,X              ;0EB9DC|BD2005  |0E0520;
						ADC.B #$00                           ;0EB9DF|6900    |      ;
						STA.W r_entity_Yspd,X              ;0EB9E1|9D2005  |0E0520;
						JSR.W xSpd_2_Xpos                    ;0EB9E4|2016B9  |0EB916;
						JSR.W ySpd_2_Ypos                    ;0EB9E7|202FB9  |0EB92F;
						JMP.W adjustRoomScroll2_entity                    ;0EB9EA|4C51B9  |0EB951;
		
		
			CODE_0EB9ED:
						LDA.B #$00                           ;0EB9ED|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB9EF|9D3804  |0E0438;
						RTS                                  ;0EB9F2|60      |      ;
		
						CLC                                  ;0EB9F3|18      |      ;
						RTS                                  ;0EB9F4|60      |      ;
  }
	
	
		subWeaponRoutines:
						dw mainAxe                           ;0EAEE0|        |0EAEFE;
						dw mainAxe                           ;0EAEE2|        |0EAEFE;
						dw mainCross                         ;0EAEE4|        |0EAF04;
						dw mainDagger                        ;0EAEE6|        |0EAF0C;
						dw mainHolyWater                     ;0EAEE8|        |0EAF12;
						dw mainFlameThrow                    ;0EAEEA|        |0EAF1A;
						dw mainFreeze                        ;0EAEEC|        |0EAF20;
						dw mainBalls                         ;0EAEEE|        |0EAF26;
						dw mainGrantDagger                   ;0EAEF0|        |0EAF34;
						dw mainGrantAxe                      ;0EAEF2|        |0EAF3A;
						dw mainAlucardAttack                 ;0EAEF4|        |0EAF40;
						dw mainClock                         ;0EAEF6|        |0EAF46;
						dw mainDonno_00                      ;0EAEF8|        |0EAF48;
						dw mainDonno_01                      ;0EAEFA|        |0EAF4E;					
	if !grantNinjaStar					
						dw mainSurikan
	
				
				mainSurikan:
						dw mainSurikan_00         
						dw mainSurikan_01         
						dw mainSurikan_02         
						dw mainSurikan_03  
				
				mainSurikan_00: 
						lda #$01 					; timer 
						STA.W r_entity_AI_IDX,X
						jmp zeroPosAndStates
				
				mainSurikan_01:
						lda #$08 					; timer 
						STA.W r_entity_extra,X						
						jsr axeState_01	
						jsr clearSpeed
						ldy.w r_entity_FacingLeft
						lda shurikanSpeed,y
						sta r_entity_Xspd,x 						
						;lda #$01
						;sta.w r_entity_mask,x 	; collusion bit 
											
						rts 
				shurikanSpeed:
						db $04,$fc

				mainSurikan_02:      							
						dec.w r_entity_extra,X
						lda.w r_entity_extra,X	
						bne mainSurikanLoop
						inc.w r_Player_StateDoubled,x	
						inc.w r_Player_StateDoubled,x
				
				mainSurikanLoop:	
						jsr updateSpriteLoop		
						
						lda #$34					; speed value 
						sta $00
						
						lda.w r_entity_XPos,x 		; X wave compare against player pos 
						cmp.w r_entity_XPos
						bcc +
				
						jsr substrac_Xspeed
						jmp ++
					+	jsr add_Xspeed
					++
					
						lda.w r_entity_YPos,x 		; Y wave compare against player pos 
						cmp.w r_entity_YPos
						bcc +
			
						jsr substrac_ySpeed
						jmp ++
					+	jsr add_Yspeed
					++	
						jsr mainDagger_02
						
;						txa 
;						pha 
;						jsr getDistance_yPos
;						tay 
;						jsr showHUDnumber_addressInY
;						pla 
;						tax 
 						
						jmp currentScreenBoundry
				
							
				mainSurikan_03:
						jsr mainSurikanLoop
						jsr clearShurikanWhenTouching
						rts 
				clearShurikanWhenTouching:					
						jmp crossState_03
						
				throwAnimRoutine:
						dec.w r_entity_AnimTimer,x 
						lda.w r_entity_AnimTimer,x 
						lda #$24 
	
						sta.w r_entity_spriteID			
						rts 
	endif 
	
					mainSubweaponPointer:	
						dw mainSubweapon-1
						
				mainAxe:
						dw initThrowSubweapon_00             ;0EAEFE|        |0EB45C;
						dw axeState_01                       ;0EAF00|        |0EB495;
						dw axeState_02                       ;0EAF02|        |0EB4D7;
	
				mainCross:
						dw initThrowSubweapon_00             ;0EAF04|        |0EB45C;
	
						dw crossState_01                     ;0EAF06|        |0EB4F4;
						dw crossState_02                     ;0EAF08|        |0EB52D;
						dw crossState_03                     ;0EAF0A|        |0EB56F;
	
			mainDagger:
						dw initThrowSubweapon_00             ;0EAF0C|        |0EB45C;
						dw mainDagger_01                     ;0EAF0E|        |0EB6B2;
						dw mainDagger_02                     ;0EAF10|        |0EB6F4;
	
			mainHolyWater:
						dw initThrowSubweapon_00             ;0EAF12|        |0EB45C;
						dw holyWaterState_01                 ;0EAF14|        |0EB752;
						dw holyWaterState_02                 ;0EAF16|        |0EB792;
						dw holyWaterState_03                 ;0EAF18|        |0EB7D0;
	
		mainFlameThrow:
						dw initThrowSubweapon_00             ;0EAF1A|        |0EB45C;
						dw flameThrowState_01                ;0EAF1C|        |0EB390;
						dw flameThrowState_02                ;0EAF1E|        |0EB3DC;
	
			mainFreeze:
						dw freezSpellState_00                ;0EAF20|        |0EB7EA;
						dw freezSpellState_01                ;0EAF22|        |0EB823;
						dw freezSpellState_02                ;0EAF24|        |0EB8A4;
	
				mainBalls:
						dw ballState_00                      ;0EAF26|        |0EB03A;
						dw ballState_01                      ;0EAF28|        |0EB073;
						dw ballState_02                      ;0EAF2A|        |0EB0FA;
						dw ballState_03                      ;0EAF2C|        |0EB136;
						dw ballState_04                      ;0EAF2E|        |0EB17D;
						dw ballState_05                      ;0EAF30|        |0EB1F6;
						dw ballState_06                      ;0EAF32|        |0EB246;
	
	
			if !grantDaggerSpiderSilkFreez == 1		
			mainGrantDagger:			
            dw initThrowSubweapon_00             
						dw grantDagger_state_01              		
						dw mainDagger_ice
			
      mainGrantAxe:
						dw initThrowSubweapon_00            
						dw grantAxe_state_01                
						dw newAxe           ; axeState_02   
            dw newAxeGround_03 
      
      ;			dw initThrowSubweapon_00             
			;			dw grantDagger_state_01			
			;			dw mainDagger_ice					;!daggerHolyFreez ; a alternative subweapon 
			;			dw holyWaterState_03				;!daggerHolyFreez ; a alternative subweapon 
      
      else 				
				mainGrantDagger:			
            dw initThrowSubweapon_00             ;0EAF34|        |0EB45C;
						dw grantDagger_state_01              ;0EAF36|        |0EB62A;						
						dw mainDagger_02                     ;0EAF38|        |0EB6F4;
			
			mainGrantAxe:
						dw initThrowSubweapon_00             ;0EAF3A|        |0EB45C;
						dw grantAxe_state_01                 ;0EAF3C|        |0EB5B9;
						dw axeState_02                       ;0EAF3E|        |0EB4D7;
      endif
		
    
    mainAlucardAttack:
						dw initThrowSubweapon_00             ;0EAF40|        |0EB45C;
						dw alucardAttackState_01             ;0EAF42|        |0EAF77;
						dw alucardAttackState_02             ;0EAF44|        |0EAFEA;
	
				mainClock:
						dw clockState_rts                    ;0EAF46|        |0EAF66;


			mainDonno_00:
						dw donno_00_state_00                 ;0EAF48|        |0EB99F;
						dw donno_state_01                    ;0EAF4A|        |0EB9BA;
						dw donno_state_03                    ;0EAF4C|        |0EB9C0;
	
			mainDonno_01:
						dw donno_01_state_00                       ;0EAF4E|        |0EB984;
						dw donno_state_01                    ;0EAF50|        |0EB9BA;
						dw donno_state_03                    ;0EAF52|        |0EB9C0;
	
			
			getThrowWeaponStats:
						JSR.W throwSubweaponRelated               ;0EAF54|2055BC  |0EBC55;			
            INC.W r_Player_StateDoubled,X      ;0EAF57|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EAF5A|FE6505  |0E0565;
						LDY.W r_entity_ID,X       ;0EAF5D|BC4E05  |0E054E;
						LDA.W weaponDamage,Y              ;0EAF60|B967AF  |0EAF67;
						STA.W r_entity_target,X        ;0EAF63|9D0606  |0E0606;
	
		clockState_rts:
						RTS                                  ;0EAF66|60      |      ;
	
	
		weaponDamage:
						db $00		  ; mainAxe               
						db $60      ; mainAxe               
						db $60      ; mainCross             
						db $40      ; mainDagger            
						db $30      ; mainHolyWater         
						db $C0      ; mainFlameThrow        
						db $02      ; mainFreeze            
						db $C0      ; mainBalls             
						db $40      ; mainGrantDagger       
			if !grantDaggerSpiderSilkFreez == 1			
            db $50      ; groundShurikan
      else     
            db $60      ; mainGrantAxe          
			endif 			
            db $20      ; mainAlucardAttack     
						db $00      ; mainClock             
						db $00      ; mainDonno_00          
						db $00      ; mainDonno_01          		
						db $50		  ; grant shurikan 
	
	
	
	alucardAttackState_01:
						DEC.W r_entity_AI_IDX,X        ;0EAF77|DEC105  |0E05C1;
						BNE clockState_rts                   ;0EAF7A|D0EA    |0EAF66;
						LDA.W r_entity_extra,X             ;0EAF7C|BDD805  |0E05D8;
						BNE CODE_0EAF86                      ;0EAF7F|D005    |0EAF86;
						LDA.B #$1F                           ;0EAF81|A91F    |      ;
						db $20                               ;0EAF83|        |      ;
						dw lunchMusic                        ;0EAF84|        |0FE25F;
	
			CODE_0EAF86:
						LDA.B #$06                           ;0EAF86|A906    |      ;
						LDY.B #$0B                           ;0EAF88|A00B    |      ;
						db $20                               ;0EAF8A|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EAF8B|        |0FEF5C;
						LDY.B r_index                        ;0EAF8D|A410    |000010;
						LDA.W r_entity_FacingLeft,Y        ;0EAF8F|B9A804  |0E04A8;
						STA.B $00                            ;0EAF92|8500    |000000;
						LDY.B #$00                           ;0EAF94|A000    |      ;
						LDA.W alucarShotsSpawnData,Y         ;0EAF96|B906B0  |0EB006;
						STA.B r_pointerQueue                 ;0EAF99|8508    |000008;
						LDA.W alucarShotsSpawnData+1,Y                 ;0EAF9B|B907B0  |0EB007;
						STA.B $09                            ;0EAF9E|8509    |000009;
						LDA.W r_entity_extra,X             ;0EAFA0|BDD805  |0E05D8;
						ASL A                                ;0EAFA3|0A      |      ;
						ASL A                                ;0EAFA4|0A      |      ;
						TAY                                  ;0EAFA5|A8      |      ;
						LDA.B $00                            ;0EAFA6|A500    |000000;
						BEQ CODE_0EAFAF                      ;0EAFA8|F005    |0EAFAF;
						TYA                                  ;0EAFAA|98      |      ;
						CLC                                  ;0EAFAB|18      |      ;
						ADC.B #$0C                           ;0EAFAC|690C    |      ;
						TAY                                  ;0EAFAE|A8      |      ;
	
			CODE_0EAFAF:
						LDA.B (r_pointerQueue),Y             ;0EAFAF|B108    |000008;
						STA.W r_entity_XsubSpd,X           ;0EAFB1|9D0905  |0E0509;
						INY                                  ;0EAFB4|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EAFB5|B108    |000008;
						STA.W r_entity_Xspd,X              ;0EAFB7|9DF204  |0E04F2;
						INY                                  ;0EAFBA|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EAFBB|B108    |000008;
						STA.W r_entity_YsubSpd,X           ;0EAFBD|9D3705  |0E0537;
						INY                                  ;0EAFC0|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EAFC1|B108    |000008;
						STA.W r_entity_Yspd,X              ;0EAFC3|9D2005  |0E0520;
						LDA.B #$00                           ;0EAFC6|A900    |      ;
						STA.W r_entity_FacingLeft,X        ;0EAFC8|9DA804  |0E04A8;
						LDY.B r_index                        ;0EAFCB|A410    |000010;
						LDA.W r_entity_XPos,Y              ;0EAFCD|B93804  |0E0438;
						STA.W r_entity_XPos,X              ;0EAFD0|9D3804  |0E0438;
						LDA.W r_entity_YPos,Y              ;0EAFD3|B91C04  |0E041C;
						LDY.B r_collisionPointXvalDiv32      ;0EAFD6|A412    |000012;
						CPY.B #$07                           ;0EAFD8|C007    |      ;
						BNE CODE_0EAFDF                      ;0EAFDA|D003    |0EAFDF;
						CLC                                  ;0EAFDC|18      |      ;
						ADC.B #$06                           ;0EAFDD|6906    |      ;
	
			CODE_0EAFDF:
						STA.W r_entity_YPos,X              ;0EAFDF|9D1C04  |0E041C;
						LDA.B #$18                           ;0EAFE2|A918    |      ;
						STA.W r_entity_AI_IDX,X        ;0EAFE4|9DC105  |0E05C1;
						JMP.W getThrowWeaponStats                    ;0EAFE7|4C54AF  |0EAF54;
	
	
	alucardAttackState_02:
						LDA.W r_damagActionFlag,X       ;0EAFEA|BD1D06  |0E061D;
						BNE CODE_0EB000                      ;0EAFED|D011    |0EB000;
						DEC.W r_entity_AI_IDX,X        ;0EAFEF|DEC105  |0E05C1;
						BEQ CODE_0EB000                      ;0EAFF2|F00C    |0EB000;
						db $20                               ;0EAFF4|        |      ;
						dw updateSpriteLoop                  ;0EAFF5|        |0FEF75;
						JSR.W xSpd_2_Xpos                    ;0EAFF7|2016B9  |0EB916;
						JSR.W ySpd_2_Ypos                    ;0EAFFA|202FB9  |0EB92F;
						JMP.W adjustRoomScroll2_entity                    ;0EAFFD|4C51B9  |0EB951;
	
	
			CODE_0EB000:
						LDA.B #$00                           ;0EB000|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB002|9D3804  |0E0438;
						RTS                                  ;0EB005|60      |      ;
	
	
	alucarShotsSpawnData:
						dw alucarShotsSpawnData_00           ;0EB006|        |0EB00A;
						dw alucarShotsSpawnData_01           ;0EB008|        |0EB022;
	
	alucarShotsSpawnData_00:
						db $80,$04,$00,$00,$26,$04,$4C,$FE   ;0EB00A|        |      ;
						db $26,$04,$B4,$01,$80,$FB,$00,$00   ;0EB012|        |      ;
						db $DA,$FB,$4C,$FE,$DA,$FB,$B4,$01   ;0EB01A|        |      ;
	
	alucarShotsSpawnData_01:
						db $00,$05,$00,$00,$9C,$04,$1B,$FE   ;0EB022|        |      ;
						db $9C,$04,$E5,$01,$00,$FB,$00,$00   ;0EB02A|        |      ;
						db $64,$FB,$1B,$FE,$64,$FB,$E5,$01   ;0EB032|        |      ;
	
			ballState_00:
						JSR.W spawnSubweapon                 ;0EB03A|206EB4  |0EB46E;
						CLC                                  ;0EB03D|18      |      ;
						ADC.B #$01                           ;0EB03E|6901    |      ;
						STA.W $05C2,X                        ;0EB040|9DC205  |0E05C2;
						STA.W $05C3,X                        ;0EB043|9DC305  |0E05C3;
						LDA.B #$00                           ;0EB046|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB048|9D3804  |0E0438;
						STA.W $0439,X                        ;0EB04B|9D3904  |0E0439;
						STA.W $043A,X                        ;0EB04E|9D3A04  |0E043A;
						STA.W r_entity_YPos,X              ;0EB051|9D1C04  |0E041C;
						STA.W $041D,X                        ;0EB054|9D1D04  |0E041D;
						STA.W $041E,X                        ;0EB057|9D1E04  |0E041E;
						INC.W r_Player_StateDoubled,X      ;0EB05A|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB05D|FE6505  |0E0565;
						LDA.W r_entity_ID,X       ;0EB060|BD4E05  |0E054E;
						STA.W $054F,X                        ;0EB063|9D4F05  |0E054F;
						STA.W $0550,X                        ;0EB066|9D5005  |0E0550;
						LDA.W r_Player_StateDoubled,X      ;0EB069|BD6505  |0E0565;
						STA.W $0566,X                        ;0EB06C|9D6605  |0E0566;
						STA.W $0567,X                        ;0EB06F|9D6705  |0E0567;
	
			CODE_0EB072:
						RTS                                  ;0EB072|60      |      ;
	
	
			ballState_01:
						DEC.W r_entity_AI_IDX,X        ;0EB073|DEC105  |0E05C1;
						BNE CODE_0EB072                      ;0EB076|D0FA    |0EB072;
						CPX.B #$14                           ;0EB078|E014    |      ;
						BNE CODE_0EB081                      ;0EB07A|D005    |0EB081;
						LDA.B #$1E                           ;0EB07C|A91E    |      ;
						db $20                               ;0EB07E|        |      ;
						dw lunchMusic                        ;0EB07F|        |0FE25F;
	
			CODE_0EB081:
						LDA.W r_entity_XPos                ;0EB081|AD3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB084|9D3804  |0E0438;
						LDA.W r_entity_YPos                ;0EB087|AD1C04  |0E041C;
						STA.W r_entity_YPos,X              ;0EB08A|9D1C04  |0E041C;
						LDA.B #$00                           ;0EB08D|A900    |      ;
						STA.W r_damagActionFlag,X       ;0EB08F|9D1D06  |0E061D;
						CPX.B #$14                           ;0EB092|E014    |      ;
						BNE CODE_0EB09B                      ;0EB094|D005    |0EB09B;
						JSR.W CODE_0EB0AC                    ;0EB096|20ACB0  |0EB0AC;
						LDX.B #$14                           ;0EB099|A214    |      ;
	
			CODE_0EB09B:
						TXA                                  ;0EB09B|8A      |      ;
						SEC                                  ;0EB09C|38      |      ;
						SBC.B #$14                           ;0EB09D|E914    |      ;
						TAY                                  ;0EB09F|A8      |      ;
						LDA.W DATA8_0EB0A9,Y                 ;0EB0A0|B9A9B0  |0EB0A9;
						STA.W r_entity_AI_IDX,X        ;0EB0A3|9DC105  |0E05C1;
						JMP.W getThrowWeaponStats                    ;0EB0A6|4C54AF  |0EAF54;
	
	
			DATA8_0EB0A9:
						db $03,$02,$01                       ;0EB0A9|        |      ;
	
			CODE_0EB0AC:
						LDA.B #$00                           ;0EB0AC|A900    |      ;
						STA.B r_pointerQueue                 ;0EB0AE|8508    |000008;
						LDY.B #$01                           ;0EB0B0|A001    |      ;
	
			CODE_0EB0B2:
						LDA.W r_entity_ID,Y       ;0EB0B2|B94E05  |0E054E;
						BNE CODE_0EB0C7                      ;0EB0B5|D010    |0EB0C7;
	
			CODE_0EB0B7:
						INY                                  ;0EB0B7|C8      |      ;
						CPY.B #$0D                           ;0EB0B8|C00D    |      ;
						BCC CODE_0EB0B2                      ;0EB0BA|90F6    |0EB0B2;
						LDA.B #$FF                           ;0EB0BC|A9FF    |      ;
	
			CODE_0EB0BE:
						STA.W r_entity_extra,X             ;0EB0BE|9DD805  |0E05D8;
						INX                                  ;0EB0C1|E8      |      ;
						CPX.B #$17                           ;0EB0C2|E017    |      ;
						BCC CODE_0EB0BE                      ;0EB0C4|90F8    |0EB0BE;
						RTS                                  ;0EB0C6|60      |      ;
	
	
			CODE_0EB0C7:
						LDA.W r_entity_mask,Y            ;0EB0C7|B97004  |0E0470;
						BMI CODE_0EB0B7                      ;0EB0CA|30EB    |0EB0B7;
						LDA.W r_entity_XPos,Y              ;0EB0CC|B93804  |0E0438;
						SEC                                  ;0EB0CF|38      |      ;
						SBC.W r_entity_XPos,X              ;0EB0D0|FD3804  |0E0438;
						BCS CODE_0EB0DA                      ;0EB0D3|B005    |0EB0DA;
						EOR.B #$FF                           ;0EB0D5|49FF    |      ;
						CLC                                  ;0EB0D7|18      |      ;
						ADC.B #$01                           ;0EB0D8|6901    |      ;
	
			CODE_0EB0DA:
						CMP.B #$40                           ;0EB0DA|C940    |      ;
						BCS CODE_0EB0B7                      ;0EB0DC|B0D9    |0EB0B7;
						LDA.W r_entity_YPos,Y              ;0EB0DE|B91C04  |0E041C;
						SEC                                  ;0EB0E1|38      |      ;
						SBC.W r_entity_YPos,X              ;0EB0E2|FD1C04  |0E041C;
						BCS CODE_0EB0EC                      ;0EB0E5|B005    |0EB0EC;
						EOR.B #$FF                           ;0EB0E7|49FF    |      ;
						CLC                                  ;0EB0E9|18      |      ;
						ADC.B #$01                           ;0EB0EA|6901    |      ;
	
			CODE_0EB0EC:
						CMP.B #$80                           ;0EB0EC|C980    |      ;
						BCS CODE_0EB0B7                      ;0EB0EE|B0C7    |0EB0B7;
						TYA                                  ;0EB0F0|98      |      ;
						STA.W r_entity_extra,X             ;0EB0F1|9DD805  |0E05D8;
						INX                                  ;0EB0F4|E8      |      ;
						CPX.B #$17                           ;0EB0F5|E017    |      ;
						BCS CODE_0EB0B7                      ;0EB0F7|B0BE    |0EB0B7;
	
			CODE_0EB0F9:
						RTS                                  ;0EB0F9|60      |      ;
	
	
			ballState_02:
						LDA.W r_entity_extra,X             ;0EB0FA|BDD805  |0E05D8;
						BMI CODE_0EB106                      ;0EB0FD|3007    |0EB106;
	
			CODE_0EB0FF:
						INC.W r_Player_StateDoubled,X      ;0EB0FF|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB102|FE6505  |0E0565;
						RTS                                  ;0EB105|60      |      ;
	
	
			CODE_0EB106:
						JSR.W CODE_0EB112                    ;0EB106|2012B1  |0EB112;
						BCS CODE_0EB0FF                      ;0EB109|B0F4    |0EB0FF;
						TYA                                  ;0EB10B|98      |      ;
						STA.W r_entity_extra,X             ;0EB10C|9DD805  |0E05D8;
						JMP.W CODE_0EB0FF                    ;0EB10F|4CFFB0  |0EB0FF;
	
	
			CODE_0EB112:
						LDY.B #$01                           ;0EB112|A001    |      ;
	
			CODE_0EB114:
						LDA.W r_entity_ID,Y       ;0EB114|B94E05  |0E054E;
						BNE CODE_0EB120                      ;0EB117|D007    |0EB120;
	
			CODE_0EB119:
						INY                                  ;0EB119|C8      |      ;
						CPY.B #$0D                           ;0EB11A|C00D    |      ;
						BCC CODE_0EB114                      ;0EB11C|90F6    |0EB114;
						SEC                                  ;0EB11E|38      |      ;
						RTS                                  ;0EB11F|60      |      ;
	
	
			CODE_0EB120:
						LDA.W r_entity_mask,Y            ;0EB120|B97004  |0E0470;
						BMI CODE_0EB119                      ;0EB123|30F4    |0EB119;
						CPY.W $05EC                          ;0EB125|CCEC05  |0E05EC;
						BEQ CODE_0EB119                      ;0EB128|F0EF    |0EB119;
						CPY.W $05ED                          ;0EB12A|CCED05  |0E05ED;
						BEQ CODE_0EB119                      ;0EB12D|F0EA    |0EB119;
						CPY.W $05EE                          ;0EB12F|CCEE05  |0E05EE;
						BEQ CODE_0EB119                      ;0EB132|F0E5    |0EB119;
						CLC                                  ;0EB134|18      |      ;
						RTS                                  ;0EB135|60      |      ;
	
	
			ballState_03:
						DEC.W r_entity_AI_IDX,X        ;0EB136|DEC105  |0E05C1;
						BNE CODE_0EB0F9                      ;0EB139|D0BE    |0EB0F9;
						LDA.B #$02                           ;0EB13B|A902    |      ;
						LDY.B #$0A                           ;0EB13D|A00A    |      ;
						db $20                               ;0EB13F|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EB140|        |0FEF5C;
						LDA.W DATA8_0EB17A                   ;0EB142|AD7AB1  |0EB17A;
						STA.W r_entity_AI_IDX,X        ;0EB145|9DC105  |0E05C1;
						LDA.B #$01                           ;0EB148|A901    |      ;
						STA.W r_entity_XsubSpd,X           ;0EB14A|9D0905  |0E0509;
						TXA                                  ;0EB14D|8A      |      ;
						SEC                                  ;0EB14E|38      |      ;
						SBC.B #$14                           ;0EB14F|E914    |      ;
						TAY                                  ;0EB151|A8      |      ;
						LDA.W r_entity_FacingLeft          ;0EB152|ADA804  |0E04A8;
						BEQ CODE_0EB15A                      ;0EB155|F003    |0EB15A;
						INY                                  ;0EB157|C8      |      ;
						INY                                  ;0EB158|C8      |      ;
						INY                                  ;0EB159|C8      |      ;
	
			CODE_0EB15A:
						LDA.W DATA8_0EB174,Y                 ;0EB15A|B974B1  |0EB174;
						STA.W r_entity_AI,X            ;0EB15D|9DEF05  |0E05EF;
						LDA.B #$00                           ;0EB160|A900    |      ;
						STA.W r_entity_FacingLeft,X        ;0EB162|9DA804  |0E04A8;
						LDA.W r_entity_XPos                ;0EB165|AD3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB168|9D3804  |0E0438;
						LDA.W r_entity_YPos                ;0EB16B|AD1C04  |0E041C;
						STA.W r_entity_YPos,X              ;0EB16E|9D1C04  |0E041C;
						JMP.W getThrowWeaponStats                    ;0EB171|4C54AF  |0EAF54;
	
	
			DATA8_0EB174:
						db $00,$04,$1C,$10,$0C,$14           ;0EB174|        |      ;
	
			DATA8_0EB17A:
						db $10                               ;0EB17A|        |      ;
	
			DATA8_0EB17B:
						db $10                               ;0EB17B|        |      ;
	
			DATA8_0EB17C:
						db $02                               ;0EB17C|        |      ;
	
			ballState_04:
						DEC.W r_entity_AI_IDX,X        ;0EB17D|DEC105  |0E05C1;
						BEQ CODE_0EB195                      ;0EB180|F013    |0EB195;
	
			DATA8_0EB182:
						db $20                               ;0EB182|        |      ;
						dw updateSpriteLoop                  ;0EB183|        |0FEF75;
						JSR.W CODE_0EB2BB                    ;0EB185|20BBB2  |0EB2BB;
						JSR.W CODE_0EB30A                    ;0EB188|200AB3  |0EB30A;
						JMP.W adjustRoomScroll2_entity                    ;0EB18B|4C51B9  |0EB951;
	
	
			CODE_0EB18E:
						LDA.B #$FF                           ;0EB18E|A9FF    |      ;
						STA.W r_entity_extra,X             ;0EB190|9DD805  |0E05D8;
						BNE DATA8_0EB182                     ;0EB193|D0ED    |0EB182;
	
			CODE_0EB195:
						LDY.W r_entity_extra,X             ;0EB195|BCD805  |0E05D8;
						BMI DATA8_0EB182                     ;0EB198|30E8    |0EB182;
						BEQ DATA8_0EB182                     ;0EB19A|F0E6    |0EB182;
						LDA.W r_entity_ID,Y       ;0EB19C|B94E05  |0E054E;
						BEQ CODE_0EB18E                      ;0EB19F|F0ED    |0EB18E;
						LDA.W r_entity_mask,Y            ;0EB1A1|B97004  |0E0470;
						BMI CODE_0EB18E                      ;0EB1A4|30E8    |0EB18E;
						LDA.W r_damagActionFlag,X       ;0EB1A6|BD1D06  |0E061D;
						BNE CODE_0EB18E                      ;0EB1A9|D0E3    |0EB18E;
						LDA.B #$00                           ;0EB1AB|A900    |      ;
						STA.B r_pointerQueue                 ;0EB1AD|8508    |000008;
						LDA.W r_entity_XPos,Y              ;0EB1AF|B93804  |0E0438;
						SEC                                  ;0EB1B2|38      |      ;
						SBC.W r_entity_XPos,X              ;0EB1B3|FD3804  |0E0438;
						BCS CODE_0EB1C1                      ;0EB1B6|B009    |0EB1C1;
						EOR.B #$FF                           ;0EB1B8|49FF    |      ;
						CLC                                  ;0EB1BA|18      |      ;
						ADC.B #$01                           ;0EB1BB|6901    |      ;
						INC.B r_pointerQueue                 ;0EB1BD|E608    |000008;
						INC.B r_pointerQueue                 ;0EB1BF|E608    |000008;
	
			CODE_0EB1C1:
						STA.B $09                            ;0EB1C1|8509    |000009;
						LDA.W r_entity_YPos,Y              ;0EB1C3|B91C04  |0E041C;
						SEC                                  ;0EB1C6|38      |      ;
						SBC.W r_entity_YPos,X              ;0EB1C7|FD1C04  |0E041C;
						BCS CODE_0EB1D3                      ;0EB1CA|B007    |0EB1D3;
						EOR.B #$FF                           ;0EB1CC|49FF    |      ;
						CLC                                  ;0EB1CE|18      |      ;
						ADC.B #$01                           ;0EB1CF|6901    |      ;
						INC.B r_pointerQueue                 ;0EB1D1|E608    |000008;
	
			CODE_0EB1D3:
						STA.B $01                            ;0EB1D3|8501    |000001;
						LDA.B $09                            ;0EB1D5|A509    |000009;
						LDY.B #$00                           ;0EB1D7|A000    |      ;
						STY.B $00                            ;0EB1D9|8400    |000000;
						JSR.W CODE_0EAE0D                    ;0EB1DB|200DAE  |0EAE0D;
						LDA.B $01                            ;0EB1DE|A501    |000001;
						STA.W r_entity_Yspd,X              ;0EB1E0|9D2005  |0E0520;
						LDA.B $00                            ;0EB1E3|A500    |000000;
						STA.W r_entity_YsubSpd,X           ;0EB1E5|9D3705  |0E0537;
						LDA.B r_pointerQueue                 ;0EB1E8|A508    |000008;
						STA.W r_entity_Xspd,X              ;0EB1EA|9DF204  |0E04F2;
						INC.W r_Player_StateDoubled,X      ;0EB1ED|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB1F0|FE6505  |0E0565;
						JMP.W DATA8_0EB182                   ;0EB1F3|4C82B1  |0EB182;
	
	
			ballState_05:
						JSR.W CODE_0EB208                    ;0EB1F6|2008B2  |0EB208;
						INC.W r_Player_StateDoubled,X      ;0EB1F9|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB1FC|FE6505  |0E0565;
						LDA.W DATA8_0EB17C                   ;0EB1FF|AD7CB1  |0EB17C;
						STA.W r_entity_Yspd,X              ;0EB202|9D2005  |0E0520;
						JMP.W DATA8_0EB182                   ;0EB205|4C82B1  |0EB182;
	
	
			CODE_0EB208:
						LDY.B #$00                           ;0EB208|A000    |      ;
	
			CODE_0EB20A:
						LDA.W r_entity_Yspd,X              ;0EB20A|BD2005  |0E0520;
						CMP.W DATA8_0EB37E,Y                 ;0EB20D|D97EB3  |0EB37E;
						BCC CODE_0EB224                      ;0EB210|9012    |0EB224;
						BNE CODE_0EB21E                      ;0EB212|D00A    |0EB21E;
						LDA.W r_entity_YsubSpd,X           ;0EB214|BD3705  |0E0537;
						CMP.W DATA8_0EB37F,Y                 ;0EB217|D97FB3  |0EB37F;
						BCC CODE_0EB224                      ;0EB21A|9008    |0EB224;
						BEQ CODE_0EB224                      ;0EB21C|F006    |0EB224;
	
			CODE_0EB21E:
						INY                                  ;0EB21E|C8      |      ;
						INY                                  ;0EB21F|C8      |      ;
						CPY.B #$10                           ;0EB220|C010    |      ;
						BCC CODE_0EB20A                      ;0EB222|90E6    |0EB20A;
	
			CODE_0EB224:
						TYA                                  ;0EB224|98      |      ;
						LSR A                                ;0EB225|4A      |      ;
						STA.B $00                            ;0EB226|8500    |000000;
						LDY.W r_entity_Xspd,X              ;0EB228|BCF204  |0E04F2;
						BEQ CODE_0EB242                      ;0EB22B|F015    |0EB242;
						DEY                                  ;0EB22D|88      |      ;
						BEQ CODE_0EB23D                      ;0EB22E|F00D    |0EB23D;
						DEY                                  ;0EB230|88      |      ;
						BEQ CODE_0EB239                      ;0EB231|F006    |0EB239;
						CLC                                  ;0EB233|18      |      ;
						ADC.B #$10                           ;0EB234|6910    |      ;
						JMP.W CODE_0EB242                    ;0EB236|4C42B2  |0EB242;
	
	
			CODE_0EB239:
						LDA.B #$10                           ;0EB239|A910    |      ;
						BNE CODE_0EB23F                      ;0EB23B|D002    |0EB23F;
	
			CODE_0EB23D:
						LDA.B #$20                           ;0EB23D|A920    |      ;
	
			CODE_0EB23F:
						SEC                                  ;0EB23F|38      |      ;
						SBC.B $00                            ;0EB240|E500    |000000;
	
			CODE_0EB242:
						STA.W r_entity_Xspd,X              ;0EB242|9DF204  |0E04F2;
						RTS                                  ;0EB245|60      |      ;
	
	
			ballState_06:
						JSR.W CODE_0EB259                    ;0EB246|2059B2  |0EB259;
						BCC CODE_0EB256                      ;0EB249|900B    |0EB256;
						LDA.W DATA8_0EB17B                   ;0EB24B|AD7BB1  |0EB17B;
						STA.W r_entity_AI_IDX,X        ;0EB24E|9DC105  |0E05C1;
						LDA.B #$08                           ;0EB251|A908    |      ;
						STA.W r_Player_StateDoubled,X      ;0EB253|9D6505  |0E0565;
	
			CODE_0EB256:
						JMP.W DATA8_0EB182                   ;0EB256|4C82B1  |0EB182;
	
	
			CODE_0EB259:
						DEC.W r_entity_Yspd,X              ;0EB259|DE2005  |0E0520;
						BNE CODE_0EB297                      ;0EB25C|D039    |0EB297;
						LDA.W DATA8_0EB17C                   ;0EB25E|AD7CB1  |0EB17C;
						STA.W r_entity_Yspd,X              ;0EB261|9D2005  |0E0520;
						LDA.W r_entity_Xspd,X              ;0EB264|BDF204  |0E04F2;
						SEC                                  ;0EB267|38      |      ;
						SBC.W r_entity_AI,X            ;0EB268|FDEF05  |0E05EF;
						STA.B $00                            ;0EB26B|8500    |000000;
						BCS CODE_0EB27A                      ;0EB26D|B00B    |0EB27A;
						CMP.B #$F0                           ;0EB26F|C9F0    |      ;
						BCC CODE_0EB299                      ;0EB271|9026    |0EB299;
						LDA.B #$00                           ;0EB273|A900    |      ;
						SEC                                  ;0EB275|38      |      ;
						SBC.B $00                            ;0EB276|E500    |000000;
						BCC CODE_0EB283                      ;0EB278|9009    |0EB283;
	
			CODE_0EB27A:
						CMP.B #$11                           ;0EB27A|C911    |      ;
						BCC CODE_0EB29C                      ;0EB27C|901E    |0EB29C;
						LDA.B #$20                           ;0EB27E|A920    |      ;
						SEC                                  ;0EB280|38      |      ;
						SBC.B $00                            ;0EB281|E500    |000000;
	
			CODE_0EB283:
						CMP.W r_entity_XsubSpd,X           ;0EB283|DD0905  |0E0509;
						BCC CODE_0EB2B3                      ;0EB286|902B    |0EB2B3;
						LDA.W r_entity_AI,X            ;0EB288|BDEF05  |0E05EF;
						SEC                                  ;0EB28B|38      |      ;
						SBC.W r_entity_XsubSpd,X           ;0EB28C|FD0905  |0E0509;
						BPL CODE_0EB294                      ;0EB28F|1003    |0EB294;
						SEC                                  ;0EB291|38      |      ;
						SBC.B #$E0                           ;0EB292|E9E0    |      ;
	
			CODE_0EB294:
						STA.W r_entity_AI,X            ;0EB294|9DEF05  |0E05EF;
	
			CODE_0EB297:
						CLC                                  ;0EB297|18      |      ;
						RTS                                  ;0EB298|60      |      ;
	
	
			CODE_0EB299:
						SEC                                  ;0EB299|38      |      ;
						SBC.B #$E0                           ;0EB29A|E9E0    |      ;
	
			CODE_0EB29C:
						CMP.W r_entity_XsubSpd,X           ;0EB29C|DD0905  |0E0509;
						BCC CODE_0EB2B3                      ;0EB29F|9012    |0EB2B3;
						LDA.W r_entity_AI,X            ;0EB2A1|BDEF05  |0E05EF;
						CLC                                  ;0EB2A4|18      |      ;
						ADC.W r_entity_XsubSpd,X           ;0EB2A5|7D0905  |0E0509;
						CMP.B #$20                           ;0EB2A8|C920    |      ;
						BCC CODE_0EB2AE                      ;0EB2AA|9002    |0EB2AE;
						SBC.B #$20                           ;0EB2AC|E920    |      ;
	
			CODE_0EB2AE:
						STA.W r_entity_AI,X            ;0EB2AE|9DEF05  |0E05EF;
						CLC                                  ;0EB2B1|18      |      ;
						RTS                                  ;0EB2B2|60      |      ;
	
	
			CODE_0EB2B3:
						LDA.W r_entity_Xspd,X              ;0EB2B3|BDF204  |0E04F2;
						STA.W r_entity_AI,X            ;0EB2B6|9DEF05  |0E05EF;
						SEC                                  ;0EB2B9|38      |      ;
						RTS                                  ;0EB2BA|60      |      ;
	
	
			CODE_0EB2BB:
						LDA.W r_entity_AI,X            ;0EB2BB|BDEF05  |0E05EF;
						CMP.B #$08                           ;0EB2BE|C908    |      ;
						BCC CODE_0EB2F4                      ;0EB2C0|9032    |0EB2F4;
						CMP.B #$10                           ;0EB2C2|C910    |      ;
						BCC CODE_0EB2DB                      ;0EB2C4|9015    |0EB2DB;
						CMP.B #$18                           ;0EB2C6|C918    |      ;
						BCC CODE_0EB2D2                      ;0EB2C8|9008    |0EB2D2;
						LDA.B #$20                           ;0EB2CA|A920    |      ;
						SEC                                  ;0EB2CC|38      |      ;
						SBC.W r_entity_AI,X            ;0EB2CD|FDEF05  |0E05EF;
						BNE CODE_0EB2F4                      ;0EB2D0|D022    |0EB2F4;
	
			CODE_0EB2D2:
						LDA.B #$18                           ;0EB2D2|A918    |      ;
						SEC                                  ;0EB2D4|38      |      ;
						SBC.W r_entity_AI,X            ;0EB2D5|FDEF05  |0E05EF;
						JMP.W CODE_0EB2DE                    ;0EB2D8|4CDEB2  |0EB2DE;
	
	
			CODE_0EB2DB:
						SEC                                  ;0EB2DB|38      |      ;
						SBC.B #$08                           ;0EB2DC|E908    |      ;
	
			CODE_0EB2DE:
						ASL A                                ;0EB2DE|0A      |      ;
						TAY                                  ;0EB2DF|A8      |      ;
						SEC                                  ;0EB2E0|38      |      ;
						LDA.W r_entity_FractionalX,X       ;0EB2E1|BDC404  |0E04C4;
						SBC.W DATA8_0EB36D,Y                 ;0EB2E4|F96DB3  |0EB36D;
						STA.W r_entity_FractionalX,X       ;0EB2E7|9DC404  |0E04C4;
						LDA.W r_entity_XPos,X              ;0EB2EA|BD3804  |0E0438;
						SBC.W DATA8_0EB36C,Y                 ;0EB2ED|F96CB3  |0EB36C;
						STA.W r_entity_XPos,X              ;0EB2F0|9D3804  |0E0438;
						RTS                                  ;0EB2F3|60      |      ;
	
	
			CODE_0EB2F4:
						ASL A                                ;0EB2F4|0A      |      ;
						TAY                                  ;0EB2F5|A8      |      ;
						CLC                                  ;0EB2F6|18      |      ;
						LDA.W DATA8_0EB35B,Y                 ;0EB2F7|B95BB3  |0EB35B;
						ADC.W r_entity_FractionalX,X       ;0EB2FA|7DC404  |0E04C4;
						STA.W r_entity_FractionalX,X       ;0EB2FD|9DC404  |0E04C4;
						LDA.W DATA8_0EB35A,Y                 ;0EB300|B95AB3  |0EB35A;
						ADC.W r_entity_XPos,X              ;0EB303|7D3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB306|9D3804  |0E0438;
						RTS                                  ;0EB309|60      |      ;
	
	
			CODE_0EB30A:
						LDA.W r_entity_AI,X            ;0EB30A|BDEF05  |0E05EF;
						CMP.B #$08                           ;0EB30D|C908    |      ;
						BCC CODE_0EB344                      ;0EB30F|9033    |0EB344;
						CMP.B #$10                           ;0EB311|C910    |      ;
						BCC CODE_0EB33E                      ;0EB313|9029    |0EB33E;
						CMP.B #$18                           ;0EB315|C918    |      ;
						BCC CODE_0EB322                      ;0EB317|9009    |0EB322;
						LDA.W r_entity_AI,X            ;0EB319|BDEF05  |0E05EF;
						SEC                                  ;0EB31C|38      |      ;
						SBC.B #$18                           ;0EB31D|E918    |      ;
						JMP.W CODE_0EB328                    ;0EB31F|4C28B3  |0EB328;
	
	
			CODE_0EB322:
						LDA.B #$18                           ;0EB322|A918    |      ;
						SEC                                  ;0EB324|38      |      ;
						SBC.W r_entity_AI,X            ;0EB325|FDEF05  |0E05EF;
	
			CODE_0EB328:
						ASL A                                ;0EB328|0A      |      ;
						TAY                                  ;0EB329|A8      |      ;
						SEC                                  ;0EB32A|38      |      ;
						LDA.W r_entity_FractionalY,X       ;0EB32B|BDDB04  |0E04DB;
						SBC.W DATA8_0EB35B,Y                 ;0EB32E|F95BB3  |0EB35B;
						STA.W r_entity_FractionalY,X       ;0EB331|9DDB04  |0E04DB;
						LDA.W r_entity_YPos,X              ;0EB334|BD1C04  |0E041C;
						SBC.W DATA8_0EB35A,Y                 ;0EB337|F95AB3  |0EB35A;
						STA.W r_entity_YPos,X              ;0EB33A|9D1C04  |0E041C;
						RTS                                  ;0EB33D|60      |      ;
	
	
			CODE_0EB33E:
						LDA.B #$10                           ;0EB33E|A910    |      ;
						SEC                                  ;0EB340|38      |      ;
						SBC.W r_entity_AI,X            ;0EB341|FDEF05  |0E05EF;
	
			CODE_0EB344:
						ASL A                                ;0EB344|0A      |      ;
						TAY                                  ;0EB345|A8      |      ;
						CLC                                  ;0EB346|18      |      ;
						LDA.W DATA8_0EB36D,Y                 ;0EB347|B96DB3  |0EB36D;
						ADC.W r_entity_FractionalY,X       ;0EB34A|7DDB04  |0E04DB;
						STA.W r_entity_FractionalY,X       ;0EB34D|9DDB04  |0E04DB;
						LDA.W DATA8_0EB36C,Y                 ;0EB350|B96CB3  |0EB36C;
						ADC.W r_entity_YPos,X              ;0EB353|7D1C04  |0E041C;
						STA.W r_entity_YPos,X              ;0EB356|9D1C04  |0E041C;
						RTS                                  ;0EB359|60      |      ;
	
	
			DATA8_0EB35A:
						db $02                               ;0EB35A|        |      ;
	
			DATA8_0EB35B:
						db $00,$01,$F6,$01,$D9,$01,$A9,$01   ;0EB35B|        |      ;
						db $6A,$01,$1C,$00,$C3,$00,$63,$00   ;0EB363|        |      ;
						db $00                               ;0EB36B|        |      ;
	
			DATA8_0EB36C:
						db $00                               ;0EB36C|        |      ;
	
			DATA8_0EB36D:
						db $00,$00,$63,$00,$C3,$01,$1C,$01   ;0EB36D|        |      ;
						db $69,$01,$A9,$01,$D9,$01,$F6,$02   ;0EB375|        |      ;
						db $00                               ;0EB37D|        |      ;
	
			DATA8_0EB37E:
						db $00                               ;0EB37E|        |      ;
	
			DATA8_0EB37F:
						db $00,$00,$32,$00,$6A,$00,$C4,$01   ;0EB37F|        |      ;
						db $00,$01,$7F,$02,$6A,$05,$06,$FF   ;0EB387|        |      ;
						db $FF                               ;0EB38F|        |      ;
	
	flameThrowState_01:
						DEC.W r_entity_AI_IDX,X        ;0EB390|DEC105  |0E05C1;
						BNE CODE_0EB3F5                      ;0EB393|D060    |0EB3F5;
						LDA.B #$24                           ;0EB395|A924    |      ;
						db $20                               ;0EB397|        |      ;
						dw lunchMusic                        ;0EB398|        |0FE25F;
						LDY.B r_index                        ;0EB39A|A410    |000010;
						LDA.W r_entity_XPos,Y              ;0EB39C|B93804  |0E0438;
						STA.B r_tempCurrGroup                ;0EB39F|850C    |00000C;
						LDA.W r_entity_YPos,Y              ;0EB3A1|B91C04  |0E041C;
						STA.B r_tempCurrSection              ;0EB3A4|850D    |00000D;
						LDA.W r_entity_FacingLeft,Y        ;0EB3A6|B9A804  |0E04A8;
						STA.B r_tempCurrRoomIdx              ;0EB3A9|850E    |00000E;
						LDA.B #$00                           ;0EB3AB|A900    |      ;
						STA.W r_entity_OamBaseOffset,X     ;0EB3AD|9D9305  |0E0593;
						LDA.B #$02                           ;0EB3B0|A902    |      ;
						STA.W r_entity_spriteGroup,X;0EB3B2|9D8C04  |0E048C;
						LDA.B #$01                           ;0EB3B5|A901    |      ;
						STA.W r_entity_AnimTimer,X         ;0EB3B7|9D7C05  |0E057C;
						LDA.B r_tempCurrSection              ;0EB3BA|A50D    |00000D;
						SEC                                  ;0EB3BC|38      |      ;
						SBC.B #$08                           ;0EB3BD|E908    |      ;
						STA.W r_entity_YPos,X              ;0EB3BF|9D1C04  |0E041C;
						LDY.B r_tempCurrGroup                ;0EB3C2|A40C    |00000C;
						LDA.B r_tempCurrRoomIdx              ;0EB3C4|A50E    |00000E;
						STA.W r_entity_FacingLeft,X        ;0EB3C6|9DA804  |0E04A8;
						BEQ CODE_0EB3D2                      ;0EB3C9|F007    |0EB3D2;
						TYA                                  ;0EB3CB|98      |      ;
						SEC                                  ;0EB3CC|38      |      ;
						SBC.B #$18                           ;0EB3CD|E918    |      ;
						JMP.W CODE_0EB3D6                    ;0EB3CF|4CD6B3  |0EB3D6;
	
	
			CODE_0EB3D2:
						TYA                                  ;0EB3D2|98      |      ;
						CLC                                  ;0EB3D3|18      |      ;
						ADC.B #$18                           ;0EB3D4|6918    |      ;
	
			CODE_0EB3D6:
						STA.W r_entity_XPos,X              ;0EB3D6|9D3804  |0E0438;
						JMP.W getThrowWeaponStats                    ;0EB3D9|4C54AF  |0EAF54;
	
	
	flameThrowState_02:
						JSR.W CODE_0EB3F6                    ;0EB3DC|20F6B3  |0EB3F6;
						BCS CODE_0EB3E7                      ;0EB3DF|B006    |0EB3E7;
						JSR.W xSpd_2_Xpos                    ;0EB3E1|2016B9  |0EB916;
						JMP.W adjustRoomScroll2_entity                    ;0EB3E4|4C51B9  |0EB951;
	
	
			CODE_0EB3E7:
						LDA.B #$00                           ;0EB3E7|A900    |      ;
						STA.W r_entity_ID,X       ;0EB3E9|9D4E05  |0E054E;
						STA.W r_entity_XPos,X              ;0EB3EC|9D3804  |0E0438;
						STA.W r_entity_YPos,X              ;0EB3EF|9D1C04  |0E041C;
						STA.W r_entity_spriteID,X        ;0EB3F2|9D0004  |0E0400;
	
			CODE_0EB3F5:
						RTS                                  ;0EB3F5|60      |      ;
	
	
			CODE_0EB3F6:
						LDA.B #$00                           ;0EB3F6|A900    |      ;
						STA.W r_entity_XsubSpd,X           ;0EB3F8|9D0905  |0E0509;
						DEC.W r_entity_AnimTimer,X         ;0EB3FB|DE7C05  |0E057C;
						BEQ CODE_0EB407                      ;0EB3FE|F007    |0EB407;
						LDA.B #$00                           ;0EB400|A900    |      ;
						STA.W r_entity_Xspd,X              ;0EB402|9DF204  |0E04F2;
						CLC                                  ;0EB405|18      |      ;
						RTS                                  ;0EB406|60      |      ;
	
	
			CODE_0EB407:
						LDA.W r_entity_OamBaseOffset,X     ;0EB407|BD9305  |0E0593;
						STA.B r_pointerQueue                 ;0EB40A|8508    |000008;
						ASL A                                ;0EB40C|0A      |      ;
						CLC                                  ;0EB40D|18      |      ;
						ADC.B r_pointerQueue                 ;0EB40E|6508    |000008;
						TAY                                  ;0EB410|A8      |      ;
						LDA.W DATA8_0EB440,Y                 ;0EB411|B940B4  |0EB440;
						CMP.B #$FF                           ;0EB414|C9FF    |      ;
						BEQ CODE_0EB43E                      ;0EB416|F026    |0EB43E;
						STA.B $00                            ;0EB418|8500    |000000;
						LDA.W r_entity_FacingLeft,X        ;0EB41A|BDA804  |0E04A8;
						BEQ CODE_0EB428                      ;0EB41D|F009    |0EB428;
						LDA.B $00                            ;0EB41F|A500    |000000;
						EOR.B #$FF                           ;0EB421|49FF    |      ;
						CLC                                  ;0EB423|18      |      ;
						ADC.B #$01                           ;0EB424|6901    |      ;
						BNE CODE_0EB42A                      ;0EB426|D002    |0EB42A;
	
			CODE_0EB428:
						LDA.B $00                            ;0EB428|A500    |000000;
	
			CODE_0EB42A:
						STA.W r_entity_Xspd,X              ;0EB42A|9DF204  |0E04F2;
						LDA.W DATA8_0EB441,Y                 ;0EB42D|B941B4  |0EB441;
						STA.W r_entity_AnimTimer,X         ;0EB430|9D7C05  |0E057C;
						LDA.W DATA8_0EB442,Y                 ;0EB433|B942B4  |0EB442;
						STA.W r_entity_spriteID,X        ;0EB436|9D0004  |0E0400;
						INC.W r_entity_OamBaseOffset,X     ;0EB439|FE9305  |0E0593;
						CLC                                  ;0EB43C|18      |      ;
						RTS                                  ;0EB43D|60      |      ;
	
	
			CODE_0EB43E:
						SEC                                  ;0EB43E|38      |      ;
						RTS                                  ;0EB43F|60      |      ;
	
	
			DATA8_0EB440:
						db $00                               ;0EB440|        |      ;
	
			DATA8_0EB441:
						db $03                               ;0EB441|        |      ;
	
			DATA8_0EB442:
						db $3C,$04,$03,$3E,$04,$03,$3E,$0C   ;0EB442|        |      ;
						db $03,$40,$08,$03,$40,$08,$03,$42   ;0EB44A|        |      ;
						db $04,$03,$42,$08,$03,$44,$00,$03   ;0EB452|        |      ;
						db $56,$FF                           ;0EB45A|        |      ;
	
      
      
      
      initThrowSubweapon_00:
						JSR.W spawnSubweapon                 ;0EB45C|206EB4  |0EB46E;
				zeroPosAndStates:		
						LDA.B #$00                           ;0EB45F|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB461|9D3804  |0E0438;
						STA.W r_entity_YPos,X              ;0EB464|9D1C04  |0E041C;
				increaseState:		
						INC.W r_Player_StateDoubled,X      ;0EB467|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB46A|FE6505  |0E0565;
	
			CODE_0EB46D:
						RTS                                  ;0EB46D|60      |      ;
	
	
		spawnSubweapon:
						LDY.W r_entity_ID,X       ;0EB46E|BC4E05  |0E054E;
						LDA.W DATA8_0EB478,Y                 ;0EB471|B978B4  |0EB478;
						STA.W r_entity_AI_IDX,X        ;0EB474|9DC105  |0E05C1;
						RTS                                  ;0EB477|60      |      ;
	
	
			DATA8_0EB478:
						db $00,$0A,$0A,$0A,$0A,$0C,$08,$08   ;0EB478|        |      ;
						db $08,$08,$10                       ;0EB480|        |      ;
	
			DATA8_0EB483:
						db $02                               ;0EB483|        |      ;
	
			DATA8_0EB484:
						db $00,$FE,$00                       ;0EB484|        |      ;
	
			DATA8_0EB487:
						db $FA                               ;0EB487|        |      ;
	
			DATA8_0EB488:
						db $80                               ;0EB488|        |      ;
	
	
			DATA8_0EB489:
						db $02                               ;0EB489|        |      ;
	
			DATA8_0EB48A:
						db $00,$FE,$00                       ;0EB48A|        |      ;
	
			DATA8_0EB48D:
						db $04                               ;0EB48D|        |      ;
	
			DATA8_0EB48E:
						db $00,$FC,$00                       ;0EB48E|        |      ;
	
			DATA8_0EB491:
						db $01                               ;0EB491|        |      ;
	
			DATA8_0EB492:
						db $80,$FE,$80                       ;0EB492|        |      ;
	
	
			axeState_01:
						DEC.W r_entity_AI_IDX,X          ;0EB495|DEC105  |0005C1;
						BNE CODE_0EB46D                      ;0EB498|D0D3    |0EB46D;
						LDA.B #$13                           ;0EB49A|A913    |      ;
						db $20                               ;0EB49C|        |      ;
						dw lunchMusic                        ;0EB49D|        |0FE25F;
						LDA.B #$00                           ;0EB49F|A900    |      ;
						LDY.B #$08                           ;0EB4A1|A008    |      ;
						db $20                               ;0EB4A3|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EB4A4|        |0FEF5C;
						LDA.W r_entity_FacingLeft          ;0EB4A6|ADA804  |0E04A8;
						ASL A                                ;0EB4A9|0A      |      ;
						TAY                                  ;0EB4AA|A8      |      ;
						LDA.W DATA8_0EB483,Y                 ;0EB4AB|B983B4  |0EB483;
						STA.W r_entity_Xspd,X              ;0EB4AE|9DF204  |0E04F2;
						LDA.W DATA8_0EB484,Y                 ;0EB4B1|B984B4  |0EB484;
						STA.W r_entity_XsubSpd,X           ;0EB4B4|9D0905  |0E0509;
						LDA.W DATA8_0EB487                   ;0EB4B7|AD87B4  |0EB487;
						STA.W r_entity_Yspd,X              ;0EB4BA|9D2005  |0E0520;
						LDA.W DATA8_0EB488                   ;0EB4BD|AD88B4  |0EB488;
						STA.W r_entity_YsubSpd,X           ;0EB4C0|9D3705  |0E0537;
						LDA.B #$00                           ;0EB4C3|A900    |      ;
						STA.W r_entity_FacingLeft,X        ;0EB4C5|9DA804  |0E04A8;
						LDA.W r_entity_XPos                ;0EB4C8|AD3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB4CB|9D3804  |0E0438;
						LDA.W r_entity_YPos                ;0EB4CE|AD1C04  |0E041C;
						STA.W r_entity_YPos,X              ;0EB4D1|9D1C04  |0E041C;
						JMP.W getThrowWeaponStats                    ;0EB4D4|4C54AF  |0EAF54;
		
    if !grantDaggerSpiderSilkFreez == 1	
      newAxe:
 						; lda #$02
            ; sta.w r_entity_OamBaseOffset,x 
            
            LDA.B #$00  
						LDY.B #$08                          
						jsr getCollusionBasedOnOffset       
						beq shurikanInAir				
            
            lda #$7f    ; timer till it disappears 
						sta.w r_entity_AI_IDX,X
            
            lda #$26   
            jsr lunchMusic	
            jsr clearSpeed
            
            ; lda #$02    ; good example to see how badly managed this is.. or is it a bug? 
            ; sta.w r_entity_PaletteOverride,x 
            
            lda #$01          
            sta.w r_entity_Yspd,X 
            
            ldy #$ff    ; make surikan move in the direction you are not looking 
            lda.w r_entity_FacingLeft
            bne +
            ldy #$01
         +  tya 
            sta.w r_entity_Xspd,x 
             ; inc.w r_Player_StateDoubled,x 
             ; inc.w r_Player_StateDoubled,x 
             ; rts 
            jmp getThrowWeaponStats

   shurikanInAir: 
            LDA.W r_entity_YsubSpd,X     
 						CLC                          
 						ADC.B #$60                   
 						STA.W r_entity_YsubSpd,X 
            jmp continueAxeRoutine
    endif 
			
      axeState_02:
						LDA.W r_entity_YsubSpd,X           ;0EB4D7|BD3705  |0E0537;
						CLC                                  ;0EB4DA|18      |      ;
						ADC.B #$40                           ;0EB4DB|6940    |      ;
						STA.W r_entity_YsubSpd,X           ;0EB4DD|9D3705  |0E0537;
            
      continueAxeRoutine:		
            LDA.W r_entity_Yspd,X              ;0EB4E0|BD2005  |0E0520;
						ADC.B #$00                           ;0EB4E3|6900    |      ;
						STA.W r_entity_Yspd,X              ;0EB4E5|9D2005  |0E0520;
						jsr updateSpriteLoop               
						JSR.W xSpd_2_Xpos                    ;0EB4EB|2016B9  |0EB916;
						JSR.W ySpd_2_Ypos                    ;0EB4EE|202FB9  |0EB92F;
						JMP.W adjustRoomScroll2_entity                    ;0EB4F1|4C51B9  |0EB951;
	
	
			crossState_01:
						DEC.W r_entity_AI_IDX,X        ;0EB4F4|DEC105  |0E05C1;
						BEQ CODE_0EB4FA                      ;0EB4F7|F001    |0EB4FA;
						RTS                                  ;0EB4F9|60      |      ;
	
	
			CODE_0EB4FA:
						LDA.B #$00                           ;0EB4FA|A900    |      ;
						LDY.B #$07                           ;0EB4FC|A007    |      ;
						db $20                               ;0EB4FE|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EB4FF|        |0FEF5C;
						LDY.B r_index                        ;0EB501|A410    |000010;
						LDA.W r_entity_FacingLeft,Y        ;0EB503|B9A804  |0E04A8;
						ASL A                                ;0EB506|0A      |      ;
						TAY                                  ;0EB507|A8      |      ;
						LDA.W DATA8_0EB489,Y                 ;0EB508|B989B4  |0EB489;
						STA.W r_entity_Xspd,X              ;0EB50B|9DF204  |0E04F2;
						LDA.W DATA8_0EB48A,Y                 ;0EB50E|B98AB4  |0EB48A;
						STA.W r_entity_XsubSpd,X           ;0EB511|9D0905  |0E0509;
						LDA.B #$00                           ;0EB514|A900    |      ;
						STA.W r_entity_FacingLeft,X        ;0EB516|9DA804  |0E04A8;
						LDY.B r_index                        ;0EB519|A410    |000010;
						LDA.W r_entity_XPos,Y              ;0EB51B|B93804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB51E|9D3804  |0E0438;
						SEC                                  ;0EB521|38      |      ;
						LDA.W r_entity_YPos,Y              ;0EB522|B91C04  |0E041C;
						SBC.B #$04                           ;0EB525|E904    |      ;
						STA.W r_entity_YPos,X              ;0EB527|9D1C04  |0E041C;
						JMP.W getThrowWeaponStats                    ;0EB52A|4C54AF  |0EAF54;
	
	
			crossState_02:
						LDA.W r_damagActionFlag,X       ;0EB52D|BD1D06  |0E061D;
						AND.B #$0F                           ;0EB530|290F    |      ;
						CMP.B #$03                           ;0EB532|C903    |      ;
						BEQ CODE_0EB541                      ;0EB534|F00B    |0EB541;
						LDA.W r_entity_XPos,X              ;0EB536|BD3804  |0E0438;
						CMP.B #$F1                           ;0EB539|C9F1    |      ;
						BCS CODE_0EB541                      ;0EB53B|B004    |0EB541;
						CMP.B #$10                           ;0EB53D|C910    |      ;
						BCS CODE_0EB55B                      ;0EB53F|B01A    |0EB55B;
	
			CODE_0EB541:
						JSR.W throwSubweaponRelated               ;0EB541|2055BC  |0EBC55;
						LDA.B #$00                           ;0EB544|A900    |      ;
						SEC                                  ;0EB546|38      |      ;
						SBC.W r_entity_XsubSpd,X           ;0EB547|FD0905  |0E0509;
						STA.W r_entity_XsubSpd,X           ;0EB54A|9D0905  |0E0509;
						LDA.B #$00                           ;0EB54D|A900    |      ;
						SBC.W r_entity_Xspd,X              ;0EB54F|FDF204  |0E04F2;
						STA.W r_entity_Xspd,X              ;0EB552|9DF204  |0E04F2;
						INC.W r_Player_StateDoubled,X      ;0EB555|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB558|FE6505  |0E0565;
	
			CODE_0EB55B:
						LDA.B r_frameCount         ;0EB55B|A51A    |00001A;
						AND.B #$0F                           ;0EB55D|290F    |      ;
						BNE DATA8_0EB566                     ;0EB55F|D005    |0EB566;
						LDA.B #$15                           ;0EB561|A915    |      ;
						db $20                               ;0EB563|        |      ;
						dw lunchMusic                        ;0EB564|        |0FE25F;
	
			DATA8_0EB566:
						db $20                               ;0EB566|        |      ;
						dw updateSpriteLoop                  ;0EB567|        |0FEF75;
						JSR.W xSpd_2_Xpos                    ;0EB569|2016B9  |0EB916;
						JMP.W adjustRoomScroll2_entity                    ;0EB56C|4C51B9  |0EB951;
	
	
			crossState_03:
						LDY.B r_index                        ;0EB56F|A410    |000010;
						LDA.W r_entity_XPos,Y              ;0EB571|B93804  |0E0438;
						SEC                                  ;0EB574|38      |      ;
						SBC.W r_entity_XPos,X              ;0EB575|FD3804  |0E0438;
						BCS CODE_0EB57F                      ;0EB578|B005    |0EB57F;
						EOR.B #$FF                           ;0EB57A|49FF    |      ;
						CLC                                  ;0EB57C|18      |      ;
						ADC.B #$01                           ;0EB57D|6901    |      ;
	
			CODE_0EB57F:
						CMP.B #$10                           ;0EB57F|C910    |      ;
						BCS CODE_0EB55B                      ;0EB581|B0D8    |0EB55B;
						LDA.W r_entity_YPos,Y              ;0EB583|B91C04  |0E041C;
						SEC                                  ;0EB586|38      |      ;
						SBC.W r_entity_YPos,X              ;0EB587|FD1C04  |0E041C;
						BCS CODE_0EB591                      ;0EB58A|B005    |0EB591;
						EOR.B #$FF                           ;0EB58C|49FF    |      ;
						CLC                                  ;0EB58E|18      |      ;
						ADC.B #$01                           ;0EB58F|6901    |      ;
	
			CODE_0EB591:
						CMP.B #$10                           ;0EB591|C910    |      ;
						BCS CODE_0EB55B                      ;0EB593|B0C6    |0EB55B;
						LDA.B #$00                           ;0EB595|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB597|9D3804  |0E0438;
						RTS                                  ;0EB59A|60      |      ;
	
	
			grantStates_Axe_getY:
						LDA.B r_index                        ;0EB59B|A510    |000010;
						CMP.B #$01                           ;0EB59D|C901    |      ;
						BEQ CODE_0EB5B3                      ;0EB59F|F012    |0EB5B3;
						LDY.B #$00                           ;0EB5A1|A000    |      ;
	
			CODE_0EB5A3:
						LDA.W grantStates_Axe,Y                 ;0EB5A3|B908B7  |0EB708;
						CMP.B #$FF                           ;0EB5A6|C9FF    |      ;
						BEQ CODE_0EB5B3                      ;0EB5A8|F009    |0EB5B3;
						CMP.W r_Player_StateDoubled        ;0EB5AA|CD6505  |0E0565;
						BEQ CODE_0EB5B7                      ;0EB5AD|F008    |0EB5B7;
						INY                                  ;0EB5AF|C8      |      ;
						INY                                  ;0EB5B0|C8      |      ;
						BNE CODE_0EB5A3                      ;0EB5B1|D0F0    |0EB5A3;
	
			CODE_0EB5B3:
						LDY.B #$00                           ;0EB5B3|A000    |      ;
						SEC                                  ;0EB5B5|38      |      ;
						RTS                                  ;0EB5B6|60      |      ;
	
	
			CODE_0EB5B7:
						CLC                                  ;0EB5B7|18      |      ;
	
			CODE_0EB5B8:
						RTS                                  ;0EB5B8|60      |      ;
	
	
		grantAxe_state_01:
						DEC.W r_entity_AI_IDX,X        ;0EB5B9|DEC105  |0E05C1;
						BNE CODE_0EB5B8                      ;0EB5BC|D0FA    |0EB5B8;
	
						LDY.B r_index                        ;0EB5BE|A410    |000010;
						LDA.W r_entity_XPos,Y              ;0EB5C0|B93804  |0E0438;
						STA.B r_tempCurrGroup                ;0EB5C3|850C    |00000C;
						LDA.W r_entity_YPos,Y              ;0EB5C5|B91C04  |0E041C;
						STA.B r_tempCurrSection              ;0EB5C8|850D    |00000D;
						LDA.W r_entity_FacingLeft,Y        ;0EB5CA|B9A804  |0E04A8;
						STA.B r_tempCurrRoomIdx              ;0EB5CD|850E    |00000E;
						
            LDA.B #$13                           ;0EB5CF|A913    |      ;
						jsr lunchMusic                        ;0EB5D2|        |0FE25F;
						
            JSR.W grantStates_Axe_getY                    ;0EB5D4|209BB5  |0EB59B;
						BCS CODE_0EB5E8                      ;0EB5D7|B00F    |0EB5E8;
						LDA.W grantStates_AxeSpawn,Y                 ;0EB5D9|B909B7  |0EB709;
						ASL A                                ;0EB5DC|0A      |      ;
						STA.B $00                            ;0EB5DD|8500    |000000;
						ASL A                                ;0EB5DF|0A      |      ;
						ASL A                                ;0EB5E0|0A      |      ;
						CLC                                  ;0EB5E1|18      |      ;
						ADC.B $00                            ;0EB5E2|6500    |000000;
						ADC.W grantStates_AxeSpawn,Y                 ;0EB5E4|7909B7  |0EB709;
						TAY                                  ;0EB5E7|A8      |      ;
	
			CODE_0EB5E8:
						LDA.W DATA8_0EB70D,Y                 ;0EB5E8|B90DB7  |0EB70D;
						CLC                                  ;0EB5EB|18      |      ;
						ADC.B r_tempCurrGroup                ;0EB5EC|650C    |00000C;
						STA.W r_entity_XPos,X              ;0EB5EE|9D3804  |0E0438;
						LDA.W DATA8_0EB70E,Y                 ;0EB5F1|B90EB7  |0EB70E;
						CLC                                  ;0EB5F4|18      |      ;
						ADC.B r_tempCurrSection              ;0EB5F5|650D    |00000D;
						STA.W r_entity_YPos,X              ;0EB5F7|9D1C04  |0E041C;
						LDA.B r_tempCurrRoomIdx              ;0EB5FA|A50E    |00000E;
						EOR.W DATA8_0EB70F,Y                 ;0EB5FC|590FB7  |0EB70F;
						STA.W r_entity_FacingLeft,X        ;0EB5FF|9DA804  |0E04A8;
						BEQ CODE_0EB608                      ;0EB602|F004    |0EB608;
						INY                                  ;0EB604|C8      |      ;
						INY                                  ;0EB605|C8      |      ;
						INY                                  ;0EB606|C8      |      ;
						INY                                  ;0EB607|C8      |      ;
	
			CODE_0EB608:
						LDA.W DATA8_0EB710,Y                 ;0EB608|B910B7  |0EB710;
						STA.W r_entity_Xspd,X              ;0EB60B|9DF204  |0E04F2;
						LDA.W DATA8_0EB711,Y                 ;0EB60E|B911B7  |0EB711;
						STA.W r_entity_XsubSpd,X           ;0EB611|9D0905  |0E0509;
						LDA.W DATA8_0EB712,Y                 ;0EB614|B912B7  |0EB712;
						STA.W r_entity_Yspd,X              ;0EB617|9D2005  |0E0520;
						LDA.W DATA8_0EB713,Y                 ;0EB61A|B913B7  |0EB713;
						STA.W r_entity_YsubSpd,X           ;0EB61D|9D3705  |0E0537;
						LDA.B #$00                           ;0EB620|A900    |      ;
						LDY.B #$08                           ;0EB622|A008    |      ;
						db $20                               ;0EB624|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EB625|        |0FEF5C;
						JMP.W getThrowWeaponStats                    ;0EB627|4C54AF  |0EAF54;
					
          
      if !grantDaggerSpiderSilkFreez == 1			
					grantDagger_state_01:		
						DEC.W r_entity_AI_IDX,X        
						BNE CODE_0EB5B8                
						LDY.B r_index                  
						LDA.W r_entity_XPos,Y          
						STA.B r_tempCurrGroup          
						LDA.W r_entity_YPos,Y          
						STA.B r_tempCurrSection        
						LDA.W r_entity_FacingLeft,Y    
						STA.B r_tempCurrRoomIdx        
						lda #$1E
						jsr lunchMusic	
						JSR.W grantStates_Axe_getY              
						BCS CODE_0EB656                
						LDA.W grantStates_AxeSpawn,Y           
						ASL A                          
						ASL A                          
						STA.B $00                      
						ASL A                          
						CLC                            
						ADC.B $00                      
						TAY                            
	
				CODE_0EB656:
						LDA.W spriteID_grantDagger,Y     
						STA.W r_entity_spriteID,X        
						LDA.W grantDagger_xPosOffset,Y   
						CLC                              
						ADC.B r_tempCurrGroup            
						STA.W r_entity_XPos,X            
						LDA.W grantDagger_yPosOffset,Y   
						CLC                              
						ADC.B r_tempCurrSection          
						STA.W r_entity_YPos,X            
						LDA.B r_index                    
						CMP.B #$01                       
						BEQ CODE_0EB684                  
						LDA.W r_Player_StateDoubled      
						CMP.B #$1C                       
						BNE CODE_0EB684                  
						CLC                              
						LDA.W r_entity_YPos,X            
						ADC.B #$06                       
						STA.W r_entity_YPos,X            
	
				CODE_0EB684:
						LDA.B r_tempCurrRoomIdx          
						EOR.W grantDagger_dirMask,Y      
						STA.W r_entity_FacingLeft,X      
						BEQ CODE_0EB692                  
						INY                              
						INY                              
						INY                              
						INY                              
	
				CODE_0EB692:
						LDA.W grantDaggerXspd,Y           
						STA.W r_entity_Xspd,X             
						LDA.W grantDaggerXsubSpd,Y        
						STA.W r_entity_XsubSpd,X          
						LDA.W grantDaggerYspd,Y           
						STA.W r_entity_Yspd,X             
						LDA.W grantDaggerYsubSpd,Y        
						STA.W r_entity_YsubSpd,X          
						LDA.B #$00                        
						STA.W r_entity_spriteGroup,X	
						JMP.W getThrowWeaponStats         
	
					-	rts 						
						
			else									
				grantDagger_state_01:		
						DEC.W r_entity_AI_IDX,X        		;0EB62A|DEC105  |0E05C1;
						BNE CODE_0EB5B8                      ;0EB62D|D089    |0EB5B8;
						LDY.B r_index                        ;0EB62F|A410    |000010;
						LDA.W r_entity_XPos,Y              ;0EB631|B93804  |0E0438;
						STA.B r_tempCurrGroup                ;0EB634|850C    |00000C;
						LDA.W r_entity_YPos,Y              ;0EB636|B91C04  |0E041C;
						STA.B r_tempCurrSection              ;0EB639|850D    |00000D;
						LDA.W r_entity_FacingLeft,Y        ;0EB63B|B9A804  |0E04A8;
						STA.B r_tempCurrRoomIdx              ;0EB63E|850E    |00000E;
						LDA.B #$14                           ;0EB640|A914    |      ;
						db $20                               ;0EB642|        |      ;
						dw lunchMusic                        ;0EB643|        |0FE25F;
						JSR.W grantStates_Axe_getY                    ;0EB645|209BB5  |0EB59B;
						BCS CODE_0EB656                      ;0EB648|B00C    |0EB656;
						LDA.W grantStates_AxeSpawn,Y                 ;0EB64A|B909B7  |0EB709;
						ASL A                                ;0EB64D|0A      |      ;
						ASL A                                ;0EB64E|0A      |      ;
						STA.B $00                            ;0EB64F|8500    |000000;
						ASL A                                ;0EB651|0A      |      ;
						CLC                                  ;0EB652|18      |      ;
						ADC.B $00                            ;0EB653|6500    |000000;
						TAY                                  ;0EB655|A8      |      ;
	
			CODE_0EB656:
						LDA.W spriteID_grantDagger,Y                 ;0EB656|B92EB7  |0EB72E;
						STA.W r_entity_spriteID,X        ;0EB659|9D0004  |0E0400;
						LDA.W grantDagger_xPosOffset,Y                 ;0EB65C|B92FB7  |0EB72F;
						CLC                                  ;0EB65F|18      |      ;
						ADC.B r_tempCurrGroup                ;0EB660|650C    |00000C;
						STA.W r_entity_XPos,X              ;0EB662|9D3804  |0E0438;
						LDA.W grantDagger_yPosOffset,Y                 ;0EB665|B930B7  |0EB730;
						CLC                                  ;0EB668|18      |      ;
						ADC.B r_tempCurrSection              ;0EB669|650D    |00000D;
						STA.W r_entity_YPos,X              ;0EB66B|9D1C04  |0E041C;
						LDA.B r_index                        ;0EB66E|A510    |000010;
						CMP.B #$01                           ;0EB670|C901    |      ;
						BEQ CODE_0EB684                      ;0EB672|F010    |0EB684;
						LDA.W r_Player_StateDoubled        ;0EB674|AD6505  |0E0565;
						CMP.B #$1C                           ;0EB677|C91C    |      ;
						BNE CODE_0EB684                      ;0EB679|D009    |0EB684;
						CLC                                  ;0EB67B|18      |      ;
						LDA.W r_entity_YPos,X              ;0EB67C|BD1C04  |0E041C;
						ADC.B #$06                           ;0EB67F|6906    |      ;
						STA.W r_entity_YPos,X              ;0EB681|9D1C04  |0E041C;
	
			CODE_0EB684:
						LDA.B r_tempCurrRoomIdx              ;0EB684|A50E    |00000E;
						EOR.W grantDagger_dirMask,Y                 ;0EB686|5931B7  |0EB731;
						STA.W r_entity_FacingLeft,X        ;0EB689|9DA804  |0E04A8;
						BEQ CODE_0EB692                      ;0EB68C|F004    |0EB692;
						INY                                  ;0EB68E|C8      |      ;
						INY                                  ;0EB68F|C8      |      ;
						INY                                  ;0EB690|C8      |      ;
						INY                                  ;0EB691|C8      |      ;
	
			CODE_0EB692:
						LDA.W grantDaggerXspd,Y                 ;0EB692|B932B7  |0EB732;
						STA.W r_entity_Xspd,X              ;0EB695|9DF204  |0E04F2;
						LDA.W grantDaggerXsubSpd,Y                 ;0EB698|B933B7  |0EB733;
						STA.W r_entity_XsubSpd,X           ;0EB69B|9D0905  |0E0509;
						LDA.W grantDaggerYspd,Y                 ;0EB69E|B934B7  |0EB734;
						STA.W r_entity_Yspd,X              ;0EB6A1|9D2005  |0E0520;
						LDA.W grantDaggerYsubSpd,Y                 ;0EB6A4|B935B7  |0EB735;
						STA.W r_entity_YsubSpd,X           ;0EB6A7|9D3705  |0E0537;
						LDA.B #$00                           ;0EB6AA|A900    |      ;
						STA.W r_entity_spriteGroup,X;0EB6AC|9D8C04  |0E048C;
						JMP.W getThrowWeaponStats                    ;0EB6AF|4C54AF  |0EAF54;
	
					-	rts 
			endif 
			
			mainDagger_01:
						DEC.W r_entity_AI_IDX,X        ;0EB6B2|DEC105  |0E05C1;
						BNE -
						LDA.B #$14                           ;0EB6B7|A914    |      ;
						jsr lunchMusic                        ;0EB6BA|        |0FE25F;
						LDA.B #$00                           ;0EB6BC|A900    |      ;
						STA.W r_entity_spriteGroup,X;0EB6BE|9D8C04  |0E048C;
						LDA.B #$4E                           ;0EB6C1|A94E    |      ;
						STA.W r_entity_spriteID,X        ;0EB6C3|9D0004  |0E0400;
						LDA.W r_entity_FacingLeft          ;0EB6C6|ADA804  |0E04A8;
						STA.W r_entity_FacingLeft,X        ;0EB6C9|9DA804  |0E04A8;
						ASL A                                ;0EB6CC|0A      |      ;
						TAY                                  ;0EB6CD|A8      |      ;
						LDA.W DATA8_0EB48D,Y                 ;0EB6CE|B98DB4  |0EB48D;
						STA.W r_entity_Xspd,X              ;0EB6D1|9DF204  |0E04F2;
						LDA.W DATA8_0EB48E,Y                 ;0EB6D4|B98EB4  |0EB48E;
						STA.W r_entity_XsubSpd,X           ;0EB6D7|9D0905  |0E0509;
						LDA.B #$00                           ;0EB6DA|A900    |      ;
						STA.W r_entity_YsubSpd,X           ;0EB6DC|9D3705  |0E0537;
						STA.W r_entity_Yspd,X              ;0EB6DF|9D2005  |0E0520;
						LDA.W r_entity_XPos                ;0EB6E2|AD3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB6E5|9D3804  |0E0438;
						SEC                                  ;0EB6E8|38      |      ;
						LDA.W r_entity_YPos                ;0EB6E9|AD1C04  |0E041C;
						SBC.B #$04                           ;0EB6EC|E904    |      ;
						STA.W r_entity_YPos,X              ;0EB6EE|9D1C04  |0E041C;
						JMP.W getThrowWeaponStats                    ;0EB6F1|4C54AF  |0EAF54;
	
		if !grantDaggerSpiderSilkFreez == 1	
			
			mainDagger_ice:						
				;		ldy #$4e				; blink
				;		lda.b r_frameCount
				;		and #$03
				;		beq +
				;		ldy #$00	
				;	+	tya 
				;		sta.w r_entity_spriteID,x 
					
						
						inc.w r_entity_AI_IDX,x 
						lda.w r_entity_AI_IDX,x
						cmp #$20 
						bne +
;						lda #$1E			; would be cool to start a animation along it.. 
;						jsr lunchMusic
						jmp makeSubweDespawn
					
					+	lda #$18
						sta $00
						jsr decelarate_xSpeed						
						
						
						jmp iceDagger02 				; skip hit disappear on candles 

						

		else 
;					; 	!daggerHolyFreez ; a alternative subweapon 			
;						LDA.B #$00  
;						LDY.B #$08                          
;						jsr getCollusionBasedOnOffset       
;						bne coldFlame
;						
;					;	LDA.W r_damagActionFlag,X 							
;					;	beq +						
;					;	lda #$06
;					;	sta.w r_Player_StateDoubled,x 
;					;	jmp coldFlame						; make it burn on inpact 
;						
;					+	lda.w r_entity_AI_IDX,x 		; timer till the dagger starts acting like holywater 
;						cmp	#$20				
;						bcc ++	
;					
;					coldFlame:	
;						lda #$01						
;						sta.w r_entity_PaletteOverride,x 			
;						jmp holyWaterState_02						
;				
;				++		lda #$18
;						sta $00
;						jsr decelarate_xSpeed
;						jsr decelarate_ySpeed
;						inc.w r_entity_AI_IDX,x 
;						jmp iceDagger02		
		endif 				
			
			mainDagger_02:
						LDA.W r_damagActionFlag,X       ;0EB6F4|BD1D06  |0E061D;
						BNE makeSubweDespawn                      ;0EB6F7|D009    |0EB702;
			iceDagger02:		
						JSR.W xSpd_2_Xpos                    ;0EB6F9|2016B9  |0EB916;
						JSR.W ySpd_2_Ypos                    ;0EB6FC|202FB9  |0EB92F;
						JMP.W adjustRoomScroll2_entity                    ;0EB6FF|4C51B9  |0EB951;
	
	
			makeSubweDespawn:
						LDA.B #$00                           ;0EB702|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB704|9D3804  |0E0438;
	
			CODE_0EB707:
						RTS                                  ;0EB707|60      |      ;
	
	
			grantStates_Axe:
						db $46                               ;0EB708|        |      ;
	
			grantStates_AxeSpawn:
            db $01,$48,$02,$FF                   ;0EB709|        |      ;
	
			DATA8_0EB70D:
						db $00                               ;0EB70D|        |      ;
	
			DATA8_0EB70E:
						db $00                               ;0EB70E|        |      ;
	
			DATA8_0EB70F:
						db $00                               ;0EB70F|        |      ;
	
			DATA8_0EB710:
						db $02                               ;0EB710|        |      ;
	
			DATA8_0EB711:
						db $00                               ;0EB711|        |      ;
	
			DATA8_0EB712:
						db $FA                               ;0EB712|        |      ;
	
			DATA8_0EB713:
						db $80,$FE,$00,$FA,$80,$00,$00,$01   ;0EB713|        |      ;
	
						db $02,$00,$FA,$80,$FE,$00,$FA,$80   ;0EB71B|        |      ;
						db $00,$00,$00,$00,$00,$00,$00,$00   ;0EB723|        |      ;
						db $00,$00,$00                       ;0EB72B|        |      ;
	
			spriteID_grantDagger:
						db $4E                               ;0EB72E|        |      ;	
			grantDagger_xPosOffset:
						db $00                               ;0EB72F|        |      ;	
			grantDagger_yPosOffset:
						db $FC                               ;0EB730|        |      ;	
			grantDagger_dirMask:
						db $00                               ;0EB731|        |      ;
			
			grantDaggerXspd:
						db $04                               ;0EB732|        |      ;
			grantDaggerXsubSpd:
						db $00                               ;0EB733|        |      ;	
			grantDaggerYspd:
						db $00                               ;0EB734|        |      ;	
			grantDaggerYsubSpd:
						db $00						
						
						db $FC,$00,$00,$00,$4E,$00,$00,$01	; left 						
						db $04,$00,$00,$00,$FC,$00,$00,$00
						db $64,$00,$00,$00,$00,$00,$04,$00 
						db $00,$00,$04,$00              
	
		holyWaterState_01:
						DEC.W r_entity_AI_IDX,X             ;0EB752|DEC105  |0E05C1;
						BNE CODE_0EB791                      ;0EB755|D03A    |0EB791;
						LDA.B #$00                           ;0EB757|A900    |      ;
						STA.W r_entity_spriteGroup,X        ;0EB759|9D8C04  |0E048C;
						LDA.B #$52                           ;0EB75C|A952    |      ;
						STA.W r_entity_spriteID,X           ;0EB75E|9D0004  |0E0400;
						LDA.W r_entity_FacingLeft          ;0EB761|ADA804  |0E04A8;
						ASL A                                ;0EB764|0A      |      ;
						TAY                                  ;0EB765|A8      |      ;
						LDA.W DATA8_0EB491,Y                 ;0EB766|B991B4  |0EB491;
						STA.W r_entity_Xspd,X              ;0EB769|9DF204  |0E04F2;
						LDA.W DATA8_0EB492,Y                 ;0EB76C|B992B4  |0EB492;
						STA.W r_entity_XsubSpd,X           ;0EB76F|9D0905  |0E0509;
						LDA.B #$FE                           ;0EB772|A9FE    |      ;
						STA.W r_entity_Yspd,X              ;0EB774|9D2005  |0E0520;
						LDA.B #$80                           ;0EB777|A980    |      ;
						STA.W r_entity_YsubSpd,X           ;0EB779|9D3705  |0E0537;
						LDA.W r_entity_FacingLeft          ;0EB77C|ADA804  |0E04A8;
						STA.W r_entity_FacingLeft,X        ;0EB77F|9DA804  |0E04A8;
						LDA.W r_entity_XPos                ;0EB782|AD3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB785|9D3804  |0E0438;
						LDA.W r_entity_YPos                ;0EB788|AD1C04  |0E041C;
						STA.W r_entity_YPos,X              ;0EB78B|9D1C04  |0E041C;
						JMP.W getThrowWeaponStats                    ;0EB78E|4C54AF  |0EAF54;
	
	
			CODE_0EB791:
						RTS                                  ;0EB791|60      |      ;
	
	
		holyWaterState_02:
						LDA.B #$00                           ;0EB792|A900    |      ;
						LDY.B #$08                           ;0EB794|A008    |      ;
						db $20                               ;0EB796|        |      ;
						dw getCollusionBasedOnOffset                       ;0EB797|        |0FFC1E;
						BNE CODE_0EB7B5                      ;0EB799|D01A    |0EB7B5;
						LDA.W r_entity_YsubSpd,X           ;0EB79B|BD3705  |0E0537;
						CLC                                  ;0EB79E|18      |      ;
						ADC.B #$20                           ;0EB79F|6920    |      ;
						STA.W r_entity_YsubSpd,X           ;0EB7A1|9D3705  |0E0537;
						LDA.W r_entity_Yspd,X              ;0EB7A4|BD2005  |0E0520;
						ADC.B #$00                           ;0EB7A7|6900    |      ;
						STA.W r_entity_Yspd,X              ;0EB7A9|9D2005  |0E0520;
						JSR.W xSpd_2_Xpos                    ;0EB7AC|2016B9  |0EB916;
						JSR.W ySpd_2_Ypos                    ;0EB7AF|202FB9  |0EB92F;
						JMP.W adjustRoomScroll2_entity                    ;0EB7B2|4C51B9  |0EB951;
	
	
			CODE_0EB7B5:
						LDA.B #$16                           ;0EB7B5|A916    |      ;
						db $20                               ;0EB7B7|        |      ;
						dw lunchMusic                        ;0EB7B8|        |0FE25F;
						JSR.W throwSubweaponRelated               ;0EB7BA|2055BC  |0EBC55;
						LDA.B #$4C                           ;0EB7BD|A94C    |      ;
						STA.W r_entity_AI_IDX,X             ;0EB7BF|9DC105  |0E05C1;
						LDA.B #$00                           ;0EB7C2|A900    |      ;
						LDY.B #$0C                           ;0EB7C4|A00C    |      ;
						db $20                               ;0EB7C6|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EB7C7|        |0FEF5C;
						INC.W r_Player_StateDoubled,X      ;0EB7C9|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB7CC|FE6505  |0E0565;
						RTS                                  ;0EB7CF|60      |      ;
	
    if !grantDaggerSpiderSilkFreez == 1	
   
        newAxeGround_03:
            LDA.B r_index                ; !!FIXME there is a spawning bug.. not sure if IDX overflow.. but this index ended up with wired values
            pha 
            jsr groundShurikanRoutine
            pla 
            STA.B r_index  
            rts 
            
         groundShurikanRoutine:   
            DEC.W r_entity_AI_IDX,X
            bpl +
            LDA.B #$00                ; desspawn with out of bounce         
						STA.W r_entity_XPos,X  
          +        
            lda #$10
            sta $00
            jsr acelarate_xSpeed
              
            lda #$02  
            jsr speedLimit_A                      
            jsr updateSpriteLoop           
               
            LDA.B #$00               
						LDY.B #$00                          
						jsr getCollusionBasedOnOffset       
						beq surikanWallHit
            
            lda.w r_entity_AI_IDX,X   ; will make it disappear quicker when stuck 
            sbc #$0F 
            sta.w r_entity_AI_IDX,X

            inc.w r_entity_YPos,X      ; help it drop out of celling 
            inc.w r_entity_YPos,X      ; help it drop out of celling 
            
            lda #$28
            jsr lunchMusic	
            lda.w r_entity_Xspd,X 
            eor #$FF 
            sta.w r_entity_Xspd,X 
            
        surikanWallHit:	
            JSR.W xSpd_2_Xpos                    
            
            LDA.B #$00  
						LDY.B #$08                          
						jsr getCollusionBasedOnOffset       
						bne +	
            lda #$20
            sta $00
            jsr acelarate_ySpeed
            JSR.W ySpd_2_Ypos                    
        +
            jmp adjustRoomScroll2_entity
        
       
    endif 
    
    
    holyWaterState_03:
						DEC.W r_entity_AI_IDX,X        ;0EB7D0|DEC105  |0E05C1;
						BNE CODE_0EB7DB                      ;0EB7D3|D006    |0EB7DB;
            LDA.B #$00                           ;0EB7D5|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB7D7|9D3804  |0E0438;
						RTS                                  ;0EB7DA|60      |      ;
	
	
			CODE_0EB7DB:
						LDA.B r_frameCount         ;0EB7DB|A51A    |00001A;
						AND.B #$0F                           ;0EB7DD|290F    |      ;
						BNE DATA8_0EB7E4                     ;0EB7DF|D003    |0EB7E4;
						JSR.W throwSubweaponRelated               ;0EB7E1|2055BC  |0EBC55;
	
			DATA8_0EB7E4:
						db $20                               ;0EB7E4|        |      ;
						dw updateSpriteLoop                  ;0EB7E5|        |0FEF75;
						JMP.W adjustRoomScroll2_entity                    ;0EB7E7|4C51B9  |0EB951;
	
	
    freezSpellState_00:
						LDA.W r_entity_ID,X       ;0EB7EA|BD4E05  |0E054E;
						STA.W $054F,X                        ;0EB7ED|9D4F05  |0E054F;
						STA.W $0550,X                        ;0EB7F0|9D5005  |0E0550;
						JSR.W spawnSubweapon                 ;0EB7F3|206EB4  |0EB46E;
						CLC                                  ;0EB7F6|18      |      ;
						ADC.B #$01                           ;0EB7F7|6901    |      ;
						STA.W $05C2,X                        ;0EB7F9|9DC205  |0E05C2;
						STA.W $05C3,X                        ;0EB7FC|9DC305  |0E05C3;
						LDA.B #$00                           ;0EB7FF|A900    |      ;
						STA.W r_entity_XPos,X              ;0EB801|9D3804  |0E0438;
						STA.W $0439,X                        ;0EB804|9D3904  |0E0439;
						STA.W $043A,X                        ;0EB807|9D3A04  |0E043A;
						STA.W r_entity_YPos,X              ;0EB80A|9D1C04  |0E041C;
						STA.W $041D,X                        ;0EB80D|9D1D04  |0E041D;
						STA.W $041E,X                        ;0EB810|9D1E04  |0E041E;
						INC.W r_Player_StateDoubled,X      ;0EB813|FE6505  |0E0565;
						INC.W r_Player_StateDoubled,X      ;0EB816|FE6505  |0E0565;
						LDA.W r_Player_StateDoubled,X      ;0EB819|BD6505  |0E0565;
						STA.W $0566,X                        ;0EB81C|9D6605  |0E0566;
						STA.W $0567,X                        ;0EB81F|9D6705  |0E0567;
						RTS                                  ;0EB822|60      |      ;
	
	
	freezSpellState_01:
						DEC.W r_entity_AI_IDX,X        ;0EB823|DEC105  |0E05C1;
						BEQ addSpeedDir_freezDebree        
						RTS                                
	
	
			addSpeedDir_freezDebree:
						LDA.B #$21                           ;0EB829|A921    |      ;
						db $20                               ;0EB82B|        |      ;
						dw lunchMusic                        ;0EB82C|        |0FE25F;
						LDA.B #$02                           ;0EB82E|A902    |      ;
						LDY.B #$09                           ;0EB830|A009    |      ;
						db $20                               ;0EB832|        |      ;
						dw setSpriteAndAnimGroup_AY              ;0EB833|        |0FEF5C;
						TXA                                  ;0EB835|8A      |      ;
						SEC                                  ;0EB836|38      |      ;
						SBC.B #$14                           ;0EB837|E914    |      ;
						ASL A                                ;0EB839|0A      |      ;
						ASL A                                ;0EB83A|0A      |      ;
						TAY                                  ;0EB83B|A8      |      ;
						LDA.W DATA8_0EB8F1,Y                 ;0EB83C|B9F1B8  |0EB8F1;
						STA.W r_entity_Xspd,X              ;0EB83F|9DF204  |0E04F2;
						LDA.W DATA8_0EB8F2,Y                 ;0EB842|B9F2B8  |0EB8F2;
						STA.W r_entity_XsubSpd,X           ;0EB845|9D0905  |0E0509;
						LDA.W DATA8_0EB8F3,Y                 ;0EB848|B9F3B8  |0EB8F3;
						STA.W r_entity_Yspd,X              ;0EB84B|9D2005  |0E0520;
						LDA.W DATA8_0EB8F4,Y                 ;0EB84E|B9F4B8  |0EB8F4;
						STA.W r_entity_YsubSpd,X           ;0EB851|9D3705  |0E0537;
						LDA.B #$00                           ;0EB854|A900    |      ;
						STA.W r_entity_FacingLeft,X        ;0EB856|9DA804  |0E04A8;
						LDA.W r_entity_XPos                ;0EB859|AD3804  |0E0438;
						STA.W r_entity_XPos,X              ;0EB85C|9D3804  |0E0438;
						STA.W r_entity_AI,X            ;0EB85F|9DEF05  |0E05EF;
						LDA.W r_entity_FractionalX         ;0EB862|ADC404  |0E04C4;
						STA.W r_entity_FractionalX,X       ;0EB865|9DC404  |0E04C4;
						STA.W r_entity_extra,X             ;0EB868|9DD805  |0E05D8;
						LDA.W r_entity_YPos                ;0EB86B|AD1C04  |0E041C;
						STA.W r_entity_YPos,X              ;0EB86E|9D1C04  |0E041C;
						LDA.B #$20                           ;0EB871|A920    |      ;
						STA.W r_entity_AI_IDX,X        ;0EB873|9DC105  |0E05C1;
						JMP.W getThrowWeaponStats                    ;0EB876|4C54AF  |0EAF54;
	
	
			CODE_0EB879:
						LDA.B #$00                           ;0EB879|A900    |      ;
	
			CODE_0EB87B:
						STA.W r_entity_ID,X       ;0EB87B|9D4E05  |0E054E;
						STA.W r_entity_spriteID,X        ;0EB87E|9D0004  |0E0400;
						STA.W r_entity_XPos,X              ;0EB881|9D3804  |0E0438;
						STA.W r_entity_YPos,X              ;0EB884|9D1C04  |0E041C;
						INX                                  ;0EB887|E8      |      ;
						CPX.B #$17                           ;0EB888|E017    |      ;
						BCC CODE_0EB87B                      ;0EB88A|90EF    |0EB87B;
						JSR.W CODE_0EB969                    ;0EB88C|2069B9  |0EB969;
						BCC CODE_0EB8A1                      ;0EB88F|9010    |0EB8A1;
						LDA.W r_Player_StateDoubled        ;0EB891|AD6505  |0E0565;
						ORA.B #$80                           ;0EB894|0980    |      ;
						STA.W r_Player_StateDoubled        ;0EB896|8D6505  |0E0565;
						LDA.B #$1A                           ;0EB899|A91A    |      ;
						STA.B r_gameTransition               ;0EB89B|852A    |00002A;
						LDA.B #$00                           ;0EB89D|A900    |      ;
						STA.B r_menuSelectIdx                ;0EB89F|856B    |00006B;
	
			CODE_0EB8A1:
						PLA                                  ;0EB8A1|68      |      ;
						PLA                                  ;0EB8A2|68      |      ;
						RTS                                  ;0EB8A3|60      |      ;
	
	
	freezSpellState_02:
						DEC.W r_entity_AI_IDX,X        ;0EB8A4|DEC105  |0E05C1;
						BEQ CODE_0EB879                      ;0EB8A7|F0D0    |0EB879;
						LDA.B #$00                           ;0EB8A9|A900    |      ;
						STA.W r_entity_mask,X            ;0EB8AB|9D7004  |0E0470;
						LDA.W r_entity_XPos,X              ;0EB8AE|BD3804  |0E0438;
						STA.B $09                            ;0EB8B1|8509    |000009;
						LDA.W r_entity_FractionalX,X       ;0EB8B3|BDC404  |0E04C4;
						STA.B r_pointerQueue                 ;0EB8B6|8508    |000008;
						LDA.W r_entity_AI,X            ;0EB8B8|BDEF05  |0E05EF;
						STA.W r_entity_XPos,X              ;0EB8BB|9D3804  |0E0438;
						LDA.W r_entity_extra,X             ;0EB8BE|BDD805  |0E05D8;
						STA.W r_entity_FractionalX,X       ;0EB8C1|9DC404  |0E04C4;
						LDA.B $09                            ;0EB8C4|A509    |000009;
						STA.W r_entity_AI,X            ;0EB8C6|9DEF05  |0E05EF;
						LDA.B r_pointerQueue                 ;0EB8C9|A508    |000008;
						STA.W r_entity_extra,X             ;0EB8CB|9DD805  |0E05D8;
						LDA.B #$00                           ;0EB8CE|A900    |      ;
						SEC                                  ;0EB8D0|38      |      ;
						SBC.W r_entity_XsubSpd,X           ;0EB8D1|FD0905  |0E0509;
						STA.W r_entity_XsubSpd,X           ;0EB8D4|9D0905  |0E0509;
						LDA.B #$00                           ;0EB8D7|A900    |      ;
						SBC.W r_entity_Xspd,X              ;0EB8D9|FDF204  |0E04F2;
						STA.W r_entity_Xspd,X              ;0EB8DC|9DF204  |0E04F2;
						db $20                               ;0EB8DF|        |      ;
						dw updateSpriteLoop                  ;0EB8E0|        |0FEF75;
						JSR.W xSpd_2_Xpos                    ;0EB8E2|2016B9  |0EB916;
						JSR.W CODE_0EB8FD                    ;0EB8E5|20FDB8  |0EB8FD;
						JSR.W ySpd_2_Ypos                    ;0EB8E8|202FB9  |0EB92F;
						JSR.W adjustRoomScroll2_entity                    ;0EB8EB|2051B9  |0EB951;
						JMP.W CODE_0EB943                    ;0EB8EE|4C43B9  |0EB943;
	
	
			DATA8_0EB8F1:
						db $02                               ;0EB8F1|        |      ;
	
			DATA8_0EB8F2:
						db $00                               ;0EB8F2|        |      ;
	
			DATA8_0EB8F3:
						db $00                               ;0EB8F3|        |      ;
	
			DATA8_0EB8F4:
						db $00,$01,$9E,$FE,$D4,$00,$9E,$FE   ;0EB8F4|        |      ;
						db $1A                               ;0EB8FC|        |      ;
	
			CODE_0EB8FD:
						LDA.W r_entity_AI,X            ;0EB8FD|BDEF05  |0E05EF;
						BEQ CODE_0EB915                      ;0EB900|F013    |0EB915;
						LDA.W r_entity_extra,X             ;0EB902|BDD805  |0E05D8;
						SEC                                  ;0EB905|38      |      ;
						SBC.W r_entity_XsubSpd,X           ;0EB906|FD0905  |0E0509;
						STA.W r_entity_extra,X             ;0EB909|9DD805  |0E05D8;
						LDA.W r_entity_AI,X            ;0EB90C|BDEF05  |0E05EF;
						SBC.W r_entity_Xspd,X              ;0EB90F|FDF204  |0E04F2;
						STA.W r_entity_AI,X            ;0EB912|9DEF05  |0E05EF;
	
			CODE_0EB915:
						RTS                                  ;0EB915|60      |      ;
	
	
			xSpd_2_Xpos:
						LDA.W r_entity_XPos,X              ;0EB916|BD3804  |0E0438;
						BEQ CODE_0EB92E                      ;0EB919|F013    |0EB92E;
						LDA.W r_entity_FractionalX,X       ;0EB91B|BDC404  |0E04C4;
						CLC                                  ;0EB91E|18      |      ;
						ADC.W r_entity_XsubSpd,X           ;0EB91F|7D0905  |0E0509;
						STA.W r_entity_FractionalX,X       ;0EB922|9DC404  |0E04C4;
						LDA.W r_entity_XPos,X              ;0EB925|BD3804  |0E0438;
						ADC.W r_entity_Xspd,X              ;0EB928|7DF204  |0E04F2;
						STA.W r_entity_XPos,X              ;0EB92B|9D3804  |0E0438;
	
			CODE_0EB92E:
						RTS                                  ;0EB92E|60      |      ;
	
	
			ySpd_2_Ypos:
						LDA.W r_entity_FractionalY,X       ;0EB92F|BDDB04  |0E04DB;
						CLC                                  ;0EB932|18      |      ;
						ADC.W r_entity_YsubSpd,X           ;0EB933|7D3705  |0E0537;
						STA.W r_entity_FractionalY,X       ;0EB936|9DDB04  |0E04DB;
						LDA.W r_entity_YPos,X              ;0EB939|BD1C04  |0E041C;
						ADC.W r_entity_Yspd,X              ;0EB93C|7D2005  |0E0520;
						STA.W r_entity_YPos,X              ;0EB93F|9D1C04  |0E041C;
						RTS                                  ;0EB942|60      |      ;
	
	
			CODE_0EB943:
						LDA.B r_roomOrientation              ;0EB943|A568    |000068;
						BMI CODE_0EB950                      ;0EB945|3009    |0EB950;
						LDA.W r_entity_AI,X            ;0EB947|BDEF05  |0E05EF;
						SEC                                  ;0EB94A|38      |      ;
						SBC.B r_scrollSpd                    ;0EB94B|E56E    |00006E;
						STA.W r_entity_AI,X            ;0EB94D|9DEF05  |0E05EF;
	
			CODE_0EB950:
						RTS                                  ;0EB950|60      |      ;
	
	
			adjustRoomScroll2_entity:
						LDA.B r_roomOrientation              ;0EB951|A568    |000068;
						BMI CODE_0EB95F                      ;0EB953|300A    |0EB95F;
						LDA.W r_entity_XPos,X              ;0EB955|BD3804  |0E0438;
						SEC                                  ;0EB958|38      |      ;
						SBC.B r_scrollSpd                    ;0EB959|E56E    |00006E;
						STA.W r_entity_XPos,X              ;0EB95B|9D3804  |0E0438;
	
			moreRTS_22:
						RTS                                  ;0EB95E|60      |      ;
	
	
			CODE_0EB95F:
						LDA.W r_entity_YPos,X              ;0EB95F|BD1C04  |0E041C;
						CLC                                  ;0EB962|18      |      ;
						ADC.B r_scrollSpd                    ;0EB963|656E    |00006E;
						STA.W r_entity_YPos,X              ;0EB965|9D1C04  |0E041C;
						RTS                                  ;0EB968|60      |      ;
	
	
			CODE_0EB969:
						LDA.B r_roomEffect                   ;0EB969|A57D    |00007D;
						AND.B #$F0                           ;0EB96B|29F0    |      ;
						CMP.B #$30                           ;0EB96D|C930    |      ;
						BNE CODE_0EB980                      ;0EB96F|D00F    |0EB980;
						LDA.B #$00                           ;0EB971|A900    |      ;
						LDX.B #$10                           ;0EB973|A210    |      ;
						db $20                               ;0EB975|        |      ;
						dw playerCollusionCheck              ;0EB976|        |0FFCDD;
						CMP.B #$02                           ;0EB978|C902    |      ;
						BEQ CODE_0EB982                      ;0EB97A|F006    |0EB982;
						CMP.B #$03                           ;0EB97C|C903    |      ;
						BEQ CODE_0EB982                      ;0EB97E|F002    |0EB982;
	
			CODE_0EB980:
						CLC                                  ;0EB980|18      |      ;
						RTS                                  ;0EB981|60      |      ;
	
	
			CODE_0EB982:
						SEC                                  ;0EB982|38      |      ;
						RTS                                  ;0EB983|60      |      ;

	
  { ; init weapon and animation handler  	
	
		initSubwAttack_CC:
						LDX.B #$14                           ;0EB9F5|A214    |      ;
						LDY.B r_partnerIdx               
						LDA.W r_subweap,Y                
						BEQ noSubwe                  
						
            STA.B r_pointerQueue                  ; !!backup? Does it translate ID?       
						JSR.W subWe_initCheckHeart       
						BCC noSubwe                  
						LDY.B r_partnerIdx               						
            LDA.B r_pointerQueue             
						
            CMP.B #SUBWE_FREEZ                     
						BEQ see4_freeSlot2spawn                
						
            CMP.B #SUBWE_ORB                      
						BEQ see4_freeSlot2spawn               
						
            CMP.B #SUBWE_CLOCK                     
						BEQ clockInitCheck                  
						
			bossDoupleGanger_attack_03:	
						LDA.W r_subweapMultiplier,Y      
						STA.B $09                        
						LDA.B #$03                       
						STA.B r_temp_Xpos                
	
			findSubwSlot_Loop:
						LDA.W r_entity_ID,X              
						BEQ initSubweaponShot            
						DEC.B $09                        
						BMI noSubwe                  
						INX                              
						DEC.B r_temp_Xpos                
						BNE findSubwSlot_Loop                  
	
			noSubwe:
						CLC                              
						RTS                              
			
      
			see4_freeSlot2spawn:			
            LDA.W r_player_subWeID_01                           ;0EBA5C|AD6205  |0E0562;
						ORA.W r_player_subWeID_02                           ;0EBA5F|0D6305  |0E0563;
						ORA.W r_player_subWeID_03                           ;0EBA62|0D6405  |0E0564;
						BEQ initSubweaponShot                             ;0EBA65|F0C7    |0EBA2E;
						BNE noSubwe                                   ;0EBA67|D0C3    |0EBA2C;
	
		initSubweaponShot:
						JSR.W checkSlot_heart4subWe          ;0EBA2E|20AABA  |0EBAAA;
						LDA.B r_pointerQueue                 ;0EBA31|A508    |000008;
						STA.W r_entity_ID,X                 ;0EBA33|9D4E05  |0E054E;
            LDA.B #$00                           ;0EBA36|A900    |      ;
						STA.W r_Player_StateDoubled,X       ;0EBA38|9D6505  |0E0565;
						STA.W r_damagActionFlag,X             ;0EBA3B|9D1D06  |0E061D;
						STA.W r_entity_mask,X                  ;0EBA3E|9D7004  |0E0470;
						SEC                                  ;0EBA41|38      |      ;
						RTS                                  ;0EBA42|60      |      ;
	
	
			clockInitCheck:
						LDA.B r_stopWatchActive              ;0EBA43|A5AB    |0000AB;
						BNE CODE_0EBA5A                      ;0EBA45|D013    |0EBA5A;
						JSR.W checkSlot_heart4subWe          ;0EBA47|20AABA  |0EBAAA;
						LDA.B #$B4                           ;0EBA4A|A9B4    |      ;
						STA.B r_stopWatchTimer               ;0EBA4C|85AC    |0000AC;
						LDA.B #$01                           ;0EBA4E|A901    |      ;
						STA.B r_stopWatchActive              ;0EBA50|85AB    |0000AB;
						STA.W r_sound_musicStop            ;0EBA52|8DC906  |0E06C9;
						db $20                               ;0EBA55|        |      ;
						dw CODE_0FE199                       ;0EBA56|        |0FE199;
						CLC                                  ;0EBA58|18      |      ;
						RTS                                  ;0EBA59|60      |      ;
	
	
			CODE_0EBA5A:
						CLC                                  ;0EBA5A|18      |      ;
						RTS                                  ;0EBA5B|60      |      ;
	
	

	
		alucardBaseAttack:
						LDX.B #$14                           ;0EBA69|A214    |      ;
				bossDoupleGanger_AlucardAttack_06:	
						LDY.B r_partnerIdx                   ;0EBA6B|A43B    |00003B;
						LDA.W r_trevorWhipLevel,Y          ;0EBA6D|B98E00  |0E008E;
						STA.B $09                            ;0EBA70|8509    |000009;
						LDA.B #$03                           ;0EBA72|A903    |      ;
						STA.B r_temp_Xpos                    ;0EBA74|850A    |00000A;
						LDY.B #$00                           ;0EBA76|A000    |      ;
	
			CODE_0EBA78:
						LDA.W r_entity_ID,X       ;0EBA78|BD4E05  |0E054E;
						BEQ CODE_0EBA8E                      ;0EBA7B|F011    |0EBA8E;
	
			CODE_0EBA7D:
						DEC.B $09                            ;0EBA7D|C609    |000009;
						BMI CODE_0EBA86                      ;0EBA7F|3005    |0EBA86;
						INX                                  ;0EBA81|E8      |      ;
						DEC.B r_temp_Xpos                    ;0EBA82|C60A    |00000A;
						BNE CODE_0EBA78                      ;0EBA84|D0F2    |0EBA78;
	
			CODE_0EBA86:
						CPY.B #$00                           ;0EBA86|C000    |      ;
						BEQ CODE_0EBA8C                      ;0EBA88|F002    |0EBA8C;
						SEC                                  ;0EBA8A|38      |      ;
						RTS                                  ;0EBA8B|60      |      ;
	
	
			CODE_0EBA8C:
						CLC                                  ;0EBA8C|18      |      ;
						RTS                                  ;0EBA8D|60      |      ;
	
	
			CODE_0EBA8E:
						TYA                                  ;0EBA8E|98      |      ;
						STA.W r_entity_extra,X             ;0EBA8F|9DD805  |0E05D8;
						INY                                  ;0EBA92|C8      |      ;
						LDA.B #$0A                           ;0EBA93|A90A    |      ;
						STA.W r_entity_ID,X       ;0EBA95|9D4E05  |0E054E;
						LDA.B #$00                           ;0EBA98|A900    |      ;
						STA.W r_Player_StateDoubled,X      ;0EBA9A|9D6505  |0E0565;
						STA.W r_damagActionFlag,X       ;0EBA9D|9D1D06  |0E061D;
						BEQ CODE_0EBA7D                      ;0EBAA0|F0DB    |0EBA7D;
	
	subWe_initCheckHeart:
						LDY.B r_pointerQueue                 ;0EBAA2|A408    |000008;
						LDA.B r_hearts                       ;0EBAA4|A584    |000084;
						CMP.W subweaponHeartCost,Y           ;0EBAA6|D9B6BA  |0EBAB6;

			CODE_0EBAA9:
						RTS                                  ;0EBAA9|60      |      ;
	
	
	checkSlot_heart4subWe:
						CPX.B #$14                           ;0EBAAA|E014    |      ;
						BCC CODE_0EBAA9                      ;0EBAAC|90FB    |0EBAA9;
						LDY.B r_pointerQueue                 ;0EBAAE|A408    |000008;
						LDA.W subweaponHeartCost,Y           ;0EBAB0|B9B6BA  |0EBAB6;
						jmp addHeart_A                        ;0EBAB4|        |0FE753;
	

	
		group2Stuff_dono:
						LDA.W PTR16_0EBB7A                   ;0EBAC2|AD7ABB  |0EBB7A;
						STA.B r_pointerQueue                 ;0EBAC5|8508    |000008;
						LDA.W PTR16_0EBB7A+1                   ;0EBAC7|AD7BBB  |0EBB7B;
						STA.B $09                            ;0EBACA|8509    |000009;
						LDY.B #$00                           ;0EBACC|A000    |      ;
	
			CODE_0EBACE:
						LDA.W DATA8_0EBB6F,Y                 ;0EBACE|B96FBB  |0EBB6F;
						CMP.B #$FF                           ;0EBAD1|C9FF    |      ;
						BEQ CODE_0EBB0E                      ;0EBAD3|F039    |0EBB0E;
						CMP.W r_Player_StateDoubled,X      ;0EBAD5|DD6505  |0E0565;
						BEQ CODE_0EBADE                      ;0EBAD8|F004    |0EBADE;
						INY                                  ;0EBADA|C8      |      ;
						INY                                  ;0EBADB|C8      |      ;
						BNE CODE_0EBACE                      ;0EBADC|D0F0    |0EBACE;
	
			CODE_0EBADE:
						CMP.B #$46                           ;0EBADE|C946    |      ;
						BNE CODE_0EBAEB                      ;0EBAE0|D009    |0EBAEB;
						LDA.W r_entity_AnimGroup           ;0EBAE2|ADAA05  |0E05AA;
						CMP.B #$0D                           ;0EBAE5|C90D    |      ;
						BNE CODE_0EBAEB                      ;0EBAE7|D002    |0EBAEB;
						INY                                  ;0EBAE9|C8      |      ;
						INY                                  ;0EBAEA|C8      |      ;
	
			CODE_0EBAEB:
						LDA.W DATA8_0EBB70,Y                 ;0EBAEB|B970BB  |0EBB70;
						TAY                                  ;0EBAEE|A8      |      ;
						JMP.W CODE_0EBB3F                    ;0EBAEF|4C3FBB  |0EBB3F;
	
	
	player_animCountDown:
						LDX.B #$00                           ;0EBAF2|A200    |      ;
				bossDoupleGanger_anim_05:		
						DEC.W r_entity_AnimTimer,X         ;0EBAF4|DE7C05  |0E057C;
						BEQ setNextFrame_alucard             ;0EBAF7|F002    |0EBAFB;
						CLC                                  ;0EBAF9|18      |      ;
						RTS                                  ;0EBAFA|60      |      ;
	
	
	setNextFrame_alucard:
						LDA.W r_entity_ID,X       ;0EBAFB|BD4E05  |0E054E;
						CMP.B #$02                           ;0EBAFE|C902    |      ;
						BEQ group2Stuff_dono                 ;0EBB00|F0C0    |0EBAC2;
						ASL A                                ;0EBB02|0A      |      ;
						TAY                                  ;0EBB03|A8      |      ;
						LDA.W PTR16_0EBB76,Y                 ;0EBB04|B976BB  |0EBB76;
						STA.B r_pointerQueue                 ;0EBB07|8508    |000008;
						LDA.W PTR16_0EBB76+1,Y                 ;0EBB09|B977BB  |0EBB77;
						STA.B $09                            ;0EBB0C|8509    |000009;
	
			CODE_0EBB0E:
						LDY.B #$00                           ;0EBB0E|A000    |      ;
	
			CODE_0EBB10:
						LDA.W DATA8_0EBB64,Y                 ;0EBB10|B964BB  |0EBB64;
						CMP.B #$FF                           ;0EBB13|C9FF    |      ;
						BEQ CODE_0EBB39                      ;0EBB15|F022    |0EBB39;
						CMP.W r_Player_StateDoubled,X      ;0EBB17|DD6505  |0E0565;
						BEQ CODE_0EBB20                      ;0EBB1A|F004    |0EBB20;
						INY                                  ;0EBB1C|C8      |      ;
						INY                                  ;0EBB1D|C8      |      ;
						BNE CODE_0EBB10                      ;0EBB1E|D0F0    |0EBB10;
	
			CODE_0EBB20:
						CMP.B #$24                           ;0EBB20|C924    |      ;
						BNE CODE_0EBB3B                      ;0EBB22|D017    |0EBB3B;
						LDA.W r_entity_FacingLeft,X        ;0EBB24|BDA804  |0E04A8;
						BEQ CODE_0EBB32                      ;0EBB27|F009    |0EBB32;
						LDA.W r_entity_AI,X            ;0EBB29|BDEF05  |0E05EF;
						BEQ CODE_0EBB3B                      ;0EBB2C|F00D    |0EBB3B;
	
			CODE_0EBB2E:
						INY                                  ;0EBB2E|C8      |      ;
						INY                                  ;0EBB2F|C8      |      ;
						BNE CODE_0EBB3B                      ;0EBB30|D009    |0EBB3B;
	
			CODE_0EBB32:
						LDA.W r_entity_AI,X            ;0EBB32|BDEF05  |0E05EF;
						BNE CODE_0EBB3B                      ;0EBB35|D004    |0EBB3B;
						BEQ CODE_0EBB2E                      ;0EBB37|F0F5    |0EBB2E;
	
			CODE_0EBB39:
						LDY.B #$00                           ;0EBB39|A000    |      ;
	
			CODE_0EBB3B:						
						LDA.W DATA8_0EBB65,Y                 ;0EBB3B|B965BB  |0EBB65;
						TAY                                  ;0EBB3E|A8      |      ;
	
			CODE_0EBB3F:
						LDA.B (r_pointerQueue),Y             ;0EBB3F|B108    |000008;
						STA.B r_temp_Xpos                    ;0EBB41|850A    |00000A;
						INY                                  ;0EBB43|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EBB44|B108    |000008;
						STA.B $0B                            ;0EBB46|850B    |00000B;
						LDY.W r_entity_OamBaseOffset,X     ;0EBB48|BC9305  |0E0593;
						LDA.B (r_temp_Xpos),Y                ;0EBB4B|B10A    |00000A;
						CMP.B #$FF                           ;0EBB4D|C9FF    |      ;
						BEQ CODE_0EBB62                      ;0EBB4F|F011    |0EBB62;
						STA.W r_entity_spriteID,X        ;0EBB51|9D0004  |0E0400;
						INY                                  ;0EBB54|C8      |      ;
						LDA.B (r_temp_Xpos),Y                ;0EBB55|B10A    |00000A;
						STA.W r_entity_AnimTimer,X         ;0EBB57|9D7C05  |0E057C;
						INC.W r_entity_OamBaseOffset,X     ;0EBB5A|FE9305  |0E0593;
						INC.W r_entity_OamBaseOffset,X     ;0EBB5D|FE9305  |0E0593;
						CLC                                  ;0EBB60|18      |      ;
						RTS                                  ;0EBB61|60      |      ;
	
	
			CODE_0EBB62:
						SEC                                  ;0EBB62|38      |      ;
						RTS                                  ;0EBB63|60      |      ;
	
	
			DATA8_0EBB64:
						db $20                               ;0EBB64|        |      ;
	
			DATA8_0EBB65:
						db $00,$22,$00,$1C,$02,$24,$04,$24   ;0EBB65|        |      ;
						db $06,$FF                           ;0EBB6D|        |      ;
	
			DATA8_0EBB6F:
						db $46                               ;0EBB6F|        |      ;
	
			DATA8_0EBB70:
						db $08,$46,$0A,$48,$0C,$FF           ;0EBB70|        |      ;
	
			PTR16_0EBB76:
						dw trevorThrowAnimList               ;0EBB76|        |0EBB7E;
						dw symphaThrowAnimList               ;0EBB78|        |0EBB86;
	
			PTR16_0EBB7A:
						dw grantThrowAnimList                ;0EBB7A|        |0EBB8E;
						dw alucardThrowAnimList              ;0EBB7C|        |0EBB9C;
	
	trevorThrowAnimList:
						dw trevorThrowAnim                   ;0EBB7E|        |0EBBA4;
						dw trevor__Anim                      ;0EBB80|        |0EBBAB;
						dw trevorStairDownThrowAnim          ;0EBB82|        |0EBBB2;
						dw trevorStairUpThrowAnim            ;0EBB84|        |0EBBBB;
	
	symphaThrowAnimList:
						dw symphaThrowAnim                   ;0EBB86|        |0EBBC4;
						dw sympha__Anim                      ;0EBB88|        |0EBBC9;
						dw symphaStairDownThrowAnim          ;0EBB8A|        |0EBBCE;
						dw symphaStairUpThrowAnim            ;0EBB8C|        |0EBBD5;
	
	grantThrowAnimList:
						dw grantThrowAnim                    ;0EBB8E|        |0EBBDC;
	
						dw grant__Anim                       ;0EBB90|        |0EBBE1;
						dw grantStairDownThrowAnim           ;0EBB92|        |0EBBE6;
						dw grantStairUpThrowAnim             ;0EBB94|        |0EBBED;
						dw grantStair__Anim                  ;0EBB96|        |0EBBF4;
						dw grantWallThrowAnim                ;0EBB98|        |0EBBFB;
						dw grantCellingThrowAnim             ;0EBB9A|        |0EBC02;
	
	alucardThrowAnimList:
						dw alucardThrowAnim                  ;0EBB9C|        |0EBC09;
						dw alucard__Anim                     ;0EBB9E|        |0EBC10;
						dw alucardStairDownThrowAnim         ;0EBBA0|        |0EBC17;
						dw alucardStairUppThrowAnim          ;0EBBA2|        |0EBC20;
	
		trevorThrowAnim:
						db $18,$05,$1A,$07,$1C,$09,$FF       ;0EBBA4|        |      ;
	
			trevor__Anim:
						db $1E,$05,$20,$07,$22,$09,$FF       ;0EBBAB|        |      ;
	
	trevorStairDownThrowAnim:
						db $34,$05,$36,$07,$38,$09,$0A,$01   ;0EBBB2|        |      ;
						db $FF                               ;0EBBBA|        |      ;
	
	trevorStairUpThrowAnim:
						db $3A,$05,$3C,$07,$3E,$09,$0C,$01   ;0EBBBB|        |      ;
						db $FF                               ;0EBBC3|        |      ;
	
		symphaThrowAnim:
						db $34,$08,$2C,$10,$FF               ;0EBBC4|        |      ;
	
			sympha__Anim:
						db $36,$08,$2E,$10,$FF               ;0EBBC9|        |      ;
	
	symphaStairDownThrowAnim:
						db $38,$08,$30,$10,$0A,$01,$FF       ;0EBBCE|        |      ;
	
	symphaStairUpThrowAnim:
						db $3A,$08,$32,$10,$0C,$01,$FF       ;0EBBD5|        |      ;
	
		grantThrowAnim:
						db $24,$08,$26,$0D,$FF               ;0EBBDC|        |      ;
	
			grant__Anim:
						db $32,$08,$34,$0D,$FF               ;0EBBE1|        |      ;
	
	grantStairDownThrowAnim:
						db $2A,$08,$2C,$0D,$0A,$01,$FF       ;0EBBE6|        |      ;
	
	grantStairUpThrowAnim:
						db $2E,$08,$30
						db $0D,$0C,$01,$FF       ;0EBBED|        |      ;
	
		grantStair__Anim:
						db $18,$08,$1C
						db $0D,$18,$01,$FF       ;0EBBF4|        |      ;
	
	grantWallThrowAnim:
						db $36,$08,$3A
						db $0D,$36,$01,$FF       ;0EBBFB|        |      ;
	
	grantCellingThrowAnim:
						db $1E,$08,$22
						db $0D,$1E,$01,$FF       ;0EBC02|        |      ;
	
		alucardThrowAnim:
						db $18,$08,$1A,$08,$1C,$08,$FF       ;0EBC09|        |      ;
	
			alucard__Anim:
						db $1E,$08,$20,$08,$22,$08,$FF       ;0EBC10|        |      ;
	
	alucardStairDownThrowAnim:
						db $18,$08,$1A,$08,$1C,$08,$0A,$01   ;0EBC17|        |      ;
						db $FF                               ;0EBC1F|        |      ;
	
	alucardStairUppThrowAnim:
						db $18,$08,$1A,$08,$1C,$08,$0C,$01   ;0EBC20|        |      ;
						db $FF                               ;0EBC28|        |      ;
	

		throwSubweaponRelated:
						STX.B r_bankLocationLoad             ;0EBC55|86B1    |0000B1;
						TXA                                  ;0EBC57|8A      |      ;
						SEC                                  ;0EBC58|38      |      ;
						SBC.B #$13                           ;0EBC59|E913    |      ;
						CMP.B #$04                           ;0EBC5B|C904    |      ;
						BCS CODE_0EBC7A                      ;0EBC5D|B01B    |0EBC7A;
						TAY                                  ;0EBC5F|A8      |      ;
						BNE CODE_0EBC6A                      ;0EBC60|D008    |0EBC6A;
	
	whipImpactHealthRelated:
						STX.B r_bankLocationLoad             ;0EBC62|86B1    |0000B1;
						CPX.B #$13                           ;0EBC64|E013    |      ;
						BNE CODE_0EBC7A                      ;0EBC66|D012    |0EBC7A;
						LDY.B #$00                           ;0EBC68|A000    |      ;
	
			CODE_0EBC6A:
						LDX.B #$01                           ;0EBC6A|A201    |      ;
	
			CODE_0EBC6C:
						LDA.W $068D,X                        ;0EBC6C|BD8D06  |0E068D;
						AND.W DATA8_0EBC7D,Y                 ;0EBC6F|397DBC  |0EBC7D;
						STA.W $068D,X                        ;0EBC72|9D8D06  |0E068D;
						INX                                  ;0EBC75|E8      |      ;
						CPX.B #$13                           ;0EBC76|E013    |      ;
						BCC CODE_0EBC6C                      ;0EBC78|90F2    |0EBC6C;
	
			CODE_0EBC7A:
						LDX.B r_bankLocationLoad             ;0EBC7A|A6B1    |0000B1;
						RTS                                  ;0EBC7C|60      |      ;
	
	
			DATA8_0EBC7D:
						db $FE,$FD,$FB,$F7                   ;0EBC7D|        |      ;
			
				
        
  bossDoupleGanger_weaponAnim_07:		
						LDA.B #$01                           ;0EBC81|A901    |      ;
						STA.B r_index                        ;0EBC83|8510    |000010;
						LDX.B #$05                           ;0EBC85|A205    |      ;
						BNE CODE_0EBC8F                      ;0EBC87|D006    |0EBC8F;
	
	playerAttackAnim_routine:
					
						LDA.B #$00                           ;0EBC89|A900    |      ;
						STA.B r_index                        ;0EBC8B|8510    |000010;
						LDX.B #$13                           ;0EBC8D|A213    |      ;
	
			CODE_0EBC8F:
						LDY.B r_index                        ;0EBC8F|A410    |000010;
						LDA.W r_entity_ID,Y       ;0EBC91|B94E05  |0E054E;
						STA.B r_collisionPointYinScreen      ;0EBC94|8511    |000011;
						LDA.W r_Player_StateDoubled,Y      ;0EBC96|B96505  |0E0565;
						STA.B r_collisionPointXvalDiv32      ;0EBC99|8512    |000012;
						LDA.W r_entity_FacingLeft,Y        ;0EBC9B|B9A804  |0E04A8;
						STA.B r_collisionPointAbsoluteXInRoom;0EBC9E|8513    |000013;
						LDA.W r_entity_XPos,Y              ;0EBCA0|B93804  |0E0438;
						STA.B r_collisionPointAbsoluteXRoom  ;0EBCA3|8514    |000014;
						LDA.W r_entity_YPos,Y              ;0EBCA5|B91C04  |0E041C;
						STA.B r_15                           ;0EBCA8|8515    |000015;
						LDA.W r_entity_AI,Y            ;0EBCAA|B9EF05  |0E05EF;
						STA.B r_coreLoadingFuncAddr          ;0EBCAD|8516    |000016;
						LDA.W r_Player_StateDoubled,X      ;0EBCAF|BD6505  |0E0565;
						BNE continuePlayerAttackAnim                      ;0EBCB2|D044    |0EBCF8;
						JSR.W whipImpactHealthRelated        ;0EBCB4|2062BC  |0EBC62;
						LDA.B r_collisionPointYinScreen      ;0EBCB7|A511    |000011;
						CMP.B #$01                           ;0EBCB9|C901    |      ;
						BEQ CODE_0EBCC7                      ;0EBCBB|F00A    |0EBCC7;
						CMP.B #$02                           ;0EBCBD|C902    |      ;
						BNE CODE_0EBCCB                      ;0EBCBF|D00A    |0EBCCB;
					
					if !grantNinjaStar == 1
						inc.w r_entity_AnimTimer			; end animation if ff 
						bne +
						rts 
					+	
					endif 
					
						LDY.B #$80                           ;0EBCC1|A080    |      ;
						LDA.B #$04                           ;0EBCC3|A904    |      ;
						BNE CODE_0EBCCF                      ;0EBCC5|D008    |0EBCCF;
	
			CODE_0EBCC7:						
						LDA.B #$03                           ;0EBCC7|A903    |      ;
						BNE CODE_0EBCCD                      ;0EBCC9|D002    |0EBCCD;
	
			CODE_0EBCCB:
						LDA.B r_trevorWhipLevel              ;0EBCCB|A58E    |00008E;
	
			CODE_0EBCCD:
						LDY.B #$00                           ;0EBCCD|A000    |      ;
	
			CODE_0EBCCF:
						STY.W $0483                          ;0EBCCF|8C8304  |0E0483;
						STA.W r_entity_ID,X       ;0EBCD2|9D4E05  |0E054E;
							
						LDA.B #$00                           ;0EBCD5|A900    |      ;
						STA.W r_entity_OamBaseOffset,X     ;0EBCD7|9D9305  |0E0593;
						STA.W r_entity_PaletteOverride,X   ;0EBCDA|9D5404  |0E0454;
						STA.W r_entity_spriteID,X        ;0EBCDD|9D0004  |0E0400;
						LDA.B #$01                           ;0EBCE0|A901    |      ;
						STA.W r_entity_AnimTimer,X         ;0EBCE2|9D7C05  |0E057C;
						LDY.B r_index                        ;0EBCE5|A410    |000010;
						LDA.W r_entity_spriteGroup,Y;0EBCE7|B98C04  |0E048C;
						STA.W r_entity_spriteGroup,X;0EBCEA|9D8C04  |0E048C;
						LDA.W r_entity_FacingLeft,Y        ;0EBCED|B9A804  |0E04A8;
						STA.W r_entity_FacingLeft,X        ;0EBCF0|9DA804  |0E04A8;
						INC.W r_Player_StateDoubled,X      ;0EBCF3|FE6505  |0E0565;
						CLC                                  ;0EBCF6|18      |      ;
						RTS                                  ;0EBCF7|60      |      ;
	
	
			continuePlayerAttackAnim:
						LDA.W r_entity_ID,X       ;0EBCF8|BD4E05  |0E054E;
						CMP.B #$01                           ;0EBCFB|C901    |      ;
						BEQ CODE_0EBD03                      ;0EBCFD|F004    |0EBD03;
						CMP.B #$02                           ;0EBCFF|C902    |      ;
						BNE CODE_0EBD0A                      ;0EBD01|D007    |0EBD0A;
	
			CODE_0EBD03:					
						LDA.B r_frameCount         ;0EBD03|A51A    |00001A;
						AND.B #$03                           ;0EBD05|2903    |      ;
						STA.W r_entity_PaletteOverride,X   ;0EBD07|9D5404  |0E0454;
	
			CODE_0EBD0A:					
						LDA.B r_collisionPointYinScreen      ;0EBD0A|A511    |000011;
						ASL A                                ;0EBD0C|0A      |      ;
						TAY                                  ;0EBD0D|A8      |      ;
						LDA.W animGroup_00,Y                 ;0EBD0E|B9DABD  |0EBDDA;
						STA.B r_tempCurrGroup                ;0EBD11|850C    |00000C;
						LDA.W animGroup_00+1,Y                 ;0EBD13|B9DBBD  |0EBDDB;
						STA.B r_tempCurrSection              ;0EBD16|850D    |00000D;
						LDA.B r_collisionPointAbsoluteXRoom  ;0EBD18|A514    |000014;
						STA.W r_entity_XPos,X              ;0EBD1A|9D3804  |0E0438;
						LDA.B r_15                           ;0EBD1D|A515    |000015;
						LDY.B r_collisionPointXvalDiv32      ;0EBD1F|A412    |000012;
						CPY.B #$1C                           ;0EBD21|C01C    |      ;
						BNE CODE_0EBD28                      ;0EBD23|D003    |0EBD28;
						CLC                                  ;0EBD25|18      |      ;
						ADC.B #$08                           ;0EBD26|6908    |      ;
	
			CODE_0EBD28:
						STA.W r_entity_YPos,X              ;0EBD28|9D1C04  |0E041C;
						LDY.B #$00                           ;0EBD2B|A000    |      ;
	
			CODE_0EBD2D:
						LDA.B (r_tempCurrGroup),Y            ;0EBD2D|B10C    |00000C;
						CMP.B #$FF                           ;0EBD2F|C9FF    |      ;
						BNE CODE_0EBD36                      ;0EBD31|D003    |0EBD36;
						
						JMP.W resetOamSpec                   ;0EBD33|4CC6BD  |0EBDC6;
	
	
			CODE_0EBD36:
						CMP.B r_collisionPointXvalDiv32      ;0EBD36|C512    |000012;
						BEQ CODE_0EBD3E                      ;0EBD38|F004    |0EBD3E;
						INY                                  ;0EBD3A|C8      |      ;
						INY                                  ;0EBD3B|C8      |      ;
						BNE CODE_0EBD2D                      ;0EBD3C|D0EF    |0EBD2D;
	
			CODE_0EBD3E:
						CMP.B #$1E                           ;0EBD3E|C91E    |      ;
						BNE CODE_0EBD54                      ;0EBD40|D012    |0EBD54;
						LDA.B r_collisionPointAbsoluteXInRoom;0EBD42|A513    |000013;
						BEQ CODE_0EBD4E                      ;0EBD44|F008    |0EBD4E;
						LDA.B r_coreLoadingFuncAddr          ;0EBD46|A516    |000016;
						BEQ CODE_0EBD54                      ;0EBD48|F00A    |0EBD54;
						INY                                  ;0EBD4A|C8      |      ;
						INY                                  ;0EBD4B|C8      |      ;
						BNE CODE_0EBD54                      ;0EBD4C|D006    |0EBD54;
	
			CODE_0EBD4E:
						LDA.B r_coreLoadingFuncAddr          ;0EBD4E|A516    |000016;
						BNE CODE_0EBD54                      ;0EBD50|D002    |0EBD54;
						INY                                  ;0EBD52|C8      |      ;
						INY                                  ;0EBD53|C8      |      ;
	
			CODE_0EBD54:
						INY                                  ;0EBD54|C8      |      ;
						LDA.B (r_tempCurrGroup),Y            ;0EBD55|B10C    |00000C;
						TAY                                  ;0EBD57|A8      |      ;
						LDA.W animGroup_player_01,Y          ;0EBD58|B901BE  |0EBE01;
						STA.B r_pointerQueue                 ;0EBD5B|8508    |000008;
						LDA.W animGroup_player_01+1,Y                 ;0EBD5D|B902BE  |0EBE02;
						STA.B $09                            ;0EBD60|8509    |000009;
						DEC.W r_entity_AnimTimer,X         ;0EBD62|DE7C05  |0E057C;
						BEQ CODE_0EBD69                      ;0EBD65|F002    |0EBD69;
						CLC                                  ;0EBD67|18      |      ;
						RTS                                  ;0EBD68|60      |      ;
	
	
			CODE_0EBD69:
						LDA.W r_entity_OamBaseOffset,X     ;0EBD69|BD9305  |0E0593;
						STA.B r_roomSectionChrBanksDataOffset;0EBD6C|850F    |00000F;
						ASL A                                ;0EBD6E|0A      |      ;
						CLC                                  ;0EBD6F|18      |      ;
						ADC.B r_roomSectionChrBanksDataOffset;0EBD70|650F    |00000F;
						TAY                                  ;0EBD72|A8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EBD73|B108    |000008;											
						CMP.B #$FF                           ;0EBD75|C9FF    |      ;
						BEQ resetOamSpec                     ;0EBD77|F04D    |0EBDC6;
						
						STY.B $00                            ;0EBD79|8400    |000000;
						LDY.B r_index                        ;0EBD7B|A410    |000010;
						STA.W r_entity_spriteID,Y        ;0EBD7D|990004  |0E0400;
						LDY.B $00                            ;0EBD80|A400    |000000;
						INY                                  ;0EBD82|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EBD83|B108    |000008;
						STA.W r_entity_AnimTimer,X         ;0EBD85|9D7C05  |0E057C;
						INY                                  ;0EBD88|C8      |      ;
						LDA.B r_collisionPointAbsoluteXInRoom;0EBD89|A513    |000013;
						BEQ CODE_0EBD95                      ;0EBD8B|F008    |0EBD95;
						LDA.B #$00                           ;0EBD8D|A900    |      ;
						SEC                                  ;0EBD8F|38      |      ;
						SBC.B (r_pointerQueue),Y             ;0EBD90|F108    |000008;
						JMP.W CODE_0EBD97                    ;0EBD92|4C97BD  |0EBD97;
	
	
			CODE_0EBD95:
						LDA.B (r_pointerQueue),Y             ;0EBD95|B108    |000008;
	
			CODE_0EBD97:
						CLC                                  ;0EBD97|18      |      ;
						ADC.B r_collisionPointAbsoluteXRoom  ;0EBD98|6514    |000014;
						LDY.B r_index                        ;0EBD9A|A410    |000010;
						STA.W r_entity_XPos,Y              ;0EBD9C|993804  |0E0438;
						LDA.W r_entity_ID,X       ;0EBD9F|BD4E05  |0E054E;
						BEQ setNextWeaponFrame                      ;0EBDA2|F02C    |0EBDD0;
	
			setPointer_weaponFrame_damage:
						ASL A                                ;0EBDA4|0A      |      ;
						TAY                                  ;0EBDA5|A8      |      ;
						LDA.W weaponFrame_damage,Y                     ;0EBDA6|B991BE  |0EBE91;
						STA.B r_pointerQueue                 ;0EBDA9|8508    |000008;
						LDA.W weaponFrame_damage+1,Y                 ;0EBDAB|B992BE  |0EBE92;
						STA.B $09                            ;0EBDAE|8509    |000009;
						LDA.B r_roomSectionChrBanksDataOffset;0EBDB0|A50F    |00000F;
						ASL A                                ;0EBDB2|0A      |      ;
						TAY                                  ;0EBDB3|A8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EBDB4|B108    |000008;
						STA.W r_entity_spriteID,X        ;0EBDB6|9D0004  |0E0400;
						INY                                  ;0EBDB9|C8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EBDBA|B108    |000008;
						STA.W r_damagActionFlag,X       ;0EBDBC|9D1D06  |0E061D;
						INC.W r_entity_OamBaseOffset,X     ;0EBDBF|FE9305  |0E0593;
						CLC                                  ;0EBDC2|18      |      ;
						RTS                                  ;0EBDC3|60      |      ;
	
	
	getSlot13_resetOamSpec:
						LDX.B #$13                           ;0EBDC4|A213    |      ;
	
			resetOamSpec:								
						LDA.B #$00                           ;0EBDC6|A900    |      ;
						STA.W r_entity_spriteID,X        ;0EBDC8|9D0004  |0E0400;
						STA.W r_damagActionFlag,X       ;0EBDCB|9D1D06  |0E061D;
						SEC                                  ;0EBDCE|38      |      ;
						RTS                                  ;0EBDCF|60      |      ;
	
	
			setNextWeaponFrame:
						LDY.B r_collisionPointXvalDiv32      ;0EBDD0|A412    |000012;
						CPY.B #$1C                           ;0EBDD2|C01C    |      ;
						BNE setPointer_weaponFrame_damage                      ;0EBDD4|D0CE    |0EBDA4;
						LDA.B #$05                           ;0EBDD6|A905    |      ;
						BNE setPointer_weaponFrame_damage                      ;0EBDD8|D0CA    |0EBDA4;
	
			animGroup_00:
						dw animGroup_00__00                  ;0EBDDA|        |0EBDE0;
						dw animGroup_00__01                  ;0EBDDC|        |0EBDEB;
						dw animGroup_00__02                  ;0EBDDE|        |0EBDF6;
	
		animGroup_00__00:
						db $18,$00,$1A,$00,$1C,$02,$1E,$04   ;0EBDE0|        |      ;
						db $1E,$06,$FF                       ;0EBDE8|        |      ;
	
		animGroup_00__01:
						db $18,$08,$1A,$08,$1C,$0A,$1E,$0C   ;0EBDEB|        |      ;
						db $1E,$0E,$FF                       ;0EBDF3|        |      ;
	
		animGroup_00__02:
						db $18,$10,$1A,$10,$1C,$12,$1E,$14   ;0EBDF6|        |      ;
						db $1E,$16,$FF                       ;0EBDFE|        |      ;
	
	animGroup_player_01:
						dw animPlayer_01_trevorWhip_00       ;0EBE01|        |0EBE19;
						dw animGroup_01__01                  ;0EBE03|        |0EBE23;
						dw animPlayer_01_trevorWhipStairDown_02;0EBE05|        |0EBE2D;
						dw animPlayer_01_trevorWhipStairUp_03;0EBE07|        |0EBE3A;
						dw animPlayer_01_symphaSlash_04      ;0EBE09|        |0EBE47;
						dw animPlayer_01__05                 ;0EBE0B|        |0EBE4E;
						dw animPlayer_01_symphaSlashStairDown_06;0EBE0D|        |0EBE55;
						dw animPlayer_01_symphaSlashStairUp_07;0EBE0F|        |0EBE5F;
						dw animPlayer_01_grantStab_08        ;0EBE11|        |0EBE69;
						dw animPlayer_01__09                 ;0EBE13|        |0EBE73;
						dw animPlayer_01_grantStabStairDown_0a;0EBE15|        |0EBE7D;
						dw animPlayer_01_grantStabStairUp_0b ;0EBE17|        |0EBE87;
	
	animPlayer_01_trevorWhip_00:
						db $18,$05,$00,$1A,$07,$00,$1C,$09   ;0EBE19|        |      ;
						db $00,$FF                           ;0EBE21|        |      ;
	
		animGroup_01__01:
						db $1E,$05,$00,$20,$07,$00,$22,$09   ;0EBE23|        |      ;
						db $00,$FF                           ;0EBE2B|        |      ;
	
	animPlayer_01_trevorWhipStairDown_02:
						db $34,$05,$00,$36,$07,$00,$38,$09   ;0EBE2D|        |      ;
						db $00,$0A,$01,$00,$FF               ;0EBE35|        |      ;
	
	animPlayer_01_trevorWhipStairUp_03:
						db $3A,$05,$00,$3C,$07,$00,$3E,$09   ;0EBE3A|        |      ;
						db $00,$0C,$01,$00,$FF               ;0EBE42|        |      ;
	
	animPlayer_01_symphaSlash_04:
						db $18,$05,$00,$1A,$09,$00,$FF       ;0EBE47|        |      ;
	
		animPlayer_01__05:
						db $1C,$05,$00,$1E,$09,$00,$FF       ;0EBE4E|        |      ;
	
	animPlayer_01_symphaSlashStairDown_06:
						db $24,$05,$00,$26,$09,$00,$0A,$01   ;0EBE55|        |      ;
						db $00,$FF                           ;0EBE5D|        |      ;
	
	animPlayer_01_symphaSlashStairUp_07:
						db $28,$05,$00,$2A,$09,$00,$0C,$01   ;0EBE5F|        |      ;
						db $00,$FF                           ;0EBE67|        |      ;
	
	animPlayer_01_grantStab_08:					
			if !grantNinjaStar == 1
						db $28,$03,$00
						db $44,$06,$00
						db $28,$02,$00  
						db $FF  
			else 	
						db $28,$03,$00
						db $44,$09,$00
						db $28,$02,$00  
						db $FF                          
			endif 
	
	animPlayer_01__09:
						db $46,$03,$00
						db $4A,$09,$00
						db $46,$02,$00		  
						db $FF                         
	
	animPlayer_01_grantStabStairDown_0a:

			if !grantNinjaStar == 1
						db $50,$03,$00
						db $52,$06,$00
						db $0a,$02,$00 
						db $FF 
			else 
						db $50,$03,$00
						db $52,$09,$00
						db $50,$02,$00 
						db $FF                           
			endif 
			
	animPlayer_01_grantStabStairUp_0b:
			if !grantNinjaStar == 1			
						db $4C,$03,$00
						db $4E,$06,$00
						db $0c,$02,$00,$FF 
			else 	
						db $4C,$03,$00
						db $4E,$09,$00
						db $4C,$02,$00,$FF               
			endif 
				weaponFrame_damage:
						dw group_02_trevorWhip0_00                      ;0EBE91|        |0EBEA5;
						dw group_02_trevorWhip1_01                      ;0EBE93|        |0EBEAD;
						dw group_02_trevorWhip02_02                      ;0EBE95|        |0EBEB5;
						dw group_sympha_02_knob_03                      ;0EBE97|        |0EBEBD;
						dw grant_02_knive_04                      ;0EBE99|        |0EBE9D;
						dw group_02_trevorDuck_whip0_05                      ;0EBE9B|        |0EBEC3;
	
			
	
			group_02_trevorWhip0_00:
						db $24,$00,$26,$00,$28,$40,$00,$00   ;0EBEA5|        |      ;
	
			group_02_trevorWhip1_01:
						db $2C,$00,$2E,$00,$30,$60,$00,$00   ;0EBEAD|        |      ;
	
			group_02_trevorWhip02_02:
						db $2C,$00,$2E,$00,$32,$60,$00,$00   ;0EBEB5|        |      ;
	
			group_sympha_02_knob_03:
						db $20,$00,$22,$40,$00,$00           ;0EBEBD|        |      ;

	if !grantNinjaStar == 1		
			grant_02_knive_04:
						db $00,$00,$00,$00,$00,$00,$00,$00	
	else 	
			grant_02_knive_04:
						db $00,$00,$02,$40,$00,$00,$00,$00   ;0EBE9D|        |      ;	
	endif 		
			
			group_02_trevorDuck_whip0_05:
						db $2A,$00,$26,$00,$28,$40,$00,$00   ;0EBEC3|        |      ;  may be was ment for alucard??

				if !jumpControllMovment == 1					; used when ducking but let go while slashing (alucard does not use this) 
																; rather force crouch while swinging. When changing animations it might crash
				else
			characterThrowAnim:								
						LDA.W r_entity_ID         ;0EBECB|AD4E05  |0E054E;
						ASL A                                ;0EBECE|0A      |      ;
						TAY                                  ;0EBECF|A8      |      ;
						LDA.W animGroup_00                   ;0EBED0|ADDABD  |0EBDDA;
						STA.B r_tempCurrGroup                ;0EBED3|850C    |00000C; FIXME?? vanilla bug
						LDA.W animGroup_00+1,Y                 ;0EBED5|B9DBBD  |0EBDDB;
						STA.B r_tempCurrSection              ;0EBED8|850D    |00000D;
						LDY.B #$01                           ;0EBEDA|A001    |      ;
						LDA.B (r_tempCurrGroup),Y            ;0EBEDC|B10C    |00000C;
						TAY                                  ;0EBEDE|A8      |      ;
						LDA.W animGroup_player_01,Y          ;0EBEDF|B901BE  |0EBE01;
						STA.B r_pointerQueue                 ;0EBEE2|8508    |000008;
						LDA.W animGroup_player_01+1,Y                 ;0EBEE4|B902BE  |0EBE02;
						STA.B $09                            ;0EBEE7|8509    |000009;
						LDY.W $05A6                          ;0EBEE9|ACA605  |0E05A6;
						DEY                                  ;0EBEEC|88      |      ;
						BMI CODE_0EBEFC                      ;0EBEED|300D    |0EBEFC;
						TYA                                  ;0EBEEF|98      |      ;
						STA.B r_roomSectionChrBanksDataOffset;0EBEF0|850F    |00000F;
						ASL A                                ;0EBEF2|0A      |      ;
						CLC                                  ;0EBEF3|18      |      ;
						ADC.B r_roomSectionChrBanksDataOffset;0EBEF4|650F    |00000F;
						TAY                                  ;0EBEF6|A8      |      ;
						LDA.B (r_pointerQueue),Y             ;0EBEF7|B108    |000008;
						STA.W r_entity_spriteID          ;0EBEF9|8D0004  |0E0400;
	
			CODE_0EBEFC:
						RTS                                  ;0EBEFC|60      |      ;

				endif 

  }


assert pc() <= $BFFF
pad $3C000
}





!moveStuff = 1			; troubleshoot flag 
if !moveStuff == 1 

{ 	; current hijacks I like to move 

org LAST_BANK+$48F
base $E48F
		LDA.B #$A8                           ;0FE48F|A99C    |      ;		!done 
        JSR.W swapPRGbankStore               ;0FE491|20E6E2  |0FE2E6;
        jsr subtractOneLife                   ;0FE495|        |0E896E;

org LAST_BANK+$5B3
base $E5B3
        LDA.B #$9C                           ;0FE5B3|A99C    |      ;
        JSR.W swapPRGbankStore               ;0FE5B5|20E6E2  |0FE2E6;
        jsr waterSplashInit                   ;0FE5B9|        |0E8C58;
org LAST_BANK+$65A
base $E65A        
		LDA.B #$9C                           ;0FE65A|A99C    |      ;
        JSR.W swapPRGbankStore               ;0FE65C|20E6E2  |0FE2E6;
if !removeTimer == 1	
		nop #$03
else 
        jsr mainlLvLTimerUpdate               ;0FE660|        |0E89A3;
endif 

org LAST_BANK+$6EA
base $E6EA  
		LDA.B #$9C                           ;0FE6EA|A99C    |      ;
        JSR.W backupPRGSwap                  ;0FE6EC|20E0E2  |0FE2E0;
        jsr mainPlayerAnimStuff               ;0FE6F0|        |0E9AB0;
        JMP.W restorePRG                     ;0FE6F2|4C7FE6  |0FE67F;
        
		LDA.B #$9C                           ;0FE6F5|A99C    |      ;
        JSR.W backupPRGSwap                  ;0FE6F7|20E0E2  |0FE2E0;
        jsr updateWeaponFacingSpeed_00        ;0FE6FB|        |0E9B8E;
        JMP.W restorePRG                     ;0FE6FD|4C7FE6  |0FE67F;
        
		LDA.B #$9C                           ;0FE700|A99C    |      ;
        JSR.W backupPRGSwap                  ;0FE702|20E0E2  |0FE2E0;
        jsr updatePlayerFacingSpeed_01        ;0FE706|        |0E9B9A;
        JMP.W restorePRG                     ;0FE708|4C7FE6  |0FE67F;
        
		LDA.B #$9C                           ;0FE70B|A99C    |      ;
        JSR.W backupPRGSwap                  ;0FE70D|20E0E2  |0FE2E0;
        jsr updatePlayerSpeed                 ;0FE711|        |0E9BAF;
        JMP.W restorePRG                     ;0FE713|4C7FE6  |0FE67F;
org LAST_BANK+$1402
base $F402                        
		LDA.B #$A8                           ;0FF402|A99C    |      ;		DONE!
        JSR.W swapPRGbankStore               ;0FF404|20E6E2  |0FE2E6;
        jsr mainTransit_00                    ;0FF408|        |0E8588;
        jsr mainTransit_01                    ;0FF40B|        |0E85B8;
        jsr mainTransit_02                       ;0FF40E|        |0E8642;
org LAST_BANK+$14D4
base $F4D4
		LDA.B #$A8                           ;0FF4D4|A99C    |      ; 		DONE!
        JSR.W swapPRGbankStore               ;0FF4D6|20E6E2  |0FE2E6;
        jmp lunchStageMusic                   ;0FF4DA|        |0EBC29;
org LAST_BANK+$150E
base $F50E 
		LDA.B #$A8                           ;0FF50E|A99C    |      ;		DONE!
        JSR.W swapPRGbankStore               ;0FF510|20E6E2  |0FE2E6;
        jsr update_playerBehindBG_fogEffect             ;0FF514|        |0E8529;
org LAST_BANK+$15DD
base $F5DD
        LDA.B #$9C                           ;0FF5DD|A99C    |      ;		
        JSR.W swapPRGbankStore               ;0FF5DF|20E6E2  |0FE2E6;
        jsr mainAutoPlayProcess               ;0FF5E3|        |0E8570;
org LAST_BANK+$172B
base $F72B
        LDA.B #$A8                           ;0FF72B|A99C    |      ;		DONE!
        JSR.W swapPRGbankStore               ;0FF72D|20E6E2  |0FE2E6;
        jsr mainTransit_00                    ;0FF731|        |0E8588;
        jsr mainTransit_01                    ;0FF734|        |0E85B8;		
org LAST_BANK+$18A7
base $F8A7
		LDA.B #$A8                           ;0FF8A7|A99C    |      ;		DONE!
		JSR.W swapPRGbankStore               ;0FF8A9|20E6E2  |0FE2E6;
		jsr mainTransit_00                    ;0FF8AD|        |0E8588;
		jsr mainTransit_01                    ;0FF8B0|        |0E85B8;
		jsr mainTransit_02                    ;0FF8B3|        |0E8642;


org LAST_BANK+$1B95
base $FB95		
		LDA.B #$A8 							; ending player sprite 
org $2BA27
base $BA27
	endingSpriteRelated: 
		dw endingSpriteID_00                 ;0ABA27|        |0EBF16;
        dw endingSpriteID_01                 ;0ABA29|        |0EBF4D;
        dw endingSpriteID_02                 ;0ABA2B|        |0EBF75;
        dw endingSpriteID_03                 ;0ABA2D|        |0EBEFD;
        dw endingSpriteID_04                 ;0ABA2F|       

;org LAST_BANK+$1BD3
;base $FBD3	
;		LDA.B #$A8	9C						; loadBank_E		donno where this is used 

;org LAST_BANK+$1BF0
;base $FBF0	
;		LDA.B #$A8  9C

;org LAST_BANK+$1EB4
;base $FEB4	  
;       LDA.B #$A8  9C                 

; needed for moving.. 
;org LAST_BANK+$1BE8						; needs to be moved from sprite data I guess 
;base $FBE8
;crumbleBlock: 
;		LDA.B #$9a                           	;0FFBE8|A99A    |      ;
;		JSR.W swapPRGbankStore               	;0FFBEA|20E6E2  |0FE2E6;

; 		needed to make bosses area scroll..        
;		LDA.W r_e_Player_StateDoubled        ;0FF7E4|AD6505  |0E0565;
;        ORA.B r_deathDelay                   ;0FF7E7|05BF    |0000BF;
;        BMI $32
;        LDA.B r_bossActiveFlag               ;0FF7EB|A578    |000078;
;        BNE $03
;        JSR.W scrollXposUpdate               ;0FF7EF|2075D1  |0FD175;


pullPC

		subtractOneLife:
						LDA.B r_lifes                        ;0E896E|A535    |000035;
						AND.B #$0F                           ;0E8970|290F    |      ;
						STA.B $01                            ;0E8972|8501    |000001;
						LDA.B r_lifes                        ;0E8974|A535    |000035;
						AND.B #$F0                           ;0E8976|29F0    |      ;
						STA.B $02                            ;0E8978|8502    |000002;
						LDA.B $01                            ;0E897A|A501    |000001;
						
		if !deathCouter == 1		
						clc 
						adc #$01					
						cmp #$0a
						bne CODE_0E8991		
						lda #$00		
						STA.B $01                            
						LDA.B $02                                                             
						clc 
						adc.B #$10                           
						STA.B $02                            
						LDA.B $01                            
						AND.B #$0F                           
			CODE_0E8991:											
		else 
						SEC                                  ;0E897C|38      |      ;
						SBC.B #$01                           ;0E897D|E901    |      ;	
						BPL CODE_0E8991                      ;0E897F|1010    |0E8991;
						SEC                                  ;0E8981|38      |      ;
						SBC.B #$06                           ;0E8982|E906    |      ;
						STA.B $01                            ;0E8984|8501    |000001;
						LDA.B $02                            ;0E8986|A502    |000002;
						SEC                                  ;0E8988|38      |      ;
						SBC.B #$10                           ;0E8989|E910    |      ;
						STA.B $02                            ;0E898B|8502    |000002;
						LDA.B $01                            ;0E898D|A501    |000001;
						AND.B #$0F                           ;0E898F|290F    |      ;	
			CODE_0E8991:
				
		endif		
						ORA.B $02                            ;0E8991|0502    |000002;
						STA.B r_lifes                        ;0E8993|8535    |000035;
						RTS                                  ;0E8995|60      |      ;



; -------------------------------------------------------


		lunchStageMusic:
						LDA.B r_stageMusicResetFlag          ;0EBC29|A574    |000074;
						BEQ CODE_0EBC2E                      ;0EBC2B|F001    |0EBC2E;
						RTS                                  ;0EBC2D|60      |      ;
	
	
			CODE_0EBC2E:
						INC.B r_stageMusicResetFlag          ;0EBC2E|E674    |000074;
						LDY.B r_stage                        ;0EBC30|A432    |000032;
						CPY.B #$0E                           ;0EBC32|C00E    |      ;
						BEQ finalStageMusic                  ;0EBC34|F006    |0EBC3C;
	
			CODE_0EBC36:
						LDA.W stageMusicIDs,Y                ;0EBC36|B945BC  |0EBC45;
						db $4C                               ;0EBC39|        |      ;
	
						dw lunchMusic                        ;0EBC3A|        |0FE25F;
	
		finalStageMusic:
						LDA.B r_blockLevel                   ;0EBC3C|A533    |000033;
						CMP.B #$02                           ;0EBC3E|C902    |      ;
						BNE CODE_0EBC36                      ;0EBC40|D0F4    |0EBC36;
						INY                                  ;0EBC42|C8      |      ;
						BNE CODE_0EBC36                      ;0EBC43|D0F1    |0EBC36;
	
			stageMusicIDs:
						db $4F,$53,$50,$56,$55,$51,$52,$57   ;0EBC45|        |      ;
						db $54,$58,$59,$5A,$5B,$5C,$5D,$5E   ;0EBC4D|        |      ;
	


; -------------------------------------------------------



		mainTransit_00:
						LDA.B r_roomOrientation              ;0E8588|A568    |000068;
						BMI CODE_0E85B7                      ;0E858A|302B    |0E85B7;
						LDA.B r_sceneScrollOffsetHi          ;0E858C|A557    |000057;
						BMI CODE_0E85A6                      ;0E858E|3016    |0E85A6;
						CMP.B r_scroolLock                   ;0E8590|C571    |000071;
						BEQ CODE_0E8595                      ;0E8592|F001    |0E8595;
						RTS                                  ;0E8594|60      |      ;
	
	
			CODE_0E8595:
						LDA.B r_sceneScrollOffsetLo          ;0E8595|A556    |000056;
						CLC                                  ;0E8597|18      |      ;
						ADC.W r_entity_XPos                ;0E8598|6D3804  |0E0438;
						STA.W r_entity_XPos                ;0E859B|8D3804  |0E0438;
						LDA.B r_scroolLock                   ;0E859E|A571    |000071;
						STA.B r_sceneScrollOffsetHi          ;0E85A0|8557    |000057;
						LDA.B #$00                           ;0E85A2|A900    |      ;
						BEQ CODE_0E85B3                      ;0E85A4|F00D    |0E85B3;
	
			CODE_0E85A6:
						LDA.B r_sceneScrollOffsetLo          ;0E85A6|A556    |000056;
						CLC                                  ;0E85A8|18      |      ;
						ADC.W r_entity_XPos                ;0E85A9|6D3804  |0E0438;
						STA.W r_entity_XPos                ;0E85AC|8D3804  |0E0438;
						LDA.B #$00                           ;0E85AF|A900    |      ;
						STA.B r_sceneScrollOffsetHi          ;0E85B1|8557    |000057;
	
			CODE_0E85B3:
						STA.B r_sceneScrollOffsetLo          ;0E85B3|8556    |000056;
						STA.B r_subSceneOffsets              ;0E85B5|8558    |000058;
	
			CODE_0E85B7:
						RTS                                  ;0E85B7|60      |      ;
	
	
		mainTransit_01:
						LDA.B #$00                           ;0E85B8|A900    |      ;
						STA.B r_subSceneOffsets              ;0E85BA|8558    |000058;
						LDA.W r_Player_StateDoubled        ;0E85BC|AD6505  |0E0565;
						CMP.B #$16                           ;0E85BF|C916    |      ;
						BNE CODE_0E8611                      ;0E85C1|D04E    |0E8611;
						LDA.B r_roomOrientation              ;0E85C3|A568    |000068;
						BMI CODE_0E8612                      ;0E85C5|304B    |0E8612;
						LDA.B r_PrevRoomOrientation          ;0E85C7|A573    |000073;
						BMI CODE_0E8616                      ;0E85C9|304B    |0E8616;
						LDX.B #$00                           ;0E85CB|A200    |      ;
	
			CODE_0E85CD:
						LDA.W r_entity_Yspd                ;0E85CD|AD2005  |0E0520;
						BMI CODE_0E85D6                      ;0E85D0|3004    |0E85D6;
						INX                                  ;0E85D2|E8      |      ;
						INX                                  ;0E85D3|E8      |      ;
						INX                                  ;0E85D4|E8      |      ;
						INX                                  ;0E85D5|E8      |      ;
	
			CODE_0E85D6:
						LDA.W r_entity_AI              ;0E85D6|ADEF05  |0E05EF;
						BEQ CODE_0E85DD                      ;0E85D9|F002    |0E85DD;
						INX                                  ;0E85DB|E8      |      ;
						INX                                  ;0E85DC|E8      |      ;
	
			CODE_0E85DD:
						LDA.W data_xPos_00,X                 ;0E85DD|BD1A86  |0E861A;
						CLC                                  ;0E85E0|18      |      ;
						ADC.W r_entity_XPos                ;0E85E1|6D3804  |0E0438;
						STA.W r_entity_XPos                ;0E85E4|8D3804  |0E0438;
						LDA.W data_yPos_00,X                 ;0E85E7|BD1B86  |0E861B;
						STA.W r_entity_YPos                ;0E85EA|8D1C04  |0E041C;
						LDY.W r_entity_ID         ;0E85ED|AC4E05  |0E054E;
						LDA.W data_yPos_01,Y                 ;0E85F0|B93286  |0E8632;
						CLC                                  ;0E85F3|18      |      ;
						ADC.W r_entity_YPos                ;0E85F4|6D1C04  |0E041C;
						STA.W r_entity_YPos                ;0E85F7|8D1C04  |0E041C;
						LDA.W r_entity_XPos                ;0E85FA|AD3804  |0E0438;
						LDX.W r_entity_AI              ;0E85FD|AEEF05  |0E05EF;
						BEQ CODE_0E860A                      ;0E8600|F008    |0E860A;
						CLC                                  ;0E8602|18      |      ;
						ADC.W data_yPos_01,Y                 ;0E8603|793286  |0E8632;
						STA.W r_entity_XPos                ;0E8606|8D3804  |0E0438;
						RTS                                  ;0E8609|60      |      ;
	
	
			CODE_0E860A:
						SEC                                  ;0E860A|38      |      ;
						SBC.W data_yPos_01,Y                 ;0E860B|F93286  |0E8632;
						STA.W r_entity_XPos                ;0E860E|8D3804  |0E0438;
	
			CODE_0E8611:
						RTS                                  ;0E8611|60      |      ;
	
	
			CODE_0E8612:
						LDX.B #$08                           ;0E8612|A208    |      ;
						BNE CODE_0E85CD                      ;0E8614|D0B7    |0E85CD;
	
			CODE_0E8616:
						LDX.B #$10                           ;0E8616|A210    |      ;
						BNE CODE_0E85CD                      ;0E8618|D0B3    |0E85CD;
	
			data_xPos_00:
						db $18                               ;0E861A|        |      ;
	
			data_yPos_00:
						db $D0,$E8,$D0,$EC,$28,$15,$28,$19   ;0E861B|        |      ;
						db $D3,$E8,$D3,$F3,$33,$0D,$33,$11   ;0E8623|        |      ;
						db $D0,$F0,$D0,$EB,$28,$15,$28       ;0E862B|        |      ;
	
			data_yPos_01:
						db $00,$00,$04,$00                   ;0E8632|        |      ;
	
			CODE_0E8636:
						LDA.B r_sceneScrollOffsetLo          ;0E8636|A556    |000056;
						BEQ CODE_0E866F                      ;0E8638|F035    |0E866F;
						CLC                                  ;0E863A|18      |      ;
						ADC.W r_entity_XPos                ;0E863B|6D3804  |0E0438;
						STA.W r_entity_XPos                ;0E863E|8D3804  |0E0438;
						RTS                                  ;0E8641|60      |      ;
	
	
			mainTransit_02:
						LDA.B r_roomOrientation              ;0E8642|A568    |000068;
						BMI CODE_0E8636                      ;0E8644|30F0    |0E8636;
						LDA.W r_entity_XPos                ;0E8646|AD3804  |0E0438;
						BMI CODE_0E867A                      ;0E8649|302F    |0E867A;
						LDA.B r_sceneScrollOffsetLo          ;0E864B|A556    |000056;
						ORA.B r_sceneScrollOffsetHi          ;0E864D|0557    |000057;
						BEQ CODE_0E8679                      ;0E864F|F028    |0E8679;
						LDA.B #$80                           ;0E8651|A980    |      ;
						SEC                                  ;0E8653|38      |      ;
						SBC.W r_entity_XPos                ;0E8654|ED3804  |0E0438;
						STA.B r_pointerQueue                 ;0E8657|8508    |000008;
						LDA.B r_sceneScrollOffsetLo          ;0E8659|A556    |000056;
						SEC                                  ;0E865B|38      |      ;
						SBC.B r_pointerQueue                 ;0E865C|E508    |000008;
						BCS CODE_0E8672                      ;0E865E|B012    |0E8672;
						LDY.B r_sceneScrollOffsetHi          ;0E8660|A457    |000057;
						DEY                                  ;0E8662|88      |      ;
						BPL CODE_0E8670                      ;0E8663|100B    |0E8670;
						CLC                                  ;0E8665|18      |      ;
						ADC.B #$80                           ;0E8666|6980    |      ;
						STA.W r_entity_XPos                ;0E8668|8D3804  |0E0438;
						LDA.B #$00                           ;0E866B|A900    |      ;
						STA.B r_sceneScrollOffsetLo          ;0E866D|8556    |000056;
	
			CODE_0E866F:
						RTS                                  ;0E866F|60      |      ;
	
	
			CODE_0E8670:
						STY.B r_sceneScrollOffsetHi          ;0E8670|8457    |000057;
	
			CODE_0E8672:
						STA.B r_sceneScrollOffsetLo          ;0E8672|8556    |000056;
						LDA.B #$80                           ;0E8674|A980    |      ;
						STA.W r_entity_XPos                ;0E8676|8D3804  |0E0438;
	
			CODE_0E8679:
						RTS                                  ;0E8679|60      |      ;
	
	
			CODE_0E867A:
						LDA.B r_sceneScrollOffsetHi          ;0E867A|A557    |000057;
						CMP.B r_scroolLock                   ;0E867C|C571    |000071;
						BEQ CODE_0E8679                      ;0E867E|F0F9    |0E8679;
						LDA.W r_entity_XPos                ;0E8680|AD3804  |0E0438;
						SEC                                  ;0E8683|38      |      ;
						SBC.B #$80                           ;0E8684|E980    |      ;
						BEQ CODE_0E8679                      ;0E8686|F0F1    |0E8679;
						STA.B r_pointerQueue                 ;0E8688|8508    |000008;
						LDA.B r_sceneScrollOffsetLo          ;0E868A|A556    |000056;
						CLC                                  ;0E868C|18      |      ;
						ADC.B r_pointerQueue                 ;0E868D|6508    |000008;
						BCC CODE_0E8672                      ;0E868F|90E1    |0E8672;
						LDY.B r_sceneScrollOffsetHi          ;0E8691|A457    |000057;
						INY                                  ;0E8693|C8      |      ;
						CPY.B r_scroolLock                   ;0E8694|C471    |000071;
						BNE CODE_0E8670                      ;0E8696|D0D8    |0E8670;
						CLC                                  ;0E8698|18      |      ;
						ADC.B #$80                           ;0E8699|6980    |      ;
						STA.W r_entity_XPos                ;0E869B|8D3804  |0E0438;
						STY.B r_sceneScrollOffsetHi          ;0E869E|8457    |000057;
						LDA.B #$00                           ;0E86A0|A900    |      ;
						STA.B r_sceneScrollOffsetLo          ;0E86A2|8556    |000056;
						RTS                                  ;0E86A4|60      |      ;
	
						CLC                                  ;0E86A5|18      |      ;
						ADC.W r_entity_YsubSpd             ;0E86A6|6D3705  |0E0537;
						STA.W r_entity_YsubSpd             ;0E86A9|8D3705  |0E0537;
						LDA.B #$00                           ;0E86AC|A900    |      ;
						ADC.W r_entity_Yspd                ;0E86AE|6D2005  |0E0520;
						STA.W r_entity_Yspd                ;0E86B1|8D2005  |0E0520;
						RTS                                  ;0E86B4|60      |      


; -------------------------------------------------------




	update_playerBehindBG_fogEffect:
						LDY.B #$00                           ;0E852D|A000    |      ;	
			checkStairStateLoop: 
						LDA.W allStairStates,Y               ;0E852F|B96185  |0E8561;
						CMP.B #$FF                           ;0E8532|C9FF    |      ;
						BEQ updateAtribute                   ;0E8534|F00F    |0E8545;
						INY                                  ;0E8536|C8      |      ;
						CMP.W r_Player_StateDoubled          ;0E8537|CD6505  |0E0565;
						BNE checkStairStateLoop
	
			putPlayerInFrontOfBG: 						
						LDA.W r_entity_PaletteOverride       ;0E853C|AD5404  |0E0454;
						AND.B #$DF                           ;0E853F|29DF    |      ;
						STA.W r_entity_PaletteOverride       ;0E8541|8D5404  |0E0454;	
						RTS                                  ;0E8544|60      |      ;
	
		
			updateAtribute: 
			
		if !putAllSpritesBehindFog == 1
						
						ldy.b #$17 
					-	lda.w r_entity_PaletteOverride,y 
						ora #$21							; would be cool to have a addres to just put stuff in bg.. but you can make it work
						sta.w r_entity_PaletteOverride,y 
						dey 
						bne -
						lda #$20 
						sta.w r_entity_PaletteOverride
						rts 
		else						
						
						LDA.B r_roomEffect                   ;0E8545|A57D    |00007D;
						AND.B #$0F                           ;0E8547|290F    |      ;
						ASL A                                ;0E8549|0A      |      ;
						TAY                                  ;0E854A|A8      |      ;												
						LDA.W r_entity_YPos                  ;0E854B|AD1C04  |0E041C;
						CMP.W yPos2_fogEffect_top,Y          ;0E854E|D96885  |0E8568;
						BCC putPlayerInFrontOfBG             ;0E8551|90E9    |0E853C;
						CMP.W yPos2_fogEffect_bot,Y          ;0E8553|D96985  |0E8569;
						BCS putPlayerInFrontOfBG             ;0E8556|B0E4    |0E853C;								
						
						LDA.W r_entity_PaletteOverride       ;0E8558|AD5404  |0E0454;
						ORA.B #$20                           ;0E855B|0920    |      ;
						STA.W r_entity_PaletteOverride       ;0E855D|8D5404  |0E0454;
						RTS                                  ;0E8560|60      |      ;
	
	yPos2_fogEffect_top: 
							db $40                               ;0E8568|        |      ;
	yPos2_fogEffect_bot: 	db $A5
							db $80,$C5
							db $20,$60
							db $B0,$E0  	
		endif 
	
		allStairStates: 
							db $0E,$10,$12,$14,$1E,$24,$FF       ;0E8561|        |      ;	
    
 



; ---------------------------------------------------------------------------------
;							+------------------- r_stage|r_blockLevel
;							|   +--------------- r_roomIdx|r_sceneScrollOffsetHi	
;							|   |   +----------- r_sceneScrollOffsetLo	
;							|   |   |	+------- 07A1, 	
;							|   |   |	|   +--- r_a_entity_ObjectIdxes 	
    endingSpriteID_00: 	db $41,$20,$01,$01,$02
;							+------------------- r_a_entity_OamSpecGroupDoubled		
;							|   +--------------- r_a_OamSpecIdxDoubled				
;							|   |   +----------- r_a_entity_XPos		
;							|   |   |	+------- r_a_entity_YPos		
;							|   |   |	|   +--- r_a_entity_FacingLeft			
;							|   |   |	|	|  + r_a_entity_ObjectIdxes	= 01												
						db $2C,$30,$60,$00,$02
						db $4A,$10,$44,$00,$02
						db $4A,$24,$34,$00,$02
						db $4A,$3C,$34,$00,$02
						db $4A,$50,$44,$00,$02
						db $4A,$58,$58,$00,$08
						db $8C,$A8,$40,$01,$08
						db $8E,$C8,$70,$01,$0E
						db $04,$90,$48,$01,$0E
						db $04,$D0,$48,$01,$FF     
 
    endingSpriteID_01: 	db $11,$01,$00,$02,$04             
						db $1C,$D8,$42,$00,$00             
						db $4E,$A4,$42,$01,$08             
						db $B6,$5F,$40,$00,$0C             
						db $3C,$5B,$B6,$01,$0C             
						db $3A,$46,$9C,$01,$0C             
						db $36,$26,$8E,$01,$0C             
						db $38,$08,$93,$00,$FF             
	
    endingSpriteID_02: 	db $81,$03,$01,$03,$06             
						db $36,$1D,$75,$00,$08             
						db $46,$56,$49,$01,$08             
						db $46,$63,$71,$01,$08             
						db $44,$D0,$90,$01,$FF             
	
    endingSpriteID_03: 	db $21,$02,$00,$00,$00             
						db $02,$BF,$A2,$01,$12             
						db $0A,$74,$72,$00,$12             
						db $04,$B0,$80,$00,$0E             
						db $0C,$10,$A0,$00,$FF             
	
	endingSpriteID_04: 	db $B1,$02,$00,$00,$00							
						db $02,$B0,$A0,$01,$08
						db $32,$48,$50,$00,$0E
						db $38,$70,$4C,$00,$0E
						db $04,$58,$7C,$01,$0E
						db $04,$C0,$38,$01,$FF    
           

; -------------------------------------------------------













; -------------------------------------------------------


pushPC

endif 

}
