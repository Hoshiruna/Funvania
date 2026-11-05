

pullPC 
  
  mainGameHijack:   
    
    jsr updateHeldButtonFlag
 
    if !levelSelect == 1
      lda.b r_Joy1Held
      and #$10
      beq endLevelSelect  ; check hold start 
      lda.b r_Joy1
      and #$20      ; check select
      beq endLevelSelect
      lda.b #GS_DEBUG_MODE
      sta.b r_gameState
      lda #$00
      sta.b r_gameSubstate
    ; jsr mainTransite_3  ; get current level and such 
      
    endLevelSelect:
      
    endif 
   
    if !CHR_paralex == 1
      newParalexScroll:
        lda.b r_roomEffect
        cmp #$48        ; can be set in "data_table.asm" => IRQ effect table
        bne +
        
        lda.b r_sceneScrollOffsetLo
        lsr           
        lsr
        lsr
        lsr 
        tax
        lda.w animParlX,x     ; read current offset and store to bank update table 
        sta.b r_CHR_BankBG_0400 
        bne + 
    
      animParlX:
        db $54,$55,$56,$54
        db $55,$56,$54,$55
        db $56,$54,$55,$56
        db $54,$55,$56,$54       
      +
    endif       
    
    
    
    lda.b r_pauseFlag
    bne +
    jsr runWhile_unpaused
  + rts 


  whilePauseHijack:
    
    if !levelSelect == 1
      
      
      { ; !cheats == 1
  
          ldx.b r_partnerIdx        
        selectModefyer:     
          lda.b r_Joy1Held
          and #$20
          beq getItemAB         

          lda.b r_Joy1    
          and #$40
          beq ++
          inc.b r_trevorWhipLevel,x
          lda.b r_trevorWhipLevel,x
          and #$03
          cmp #$03
          bne +
          lda #$00
        + sta.b r_trevorWhipLevel,x       
        ++  
        
          jmp endGiveCheats
        
        getItemAB:  
          lda.b r_Joy1
          and #$80
          beq ++
          lda.b r_subweapMultiplier,x 
          clc 
          adc #$01
          cmp #$03
          bne +
          lda #$00          
        
        + sta.b r_subweapMultiplier,x   
          jsr updateSpritesMulti    
          
        ++  lda.b r_Joy1
          and #$40
          beq getRemoveHearts
           
          lda.b r_subweap,x   
          clc
          adc #$01
          cmp #$0c
          bne +
          lda #$00
          
        + sta.w r_subweap,x
          jsr updateSpritesSubw
    
        getRemoveHearts:
          lda.b r_Joy1Held
          and #$03
          beq getRemoveHealth
          cmp #$02 
          beq +
          lda #$01
          jsr mainUpdateHeartCount_HUD
          jmp ++
          
        + lda.b r_hearts
          beq getRemoveHealth
          lda #$01
          jsr addHeart_A 
          
        ++  jsr updateHUDheart      
          
        getRemoveHealth:
          lda.b r_Joy1Held
          and #$0c
          beq endGiveCheats
          cmp #$04
          beq +
          lda #$3f
          cmp.b r_HUD_healthPlayer
          bcc endGiveCheats
          inc.b r_HUD_healthPlayer
          jmp ++
        
        + lda.b r_HUD_healthPlayer
          beq ++
          dec.b r_HUD_healthPlayer 
        
        ++  lda #$a6    ; updateHealth_HUD>>8
          sta $00 
          lda #$8c    ; updateHealth_HUD
          sta $01   
          lda #$80 
          jsr runRAM_00_inBankA
        
        endGiveCheats:        
        }
        
        
    endif 
    
    if !debuggMenu == 1   
      
    
      
      
      
      
      if !sprite_viewer == 1
  
        spriteViewer:           
          lda.w sr_heldButtonFlag_0F
          bne +       
          
          
          lda.b r_Joy1Held
          and #$40
          beq +
          inc $0c
        + lda $0c 
          and #$7f
          sta $0c
        
          lda.b r_Joy1  
          and #$80
          beq +
        
          inc.w r_subWe_CHRbank   
          inc.w r_subWe_CHRbank
          
          lda #$1e 
          cmp.w r_subWe_CHRbank
          bne + 
          lda #$00
          sta.w r_subWe_CHRbank 
        
        + lda.w sr_heldButtonFlag_0F    ; chr rotate held
          bne ++
          
          lda.b r_Joy1Held    
          and #$04
          beq +
          inc.w r_subWe_HUD_IDX
          inc.w r_subWe_HUD_IDX
        
        + lda.b r_Joy1Held      
          and #$08
          beq ++
          lda.w r_subWe_HUD_IDX
          beq ++
          dec.w r_subWe_HUD_IDX
          dec.w r_subWe_HUD_IDX         

          
        ++
          lda.b r_Joy1      ; chr rotate
          and #$04
          beq +
          inc.w r_subWe_HUD_IDX
          inc.w r_subWe_HUD_IDX
        
        + lda.b r_Joy1      
          and #$08
          beq +
          lda.w r_subWe_HUD_IDX
          beq +
          dec.w r_subWe_HUD_IDX
          dec.w r_subWe_HUD_IDX 
        
        
        
        + lda.b r_Joy1      ; chr idx rotate 3 slots 
          and #$01
          beq +
          inc.b $0d
          lda.b $0d  
          and #$07
          sta.b $0d 
          
        +     
          lda.b r_Joy1      ; resetStates select 
          and #$20
          beq +
          lda #$00
          sta.b $0c
          sta.w r_subWe_CHRbank
          sta.w r_subWe_HUD_IDX
        
        + ldx $0d               ; update chr 
          lda $0c 
          sta.b r_CHR_BankSpr_0000,x 
        
        +
          lda #$54              ; fix XY pos 
          sta.w r_subWe_HUD_YPos
          lda #$90
          sta.w r_subWe_HUD_XPos        
      
          jsr enemyCHR000_Bank2REG
          jsr enemyCHR800_Bank2REG
          ;jsr BG_CHR_Bank2REG
      
          lda.b #updateStageBlock_HUD
          sta $00
          lda.b #updateStageBlock_HUD>>8
          sta $01
          lda #$80
          jsr runRAM_00_inBankA
      endif
  

  
    endif 





    
    rts 


  runWhile_unpaused:
    
    
    
    
    rts



{ ; general new routines 
    
    
    updateHeldButtonFlag:
      ldy.b #BUTTONE_DELAY  
      lda.b r_Joy1
      cmp.b r_Joy1Held
      beq +
      dec.w sr_heldButtonFlag_0F
      lda.w sr_heldButtonFlag_0F
      bpl ++
      ldy #$00
    + sty.w sr_heldButtonFlag_0F
    ++  rts 
    
    
    updateSpritesMulti:
      tay
      lda.w MultiplayerSpriteID,y 
      sta.w r_subMulti_HUD_IDX
      lda #$0e
      sta.w r_subMulti_CHRbank
      rts  
    updateSpritesSubw:
      tay
      lda SubWeaponSpriteID,y 
      sta.w r_subWe_HUD_IDX
      lda.w SubWeaponSpriteBankID,y 
      sta.w r_subWe_CHRbank
      
      lda #$24    ; fix XY pos 
      sta.w r_subWe_HUD_YPos
      lda #$90
      sta.w r_subWe_HUD_XPos
      rts 
    MultiplayerSpriteID:
      db $00,$58,$5a 
    SubWeaponSpriteID:
      db $00,$46,$42
      db $4E,$50,$52
      db $54,$4E,$4E
      db $46,$50,$68 
    SubWeaponSpriteBankID:
      db $00,$00,$00
      db $00,$00,$02
      db $02,$02,$00
      db $00,$00,$0E  
    
    updateHUDheart:
        LDA.B #$20                         
            STA.B r_VRAM_QueueDestHi           
            LDA.B #$77                         
            STA.B r_VRAM_QueueDestLo           
            LDA.B r_hearts                     
            STA.B r_pointerQueue               
            jmp updateQueueWithNumber                         
 
      rts 
  
;   backupRestorePlayerState:
;     ldy #$0b
;     
;     lda.b r_Joy1
;     cmp #$02
;     beq copyPlayerStats
;     cmp #$01
;     beq savePlayerStates
;     rts
;   
;   copyPlayerStats:  
;     lda $84,y
;     sta SR_playerStateBackup,y
;     dey 
;     bne copyPlayerStats
;     lda $3b         ; player ID used for upgrades resived
;     sta SR_playerStateBackup
;     rts
;   
;   savePlayerStates:
;     lda SR_playerStateBackup,y
;     sta $84,y
;     dey 
;     bne savePlayerStates
;     lda SR_playerStateBackup
;     sta $3b
;     rts 


  displayStageName: 
      LDA.w stageNameDest,y                          
            STA.B r_VRAM_QueueDestLo             
            LDA.w stageNameDest+1,y                         
            STA.B r_VRAM_QueueDestHi      
    
      LDA.W r_stage
            ASL A                                
            TAY                                  
            LDA.W textStages,Y         
            STA.B r_pointerQueue                 
            LDA.W textStages+1,Y                 
            STA.B $09                            
            jsr updateVRAM_1                      
            LDY.B #$00                           
 
        CODE_0CA275: 
      LDA.B (r_pointerQueue),Y             
            CMP.B #$FF                           
            BNE CODE_0CA27E                      
            
      lda #$00      ; fill space
    - cpy #$0E       
      bcs +
      STA.W r_VramQueue,X
      inx 
      iny       
      jmp -
    + jmp endVRAM_queue                    

    CODE_0CA27E: 
      STA.W r_VramQueue,X                
            INX                                  
            INY                                  
            BNE CODE_0CA275                      

  stageNameDest:
    dw $20AA,$2024,$2052


    makeLevelPointer:
      lda.b #stageTables>>8
      sta.b $01
      lda.b #stageTables
      sta.b $00
      rts     
    
    add_lvl_Index2Pointer:
      lda.w sr_lvl_IDX_00
    addIndex2Pointer: 
      pha 
      bpl +
      inc $01
    + asl 
      clc 
      adc $00
      sta $00
      lda #$00    ; add carry when rollover 
      adc $01
      sta $01
      
      pla       ; lda.w sr_lvl_IDX_00
      clc 
      adc $00
      sta $00
      lda #$00
      adc $01
      sta $01
      rts 
  

    ;add_lvl_Index2Pointer:       ; math register use FIXME 
    ; jsr getLevelPointerOffset
    ; lda.w $5205 
    ; clc 
    ; adc $00
    ; sta $00
    ; lda #$00          ; add carry when rolover 
    ; adc $01
    ; sta $01
    ; 
    ; jsr getLevelPointerOffset
    ; lda.w $5206   ; fix me does not hold value as I expect
    ; clc 
    ; adc $00
    ; sta $00
    ; rts 
    ;
    ;getLevelPointerOffset:
    ; lda.w sr_lvl_IDX_00
    ; sta.w $5205
    ; lda #$03
    ; sta.w $5206
    ; rts 
    
    textStages:   ; max lanth for HUD 13 
      dw text_stage_01  
      dw text_stage_02  
      dw text_stage_03  
      dw text_stage_04  
      dw text_stage_05  
      dw text_stage_06  
      dw text_stage_07  
      dw text_stage_08  
      dw text_stage_09  
      dw text_stage_0a  
      dw text_stage_0b  
      dw text_stage_0c  
      dw text_stage_0d  
      dw text_stage_0e  
      dw text_stage_0f 
    
    text_stage_01: db "    WALLACHIA",$FF     
    text_stage_02: db "  CLOCK TOWER",$FF     
    text_stage_03: db "   MAD FOREST",$FF     
    text_stage_04: db "SHIP OF FOOLS",$FF     
    text_stage_05: db " TOWER TERROR",$FF       
    text_stage_06: db "     CAUSEWAY",$FF     
    text_stage_07: db "  MURKY MARSH",$FF     
    text_stage_08: db "ALUCARDS CAVE",$FF     
    text_stage_09: db "  SUNKEN CITY",$FF     
    text_stage_0a: db "    CATACOMBS",$FF     
    text_stage_0b: db "MOUNTAIN VIEW",$FF     
    text_stage_0c: db "    COURTYARD",$FF       
    text_stage_0d: db "  CASTLE HALL",$FF     
    text_stage_0e: db "ELUSION TOWER",$FF       
    text_stage_0f: db "DRACUL QUATER",$FF 

  { ;stage table    
    stageTables:
      db $00,$00,$00 ; stage 1-01
      db $00,$01,$00 ; stage 1-02
      db $00,$01,$01 ; stage 1-02
      db $00,$01,$03 ; stage 1-02
      db $00,$01,$02 ; stage 1-02
      db $00,$02,$01 ; stage 1-03
      db $00,$02,$00 ; stage 1-03
      db $00,$03,$00 ; stage 1-04
      db $01,$00,$00 ; stage 2-01
      db $01,$00,$01 ; stage 2-01
      db $01,$00,$02 ; stage 2-01
      db $01,$01,$00 ; stage 2-02
      db $01,$01,$01 ; stage 2-02
      db $01,$01,$02 ; stage 2-02
      db $01,$02,$00 ; stage 2-03
      db $01,$02,$01 ; stage 2-03
      db $01,$02,$02 ; stage 2-03
      db $01,$03,$02 ; stage 2-04
      db $01,$03,$01 ; stage 2-04
      db $01,$03,$00 ; stage 2-04     
      db $01,$04,$02 ; stage 2-05
      db $01,$04,$01 ; stage 2-05     
      db $01,$04,$00 ; stage 2-05
      db $01,$05,$02 ; stage 2-06
      db $01,$05,$01 ; stage 2-06
      db $01,$05,$00 ; stage 2-06
      db $02,$00,$00 ; stage 3-00
      db $02,$00,$01 ; stage 3-00
      db $02,$01,$00 ; stage 3-01
      db $02,$02,$00 ; stage 3-02
      db $02,$02,$01 ; stage 3-02
      db $02,$03,$02 ; stage 3-03
      db $02,$03,$01 ; stage 3-03
      db $02,$03,$00 ; stage 3-03     
      db $02,$04,$01 ; stage 3-04
      db $02,$04,$00 ; stage 3-04
      db $03,$00,$02 ; stage 4-0A
      db $03,$00,$01 ; stage 4-0A
      db $03,$00,$00 ; stage 4-0A
      db $03,$01,$00 ; stage 4-0B     
      db $03,$01,$01 ; stage 4-0B     
      db $03,$02,$00 ; stage 4-0C
      db $03,$02,$01 ; stage 4-0C
      db $03,$03,$00 ; stage 4-0D
      db $03,$03,$01 ; stage 4-0D
      db $03,$04,$02 ; stage 4-0E
      db $03,$04,$01 ; stage 4-0E
      db $03,$04,$00 ; stage 4-0E         
      db $04,$00,$00 ; stage 5-0A
      db $04,$00,$01 ; stage 5-0A
      db $04,$00,$02 ; stage 5-0A
      db $04,$01,$00 ; stage 5-0B
      db $04,$01,$01 ; stage 5-0B
      db $04,$01,$02 ; stage 5-0B
      db $04,$02,$00 ; stage 5-0C
      db $04,$02,$01 ; stage 5-0C
      db $04,$02,$02 ; stage 5-0C
      db $05,$00,$00 ; stage 6-0A
      db $05,$01,$00 ; stage 6-0A
      db $05,$02,$01 ; stage 6-0C
      db $05,$02,$00 ; stage 6-0B
      db $05,$03,$01 ; stage 6-0D
      db $05,$03,$00 ; stage 6-0C
      db $06,$00,$01 ; stage 4-01
      db $06,$00,$00 ; stage 6-0D
      db $06,$01,$00 ; stage 4-01
      db $06,$02,$02 ; stage 4-03
      db $06,$02,$01 ; stage 4-03   
      db $06,$02,$00 ; stage 4-02     
      db $07,$00,$01 ; stage 5-01
      db $07,$00,$00 ; stage 4-03     
      db $07,$01,$00 ; stage 5-01
      db $07,$02,$00 ; stage 5-02
      db $07,$03,$00 ; stage 5-03
      db $07,$04,$00 ; stage 5-04
      db $07,$04,$01 ; stage 5-05
      db $07,$05,$00 ; stage 5-05
      db $07,$05,$01 ; stage 5-06
      db $07,$06,$00 ; stage 5-06       
      db $08,$00,$01 ; stage 6-01
      db $08,$00,$00 ; stage 5-07   
      db $08,$01,$00 ; stage 6-02
      db $08,$02,$00 ; stage 6-03
      db $08,$02,$01 ; stage 6-03
      db $08,$03,$00 ; stage 6-04
      db $08,$04,$00 ; stage 6-04
      db $09,$00,$00 ; stage 6-01
      db $09,$00,$01 ; stage 6-01
      db $09,$01,$00 ; stage 6-02
      db $09,$01,$01 ; stage 6-02
      db $09,$01,$02 ; stage 6-02
      db $0A,$00,$00 ; stage 7-01
      db $0A,$00,$01 ; stage 7-01
      db $0A,$01,$00 ; stage 7-02
      db $0A,$02,$00 ; stage 7-02
      db $0A,$03,$00 ; stage 7-02
      db $0A,$03,$01 ; stage 7-03
      db $0A,$04,$00 ; stage 7-04
      db $0A,$04,$01 ; stage 7-05
      db $0A,$04,$02 ; stage 7-05
      db $0A,$05,$00 ; stage 7-06
      db $0A,$05,$01 ; stage 7-06
      db $0A,$06,$00 ; stage 7-07
      db $0A,$06,$01 ; stage 7-07
      db $0A,$06,$02 ; stage 7-07
      db $0B,$00,$00 ; stage 7-0A
      db $0B,$00,$01 ; stage 7-0A
      db $0B,$01,$00 ; stage 7-0B
      db $0B,$01,$01 ; stage 7-0B
      db $0B,$02,$02 ; stage 7-0C
      db $0B,$02,$01 ; stage 7-0C
      db $0B,$02,$00 ; stage 7-0C         
      db $0C,$00,$00 ; stage 8-01
      db $0C,$00,$01 ; stage 8-01
      db $0C,$01,$00 ; stage 8-02
      db $0C,$01,$01 ; stage 8-02
      db $0C,$02,$00 ; stage 8-03
      db $0D,$00,$00 ; stage 9-01
      db $0D,$00,$01 ; stage 9-01
      db $0D,$00,$02 ; stage 9-01
      db $0D,$01,$00 ; stage 9-02
      db $0D,$01,$01 ; stage 9-02
      db $0D,$01,$02 ; stage 9-02
      db $0D,$02,$00 ; stage 9-03
      db $0D,$02,$01 ; stage 9-03
      db $0D,$02,$02 ; stage 9-03
      db $0D,$03,$00 ; stage 9-04
      db $0D,$03,$01 ; stage 9-04
      db $0E,$00,$02 ; stage A-01
      db $0E,$00,$01 ; stage A-01
      db $0E,$00,$00 ; stage A-01           
      db $0E,$01,$00 ; stage A-02     
      db $0E,$01,$01 ; stage A-02
      db $0E,$02,$00 ; stage A-03
      db $0E,$02,$01 ; Dracula's room
      db $ff           

  }

}


{ ; moved routines for hijack and space   
  pauseCheck:     
    jsr mainGameHijack
    
    LDA.B r_updateNametable          
        CMP.B #$FF                       
        BEQ abordPauseCheck          
        LDA.B $1E                        
        ORA.B r_autoPlay                 
        ORA.B r_counter_ShowSprBg        
        ORA.B r_stopWatchActive          
        BNE abordPauseCheck                       
    
    LDA.B r_Joy1            
    LDY.B r_pauseFlag                   
        BNE whilePauseRoutine
        AND.B #$10                          
        BEQ abordPauseCheck                     
    
    lda #$01
    rts 
  abordPauseCheck:  
    lda #$00
    rts 
  whilePauseRoutine:
    jsr whilePauseHijack
    pla 
    pla 
    jmp whilePause 
}


pushPC  







;--------------------------------------- 
; -- hijacks patches all_banks ---------
;---------------------------------------



{ ; info 

  ; -- expanded ---------------------- 
  ; newPaletteText_dataBankA
  ; CHRanim0
  ; IRQ__30

}


if !levelSelect == 1 
org $a68  
base $8a68
      jsr debuggModeHijack  
      ldy #$03
      bne + 
    pad $a77      
      +
org $AFB
base $8AFB  
      LDA.B #$04        
      STA.B r_gameState 
      LDA.B #$00        
      jmp exitDebuggProperly
    
pullPC    
    debuggMode:       
      
      jsr updateHeldButtonFlag
      
      
      lda.w sr_heldButtonFlag_0F
      bne ++
      lda.b r_Joy1Held
      and #$03
      beq ++
      cmp #$01
      bne +
      jsr autoSelectLevelPlus
      jmp ++
    + jsr autoSelectLevelMinus
    ++      
      lda.b r_Joy1      ; single button press 
      and #$03
      beq secondQuestToggle
      cmp #$01
      bne +
      jsr autoSelectLevelPlus
      jmp secondQuestToggle
    + jsr autoSelectLevelMinus
    
    secondQuestToggle:  
      lda.b r_Joy1
      and #$20    
      beq +
      lda #$01 
      eor.w r_hardMode 
      sta.w r_hardMode    
    + lda.w r_hardMode
      asl
      asl  
      sta.w r_entity_PaletteOverride
    
    selectPartner:
      lda.b r_Joy1
      and #$C0
      beq +
      lda.w r_entity_ID
      clc 
      adc #$01
      and #$03
      sta.w r_entity_ID
  
    +
      lda #$10 
      sta.b r_VRAM_QueueDestLo
      lda #$21
      sta.b r_VRAM_QueueDestHi
      lda.w sr_lvl_IDX_00 
      sta.b r_pointerQueue
      jsr updateQueueWithNumber
      ldy #$00
      jsr displayStageName

  
    end_debuggMode: 
      rts   
    
;   upDownCurser:
;     lda.b r_Joy1      ; use autoselect instead 
;     and #$0C
;     beq ++
;     cmp #$04
;     beq +
;     dec.b r_menuSelectIdx 
;     jmp ++  
;   + inc.b r_menuSelectIdx
;     lda.b r_menuSelectIdx
;     and #$03  
;     sta.b r_menuSelectIdx
;     
;   ++
;     rts 

    autoSelectLevelMinus:
      lda.w sr_lvl_IDX_00
      beq ++
      dec.w sr_lvl_IDX_00
      jmp +
    autoSelectLevelPlus:
      lda.w sr_lvl_IDX_00
      cmp #$86      ; max level 
      beq ++      
      inc.w sr_lvl_IDX_00

    + jsr makeLevelPointer
      jsr add_lvl_Index2Pointer
      
      ldy #$02
    - lda.b ($00),y
      sta.w r_stage,y 
      dey 
      bpl -     
    ++  
      rts   
      
}



pushPC 


endif 

}
 
 
if !debuggMenu == 1

{ ; if !musicMenuFull == 1

org $321E3
base $A1E3
        dw MusicMenuSelect_00                ;0CA1E3|        |0CA1E9;
        dw MusicMenuSelect_01                ;0CA1E5|        |0CA1EC;
        dw MusicMenuSelect_input_02          ;0CA1E7|        |0CA1F7;
 
   MusicMenuSelect_00: 
    JSR.W drawMusicTitleDemo             ;0CA1E9|2059A2  |0CA259;
 
   MusicMenuSelect_01: 
    INC.B r_menuSelectIdx                ;0CA1EC|E66B    |00006B;
        RTS                                  ;0CA1EE|60      |      ;
 
 
  musicSelectPress_Start:
    jsr initSound                         ;0CA1F0|        |0FE227;
    LDA.B #$FF                           ;0CA1F2|A9FF    |      ;
    STA.B r_menuSelectIdx                ;0CA1F4|856B    |00006B;
    RTS                                  ;0CA1F6|60      |      ;
 
 
  MusicMenuSelect_input_02: 
    jsr updateHeldButtonFlag_02
    
    LDA.B r_Joy1_t                       ;0CA1F7|A526    |000026;
        AND.B #$10                           ;0CA1F9|2910    |      ;
        BNE musicSelectPress_Start           ;0CA1FB|D0F2    |0CA1EF;
        LDA.B r_Joy1_t                       ;0CA1FD|A526    |000026;
        AND.B #$08                           ;0CA1FF|2908    |      ;
        BNE musicSelectPress_Up              ;0CA201|D024    |0CA227;
        LDA.B r_Joy1_t                       ;0CA203|A526    |000026;
        AND.B #$04                           ;0CA205|2904    |      ;
        BNE musicSelectPress_Down            ;0CA207|D010    |0CA219;
        LDA.B r_Joy1_t                       ;0CA209|A526    |000026;
        AND.B #$80                           ;0CA20B|2980    |      ;
        BNE musicSelectPress_A               ;0CA20D|D007    |0CA216;
        LDA.B r_Joy1_t                       ;0CA20F|A526    |000026;
        AND.B #$40                           ;0CA211|2940    |      ;
        BNE musicSelectPress_B               ;0CA213|D022    |0CA237;
       
    lda.w sr_heldButtonFlag_0F
    beq +
    RTS                                  ;0CA215|60      |      ;
             
    +   LDA.B r_Joy1Held                       
        AND.B #$08                           
        BNE musicSelectPress_Up              
        LDA.B r_Joy1Held                       
        AND.B #$04                           
        BNE musicSelectPress_Down            
              
        RTS                                  

 
  musicSelectPress_A: 
        jmp initSound                         ;0CA217|        |0FE227;
 
  musicSelectPress_Down: 
    INC.W r_soundModeSongSelected      ;0CA219|EE8007  |0C0780;
        LDA.W r_soundModeSongSelected      ;0CA21C|AD8007  |0C0780;
        CMP.B #$7d                           ;0CA21F|C919    |      ;
        BCC CODE_0CA231                      ;0CA221|900E    |0CA231;
        LDA.B #$7d                           ;0CA223|A919    |      ;
        BNE CODE_0CA22E                      ;0CA225|D007    |0CA22E;
 
  musicSelectPress_Up: 
    DEC.W r_soundModeSongSelected      ;0CA227|CE8007  |0C0780;
        BPL CODE_0CA231                      ;0CA22A|1005    |0CA231;
        LDA.B #$00                           ;0CA22C|A900    |      ;
 
    CODE_0CA22E: 
    STA.W r_soundModeSongSelected      ;0CA22E|8D8007  |0C0780;
 
    CODE_0CA231: 
    JSR.W CODE_0CA240                    ;0CA231|2040A2  |0CA240;
        JMP.W drawMusicTitleDemo             ;0CA234|4C59A2  |0CA259;
 
 
  musicSelectPress_B: 
    LDA.W r_soundModeSongSelected      ;0CA237|AC8007  |0C0780;
        jmp lunchMusic                        ;0CA23E|        |0FE25F;
 
    CODE_0CA240: 
    LDA.B #$2B                           ;0CA240|A92B    |      ;
        STA.B r_VRAM_QueueDestLo             ;0CA242|8561    |000061;
        LDA.B #$23                           ;0CA244|A923    |      ;
        STA.B r_VRAM_QueueDestHi             ;0CA246|8562    |000062;
        db $20                               ;0CA248|        |      ;
        dw updateVRAM_1                      ;0CA249|        |0FE8B5;
        LDY.B #$0A                           ;0CA24B|A00A    |      ;
        LDA.B #$00                           ;0CA24D|A900    |      ;
 
  CODE_0CA24F: 
    STA.W r_VramQueue,X                ;0CA24F|9D0003  |0C0300;
        INX                                  ;0CA252|E8      |      ;
        DEY                                  ;0CA253|88      |      ;
        BNE CODE_0CA24F                      ;0CA254|D0F9    |0CA24F;
        jmp endVRAM_queue                     ;0CA257|        |0FE8DE;
 
   drawMusicTitleDemo: 
    LDA #$2B                        
    STA.B r_VRAM_QueueDestHi         
    LDA #$2b                        
    STA.B r_VRAM_QueueDestLo                         
    jsr updateVRAM_1
    
    lda.w r_soundModeSongSelected
    pha 
    and #$f0
    lsr
    lsr
    lsr
    lsr
    jsr makeHexNumber
    sta $0300,X
    inx
    
    pla 
    and #$0f
    jsr makeHexNumber
    sta $0300,X 
    inx
    jmp endVRAM_queue
  makeHexNumber:
    clc 
    adc #$01 
    cmp #$0b
    bcc +
    adc #$04  
  + rts
 
  updateHeldButtonFlag_02:
    ldy.b #BUTTONE_DELAY  
    lda.b r_Joy1
    cmp.b r_Joy1Held
    beq +
    dec.w sr_heldButtonFlag_0F
    lda.w sr_heldButtonFlag_0F
    bpl ++
    ldy #$00
  + sty.w sr_heldButtonFlag_0F
  ++  rts  
 
 
 
     data_soundTestBar_67:      dw $22CB                            
                       db $22,$1E,$24,$1D,$13,$00,$1C,$1E  
                       db $13,$14,$FE                      
 
     looksLikeText_01: dw $22EA                            
                       db $2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E  
                       db $2E,$2E,$2E,$2E,$FE              
 
     looksLikeText_02: dw $2309                            
                       db $2D,$FE                          
 
     looksLikeText_03: db $15,$23,$2D,$FE                  
 
     looksLikeText_04: dw $2329                            
                       db $2D,$FE                          
 
     looksLikeText_05: dw $2335                            
                       db $2D,$FE,$49,$23,$2D,$2E,$2E,$2E  
                       db $2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E  
                       db $2F,$FF                          
 
 
assert pc() <= $A3FE
pad $323FE 

}


org $f67
base $8f67
    jmp updateStageBlock_HUD

org $D96
base $8D96
  updateStageBlock_HUD:     ; show new values hud 
    
    if !sprite_viewer == 1
    LDA.B #$20                           
    STA.B r_VRAM_QueueDestHi             
    LDA.B #$54                           
    STA.B r_VRAM_QueueDestLo                                    
    ldy.b $0d
    STY.B r_pointerQueue                                                  
    jsr updateQueueWithNumber 

    LDA.B #$20                           
    STA.B r_VRAM_QueueDestHi             
    LDA.B #$57                           
    STA.B r_VRAM_QueueDestLo             
  ; LDY.W r_entity_XPos                        
    ldy.b $0c     
    STY.B r_pointerQueue                                                  
    jsr updateQueueWithNumber             

    LDA.B #$20                           
    STA.B r_VRAM_QueueDestHi             
    LDA.B #$5a                           
    STA.B r_VRAM_QueueDestLo             
  ; LDY.W r_entity_YPos                        
    ldy.w r_subWe_CHRbank
    STY.B r_pointerQueue                                                        
    jsr updateQueueWithNumber 

    LDA.B #$20                           
    STA.B r_VRAM_QueueDestHi             
    LDA.B #$5d                           
    STA.B r_VRAM_QueueDestLo                                   
    ldy.w r_subWe_HUD_IDX
    STY.B r_pointerQueue                                                  
    jsr updateQueueWithNumber 
    endif 
    
    
    rts 


assert pc() <= $8e3c
pad $e3c


else 
    data_soundTestBar_67 = $A285
endif  
 
 
if !fast_options == 1
  
  !fastPartnerSwap = 1
  !fastSwap = 1
  !fastDoor = 1
  !fastGameLunch = 0


  if !fastSwap == 1
  
  org $0014AC
  base $94AC
      lda #$1e  
      jsr lunchMusic
      jsr setAutoPlayFlag
      lda #$01
      sta.b r_timerGenerel
  org $0014CF     
  base $94CF
      lda #$01
  org $00166a
  base $966a
      lda #$01  ;countDown vertical sections
  org $001698
  base $9698
      lda #$05  ;countDown
  
  endif 

  if !fastDoor == 1 
            ; !!FIXME transition do not stop animation what cases bg animation to delay 1 4 2 door transit
  doorSpeed = $04   ; decault 1 
  
  org LAST_BANK+$1b6c
  base $fb6c      ; door right 
    adc.b #doorSpeed
  org LAST_BANK+$19cb
  base $f9cb
    sbc.b #doorSpeed
  org LAST_BANK+$19da 
  base $f9da      ; door Left
    adc.b #doorSpeed
  org LAST_BANK+$1b7a
  base $fb7a
    sbc.b #doorSpeed
    
  org LAST_BANK+$1a00
  base $fa00
    ; wait time for door to open
    lda #$10
  org LAST_BANK+$1aa2
  base $faa2
    ; wait time for door to close
    lda #$28
  endif 

  if !fastGameLunch == 1
  org LAST_BANK+$43b
  base $e41b   
      LDA #$0e          ; resolvePW to start first level 
  org LAST_BANK+$41b
  base $e41b   
      LDA #$01          ; title screen count down till it starts   
  endif 


endif 
 

if !removeTimer == 1


org $19BF
base $99BF
  db $00,$00,$00,$00,$FE    ; remove text timer 

org $D21            
base $8D21
    rts           ; stop timer update HUD 
pad $D39

org LAST_BANK+$656        ; orb countdown HUD update
base $E656
pad LAST_BANK+$666

org $4087
base $8087
    lda #$12
    sta $7f3
    inc $07ED
    rts 
pad $4093

;org $38A21           ; done in expanded player.asm (moved bank)
;base $8A21
;   nop #$1e        ; remove countdown
;assert pc() <= $8A3F
;
;org $38996
;base $8996           ; remove countdown
;pad $38A01

endif 


if !deathCouter == 1

org $c1f
base $8c1f
    rts     ; remove life from score 
pad $c2f

org $10b7
base $90B7
    lda #$00  ; starting lifes 
  - sta.b r_lifes 
    rts 
    lda #$00  ; lifes with pw 
    beq -

org LAST_BANK+$48b
base $e48b
    nop #$04

endif 


if !optionScreen == 1 

org LAST_BANK+$41B
base $E41B
    LDA.B #$30        ; start timer   
org LAST_BANK+$55D  
base $E55D  
    AND.B #$23          ; buttons to choose options 

org LAST_BANK+$787  
base $E787  
        jmp startingOptions 

org LAST_BANK+$553        ; orginal show PW init  
base $E553                  ;
    jmp gameState_00_intro  ;     
assert pc() <= $E55B            ;
pad LAST_BANK+$55B              ;

org LAST_BANK+$598  
base $E598
        jsr transitHelperBonus_CC  
org $2B628
base $B628
        dw setDefaultCHR        ; ending text            
org $00F80            ; starting option
base $8F80
        JSR.W startingOptions                
org $00D7A            ; display stage name HUD hijack 
base $8D7A
    JSR.W updateStageNAME_HUD  
org LAST_BANK+$1971       ; disable block HUD in door transition    
base $F971                      
    NOP #$03        ; jsr updateStageBlock_HUD                  
org $0120F
base $920F
        JSR.W bossHealthRefill           
org $01130
base $9130  
    JSR.W setDefaultCHR  
org $01192
base $9192
    JSR.W setDefaultCHR 
org $011AF
base $91AF
    JMP.W startingStats
org $029F2
base $A9F2    
    JSR.W startingStats
org $011EE
base $91EE
    JSR.W startingStats    ; ending  as hijack for second quest stuff          
org $010E9
base $90E9
    JSR.W bossHealthRefill  


org $00FFE            ; starting option
base $8FFE    
    startingOptions: 
      
      LDA.B #$B0                           ;00907F|A9B0    |      ;
      STA.B r_PPUCtrl             
      JSR.W setDefaultCHR              
      JSR.W startingStats     
      
      LDA.B #$02                 
      STA.B r_score4ExtraLive     
  
      lda.w sr_selectedPlayer
      bne +
      lda #$ff 
    + sta.b r_partner             
    
;           lda #$00   
;     STA.W r_hardMode            
      lda.w sr_defaultLife                 
      STA.B r_lifes  
      
      lda.w sr_setStartingStage
      beq +
      sta.b r_stage 
      lda #$00      ; reset starting level 
      sta.w sr_setStartingStage
    + 
      rts 
      
    startingStats:  
      LDA.B #$05                      
      STA.B r_hearts           
      
      LDA.B #$40                      
      STA.B r_HUD_healthPlayer                         
    bossHealthRefill: 
      LDA.B #$40 
      STA.B r_HUD_healthBoss  
      RTS 
    setDefaultCHR: 
      LDA.B #$40                      
      STA.B r_CHR_BankBG_0000         
      LDA.B #$43                      
      STA.B r_CHR_BankBG_0c00         
      RTS   
    transitHelperBonus_CC:
      ; no helper name to skip encounters 
      ldy.b r_stage     ; check for no double encounter instead 
      lda.w noNotEnconter_HelperStageTable,y
      cmp.b r_partner
      beq +
      clc         
      rts 
    + sec 
      rts 
    noNotEnconter_HelperStageTable:
      db $00,PARTNER_GRANT,PARTNER_SYMPHA,$00,$00,$00,$00,PARTNER_ALUCARD
    
    updateStageNAME_HUD:
      ldy #$04
      %jsl($A0,displayStageName) 
      RTS 


assert pc() <= $90D6
pad $10D6
else 
org $00FFE        ; starting option
base $8FFE    
  startingBonuseCheck: 
      LDY.B #$00                           ;008FFE|A000    |      ; 
      JSR.W bonusNameCheckCS               
      BCS getBonus_01                      
  
  CODE_009005: 
      LDY.B #$02                           
      JSR.W bonusNameCheckCS               
      BCS getBonus_02                      
      LDY.B #$04                           
      JSR.W bonusNameCheckCS               
      BCS getBonus_03                      
      LDY.B #$06                           
      JSR.W bonusNameCheckCS               
  
      BCS getBonus_04                      
      LDY.B #$08                           
      JSR.W bonusNameCheckCS               
      BCS getBonus_05                      
      RTS                                  
  
  
  getBonus_03: 
      LDY.B #$03                          
      RTS                                 
  
  getBonus_04: 
      LDY.B #$04                          
      RTS                                 
    
  getBonus_05: 
      LDY.B #$05                          
      RTS                                 
    
  getBonus_02: 
      LDY.B #$02                          
      RTS                                 
    
  getBonus_01: 
      LDY.B #$01                          
      RTS                                 
  
  
  bonusNameCheckCS: 
      LDA.W extraNameCheckLo,Y            
      STA.B r_pointerQueue                
      LDA.W extraNameCheckLo+1,Y            
      STA.B $09                           
      LDY.B #$00                          
  
  CODE_00903D: 
      LDA.W r_playerName,Y                
      CMP.B (r_pointerQueue),Y            
      BNE CODE_00904B                     
      INY                                 
      CPY.B #$08                          
      BNE CODE_00903D                     
      SEC                                 
      RTS                                 
  
  CODE_00904B: 
      CLC                                 
      RTS                                 
  
  
  extraNameCheckLo: 
      dw textHELPME                       
      dw textAKAMA                        
      dw textOKUDA                        
      dw textURATA                        
      dw textFUJIMOTO                     
  
  textHELPME:   db $57,$54,$5B,$5F,$00,$5C,$54,$00   ;009057|        |      ; 
  textAKAMA:    db $50,$5A,$50,$5C,$50,$00,$00,$00   
  textOKUDA:    db $5E,$5A,$64,$53,$50,$00,$00,$00   
  textURATA:    db $64,$61,$50,$63,$50,$00,$00,$00   
  textFUJIMOTO:   db $55,$64,$59,$58,$5C,$5E,$63,$5E  

  startingOptions: 
        LDA.B #$B0                           ;00907F|A9B0    |      ;
        STA.B r_PPUCtrl             

                JSR.W setDefaultCHR                  ;009083|20CD90  |0090CD;
                JSR.W startingStats                  ;009086|20C090  |0090C0;             
        
        LDA.B #$02                    
        STA.B r_score4ExtraLive     
        
        JSR.W startingBonuseCheck   
        BCC default_startLifes      
        DEY                         
        BEQ getBonus_01_moreLifes   
        DEY                         
        BEQ getBonus_02_hardMode    
  
        LDA.B r_partner             
        CMP.B #$FF                  
        BNE default_startLifes      
        DEY                         
        BEQ getBonus_03_Alucard     
        DEY                         
        BEQ getBonus_04_sympha      
        LDA.B #$02                  
        BNE CODE_0090AE             
  
  getBonus_04_sympha: 
        LDA.B #$01                  
        BNE CODE_0090AE             
  
  getBonus_03_Alucard: 
        LDA.B #$03                  
  
  CODE_0090AE: 
        STA.B r_partner             
        BNE default_startLifes      
  
  getBonus_02_hardMode: 
        LDA.B #$01                  
        STA.W r_hardMode            
  
  default_startLifes: 
        LDA.B #$02                  
  
  CODE_0090B9: 
        STA.B r_lifes               
        RTS                         
  
  
  getBonus_01_moreLifes: 
      LDA.B #$10                      
      BNE CODE_0090B9                 
  
  startingStats: 
      LDA.B #$05                      
      STA.B r_hearts                  
      LDA.B #$40                      
      STA.B r_HUD_healthPlayer        
  
  bossHealthRefill: 
      LDA.B #$40                      
      STA.B r_HUD_healthBoss          
      RTS                             
  
  setDefaultCHR: 
      LDA.B #$40                      
      STA.B r_CHR_BankBG_0000         
      LDA.B #$43                      
      STA.B r_CHR_BankBG_0c00         
      RTS                             

assert pc() <= $90D6
pad $10D6
endif 
 

if !sRAM == 1
org LAST_BANK+$40 
base $e040  
  jsr initalizeSRAM
endif 


if !alienPatchRemove == 1

org LAST_BANK+$1384 
base $F384  
  jsr $F683   ; pauseCheck

endif 


if !expandCHRanim == 1
org $060D7        
base $A0D7
  JSR.W chrAnimRoutine                 ;01A0D7|208D9F  |019F8D;
org $06218        
base $A218  
  JSR.W chrAnimRoutine                 ;01A218|208D9F  |019F8D;

org $05F8D
base $9F8D
  dw IRQ__2e        ; !!Space for addictional IRQ routines  
  dw IRQ__2f
  dw IRQ__30        
  dw IRQ__31
  dw IRQ__32
  dw IRQ__33
  dw IRQ__34
  dw IRQ__35

  

assert pc() <= $9FCB
pad $05FCB
endif 


{ ; -- pause hijack
org LAST_BANK+$1683
base $F683
    lda #$a0 
    jsr swapPRGbankStore
    jsr pauseCheck
    beq endPauseCheck
       
        LDA.B #$01                          
        STA.B r_pauseFlag                   
        LDA.B #$4D                          
        JMP.W lunchMusic       
 
 
    whilePause: 
    LDA.B r_gameTransition              
        CMP.B #$0A                          
        BNE unpauseCheck                    
        LDA.B #$80                          
        JSR.W swapPRGbankStore              
        jsr.w $852C ; tramsotIDX_A_todo     
 
    unpauseCheck: 
    LDA.B r_Joy1            
        AND.B #$10                          
        BEQ endPauseCheck                   
        LDA.B #$00                          
        STA.B r_pauseFlag                   
    endPauseCheck: 
    RTS                                 

assert pc() <= $F6BF
pad LAST_BANK+$16BF 

}


org LAST_BANK+$1FA3
base $FFA3    
    jsr freezEnemy                     

org LAST_BANK+$1FB3
base $FFB3  
        jsr collectableData                 





{ ; PAL and TEXT table expansion!


org $01826
base $9826
      LDA.B #$A0          ; move data bank 00       

org $2B5EE          ; move ending text
base $B5EE
      LDX.B #$A0   
org $2B727
base $B727
      LDX.B #$A0
      LDA.B #$5B    
org $2BA62
base $BA62
      LDX.B #$A0   
org $2B7BD
base $B7BD
      LDX.B #$A0  
      LDA.B #$5C



org $018E4
base $98E4
    palette_text_map:
      dw text_opening_T_00                ;0098E4|        |009B43; 0
      dw text_konami_01                   ;0098E6|        |009B33; 1
      dw text_konami_01                   ;0098E8|        |009B33; 2
      dw text_Game_over_02                ;0098EA|        |009B58; 3
      dw PAL_03                           ;0098EC|        |009BAA; 4
      dw PAL_04                           ;0098EE|        |009B87; 5
      dw PAL_05                           ;0098F0|        |009B25; 6
      dw PAL_06                           ;0098F2|        |009B2C; 7
      dw text_gameStart_08                ;0098F4|        |009B7A; 8
      dw PAL_09                           ;0098F6|        |008766; 9
      dw PAL_sprite_trevor                ;0098F8|        |008982; a
      dw PAL_sprite_sympha                ;0098FA|        |0089A8; b
      dw PAL_sprite_grant                 ;0098FC|        |008995; c
      dw PAL_sprite_alucart               ;0098FE|        |0089BB; d
      dw textDrawHudAll_0E                ;009900|        |0099B4; e
      dw HUD_trevor_Prfile_0f             ;009902|        |0099FE; f
      dw HUD_sympha_Prfile_10             ;009904|        |009A1C; 10
      dw HUD_grant_Prfile_11              ;009906|        |009A0D; 11
      dw HUD_alucard_Prfile_12            ;009908|        |009A2B; 12
      dw PAL_13                           ;00990A|        |009BC3; 13
      dw PAL_13                           ;00990C|        |009BC3; 14
      dw PAL_15                           ;00990E|        |009BD6; 15
      dw PAL_16                           ;009910|        |009BE9; 16
      dw PAL_17                           ;009912|        |009BFC; 17
      dw PAL_18                           ;009914|        |009BB0; 18
      dw PAL_19                           ;009916|        |009C11; 19
      dw PAL_1a                           ;009918|        |009C24; 1a
      dw PAL_1b                           ;00991A|        |009C37; 1b
      dw PAL_1c                           ;00991C|        |009C4A; 1c
      dw PAL_1d                           ;00991E|        |009C5D; 1d
      dw PAL_1e                           ;009920|        |009C70; 1e
      dw PAL_1f                           ;009922|        |009C93; 1f
      dw PAL_20                           ;009924|        |009A99; 20
      dw text_not_complete_21             ;009926|        |009D74; 21
      dw text_not_complete_21             ;009928|        |009D74; 22
      dw PAL_23                           ;00992A|        |009D8F; 23
      dw text_not_complete_21             ;00992C|        |009D74; 24
      dw text_not_complete_21             ;00992E|        |009D74; 25
      dw text_password_T_26               ;009930|        |009B4D; 26
      dw text_continue_27                 ;009932|        |009B64; 27
      dw text_Password_28                 ;009934|        |009B6F; 28
      dw $07A0                            ;009936|        |      ; 29
      dw PAL_2a                           ;009938|        |009CB6; 2a
      dw PAL_2b                           ;00993A|        |009CC9; 2b
      dw PAL_2c                           ;00993C|        |009CEF; 2c
      dw PAL_2d                           ;00993E|        |009CDC; 2d
      dw PAL_2e                           ;009940|        |009D02; 2e
      dw PAL_2f                           ;009942|        |009D15; 2f 
      dw PAL_30                           ;009944|        |009D3B; 30
      dw PAL_31                           ;009946|        |009D28; 31   
      dw text__32                         ;009948|        |08BBEF; 32
      dw text__33                         ;00994A|        |08BC16; 33
      dw text__34                         ;00994C|        |08BC31; 34
      dw text__35                         ;00994E|        |08BC50; 35
      dw text__36                         ;009950|        |08BC84; 36   
      dw data_63                          ;009952|        |08BCB6; 37
      dw data_64                          ;009954|        |08BCFF; 38
      dw endingTEXT_39                    ;009956|        |0ABAC0; 39
      dw endingTEXT_3a                    ;009958|        |0ABAEF; 3a
      dw endingTEXT_3b                    ;00995A|        |0ABB0D; 3b
      dw endingTEXT_3c                    ;00995C|        |0ABB29; 3c
      dw endingTEXT_3d                    ;00995E|        |0ABB4B; 3d
      dw endingTEXT_3e                    ;009960|        |0ABB6B; 3e
      dw endingTEXT_3f                    ;009962|        |0ABB8C; 3f
      dw endingTEXT_40                    ;009964|        |0ABBAE; 40
      dw endingTEXT_41                    ;009966|        |0ABBCE; 41
      dw endingTEXT_42                    ;009968|        |0ABBE8; 42
      dw endingTEXT_43                    ;00996A|        |0ABBF7; 43
      dw endingTEXT_44                    ;00996C|        |0ABC10; 44
      dw endingTEXT_45                    ;00996E|        |0ABC2E; 45
      dw endingTEXT_46                    ;009970|        |0ABC4E; 46      
      dw PAL_47                           ;009972|        |009B13; 47   ; ending ?? 
      dw PAL_48                           ;009974|        |009AAC; 48
      dw PAL_49                           ;009976|        |009AE6; 49
      dw PAL_4a                           ;009978|        |009A60; 4a
      dw PAL_4b                           ;00997A|        |009A73; 4b
      dw PAL_4c                           ;00997C|        |009A86; 4c           
      dw endingTEXT_4d                    ;00997E|        |0ABC6C; 4d
      dw endingTEXT_4d                    ;009980|        |0ABC6C; 4e
      dw endingTEXT_4f                    ;009982|        |0ABC77; 4f
      dw endingTEXT_50                    ;009984|        |0ABC95; 50
      dw endingTEXT_51                    ;009986|        |0ABCB0; 51
      dw endingTEXT_52                    ;009988|        |0ABCCF; 52
      dw endingTEXT_53                    ;00998A|        |0ABCEC; 53
      dw endingTEXT_54                    ;00998C|        |0ABDC0; 54
      dw endingTEXT_55                    ;00998E|        |0ABD17; 55
      dw endingTEXT_56                    ;009990|        |0ABD38; 56
      dw endingTEXT_57                    ;009992|        |0ABD52; 57
      dw endingTEXT_58                    ;009994|        |0ABD6F; 58
      dw endingTEXT_59                    ;009996|        |0ABD8E; 59
      dw endingTEXT_5a                    ;009998|        |0ABDA6; 5a   
      dw text_f0                          ;00999A|        |08BDB1; 5b ; ending 
      dw text_f1                          ;00999C|        |08BDD5; 5c   
      dw data_5d                          ;00999E|        |009A4D; 5d
      dw data_5e                          ;0099A0|        |009D4E; 5e
      dw data_5f                          ;0099A2|        |009A3A; 5f
      dw endingTEXT_3c                    ;0099A4|        |0ABB29; 60
      dw endingTEXT_3d                    ;0099A6|        |0ABB4B; 61
      dw data_62                          ;0099A8|        |009D61; 62   
      dw data_63                          ;0099AA|        |08BCB6; 63 ; very end 
      dw data_64                          ;0099AC|        |08BCFF; 64
      dw data_65                          ;0099AE|        |08BD2E; 65
      dw data_66                          ;0099B0|        |08BD5C; 66
      dw data_soundTestBar_67       ;0099B2|        |08A285; 67
      dw text_EXIT_68
      dw text_difficulty_69
      dw text_lifes_6a
      dw text_partner_6b
      dw text_stage_6c
      dw text_music_6d
      dw text_sfx_6e
      dw text_nameScreen_6f
  




assert pc() <= $9DDB
pad $1DDB
pullPC 

    { ; -- moved vanilla table data     
  
      text_EXIT_68:
          dw $234A
          db "EXIT",$FF                   
      text_difficulty_69:
          dw $218A
          db "DIFFICULTY",$FF   
      text_lifes_6a: 
          dw $21CA
          db "LIVES",$FF    
      text_partner_6b:
          dw $220A
          db "PARNTER",$FF 
      text_stage_6c: 
          dw $224A
          db "STAGE",$FF 
      text_music_6d:  
          dw $228A
          db "MUSIC",$FF 
      text_sfx_6e:  
          dw $22CA
          db "SFX",$FF 
      text_nameScreen_6f:     
          dw $230A
          db "CHANGE NAME",$FF      
      
      textDrawHudAll_0E:
        !heartHUD = $91   
            dw $2040            ; 0099B4|        |      ;                      
            db "SCORE",$FE              
    if !debuggMenu == 1
    else 
        if !removeTimer == 1     
    else   
       textTIME:
            dw $204D             ; 0099BD|        |      ;
            db "TIME",$FE                          
    endif    
       textBLK:
            dw $2057                             
            db "BLK  -0",$FE          
    endif 
            dw $2060        ; textPLAYER:                    
            db "PLAYER",$FE                   
            dw $2080                        
            db "ENEMY",$FE      ; textENEMY:                           
            dw $2075                        
            db !heartHUD,"=",$FE                        
            dw $2095                             ; 0099E4|   subWborderHUD:
            db "P=",$FE                                               
            dw $2070                             ; 0099E9|      
            db $80,$81,$81,$82,$FE               ; +----+    
            dw $2090                               
            db $90,$00,$00,$92,$FE               ; |    |    
            dw $20B0                                
            db $A0,$A1,$A1,$A2,$FF               ; +----+    
 
               HUD_trevor_Prfile_0f:
                       dw $207D                             ;0099FE|        |      ;
                       db $88,$89,$FE                       ;009A00|        |      ;
                       dw $209D                             ;009A03|        |      ;
                       db $98,$99,$FE                       ;009A05|        |      ;
                       dw $20BD                             ;009A08|        |      ; 
                       db $A8,$A9,$FF                       ;009A0A|        |      ;
 
               HUD_grant_Prfile_11:
                       dw $207D                             ;009A0D|        |      ;
                       db $8A,$8B,$FE                       ;009A0F|        |      ;
                       dw $209D                             ;009A12|        |      ;
                       db $9A,$9B,$FE                       ;009A14|        |      ;
                       dw $20BD                             ;009A17|        |      ;
                       db $AA,$AB,$FF                       ;009A19|        |      ;
 
               HUD_sympha_Prfile_10:
                       dw $207D                             ;009A1C|        |      ;
                       db $8C,$8D,$FE                       ;009A1E|        |      ;
                       dw $209D                             ;009A21|        |      ;
                       db $9C,$9D,$FE                       ;009A23|        |      ;
                       dw $20BD                             ;009A26|        |      ;
                       db $AC,$AD,$FF                       ;009A28|        |      ;
 
               HUD_alucard_Prfile_12:
                       dw $207D                             ;009A2B|        |      ;
                       db $8E,$8F,$FE                       ;009A2D|        |      ;
                       dw $209D                             ;009A30|        |      ;
                       db $9E,$9F,$FE                       ;009A32|        |      ;
                       dw $20BD                             ;009A35|        |      ;
                       db $AE,$AF,$FF                       ;009A37|        |      ;
               
         
         text_not_complete_21:
            dw $222A                             ;009D74|        |      ;
            db "NOT COMPLETE",$FE
            dw $224B
            db "TRY AGAIN",$FF          
        
               text_konami_01:
                       dw $22CA                             ;009B33|        |      ;
                       db "KONAMI 1990",$FF
    
               text_Game_over_02:
                       dw $21EC                             ;009B58|        |      ;
                       db "GAME OVER",$FF
 
               text_continue_27:
                       dw $228C                             ;009B64|        |      ;
                       db "CONTINUE",$FF 
      if !optionScreen == 1
           text_Password_28:       
             dw $22EC                             ;009B6F|        |      ;
                       db "END",$FF  
      else 
               text_Password_28:
                       dw $22EC                             ;009B6F|        |      ;
                       db "PASSWORD",$FF                
      endif 
 
               text_gameStart_08:
                       dw $22CD                             ;009B7A|        |      ;
                       db "GAME START",$FF
    
    { ; other data 
               PAL_05:
            dw $220E                             ;009B25|        |      ;
            db $47,$41,$4D,$45,$FF               ;009B27|        |      ;
 
               PAL_06:
            dw $220E                             ;009B2C|        |      ;
            db $44,$45,$4D,$4F,$FF               ;009B2E|        |      ;
 
               PAL_23:
            dw $2208                             ;009D8F|        |      ;
            db $86,$A4,$A4,$A4,$A4,$A4,$A4,$A4   ;009D91|        |      ;
            db $A4,$A4,$A4,$A4,$A4,$A4,$A4,$87   ;009D99|        |      ;
            db $FE                               ;009DA1|        |      ;
            dw $2228                             ;009DA2|        |      ;
            db $96,$00,$00,$00,$00,$00,$00,$00   ;009DA4|        |      ;
            db $00,$00,$00,$00,$00,$00,$00,$97   ;009DAC|        |      ;
            db $FE                               ;009DB4|        |      ;
            dw $2248                             ;009DB5|        |      ;
            db $96,$00,$00,$00,$00,$00,$00,$00   ;009DB7|        |      ;
            db $00,$00,$00,$00,$00,$00,$00,$97   ;009DBF|        |      ;
            db $FE                               ;009DC7|        |      ;
            dw $2268                             ;009DC8|        |      ;
            db $A6,$A5,$A5,$A5,$A5,$A5,$A5,$A5   ;009DCA|        |      ;
            db $A5,$A5,$A5,$A5,$A5,$A5,$A5,$A7   ;009DD2|        |      ;
            db $FF                               ;009DDA|        |      ;

        text__32: 
            dw $25B1                             ;08BBEF|        |      ;
            db $D5,$C0,$CC,$CF,$C8,$D1,$C4,$FE   ;08BBF1|        |      ;
            db $D6,$25,$C7,$D4,$CD,$D3,$C4,$D1   ;08BBF9|        |      ;
            db $F8,$FE,$51,$26,$D2,$D8,$C5,$C0   ;08BC01|        |      ;
            db $FE,$74,$26,$D5,$C4,$CB,$CD,$D4   ;08BC09|        |      ;
            db $CC,$C3,$C4,$D2,$FF               ;08BC11|        |      ;
  
        text__33: 
            dw $25A1                             ;08BC16|        |      ;
            db $C0,$C2,$D1,$CE,$C1,$C0,$D3,$F8   ;08BC18|        |      ;
            db $FE,$41,$26,$C6,$D1,$C0,$CD,$D3   ;08BC20|        |      ;
            db $00,$C3,$C0,$CD,$D4,$D2,$D3,$D8   ;08BC28|        |      ;
            db $FF                               ;08BC30|        |      ;
  
        text__34: 
            dw $25B1                             ;08BC31|        |      ;
            db $F6,$C0,$CB,$D4,$C2,$C0,$D1,$C3   ;08BC33|        |      ;
            db $F7,$FE,$51,$26,$C0,$C3,$D1,$C8   ;08BC3B|        |      ;
            db $C0,$CD,$FE,$75,$26,$C5,$F9,$D3   ;08BC43|        |      ;
            db $C4,$CF,$C4,$D2,$FF               ;08BC4B|        |      ;
  
        text__35: 
            dw $2561                             ;08BC50|        |      ;
            db $CF,$D1,$CE,$C3,$D4,$C2,$C4,$C3   ;08BC52|        |      ;
            db $00,$C1,$D8,$FE,$A3,$25,$CA,$CE   ;08BC5A|        |      ;
            db $CD,$C0,$CC,$C8,$FE,$E1,$25,$F6   ;08BC62|        |      ;
            db $C3,$D1,$C0,$C2,$D4,$CB,$C0,$E4   ;08BC6A|        |      ;
            db $E5,$F7,$FE,$21,$26,$CF,$D1,$CE   ;08BC72|        |      ;
            db $C9,$C4,$C2,$D3,$00,$D3,$C4,$C0   ;08BC7A|        |      ;
            db $CC,$FF                           ;08BC82|        |      ;
  
        text__36: 
            dw $25A1                             ;08BC84|        |      ;
            db $C0,$CD,$C3,$00,$D2,$D3,$C0,$D1   ;08BC86|        |      ;
            db $D1,$C8,$CD,$C6,$F8,$FE,$E1,$25   ;08BC8E|        |      ;
            db $D3,$D1,$C4,$D5,$CE,$D1,$FE,$05   ;08BC96|        |      ;
            db $26,$C2,$F9,$C1,$C4,$CB,$CC,$CE   ;08BC9E|        |      ;
            db $CD,$D3,$FE,$A1,$26,$F6,$00,$00   ;08BCA6|        |      ;
            db $00,$00,$00,$00,$00,$00,$F7,$FF   ;08BCAE|        |      ;              

        PAL_48:
            dw $250F                             ;009AAC|        |      ;
            db $4E,$7D,$7D,$4F,$FE               ;009AAE|        |      ;
            dw $252E                             ;009AB3|        |      ;
            db $5E,$78,$78,$78,$78,$5F,$FE,$4E   ;009AB5|        |      ;
            db $25,$6E,$7E,$78,$78,$7F,$6F,$FE   ;009ABD|        |      ;
            db $6D,$25,$40,$41,$42,$43,$44,$45   ;009AC5|        |      ;
            db $46,$47,$FE,$8D,$25,$50,$51,$52   ;009ACD|        |      ;
            db $53,$54,$55,$56,$57,$FE           ;009AD5|        |      ;
            dw $25AD                             ;009ADB|        |      ;
            db $60,$61,$62,$63,$64,$65,$66,$67   ;009ADD|        |      ;
            db $FF                               ;009AE5|        |      ;
 
        PAL_49:
            dw $25CD                             ;009AE6|        |      ;
            db $70,$71,$72,$73,$74,$75,$76,$77   ;009AE8|        |      ;
            db $FE,$EE,$25,$48,$49,$4A,$4B,$4C   ;009AF0|        |      ;
            db $4D,$FE                           ;009AF8|        |      ;
            dw $260E                             ;009AFA|        |      ;
            db $58,$59,$5A,$5B,$5C,$5D,$FE,$2E   ;009AFC|        |      ;
            db $26,$68,$69,$6A,$6B,$6C,$6D,$FE   ;009B04|        |      ;
            dw $264F                             ;009B0C|        |      ;
            db $79,$7A,$7B,$7C,$FF               ;009B0E|        |      ;
 
        PAL_47:
            dw $27D3                             ;009B13|        |      ;
            db $55,$55,$55,$FE,$DB,$27,$59,$7B   ;009B15|        |      ;
            db $55,$FE,$E3,$27,$55,$55,$55,$FF   ;009B1D|        |      ;
 
        data_63: 
            dw $2551                             ;08BCB6|        |      ;
            db $CF,$DF,$FB,$EA,$DF,$EB,$EC,$EC   ;08BCB8|        |      ;
            db $DE,$DF,$F8,$FE,$92,$25,$C7,$F9   ;08BCC0|        |      ;
            db $C0,$CA,$C0,$CC,$C0,$D3,$D2,$D4   ;08BCC8|        |      ;
            db $FE,$D2,$25,$D8,$F9,$CE,$CA,$D4   ;08BCD0|        |      ;
            db $C3,$C0,$FE,$31,$26,$C2,$EF,$EB   ;08BCD8|        |      ;
            db $DF,$EB,$DC,$DD,$DE,$DF,$F8,$FE   ;08BCE0|        |      ;
            db $72,$26,$C8,$F9,$D4,$D1,$C0,$D3   ;08BCE8|        |      ;
            db $C0,$FE,$B2,$26,$D3,$F9,$C5,$D4   ;08BCF0|        |      ;
            db $C9,$C8,$CC,$CE,$D3,$CE,$FF       ;08BCF8|        |      ;
  
        data_64: 
            dw $25A1                             ;08BCFF|        |      ;
            db $D2,$FB,$FC,$FD,$E7,$F8,$FE,$E2   ;08BD01|        |      ;
            db $25,$D8,$F9,$D2,$C0,$D2,$C0,$CA   ;08BD09|        |      ;
            db $C8,$FE,$22,$26,$C9,$F9,$C5,$D4   ;08BD11|        |      ;
            db $CD,$C0,$C7,$C0,$D2,$C7,$C8,$FE   ;08BD19|        |      ;
            db $62,$26,$D8,$F9,$CC,$CE,$D1,$C8   ;08BD21|        |      ;
            db $CC,$CE,$D3,$CE,$FF               ;08BD29|        |      ;
  
        data_65: 
            dw $2571                             ;08BD2E|        |      ;
            db $CF,$EE,$EB,$FD,$FD,$DE,$DF,$F8   ;08BD30|        |      ;
            db $FE,$B2,$25,$C8,$F9,$D4,$D1,$C0   ;08BD38|        |      ;
            db $D3,$C0,$FE,$11,$26,$C3,$ED,$DF   ;08BD40|        |      ;
            db $DE,$DC,$DD,$FB,$DF,$F8,$FE,$52   ;08BD48|        |      ;
            db $26,$C7,$F9,$C0,$CA,$C0,$CC,$C0   ;08BD50|        |      ;
            db $D3,$D2,$D4,$FF                   ;08BD58|        |      ;
  
        data_66: 
            dw $2541                             ;08BD5C|        |      ;
            db $D2,$F4,$DE,$DC,$ED,$EB,$EE,$FE   ;08BD5E|        |      ;
            db $64,$25,$DD,$EF,$EB,$FD,$F5,$E6   ;08BD66|        |      ;
            db $00,$DD,$FB,$F8,$FE,$A2,$25,$C7   ;08BD6E|        |      ;
            db $F9,$CC,$C0,$C4,$D9,$C0,$D6,$C0   ;08BD76|        |      ;
            db $FE,$E2,$25,$CC,$F9,$D3,$C0,$CA   ;08BD7E|        |      ;
            db $C4,$CC,$CE,$D3,$CE,$FE,$22,$26   ;08BD86|        |      ;
            db $D2,$F9,$CA,$C8,$D3,$C0,$CC,$CE   ;08BD8E|        |      ;
            db $D3,$CE,$FE,$62,$26,$CD,$F9,$D3   ;08BD96|        |      ;
            db $CE,$C6,$C0,$CA,$D4,$D2,$C7,$C8   ;08BD9E|        |      ;
            db $FE,$A2,$26,$CA,$F9,$CE,$C6,$C0   ;08BDA6|        |      ;
            db $D6,$C0,$FF                       ;08BDAE|        |      ;
  
        text_f0:
            dw $2546                             ;08BDB1|        |      ;
            db $D3,$C7,$C0,$CD,$CA,$00,$D8,$CE   ;08BDB3|        |      ;
            db $D4,$00,$D5,$C4,$D1,$D8,$00,$CC   ;08BDBB|        |      ;
            db $D4,$C2,$C7,$FE,$CA,$25,$C5,$CE   ;08BDC3|        |      ;
            db $D1,$00,$CF,$CB,$C0,$D8,$C8,$CD   ;08BDCB|        |      ;
            db $C6,$FF                           ;08BDD3|        |      ;
  
        text_f1: 
            dw $254A                             ;08BDD5|        |      ;
            db $CF,$D1,$C4,$D2,$C4,$CD,$D3,$C4   ;08BDD7|        |      ;
            db $C3,$00,$C1,$D8,$FE,$AF,$25,$8C   ;08BDDF|        |      ;
            db $8D,$8E,$FE,$CF,$25,$9C,$9D,$9E   ;08BDE7|        |      ;
            db $FE,$ED,$25,$A9,$AA,$AB,$AC,$A4   ;08BDEF|        |      ;
            db $A5,$FE,$0D,$26,$B9,$BA,$97,$B3   ;08BDF7|        |      ;
            db $B4,$B5,$FE,$2E,$26,$A6,$A7,$A8   ;08BDFF|        |      ;
            db $FE,$4E,$26,$B6,$B7,$B8,$FE,$6D   ;08BE07|        |      ;
            db $26,$90,$91,$A0,$A1,$A2,$A3,$FE   ;08BE0F|        |      ;
            db $DB,$27,$55,$55,$FE,$E3,$27,$55   ;08BE17|        |      ;
            db $55,$FF                           ;08BE1F|        |      ;       
    }
        
                              ; paletteData
        data_5f:       
            dw $3F00                             ;009A3A|        |      ; ; inport data from ROM option.. 
            db $0F,$16,$26,$20,$0F,$00,$04,$10   ;009A3C|        |      ;
            db $0F,$02,$14,$27,$0F,$02,$04,$14   ;009A44|        |      ;
            db $FF                               ;009A4C|        |      ;
                data_5d:      
            dw $3F00                             ;009A4D|        |      ;
            db $0F,$16,$26,$20,$0F,$16,$27,$10   ;009A4F|        |      ;
            db $0F,$07,$0F,$0F,$0F,$07,$0F,$27   ;009A57|        |      ;
            db $FF                               ;009A5F|        |      ;

        PAL_sprite_trevor:  
            dw $3F10                             ;008982|        |      ;
            db $0F,$08,$26,$37,$0F,$0F,$22,$34   ;008984|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   ;00898C|        |      ;
            db $FF                               ;008994|        |      ;
      if !grantDaggerSpiderSilkFreez == 1 
         PAL_sprite_grant: 
            dw $3F10                             
           ; db $0F,$0C,$13,$30,$0F,$0F,$22,$34   
           db $0F,$01,$16,$20,$0F,$0F,$22,$34
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   
            db $FF                                  
      else  
        PAL_sprite_grant: 
            dw $3F10                             ;008995|        |      ;
            db $0F,$08,$15,$38,$0F,$0F,$22,$34   ;008997|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   ;00899F|        |      ;
            db $FF                               ;0089A7|        |      ;
      endif 
        PAL_sprite_sympha: 
            dw $3F10                             ;0089A8|        |      ;
            db $0F,$21,$11,$20,$0F,$0F,$22,$34   ;0089AA|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   ;0089B2|        |      ;
            db $FF                               ;0089BA|        |      ;

        PAL_sprite_alucart: 
            dw $3F10                             ;0089BB|        |      ;
            db $0F,$0F,$15,$36,$0F,$0F,$22,$34   ;0089BD|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   ;0089C5|        |      ;
            db $FF                               ;0089CD|    

        PAL_09:   db $00,$3F,$0F,$16,$26,$20,$0F,$16   ;008766|        |      ;
            db $26,$20,$0F,$16,$26,$20,$0F,$16   ;00876E|        |      ;
            db $26,$20,$FF                       ;008776|        |      ;             
        PAL_4a:
            dw $3F00                             ;009A60|        |      ;
            db $0F,$16,$26,$20,$0F,$07,$17,$27   ;009A62|        |      ;
            db $0F,$07,$0F,$0F,$0F,$07,$0F,$27   ;009A6A|        |      ;
            db $FF                               ;009A72|        |      ;
 
        PAL_4b:
            dw $3F00                             ;009A73|        |      ;
            db $0F,$16,$26,$20,$0F,$07,$27,$37   ;009A75|        |      ;
            db $0F,$07,$0F,$11,$0F,$07,$11,$27   ;009A7D|        |      ;
            db $FF                               ;009A85|        |      ;
 
        PAL_4c:
            dw $3F00                             ;009A86|        |      ;
            db $0F,$16,$26,$20,$0F,$17,$27,$37   ;009A88|        |      ;
            db $0F,$17,$21,$31,$0F,$07,$31,$37   ;009A90|        |      ;
            db $FF                               ;009A98|        |      ;
 
        PAL_20:
            dw $3F00                             ;009A99|        |      ;
            db $0F,$16,$26,$20,$0F,$22,$12,$20   ;009A9B|        |      ;
            db $0F,$22,$0F,$0F,$0F,$22,$0F,$20   ;009AA3|        |      ;
            db $FF                               ;009AAB|        |      ;

        PAL_04:
            dw $3F00                             ;009B87|        |      ;
            db $0F,$16,$05,$20,$0F,$13,$02,$20   ;009B89|        |      ;
            db $0F,$14,$03,$3B,$0F,$16,$27,$10   ;009B91|        |      ;
            db $0F,$0C,$26,$30,$0F,$0C,$2C,$30   ;009B99|        |      ;
            db $0F,$12,$26,$30,$0F,$06,$30,$30   ;009BA1|        |      ;
            db $FE                               ;009BA9|        |      ;
 
        PAL_03:
            dw $3F00                             ;009BAA|        |      ;
            db $FE,$00,$00,$FF                   ;009BAC|        |      ;
 
        PAL_18:
            dw $3F00                             ;009BB0|        |      ;
            db $0F,$07,$17,$20,$0F,$07,$17,$20   ;009BB2|        |      ;
            db $0F,$01,$09,$08,$0F,$01,$0B,$10   ;009BBA|        |      ;
            db $FF                               ;009BC2|        |      ;
 
        PAL_13:
            dw $3F00                             ;009BC3|        |      ;
            db $0F,$07,$17,$20,$0F,$01,$12,$20   ;009BC5|        |      ;
            db $0F,$01,$09,$08,$0F,$01,$0B,$10   ;009BCD|        |      ;
            db $FF                               ;009BD5|        |      ;
 
        PAL_15:
            dw $3F00                             ;009BD6|        |      ;
            db $0F,$07,$17,$20,$0F,$01,$21,$31   ;009BD8|        |      ;
            db $0F,$01,$08,$28,$0F,$08,$18,$17   ;009BE0|        |      ;
            db $FF                               ;009BE8|        |      ;
 
        PAL_16:
            dw $3F00                             ;009BE9|        |      ;
            db $0F,$07,$17,$20,$0F,$06,$0B,$10   ;009BEB|        |      ;
            db $0F,$01,$03,$10,$0F,$01,$1B,$3C   ;009BF3|        |      ;
            db $FF                               ;009BFB|        |      ;
 
        PAL_17:
            dw $212C                             ;009BFC|        |      ;
            db $38,$39,$3A,$FE,$4C,$21,$55,$56   ;009BFE|        |      ;
            db $FE,$6C,$21,$75,$76,$B1,$FE,$8D   ;009C06|        |      ;
            db $21,$87,$FF                       ;009C0E|        |      ;
 
        PAL_19:
            dw $3F00                             ;009C11|        |      ;
            db $0F,$16,$26,$20,$0F,$0B,$1B,$01   ;009C13|        |      ;
            db $0F,$01,$11,$20,$0F,$31,$11,$21   ;009C1B|        |      ;
            db $FF                               ;009C23|        |      ;
 
        PAL_1a:
            dw $3F00                             ;009C24|        |      ;
            db $0F,$16,$26,$20,$0F,$0B,$1B,$01   ;009C26|        |      ;
            db $0F,$11,$11,$31,$0F,$31,$11,$21   ;009C2E|        |      ;
            db $FF                               ;009C36|        |      ;
 
        PAL_1b:
            dw $3F00                             ;009C37|        |      ;
            db $0F,$16,$26,$20,$0F,$0B,$1B,$01   ;009C39|        |      ;
            db $0F,$21,$11,$21,$0F,$31,$11,$21   ;009C41|        |      ;
            db $FF                               ;009C49|        |      ;
 
        PAL_1c:
            dw $3F00                             ;009C4A|        |      ;
            db $0F,$16,$26,$20,$0F,$0B,$1B,$01   ;009C4C|        |      ;
            db $0F,$31,$11,$21,$0F,$31,$11,$21   ;009C54|        |      ;
            db $FF                               ;009C5C|        |      ;
 
        PAL_1d:
            dw $3F00                             ;009C5D|        |      ;
            db $0F,$06,$16,$20,$0F,$0F,$00,$0A   ;009C5F|        |      ;
            db $0F,$0F,$0B,$2C,$0F,$00,$2B,$3C   ;009C67|        |      ;
            db $FF                               ;009C6F|        |      ;
 
        PAL_1e:
            dw $3F00                             ;009C70|        |      ;
            db $0F,$08,$18,$38,$0F,$09,$0C,$2C   ;009C72|        |      ;
            db $0F,$09,$00,$10,$0F,$09,$13,$10   ;009C7A|        |      ;
            db $0F,$0F,$10,$20,$0F,$0F,$21,$38   ;009C82|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   ;009C8A|        |      ;
            db $FF                               ;009C92|        |      ;
  
        PAL_1f: 
            dw $3F00                             ;009C93|        |      ;
            db $0F,$16,$26,$20,$0F,$00,$10,$1A   ;009C95|        |      ;
            db $0F,$00,$0B,$2C,$0F,$02,$00,$10   ;009C9D|        |      ;
            db $0F,$08,$26,$37,$0F,$0F,$22,$34   ;009CA5|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$16,$25   ;009CAD|        |      ;
            db $FF                               ;009CB5|        |      ;
  
        PAL_2a: 
            dw $3F00                             ;009CB6|        |      ;
            db $0F,$0F,$26,$16,$0F,$0F,$07,$27   ;009CB8|        |      ;
            db $0F,$0F,$02,$23,$0F,$0F,$19,$39   ;009CC0|        |      ;
            db $FF                               ;009CC8|        |      ;
  
        PAL_2b: 
            dw $3F10                             ;009CC9|        |      ;
            db $38,$08,$27,$38,$38,$0F,$0C,$33   ;009CCB|        |      ;
            db $38,$21,$11,$20,$38,$08,$18,$28   ;009CD3|        |      ;
            db $FF                               ;009CDB|        |      ;
  
        PAL_2d: 
            dw $3F10                             ;009CDC|        |      ;
            db $38,$08,$27,$38,$38,$0F,$0C,$33   ;009CDE|        |      ;
            db $38,$0F,$15,$36,$38,$08,$18,$28   ;009CE6|        |      ;
            db $FF                               ;009CEE|        |      ;
  
        PAL_2c: 
            dw $3F10                             ;009CEF|        |      ;
            db $38,$08,$27,$38,$38,$0F,$0C,$33   ;009CF1|        |      ;
            db $38,$08,$15,$38,$38,$08,$18,$28   ;009CF9|        |      ;
            db $FF                               ;009D01|        |      ;
  
        PAL_2e: 
            dw $3F00                             ;009D02|        |      ;
            db $0F,$0F,$0F,$20,$0F,$0F,$0F,$0F   ;009D04|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F   ;009D0C|        |      ;
            db $FF                               ;009D14|        |      ;
  
        PAL_2f: 
            dw $3F10                             ;009D15|        |      ;
            db $0F,$08,$27,$38,$0F,$0F,$0C,$33   ;009D17|        |      ;
            db $0F,$21,$11,$20,$0F,$08,$18,$28   ;009D1F|        |      ;
            db $FF                               ;009D27|        |      ;
  
        PAL_31: 
            dw $3F10                             ;009D28|        |      ;
            db $0F,$08,$27,$38,$0F,$0F,$0C,$33   ;009D2A|        |      ;
            db $0F,$0F,$15,$36,$0F,$08,$18,$28   ;009D32|        |      ;
            db $FF                               ;009D3A|        |      ;
  
        PAL_30: 
            dw $3F10                             ;009D3B|        |      ;
            db $0F,$08,$27,$38,$0F,$0F,$0C,$33   ;009D3D|        |      ;
            db $0F,$08,$15,$38,$0F,$08,$18,$28   ;009D45|        |      ;
            db $FF                               ;009D4D|        |      ;
                data_5e:       
            dw $3F00                             ;009D4E|        |      ;
            db $0F,$16,$05,$20,$0F,$13,$02,$20   ;009D50|        |      ;
            db $0F,$14,$03,$3B,$0F,$0F,$0F,$0F   ;009D58|        |      ;
            db $FF                               ;009D60|        |      ;
        
        data_62:  
            dw $3F00                             ;009D61|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$10,$05,$01   ;009D63|        |      ;
            db $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F   ;009D6B|        |      ;
            db $FF                               ;009D73|                 

pushTable

{ ; -- text symbols title intro 
    
      ' ' = $00
      '0' = $01
      '1' = $02
      '2' = $03
      '3' = $04
      '4' = $05
      '5' = $06
      '6' = $07
      '7' = $08
      '8' = $09
      '9' = $0A
      '.' = $0B
      '=' = $0C   
      'A' = $10
      'B' = $11
      'C' = $12
      'D' = $13
      'E' = $14
      'F' = $15
      'G' = $16
      'H' = $17
      'I' = $18
      'J' = $19
      'K' = $1A
      'L' = $1B
      'M' = $1C
      'N' = $1D
      'O' = $1E
      'P' = $1F
      'Q' = $20
      'R' = $21
      'S' = $22
      'T' = $23
      'U' = $24
      'V' = $25
      'W' = $26
      'X' = $27
      'Y' = $28
      'Z' = $29
      '!' = $2A
      '?' = $2B     
      ',' = $38     
      ''' = $39     ; '   

      }
      
      
      if !optionScreen == 1 
        text_password_T_26:
            dw $2332          
            db "OPTIONS",$FF  
          text_opening_T_00:
            dw $2327          
            db "PLAY",$ff         
      else 
        text_password_T_26:
            dw $2332          
            db "PASSWORD",$FF 
          text_opening_T_00:
            dw $2327          
            db "OPENING",$ff        
      endif 




pullTable
}


    
    { ; -- new table and data   
    newPaletteText_dataBankA:
        dw text_hard_80 
        dw text_nameScreen_81
        dw text_Solo_82
        dw text_Sympha_83
        dw text_Grant_84
        dw text_Alucard_85
      
    text_hard_80:
        dw $2196
        db "NORMAL",$FF 
    text_nameScreen_81:
        dw $2196       
        db "HARD  ",$FF 
    text_Solo_82:
        dw $2216
        db "SOLO   ",$FF 
    text_Sympha_83:
        dw $2216
        db "SYMPHA ",$FF 
    text_Grant_84:
        dw $2216
        db "GRANT  ",$FF        
    text_Alucard_85:
        dw $2216
        db "ALUCARD",$FF        




      { ; -- new loadRoutine NewTable same format without wired AND mask    
        newLoad_X_preserveAll:          
            %phxya()
            
            ASL A                     
            TAY                       
            LDA.W newPaletteText_dataBankA,Y  
            STA.B $00                 
            LDA.W newPaletteText_dataBankA+1,Y      
            STA.B $01                 
        
            LDY.B #$00                                      
        continueLoad_A:        
            lda #$01  
            jsr getIDX_storeByteVramQueue   
                    
            lda.b ($00),Y     ; store PPU pointer 
            sta.w r_VramQueue,X
            inx     
            iny 
  
            lda.b ($00),Y     ; store PPU pointer 
            sta.w r_VramQueue,X
            inx     
            iny 
            
          - lda.b ($00),Y
            cmp #$ff
            beq ++
            cmp #$fe 
            beq + 
            
            sta.w r_VramQueue,X 
            inx     
            iny         
            bne -         
  
          + txa 
            sta.b r_sceneDrawQueue
            jsr closeVramQueue
            jmp continueLoad_A
          
          ++  txa
            sta.b r_sceneDrawQueue
            jsr closeVramQueue
            %plxya()  
            rts 
      }



    }


pushPC 
}

  







;-----------------------------------------
; -- freeSpace all_banks start -----------
;-----------------------------------------


{ ; bank_00 freeSpace -------------------- 



org $03EB8        
base $BEB8

if !levelSelect == 1 
    debuggModeHijack: 
      lda.b #debuggMode
      sta $00 
      lda.b #debuggMode>>8
      sta $01   
      lda #$a0  
      jsr runRAM_00_inBankA
      rts 
    exitDebuggProperly:
      sta.b r_gameTransition
      sta.b r_gameSubstate
      sta.b r_pauseFlag
      
      rts 
endif 



assert pc() <= $C000
pad $4000 ; !!FIXME waterFreezBug stage D left.. is fixed like this but the wrong way..
}

{ ; bank_01 freeSpace --------------------


  if !optionScreen == 1   ; -- clear show password
  
    r_optionIDX = $781
    r_optionMusic_IDX = $782
    r_optionSFX_IDX = $783
    r_optionSound_IDXvalue = $784
    r_optionLifes = $785
    r_optionStage = $786
  
  org $06F65
  base $AF65  
    password_nameScreenMain:
              LDA.B r_gameSubstate                  ;01AF65|A519    |000019;
              jsr jumpFromStackYXpreserved            
              dw password_nameScreen_00             ;01AF6A|        |01AF84;
              dw name_init_01                       ;01AF6C|        |01AFA4;
              dw name_fade_02                       ;01AF6E|        |01AFC1;
              dw name_main_03                       ;01AF70|        |01AFE0;
              dw password_init_04                   ;01AF72|        |01AFF4;
              dw password_init_05                   ;01AF74|        |01B011;
              dw password_init_06                   ;01AF76|        |01B2B9;
              dw password_fade_07                   ;01AF78|        |01B2D8;
              dw password_main_08                   ;01AF7A|        |01B300;
              dw password_main_08                   ;01AF7C|        |01B351;
              dw password_go2Level_0a               ;01AF7E|        |01B368;
              dw reloadNameScreen_0b                ;01AF80|        |01B396;
              dw reloadNamePassword_0c              ;01AF82|        |01B381;
    
  { ; -- name screen code   
    password_nameScreen_00:
              LDA.B r_gameSubstate                 ;01AF84|A519    |000019;
              BMI .goNextState
              LDA.B #$03                           ;01AF88|A903    |      ;
              STA.B r_counter_ShowSprBg            ;01AF8A|851C    |00001C;
              LDA.B #$80                           ;01AF8C|A980    |      ;
              STA.B r_gameSubstate                 ;01AF8E|8519    |000019;
  
            .goNextState: 
              jsr clearScreen_E4                    ;01AF91|        |0FEBFD;
              LDA.B #$44                           ;01AF93|A944    |      ;
              STA.B r_updateNametable              ;01AF95|8525    |000025;
              STA.W $5105                          ;01AF97|8D0551  |015105;
              LDA.B #$62                           ;01AF9A|A962    |      ;
              jsr lunchMusic                        ;01AF9D|        |0FE25F;
              LDA.B #$01                           ;01AF9F|A901    |      ;
              STA.B r_gameSubstate                 ;01AFA1|8519    |000019;
              RTS                                  ;01AFA3|60      |      ;
    
    
        name_init_01:
              JSR.W initBoss_setSoundBank             ;01AFB2|        |0FE2D6;
              JSR.W showPW_routine_CHRload_00             ;01AFB4|20C7B1  |01B1C7;
              
              ldy.b r_menuSelectIdx       ; load option screen
              bne optionNotSelected
              
              lda #$00              ; start game goPrayerScreen 
              sta.b r_menuSelectIdx
              sta.b r_gameSubstate
              lda #$09
              sta.b r_gameState
              rts           
            
            optionNotSelected:  
              cpy #$02
              beq goNameScreen
              
              lda #$02              ; set flag to be able to load next time 
              sta.b r_menuSelectIdx
              lda #$04
              sta.b r_gameSubstate 
              
              rts           
        
        goNameScreen:
              JSR.W showPW_clearAllSprite_01             ;01AFA4|2025B6  |01B625;
                
              JSR.W nameScr_fadeCounterReset             ;01AFB7|2066B0  |01B066;
              LDA.B #$03                           ;01AFBA|A903    |      ;
              STA.B r_counter_ShowSprBg            ;01AFBC|851C    |00001C;           
  
              LDX.B #$18                           ;01AFA7|A218    |      ;
              JSR.W loadScreen_decompress             ;01AFAA|        |0FEC04;
                          
              INC.B r_gameSubstate                 ;01AFBE|E619    |000019;
              RTS                                  ;01AFC0|60      |      ;
    
    
        name_fade_02:           
              LDA.B r_sceneDrawQueue               ;01AFC1|A51D    |00001D;
              STA.B r_15                          
              JSR.W loadNameScreenCHR             
              JSR.W CODE_0FFBA4                   
              LDA.B $B4                           
              CMP.B #$FF                          
              BNE endNameScr                      
              
              LDA.B #$00                          
              LDX.B r_15                          
              STA.W r_VramQueue,X                 
              STX.B r_sceneDrawQueue              
              JSR.W showPW_routine__02                      
              
              LDY.B #$00                           
              JSR.W drawPlayerName_nameScreen                         
              INC.B r_gameSubstate                    
          endNameScr:
              RTS                                 
    
    
        name_main_03:
              JSR.W CODE_01B06E                    ;01AFE0|206EB0  |01B06E;
              LDA.B r_Joy1_t                      
              AND.B #$10                          
              BNE .goNextState                    
              LDA.B $2D                           
              BEQ endNameScr                     
    
        .goNextState:
              LDY.B #$00                          
              STY.B $2D                           
              INC.B r_gameSubstate                
              RTS                                 
  
        CODE_01B06E:
              JSR.W RAM780_func                    ;01B06E|207AB0  |01B07A;
              JSR.W PW_transitSpriteDimming                    ;01B071|207AB1  |01B17A;           
              JSR.W nameScreen_joyInputs_00                    ;01B074|20DCB1  |01B1DC;
  
              LDY.B #$01                           ;01B14E|A001    |      ;
              LDX.B #$01                           ;01B150|A201    |      ;
              LDA.B r_frameCount                   ;01B152|A51A    |00001A;
              AND.B #$10                           ;01B154|2910    |      ;
              BEQ CODE_01B174                      ;01B156|F01C    |01B174;
              LDA.W r_EffectSpeedSupGeneral        ;01B158|AD8507  |010785;
              CLC                                  ;01B15B|18      |      ;
              ADC.B #$50                           ;01B15C|6947    |      ;
              STA.B $00                            ;01B15E|8500    |000000;
              LDA.W r_EffectSpeedGeneral           ;01B160|AD8407  |010784;
              ASL A                                ;01B163|0A      |      ;
              ASL A                                ;01B164|0A      |      ;
              ASL A                                ;01B165|0A      |      ;
              CLC                                  ;01B166|18      |      ;
              ADC.B #$60                           ;01B167|6960    |      ;
              STA.B $01                            ;01B169|8501    |000001;
              JSR.W defaultPos_spriteGroup_nameSc                    ;01B16B|20ACB1  |01B1AC;
              LDA.B #$F6                           ;01B16E|A9F6    |      ;
              STA.W r_entity_spriteID,X            ;01B170|9D0004  |010400;
              RTS                                  ;01B173|60      |      ;
        CODE_01B174:
              LDA.B #$00                           ;01B174|A900    |      ;
              STA.W r_entity_spriteID,X            ;01B176|9D0004  |010400;
              RTS                                  ;01B179|60      |      ;
        
        
        RAM780_func:
              LDX.B #$00                           ;01B07A|A200    |      ;
              JSR.W inputCurserUpdate_namScr       ;01B07C|20CCB0  |01B0CC;
    
        CODE_01B082:
              LDA.W r_optionIDX                   ;01B082|AD8107  |010781;
              CMP.B #$03                           ;01B085|C903    |      ;
              BCC CODE_01B0C5                      ;01B087|903C    |01B0C5;
              LDA.B r_index                        ;01B089|A510    |000010;
              AND.B #$0C                           ;01B08B|290C    |      ;
              BEQ CODE_01B0AA                      ;01B08D|F01B    |01B0AA;
              LDY.W r_soundModeSongSelected        ;01B08F|AC8007  |010780;
              LDA.W characterSpecial_name,Y                 ;01B092|B975B2  |01B275;
              CMP.B #$FC                           ;01B095|C9FC    |      ;
              BNE CODE_01B0AA                      ;01B097|D011    |01B0AA;
              LDA.B #$02                           ;01B099|A902    |      ;
              CPY.B #$03                           ;01B09B|C003    |      ;
              BEQ CODE_01B0A7                      ;01B09D|F008    |01B0A7;
              LDA.B #$05                           ;01B09F|A905    |      ;
              CPY.B #$04                           ;01B0A1|C004    |      ;
              BEQ CODE_01B0A7                      ;01B0A3|F002    |01B0A7;
              LDA.B #$08                           ;01B0A5|A908    |      ;
    
        CODE_01B0A7:
              STA.W r_soundModeSongSelected        ;01B0A7|8D8007  |010780;
    
        CODE_01B0AA:
              LDA.B r_index                        ;01B0AA|A510    |000010;
              AND.B #$03                           ;01B0AC|2903    |      ;
              BEQ CODE_01B0C5                      ;01B0AE|F015    |01B0C5;
              TAX                                  ;01B0B0|AA      |      ;
              LDY.W r_soundModeSongSelected        ;01B0B1|AC8007  |010780;
              LDA.W characterSpecial_name,Y                 ;01B0B4|B975B2  |01B275;
              CMP.B #$FC                           ;01B0B7|C9FC    |      ;
              BNE CODE_01B0C5                      ;01B0B9|D00A    |01B0C5;
              LDA.W DATA8_01B0C6,X                 ;01B0BB|BDC6B0  |01B0C6;
              CLC                                  ;01B0BE|18      |      ;
              ADC.W r_soundModeSongSelected        ;01B0BF|6D8007  |010780;
              STA.W r_soundModeSongSelected        ;01B0C2|8D8007  |010780;
    
        CODE_01B0C5:
              RTS                                  ;01B0C5|60      |      ;
    
    
        DATA8_01B0C6:
              db $00,$01,$FF,$01                   ;01B0C6|        |      ;
  
  
  
  
  
    
        curserUpdate_namScr:
              LDX.B #$01                           ;01B0CA|A201    |      ; 
        inputCurserUpdate_namScr:
              JSR.W CODE_01B12B                    ;01B0CC|202BB1  |01B12B;
              STA.B $00                            ;01B0CF|8500    |000000;
              AND.B #$0F                           ;01B0D1|290F    |      ;
              BEQ CODE_01B0DA                      ;01B0D3|F005    |01B0DA;
              LDA.B #$1A                           ;01B0D5|A91A    |     
              JSR.W lunchMusic                        ;01B0D8|        |0FE25F;
    
        CODE_01B0DA:
              LSR.B $00                            ;01B0DA|4600    |000000;
              BCC CODE_01B0ED                      ;01B0DC|900F    |01B0ED;
              LDA.W r_soundModeSongSelected        ;01B0DE|AD8007  |010780;
              ADC.B #$00                           ;01B0E1|6900    |      ;
              CMP.W DATA8_01B127,X                 ;01B0E3|DD27B1  |01B127;
              BCC CODE_01B0EA                      ;01B0E6|9002    |01B0EA;
              LDA.B #$00                           ;01B0E8|A900    |      ;
    
        CODE_01B0EA:
              STA.W r_soundModeSongSelected        ;01B0EA|8D8007  |010780;
    
        CODE_01B0ED:
              LSR.B $00                            ;01B0ED|4600    |000000;
              BCC CODE_01B100                      ;01B0EF|900F    |01B100;
              LDA.W r_soundModeSongSelected        ;01B0F1|AD8007  |010780;
              SBC.B #$01                           ;01B0F4|E901    |      ;
              BPL CODE_01B0FD                      ;01B0F6|1005    |01B0FD;
              LDY.W DATA8_01B127,X                 ;01B0F8|BC27B1  |01B127;
              DEY                                  ;01B0FB|88      |      ;
              TYA                                  ;01B0FC|98      |      ;
    
        CODE_01B0FD:
              STA.W r_soundModeSongSelected        ;01B0FD|8D8007  |010780;
    
        CODE_01B100:
              LSR.B $00                            ;01B100|4600    |000000;
              BCC CODE_01B113                      ;01B102|900F    |01B113;
              LDA.W r_optionIDX              ;01B104|AD8107  |010781;
              ADC.B #$00                           ;01B107|6900    |      ;
              CMP.W DATA8_01B129,X                 ;01B109|DD29B1  |01B129;
              BCC CODE_01B110                      ;01B10C|9002    |01B110;
              LDA.B #$00                           ;01B10E|A900    |      ;
    
        CODE_01B110:
              STA.W r_optionIDX              ;01B110|8D8107  |010781;
    
        CODE_01B113:
              LSR.B $00                            ;01B113|4600    |000000;
              BCC CODE_01B126                      ;01B115|900F    |01B126;
              LDA.W r_optionIDX              ;01B117|AD8107  |010781;
              SBC.B #$01                           ;01B11A|E901    |      ;
              BPL CODE_01B123                      ;01B11C|1005    |01B123;
              LDY.W DATA8_01B129,X                 ;01B11E|BC29B1  |01B129;
              DEY                                  ;01B121|88      |      ;
              TYA                                  ;01B122|98      |      ;
    
        CODE_01B123:
              STA.W r_optionIDX              ;01B123|8D8107  |010781;
    
        CODE_01B126:
              RTS                                  ;01B126|60      |      ;
    
    
        DATA8_01B127:
              db $09,$04                           ;01B127|        |      ;
    
        DATA8_01B129:
              db $04,$04                           ;01B129|        |      ;
    
        CODE_01B12B:
              CPX.B #$01                           ;01B12B|E001    |      ;
              BCS CODE_01B149                      ;01B12D|B01A    |01B149;
              CLC                                  ;01B12F|18      |      ;
              LDY.B #$00                           ;01B130|A000    |      ;
              LDA.B r_Joy1Held_t                   ;01B132|A528    |000028;
              AND.B #$0F                           ;01B134|290F    |      ;
              BEQ CODE_01B142                      ;01B136|F00A    |01B142;
              LDY.W $07B0                          ;01B138|ACB007  |0107B0;
              INY                                  ;01B13B|C8      |      ;
              CPY.B #$0E                           ;01B13C|C00E    |      ;
              BCC CODE_01B142                      ;01B13E|9002    |01B142;
              LDY.B #$00                           ;01B140|A000    |      ; 
        CODE_01B142:
              STY.W $07B0                          ;01B142|8CB007  |0107B0;
              LDA.B r_Joy1Held_t                   ;01B145|A528    |000028;
              BCS CODE_01B14B                      ;01B147|B002    |01B14B; 
        CODE_01B149:
              LDA.B r_Joy1_t                       ;01B149|A526    |000026; 
        CODE_01B14B:
              STA.B r_index                        ;01B14B|8510    |000010;
              RTS                                  ;01B14D|60      |      ;
    
  
    
        PW_transitSpriteDimming:
              JSR.W CODE_01B190                    ;01B17A|2090B1  |01B190;
              LDY.B #$F8                           ;01B17D|A0F8    |      ;
              INC.W r_entity_AnimTimer,X           ;01B17F|FE7C05  |01057C;
              LDA.W r_entity_AnimTimer,X           ;01B182|BD7C05  |01057C;
              AND.B #$08                           ;01B185|2908    |      ;
              BNE CODE_01B18B                      ;01B187|D002    |01B18B;
              LDY.B #$FA                           ;01B189|A0FA    |      ;
    
        CODE_01B18B:
              TYA                                  ;01B18B|98      |      ;
              STA.W r_entity_spriteID,X            ;01B18C|9D0004  |010400;
              RTS                                  ;01B18F|60      |      ;
    
    
        CODE_01B190:
              LDY.B #$00                           ;01B190|A000    |      ;
              LDX.B #$00                           ;01B192|A200    |      ;
              LDA.W r_optionIDX              ;01B194|AD8107  |010781;
              ASL A                                ;01B197|0A      |      ;
              ASL A                                ;01B198|0A      |      ;
              ASL A                                ;01B199|0A      |      ;
              ASL A                                ;01B19A|0A      |      ;
              CLC                                  ;01B19B|18      |      ;
              ADC.B #$88                           ;01B19C|6988    |      ;
              STA.B $00                            ;01B19E|8500    |000000;
              LDA.W r_soundModeSongSelected        ;01B1A0|AD8007  |010780;
              ASL A                                ;01B1A3|0A      |      ;
              ASL A                                ;01B1A4|0A      |      ;
              ASL A                                ;01B1A5|0A      |      ;
              ASL A                                ;01B1A6|0A      |      ;
              CLC                                  ;01B1A7|18      |      ;
              ADC.B #$3C                           ;01B1A8|693C    |      ;
              STA.B $01                            ;01B1AA|8501    |000001;
    
        defaultPos_spriteGroup_nameSc:
              LDA.B $00                            ;01B1AC|A500    |000000;
              STA.W r_entity_YPos,X                ;01B1AE|9D1C04  |01041C;
              LDA.B $01                            ;01B1B1|A501    |000001;
              STA.W r_entity_XPos,X                ;01B1B3|9D3804  |010438;
              LDA.W DATA8_01B1C3,Y                 ;01B1B6|B9C3B1  |01B1C3;
              STA.W r_entity_spriteGroup,X         ;01B1B9|9D8C04  |01048C;
              LDA.W DATA8_01B1C5,Y                 ;01B1BC|B9C5B1  |01B1C5;
              STA.W r_entity_PaletteOverride,X     ;01B1BF|9D5404  |010454;
              RTS                                  ;01B1C2|60      |      ;
    
    
        DATA8_01B1C3:
              db $0C,$0C                           ;01B1C3|        |      ;
    
        DATA8_01B1C5:
              db $23,$00                           ;01B1C5|        |      ;
    
        showPW_routine_CHRload_00:
              LDX.B #$00                           ;01B1C7|A200    |      ;
    
        CODE_01B1C9:
              LDA.W PW_CHR_banks,X                 ;01B1C9|BDD4B1  |01B1D4;
              STA.B r_CHR_BankSpr_0000,X           ;01B1CC|9546    |000046;
              INX                                  ;01B1CE|E8      |      ;
              CPX.B #$08                           ;01B1CF|E008    |      ;
              BCC CODE_01B1C9                      ;01B1D1|90F6    |01B1C9;
              RTS                                  ;01B1D3|60      |      ;
    
    
        PW_CHR_banks:
              db $40,$01,$00,$43,$40,$41,$42,$73   ;01B1D4|        |      ;
    
        nameScreen_joyInputs_00:
              LDA.B r_Joy1_t                       ;01B1DC|A526    |000026;
              AND.B #$C0                           ;01B1DE|29C0    |      ;
              BEQ CODE_01B22E                      ;01B1E0|F04C    |01B22E;
              LDA.B r_Joy1_t                       ;01B1E2|A526    |000026;
              AND.B #$80                           ;01B1E4|2980    |      ;
              BEQ CODE_01B22F                      ;01B1E6|F047    |01B22F;
              LDA.W r_optionIDX              ;01B1E8|AD8107  |010781;
              STA.B $00                            ;01B1EB|8500    |000000;
              LDA.B $00                            ;01B1ED|A500    |000000;
              BEQ CODE_01B1FB                      ;01B1EF|F00A    |01B1FB;
              LDA.B #$00                           ;01B1F1|A900    |      ;
              CLC                                  ;01B1F3|18      |      ;
    
        CODE_01B1F4:
              ADC.W DATA8_01B127                   ;01B1F4|6D27B1  |01B127;
              DEC.B $00                            ;01B1F7|C600    |000000;
              BNE CODE_01B1F4                      ;01B1F9|D0F9    |01B1F4;
    
        CODE_01B1FB:
              CLC                                  ;01B1FB|18      |      ;
              ADC.W r_soundModeSongSelected        ;01B1FC|6D8007  |010780;
              TAY                                  ;01B1FF|A8      |      ;
              LDX.W r_EffectSpeedGeneral           ;01B200|AE8407  |010784;
              LDA.W characterTable_name,Y                 ;01B203|B95AB2  |01B25A;
              CMP.B #$FF                           ;01B206|C9FF    |      ;
              BEQ endNameScreen                      ;01B208|F03C    |01B246;
              CMP.B #$FE                           ;01B20A|C9FE    |      ;
              BEQ charSelect_movRight              ;01B20C|F03D    |01B24B;
              CMP.B #$FD                           ;01B20E|C9FD    |      ;
              BEQ charSelect_movLeft               ;01B210|F028    |01B23A;
              CMP.B #$FC                           ;01B212|C9FC    |      ;
              BEQ CODE_01B259                      ;01B214|F043    |01B259;
              STA.W r_playerName,X                 ;01B216|9DF807  |0107F8;
              JSR.W updateChracter_name                    ;01B219|207EB2  |01B27E;
              LDA.B #$1B                           ;01B21C|A91B    |     
              JSR.W lunchMusic                        ;01B21F|        |0FE25F;
              LDY.W r_EffectSpeedGeneral           ;01B221|AC8407  |010784;
              INY                                  ;01B224|C8      |      ;
              CPY.B #$08                           ;01B225|C008    |      ;
              BCC CODE_01B22B                      ;01B227|9002    |01B22B;
              LDY.B #$00                           ;01B229|A000    |      ;
    
        CODE_01B22B:
              STY.W r_EffectSpeedGeneral           ;01B22B|8C8407  |010784;
    
        CODE_01B22E:
              RTS                                  ;01B22E|60      |      ;
  
  
        characterTable_name:
              db $50,$51,$52,$53,$54,$55,$56,$57   ;01B25A|        |      ;
              db $58,$59,$5A,$5B,$5C,$5D,$5E,$5F   ;01B262|        |      ;
              db $60,$61,$62,$63,$64,$65,$66,$67   ;01B26A|        |      ;
              db $68,$69,$00                       ;01B272|        |      ;
    
        characterSpecial_name:
              db $6A,$6B,$4B,$FC,$FC,$FD,$FE,$FC   ;01B275|        |      ;
              db $FF                               ;01B27D|        |      ;
    
    
        CODE_01B22F:
              JSR.W charSelect_movLeft                    ;01B22F|203AB2  |01B23A;
              LDA.B #$00                           ;01B232|A900    |      ;
              STA.W r_playerName,Y                 ;01B234|99F807  |0107F8;
              JMP.W updateChracter_name                    ;01B237|4C7EB2  |01B27E;
    
    
        charSelect_movLeft:
              LDY.W r_EffectSpeedGeneral           ;01B23A|AC8407  |010784;
              DEY                                  ;01B23D|88      |      ;
              BPL CODE_01B242                      ;01B23E|1002    |01B242;
              LDY.B #$07                           ;01B240|A007    |      ;
    
        CODE_01B242:
              STY.W r_EffectSpeedGeneral           ;01B242|8C8407  |010784;
              RTS                                  ;01B245|60      |      ;
    
    
        endNameScreen:
              LDA.B #$01                           ;01B246|A901    |      ;
              STA.B $2D                            ;01B248|852D    |00002D;
              RTS                                  ;01B24A|60      |      ;
    
    
        charSelect_movRight:
              LDY.W r_EffectSpeedGeneral           ;01B24B|AC8407  |010784;
              INY                                  ;01B24E|C8      |      ;
              CPY.B #$08                           ;01B24F|C008    |      ;
              BCC CODE_01B255                      ;01B251|9002    |01B255;
              LDY.B #$00                           ;01B253|A000    |      ;
    
        CODE_01B255:
              STY.W r_EffectSpeedGeneral           ;01B255|8C8407  |010784;
              RTS                                  ;01B258|60      |      ;
    
    
        CODE_01B259:
              RTS                                  ;01B259|60      |      ;
      
        updateChracter_name:
              PHA                                  ;01B27E|48      |      ;
              LDY.B #$00                           ;01B27F|A000    |      ;
              JSR.W CODE_01B2A0                    ;01B281|20A0B2  |01B2A0;
              PLA                                  ;01B284|68      |     
              JSR.W getIDX_storeByteVramQueue         ;01B286|        |0FED14;
              jmp closeVramQueue                    ;01B289|        |0FED12;
  
  
  
  
  } 
  
  
  { ; -- optionScreen 
  
      
    { ; option init   
      
      password_init_04:
              LDY.B r_menuSelectIdx                ;01AFF4|A46B    |00006B;
              BNE CODE_01B007                      ;01AFF6|D00F    |01B007;
              LDA.B #$07                           ;01AFF8|A907    |      ;
              STA.W $0160                          ;01AFFA|8D6001  |010160;
              JSR.W nameScr_fadeCounterReset             ;01AFFD|2066B0  |01B066;
              LDA.B #$78                           ;01B000|A978    |      ;
              STA.B r_timerGenerel                 ;01B002|8530    |000030;
              INC.B r_gameSubstate                 ;01B004|E619    |000019;
    
              RTS                                  ;01B006|60      |      ;
    
    
        CODE_01B007:
              INC.B r_gameSubstate                 ;01B007|E619    |000019; 
              JMP.W nameScr_fadeCounterReset             ;01B009|4C66B0  |01B066;
    
              LDA.B #$02                           ;01B00C|A902    |      ;
              STA.B r_gameSubstate                 ;01B00E|8519    |000019;
              RTS                                  ;01B010|60      |      ;
    
    
      password_init_05:
              LDY.B r_menuSelectIdx 
              bne +
              JSR.W PW_transitSpriteDimming                    ;01B011|207AB1  |01B17A;
            + 
              LDA.B #$00                           ;01B014|A900    |      ;
              STA.W $0401                          ;01B016|8D0104  |010401;
              LDA.B r_menuSelectIdx                ;01B019|A56B    |00006B;
              BNE CODE_01B047                      ;01B01B|D02A    |01B047;
              DEC.B r_timerGenerel                 ;01B01D|C630    |000030;
              BEQ CODE_01B050                      ;01B01F|F02F    |01B050;
              LDA.B $B4                            ;01B021|A5B4    |0000B4;
              CMP.B #$FF                           ;01B023|C9FF    |      ;
              BEQ CODE_01B05C                      ;01B025|F035    |01B05C;
              LDA.B r_timerGenerel                 ;01B027|A530    |000030;
              CMP.B #$30                           ;01B029|C930    |      ;
              BCS CODE_01B05C                      ;01B02B|B02F    |01B05C;
    
        CODE_01B02D:
              LDA.B r_sceneDrawQueue               ;01B02D|A51D    |00001D;
              STA.B r_15                           ;01B02F|8515    |000015;
              JSR.W loadNameScreenCHR              ;01B031|2098B5  |01B59
              JSR.W CODE_0FFBAF                       ;01B035|        |0FFBAF;
              LDA.B $B4                            ;01B037|A5B4    |0000B4;
              CMP.B #$FF                           ;01B039|C9FF    |      ;
              BNE CODE_01B05C                      ;01B03B|D01F    |01B05C;
              LDA.B #$00                           ;01B03D|A900    |      ;
              LDX.B r_15                           ;01B03F|A615    |000015;
              STA.W r_VramQueue,X                  ;01B041|9D0003  |010300;
              STX.B r_sceneDrawQueue               ;01B044|861D    |00001D;
              RTS                                  ;01B046|60      |      ;
    
    
        CODE_01B047:
              JSR.W CODE_01B02D                    ;01B047|202DB0  |01B02D;
              LDA.B $B4                            ;01B04A|A5B4    |0000B4;
              CMP.B #$FF                           ;01B04C|C9FF    |      ;
              BNE CODE_01B05C                      ;01B04E|D00C    |01B05C;
    
        CODE_01B050:
              LDA.B #$00                           ;01B050|A900    |      ;
              STA.B $2D                            ;01B052|852D    |00002D;
              LDA.B r_menuSelectIdx                ;01B054|A56B    |00006B;
              BEQ initMainGame                      ;01B056|F005    |01B05D;
              LDA.B #$06                           ;01B058|A906    |      ;
              STA.B r_gameSubstate                 ;01B05A|8519    |000019;
    
        CODE_01B05C:
              RTS                                  ;01B05C|60      |      ;
    
    
        initMainGame:
              LDA.B #$FF                           ;01B05D|A9FF    |      ;
              STA.B r_partner                      ;01B05F|853A    |00003A;
              LDA.B #$09                           ;01B061|A909    |      ;
              jmp storeGameState_zeroSub            ;01B064|        |0FE574;
    
  
        drawPlayerName_nameScreen:
              LDA.B #$01                           
              JSR.W getIDX_storeByteVramQueue       
              LDA.W playerNameScreenPos,Y           
              JSR.W getIDX_storeByteVramQueue
              LDA.W playerNameScreenPos+1,Y         
              JSR.W getIDX_storeByteVramQueue
              LDY.B #$00                           ;01B290|A000    |      ; 
        
        CODE_01B292:
              LDA.W r_playerName,Y                 ;01B292|B9F807  |0107F
              JSR.W getIDX_storeByteVramQueue         ;01B296|        |0FED14;
              INY                                  ;01B298|C8      |      ;
              CPY.B #$08                           ;01B299|C008    |      ;
              BCC CODE_01B292                      ;01B29B|90F5    |01B292;
              jmp closeVramQueue                    ;01B29E|        |0FED12;
    
        CODE_01B2A0:
              LDA.B #$01                           ;01B2A0|A901    |      ;
              jsr getIDX_storeByteVramQueue         ;01B2A3|        |0FED14;
              LDA.W r_EffectSpeedGeneral           ;01B2A5|AD8407  |010784;
              CLC                                  ;01B2A8|18      |      ;
              ADC.W playerNameScreenPos,Y          ;01B2A9|79B5B2  |01B2B5;
              jsr getIDX_storeByteVramQueue         ;01B2AD|        |0FED14;
              LDA.W playerNameScreenPos+1,Y        ;01B2AF|B9B6B2  |01B2B6;
              jmp getIDX_storeByteVramQueue         ;01B2B3|        |0FED14;
    
        playerNameScreenPos:
              dw $210C
              dw $20AC
    
  
    
    
      password_fade_07:
              LDA.B $B4                            ;01B2D8|A5B4    |0000B4;
              CMP.B #$FF                           ;01B2DA|C9FF    |      ;
              BEQ CODE_01B2F8                      ;01B2DC|F01A    |01B2F8;
              LDA.B r_sceneDrawQueue               ;01B2DE|A51D    |00001D;
              STA.B r_15                           ;01B2E0|8515    |000015;
              JSR.W loadNameScreenCHR              ;01B2E2|2098B5  |01B598;
              JSR.W CODE_0FFBA4                       ;01B2E6|        |0FFBA4;
              LDA.B $B4                            ;01B2E8|A5B4    |0000B4;
              CMP.B #$FF                           ;01B2EA|C9FF    |      ;
              BNE +
              LDA.B #$00                           ;01B2EE|A900    |      ;
              LDX.B r_15                           ;01B2F0|A615    |000015;
              STA.W r_VramQueue,X                  ;01B2F2|9D0003  |010300;
              STX.B r_sceneDrawQueue               ;01B2F5|861D    |00001D;
            + RTS                                  ;01B2F7|60      |      ;
    
    
        CODE_01B2F8:
              INC.B r_gameSubstate                 ;01B2F8|E619    |000019;
              rts 
  
    
      password_init_06:
              JSR.W  clearScreen_E4                    ;01B2BA|        |0FEBFD;
              LDA.B #$98                           ;01B2BC|A998    |      ;
              LDX.B #$1A                           ;01B2BE|A21A    |      ;
              JSR.W screenLoadRoutine01               ;01B2C1|        |0FEBD5;
              JSR.W showPW_routine__02             ;01B2C3|2075B6  |01B675            
              jsr loadMenuNamesAll
              
              
              LDA.B #$02                           ;01B2C9|A902    |      ;
              STA.B r_counter_ShowSprBg            ;01B2CB|851C    |00001C;
              JSR.W showPW_clearAllSprite_01             ;01B2CD|2025B6  |01B625;
              JSR.W nameScr_fadeCounterReset             ;01B2D0|2066B0  |01B066;
              
              jsr optionUpdatesBG
              jsr doMenue_stage_03        ; draw stage name   
              LDY.B #$02     
              JSR.W drawPlayerName_nameScreen
              
              INC.B r_gameSubstate                 ;01B2D3|E619    |000019;
              JMP.W showPW_routine_CHRload_00             ;01B2D5|4CC7B1  |01B1C7;  
      
      
    }
    
      
    { ; option main   
      
      ; 0 
      ; 1 difficulty
      ; 2 lifes 
      ; 3 partner 
      ; 4 stage 
      ; 5 music 
      ; 6 sfx 
      ; 7 name screen
      
          password_main_08:       
              jsr optionMenuMain
              
              LDA.B r_Joy1_t                   
              AND.B #$F0                       
              BNE pressAnyButton_option             
              
  ;           LDA.B $2D                        
  ;           BNE pressAnyButton_option                 
              RTS 
        
          pressAnyButton_option:              
              LDA.B r_Joy1_t                   
              AND.B #$10                       
              beq +           
            ; jmp goTitleScreen ; exiting with start.. I do not really like that            
            + lda.w r_optionIDX
              jsr jumpFromStackYXpreserved
              dw doMenue_difficulty_00
              dw doMenue_life_01
              dw doMenue_partner_02
              dw doMenue_stage_03 
              dw doMenue_music_04
              dw doMenue_music_04
              dw go2NameScreen
              dw goTitleScreen
  
  
          doMenue_difficulty_00:    ; empty
              lda.w r_hardMode  ; text_HARD_67  
              eor #$01
              sta.w r_hardMode    
              rts             
          
          doMenue_life_01:  
              inc.w r_optionLifes
            - ldy.w r_optionLifes
              lda.w lifeOptsions,y 
              cmp #$ff
              bne +
              lda #$00
              sta.w r_optionLifes
              beq -
            + sta.w sr_defaultLife
              rts 
          lifeOptsions:
              db $02,$05,$10,$30,$FF
          
          doMenue_partner_02:
              inc.w sr_selectedPlayer
            updateOptionHelper: 
              lda.w sr_selectedPlayer
              and #$03
              sta.w sr_selectedPlayer
              jsr updateHelperName            
  
              rts 
          doMenue_stage_03:
              lda.w sr_setStartingStage   
              sta.b r_stage
              
              ldy #$02
              %jsl ($A0,displayStageName)
              rts 
          doMenue_music_04:
              LDA.B r_Joy1_t         ; mute with B           
              AND.B #$30  
              beq +
              jmp initSound
            
            + lda.w r_optionIDX
              cmp #$05
              beq doMenue_sfx_05
              
              lda.w r_optionMusic_IDX
              clc 
              adc #$4e    ; 4e - 7d 
              sta.w r_optionSound_IDXvalue
              jmp lunchMusic 
          
          doMenue_sfx_05:         
              lda.w r_optionSFX_IDX
              sta.w r_optionSound_IDXvalue
              jmp lunchMusic 
          
        
          loadMenuNamesAll:
              lda #$68      ; 68 - 6e 
            - pha 
              jsr screenLoad_A_CHR
              pla 
              clc 
              adc #$01
              cmp #$71 
              bne -
          
          updateHelperName:   
              lda.w sr_selectedPlayer
              clc 
              adc #$0f 
              jsr screenLoad_A_CHR      ; HUD_trevor_Prfile_0f  
              lda.w sr_selectedPlayer
              clc 
              adc #$02
              tax 
              jsr goNewLoad_X_preserveAll   ; %jsl ($A0,newLoad_X_preserveAll)
              
              rts 
  
  
  
          optionMenuMain:   ; ----------------------------------------------
              LDA.B r_Joy1_t
              and #$0C          
              beq +
              
              LDA.B #$1A        
              JSR.W lunchMusic  
              
            + LDA.B r_Joy1_t
              and #$04
              bne +
              
              dec.w r_optionIDX
  
            + LDA.B r_Joy1_t
              and #$08
              bne +       
              
              inc.w r_optionIDX
              
            + lda.w r_optionIDX
              and #$07
              sta.w r_optionIDX
            
            + jsr optionCurser
              jsr optionUpdatesBG
              rts     
          
  
          optionCurser:
              ldx.w r_optionIDX
              
              LDA #$F4      
              STA.W r_entity_spriteID            
              LDA #$0C           
              STA.W r_entity_spriteGroup         
              
              
              LDA.W option_YPosData,X
              STA.W r_entity_YPos             
              LDA #$3C        
              STA.W r_entity_XPos               
              
              LDA #$03                   
              STA.W r_entity_PaletteOverride,X 
              
              txa 
              jsr jumpFromStackYXpreserved
              dw Menue_difficulty_00  
              dw Menue_life_01          
              dw Menue_partner_02
              dw Menue_stage_03
              dw Menue_music_04
              dw Menue_sfx_05
              dw Menue_name_06
              dw Menue_exit_07
            
            Menue_difficulty_00:  
              LDA.B r_Joy1_t
              and #$03
              beq + 
              jmp doMenue_difficulty_00 
            + rts
          
          
            Menue_life_01:          
                LDA.B r_Joy1_t
                and #$03
                beq + 
                jmp doMenue_life_01 
              + rts           
          
          
            Menue_partner_02:
              LDA.B r_Joy1_t
              and #$03
              beq + 
              jmp doMenue_partner_02              
            + rts 
          
          
            Menue_stage_03:
              lda.w sr_setStartingStage ; get backup value in case we come from other screens
              sta.w r_optionStage
              ldy #$04
              jsr musicNav
              
              lda.w r_optionStage     
              bpl +
              lda #$0e
              bne ++
              
            + cmp #$0f 
              bne ++
              lda #$00
            
            ++  sta.b r_stage
              sta.w r_optionStage
              sta.w sr_setStartingStage ; back it up again 
              
              LDA.B r_Joy1_t
              and #$03
              beq + 
              jmp doMenue_stage_03  
            + rts 
          
          
            Menue_music_04:
              ldy #$00
              jsr musicNav
              
              lda.w r_optionMusic_IDX
              bpl +
              lda #$2E  ; max 1e
              bne ++
            + cmp #$2F
              bne +
              lda #$00  ; min 
            ++  sta.w r_optionMusic_IDX
            +   
              rts 
            
            
            Menue_sfx_05:
              ldy #$01
              jsr musicNav
              
              lda.w r_optionSFX_IDX
              bpl +
              lda #$4d  ; max 
              bne ++
            + cmp #$4e
              bne +
              lda #$00  ; min 
            ++  sta.w r_optionSFX_IDX
            + 
              rts 
          
          
          Menue_name_06:
          Menue_exit_07:
              rts
  
          option_YPosData:
              db $60,$70,$80,$90,$A0,$B0,$C0,$D0    
          
          musicNav:
              lda.w r_Joy1_t
              and #$01
              beq +
              
              lda.w r_optionMusic_IDX,y
              clc 
              adc #$01
              sta.w r_optionMusic_IDX,y
            + 
              lda.w r_Joy1_t
              and #$02
              beq +         
            
              lda.w r_optionMusic_IDX,y
              sec           
              sbc #$01
              sta.w r_optionMusic_IDX,y
            + rts
  
  
          optionUpdatesBG:
              ldx.w r_hardMode      ; text_hard_80
              jsr goNewLoad_X_preserveAll ; %jsl ($A0,newLoad_X_preserveAll)
        
          if !debuggMenu == 1           
              LDA.B #$20                ; showSound ID           
              STA.B r_VRAM_QueueDestHi             
              LDA.B #$54                           
              STA.B r_VRAM_QueueDestLo                                    
              ldy.w r_optionSound_IDXvalue
              sty.b r_pointerQueue                                                  
              %jsl ($80,updateQueueWithNumber)  
          endif 
                
              LDA.B #$22                        
              STA.B r_VRAM_QueueDestHi             
              LDA.B #$96                           
              STA.B r_VRAM_QueueDestLo                                    
              ldy.w r_optionMusic_IDX
              sty.b r_pointerQueue                                                  
              %jsl ($80,updateQueueWithNumber) 
  
              LDA.B #$22                        
              STA.B r_VRAM_QueueDestHi             
              LDA.B #$d6                           
              STA.B r_VRAM_QueueDestLo                                    
              ldy.w r_optionSFX_IDX
              sty.b r_pointerQueue                                                  
              %jsl ($80,updateQueueWithNumber) 
              
              LDA.B #$21                  ; default lifes             
              STA.B r_VRAM_QueueDestHi             
              LDA.B #$d6                           
              STA.B r_VRAM_QueueDestLo                                    
              ldy.w sr_defaultLife
              sty.b r_pointerQueue                                                  
              %jsl ($80,updateQueueWithNumber)                        
  
              LDA.B #$22                  ; starting stage            
              STA.B r_VRAM_QueueDestHi             
              LDA.B #$56                           
              STA.B r_VRAM_QueueDestLo                                    
              ldy.w sr_setStartingStage
              sty.b r_pointerQueue                                                  
              %jsl ($80,updateQueueWithNumber)  
              
              
              rts 
  
    
    
    }   
  
  
    { ; -- general ScreenRoutines 
  
        goTitleScreen:    
              LDA.B #$02                       
              STA.B r_gameSubstate             
              lda #$00
              sta.b r_gameState
  
              LDA.B #$28                       
              STA.B r_timerGenerel             
  
            ; LDA.B #$48         ; switching to title sound               
            ; JSR.W  lunchMusic  
              
              RTS                              
        go2NameScreen:
              JSR.W nameScr_fadeCounterReset   
              LDA.B #$0B                       
              STA.B r_gameSubstate             
              RTS  
              
              
  
  
        showPW_routine__02:
              LDA.B #$00                           ;01B675|A900    |      ;
              LDX.B #$00                           ;01B677|A200    |      ;
    
        CODE_01B679:
              STA.W r_soundModeSongSelected,X      ;01B679|9D8007  |010780;
              INX                                  ;01B67C|E8      |      ;
              CPX.B #$10                           ;01B67D|E010    |      ;
              BCC CODE_01B679                      ;01B67F|90F8    |01B679;
              RTS                                  ;01B681|60      |      ;
    
    
        CODE_01B682:
              LDY.B #$00                           ;01B682|A000    |      ;
              LDA.B #$00                           ;01B684|A900    |      ;
    
        CODE_01B686:
              STA.W $0790,Y                        ;01B686|999007  |010790;
              INY                                  ;01B689|C8      |      ;
              CPY.B #$10                           ;01B68A|C010    |      ;
              BCC CODE_01B686                      ;01B68C|90F8    |01B686;
              RTS                                  ;01B68E|60      |      ;
  
  
        showPW_clearAllSprite_01:
              LDX.B #$00                           ;01B625|A200    |      ;
          CODE_01B627:
              LDA.B #$00                           ;01B627|A900    |      ;
    
          CODE_01B629:
              STA.W r_entity_spriteID,X            ;01B629|9D0004  |010400;
              STA.W r_entity_YPos,X                ;01B62C|9D1C04  |01041C;
              STA.W r_entity_XPos,X                ;01B62F|9D3804  |010438;
              STA.W r_entity_PaletteOverride,X     ;01B632|9D5404  |010454;
              STA.W r_entity_mask,X                ;01B635|9D7004  |010470;
              STA.W r_entity_spriteGroup,X         ;01B638|9D8C04  |01048C;
              STA.W r_entity_FacingLeft,X          ;01B63B|9DA804  |0104A8;
              STA.W r_entity_ID,X                  ;01B63E|9D4E05  |01054E;
              INX                                  ;01B641|E8      |      ;
              CPX.B #$17                           ;01B642|E017    |      ;
              BCC CODE_01B629                      ;01B644|90E3    |01B629;
              RTS                                  ;01B646|60      |      ;   
          
          nameScr_fadeCounterReset:
              LDY.B #$00                           ;01B066|A000    |      ;
              STY.B $B4                            ;01B068|84B4    |0000B4;
              INY                                  ;01B06A|C8      |      ;
              STY.B $B5                            ;01B06B|84B5    |0000B5;
              RTS                                  ;01B06D|60      |      ;
  
  
      password_go2Level_0a:
              LDA.B $B4                            ;01B368|A5B4    |0000B4; passwordCorrect
              CMP.B #$FF                           ;01B36A|C9FF    |      ;
              BEQ CODE_01B378                      ;01B36C|F00A    |01B378;
              LDA.B r_sceneDrawQueue               ;01B36E|A51D    |00001D;
              STA.B r_15                           ;01B370|8515    |000015;
              JSR.W loadNameScreenCHR              ;01B372|2098B5  |01B598;
              JSR.W  CODE_0FFBAF                       ;01B376|        |0FFBAF;
    
        CODE_01B378:
              DEC.B r_timerGenerel                 ;01B378|C630    |000030;
              BNE +
              LDA.B #$0E                           ;01B37C|A90E    |      ;
              db $4C                               ;01B37E|        |      ;
              dw storeGameState_zeroSub            ;01B37F|        |0FE574;
    
      reloadNamePassword_0c:
              LDA.B r_sceneDrawQueue               ;01B381|A51D    |00001D;
              STA.B r_15                           ;01B383|8515    |000015;
              JSR.W loadNameScreenCHR              ;01B385|2098B5  |01B598;
              JSR.W  CODE_0FFBAF                       ;01B389|        |0FFBAF;
              LDA.B $B4                            ;01B38B|A5B4    |0000B4;
              CMP.B #$FF                           ;01B38D|C9FF    |      ;
              BNE CODE_01B3AA                      ;01B38F|D019    |01B3AA;
              LDA.B #$06                           ;01B391|A906    |      ;
              STA.B r_gameSubstate                 ;01B393|8519    |000019;
            + 
              RTS                                  ;01B395|60      |      ;
    
    
      reloadNameScreen_0b:
              LDA.B r_sceneDrawQueue               ;01B396|A51D    |00001D;
              STA.B r_15                           ;01B398|8515    |000015;
              JSR.W loadNameScreenCHR              ;01B39A|2098B5  |01B598;
              JSR.W  CODE_0FFBAF                       ;01B39E|        |0FFBAF;
              LDA.B $B4                            ;01B3A0|A5B4    |0000B4;
              CMP.B #$FF                           ;01B3A2|C9FF    |      ;
              BNE CODE_01B3AA                      ;01B3A4|D004    |01B3AA;
              LDA.B #$01                           ;01B3A6|A901    |      ;
              STA.B r_gameSubstate                 ;01B3A8|8519    |000019;
    
        CODE_01B3AA:
              RTS                                  ;01B3AA|60      |      ;
    
  
        CODE_01B4DF:
              ASL A                                ;01B4DF|0A      |      ;
              ASL A                                ;01B4E0|0A      |      ;
              CLC                                  ;01B4E1|18      |      ;
              ADC.B #$08                           ;01B4E2|6908    |      ;
              STA.B $00                            ;01B4E4|8500    |000000;
              LDA.B #$21                           ;01B4E6|A921    |      ;
              STA.B $01                            ;01B4E8|8501    |000001;
              RTS                                  ;01B4EA|60      |      ;
    
        CODE_01B4EB:
              ASL A                                ;01B4EB|0A      |      ;
              TAX                                  ;01B4EC|AA      |      ;
              LDA.W DATA8_01B500,X                 ;01B4ED|BD00B5  |01B500;
              STA.B $00                            ;01B4F0|8500    |000000;
              LDA.W DATA8_01B501,X                 ;01B4F2|BD01B5  |01B501;
              STA.B $01                            ;01B4F5|8501    |000001;
              LDA.B $00                            ;01B4F7|A500    |000000;
              CLC                                  ;01B4F9|18      |      ;
              ADC.W DATA8_01B508,Y                 ;01B4FA|7908B5  |01B508;
              STA.B $00                            ;01B4FD|8500    |000000; 
              RTS                                  ;01B4FF|60      |      ;
    
        DATA8_01B500:
              db $C0                               ;01B500|        |      ; 
        DATA8_01B501:
              db $21,$20,$22,$80,$22,$E0,$22       ;01B501|        |      ; 
        DATA8_01B508:
              db $0A,$0D,$10,$13                   ;01B508|        |      ;
    
  
    
    
        CODE_01B533:
              LDA.B r_Joy1_t                       ;01B533|A526    |000026;
              AND.B #$40                           ;01B535|2940    |      ;
              BEQ CODE_01B550                      ;01B537|F017    |01B550;
              LDA.B #$1A                           ;01B539|A91A    |      ;
              JSR.W  lunchMusic                        ;01B53C|        |0FE25F;
              LDA.B #$01                           ;01B53E|A901    |      ;
              STA.W $078D                          ;01B540|8D8D07  |01078D;
              LDY.W r_PW_iconGeneral               ;01B543|AC8607  |010786;
              STY.W $0787                          ;01B546|8C8707  |010787;
              INY                                  ;01B549|C8      |      ;
              TYA                                  ;01B54A|98      |      ;
              AND.B #$03                           ;01B54B|2903    |      ;
              STA.W r_PW_iconGeneral               ;01B54D|8D8607  |010786;
    
        CODE_01B550:
              LDA.B r_Joy1_t                       ;01B550|A526    |000026;
              AND.B #$80                           ;01B552|2980    |      ;
              BEQ CODE_01B583
              LDA.B #$1B                           ;01B556|A91B    |      ;
              JSR.W  lunchMusic                        ;01B559|        |0FE25F;
              LDA.W r_optionIDX              ;01B55B|AD8107  |010781;
              ASL A                                ;01B55E|0A      |      ;
              ASL A                                ;01B55F|0A      |      ;
              ADC.W r_soundModeSongSelected        ;01B560|6D8007  |010780;
              TAY                                  ;01B563|A8      |      ;
              LDA.W r_optionIDX              ;01B564|AD8107  |010781;
              ASL A                                ;01B567|0A      |      ;
              ASL A                                ;01B568|0A      |      ;
              ORA.W r_soundModeSongSelected        ;01B569|0D8007  |010780;
              PHA                                  ;01B56C|48      |      ;
              CLC                                  ;01B56D|18      |      ;
              ADC.B #$05                           ;01B56E|6905    |      ;
              TAX                                  ;01B570|AA      |      ;
              PLA                                  ;01B571|68      |      ;
              ASL A                                ;01B572|0A      |      ;
              ASL A                                ;01B573|0A      |      ;
              ORA.W r_PW_iconGeneral               ;01B574|0D8607  |010786;
              STA.B $00                            ;01B577|8500    |000000;
              AND.B #$03                           ;01B579|2903    |      ;
              BNE CODE_01B581                      ;01B57B|D004    |01B581;
              LDA.B #$00                           ;01B57D|A900    |      ;
              BEQ CODE_01B583                      ;01B57F|F002    |01B583;
    
        CODE_01B581:
              LDA.B $00                            ;01B581|A500    |000000;
    
        CODE_01B583:
              rts 
              
  
    
    
        loadNameScreenCHR:
              LDA.B #$1E                           ;01B598|A91E    |      ;
              JSR.W  screenLoad_A_CHR                  ;01B59B|        |0FECE9;
              LDA.B #$04                           ;01B59D|A904    |      ;
              jmp screenLoad_A_CHR                  ;01B5A0|        |0FECE9;
    
  
    
    
        CODE_01B7D6:
              LDA.B #$01                           ;01B7D6|A901    |      ;
    
        CODE_01B7D8:
              ORA.W $078B                          ;01B7D8|0D8B07  |01078B;
              STA.W $078B                          ;01B7DB|8D8B07  |01078B;
              RTS                                  ;01B7DE|60      |      ;
    
    
        DATA8_01B7DF:
              db $00,$12,$31                       ;01B7DF|        |      ;
    
        CODE_01B7E2:
              PHA                                  ;01B7E2|48      |      ;
              AND.B #$30                           ;01B7E3|2930    |      ;
              LSR A                                ;01B7E5|4A      |      ;
              LSR A                                ;01B7E6|4A      |      ;
              STA.B $07                            ;01B7E7|8507    |000007;
              PLA                                  ;01B7E9|68      |      ;
              AND.B #$03                           ;01B7EA|2903    |      ;
              ORA.B $07                            ;01B7EC|0507    |000007;
              TAY                                  ;01B7EE|A8      |      ;
              RTS                                  ;01B7EF|60      |      ;
    
  
  
    }
    
  
  
  
  
  
  }
  
  
  
    
  
  else 
  org $079A6
  base $B9A6
  endif
  
  
  { ; -- moved routine within bank ---------
  
        freezEnemy: LDA.W r_Player_StateDoubled,X        ;01BC8D|BD6505  |010565;
              LSR A                                ;01BC90|4A      |      ;
              LSR A                                ;01BC91|4A      |      ;
              LSR A                                ;01BC92|4A      |      ;
              LSR A                                ;01BC93|4A      |      ;
              LSR A                                ;01BC94|4A      |      ;
              LSR A                                ;01BC95|4A      |      ;
              jsr jumpFromStackYXpreserved          ;01BC97|        |0FE86D;
              dw freezEnemy_freez_00               ;01BC99|        |01BC9F;
              dw freezEnemy_platform_01            ;01BC9B|        |01BCA7;
              dw freezEnemy_unfreez_02             ;01BC9D|        |01BCBC;
    
    freezEnemy_freez_00: 
              LDA.B #$80                           ;01BC9F|A980    |      ;
              STA.W r_entity_extra,X               ;01BCA1|9DD805  |0105D8;
     
;     if !grantDaggerSpiderSilkFreez == 1         
;              %phxya() 
;              
;              tay 
;              jsr findEmptyEntitySlot
;              jsr clearAll_entitySlot     
;              
;              LDA.B #$ae
;              STA.W r_entity_ID,X 
;              lda #$73
;              sta.w r_entity_AI,x 
;
; ;             LDA.B #$57                       ; spider string     
; ;             STA.W r_entity_AI,X                
; ;             LDA.B #$00                         
; ;             STA.W r_entity_AI_IDX,X            
; ;             LDA.B #$68                         
; ;             STA.W r_entity_ID,X                
;             
;              lda.w r_entity_XPos,y 
;              sta.w r_entity_XPos,x
;              lda.w r_entity_YPos,y 
;              sta.w r_entity_YPos,x 
; 
;              %plxya() 
;     endif    
            
            jmp changePalette_frozen              ;01BCA5|        |0FFF8A;
    
    freezEnemy_platform_01: 
              DEC.W r_entity_extra,X               ;01BCA7|DED805  |0105D8;
              BNE CODE_01BCBB                      ;01BCAA|D00F    |01BCBB;
              LDA.B #$08                           ;01BCAC|A908    |      ;
              STA.W r_entity_extra,X               ;01BCAE|9DD805  |0105D8;
              LDA.W r_Player_StateDoubled,X        ;01BCB1|BD6505  |010565;
              AND.B #$BF                           ;01BCB4|29BF    |      ;
              ORA.B #$80                           ;01BCB6|0980    |      ;
              STA.W r_Player_StateDoubled,X        ;01BCB8|9D6505  |010565; 
        CODE_01BCBB: RTS                                  ;01BCBB|60      |      ;
    
    
    freezEnemy_unfreez_02: 
              LDA.B r_frameCount                   ;01BCBC|A51A    |00001A;
              AND.B #$03                           ;01BCBE|2903    |      ;
              BNE CODE_01BCBB                      ;01BCC0|D0F9    |01BCBB;
              LDA.W r_entity_ID,X                  ;01BCC2|BD4E05  |01054E;
              CMP.B #$57                           ;01BCC5|C957    |      ;
              BEQ CODE_01BCF0                      ;01BCC7|F027    |01BCF0;
              CMP.B #$5B                           ;01BCC9|C95B    |      ;
              BEQ CODE_01BCF0                      ;01BCCB|F023    |01BCF0;
              LDA.W r_entity_PaletteOverride,X     ;01BCCD|BD5404  |010454;
              EOR.B #$04                           ;01BCD0|4904    |      ;
              STA.W r_entity_PaletteOverride,X     ;01BCD2|9D5404  |010454;
              LDA.W r_entity_extra,X               ;01BCD5|BDD805  |0105D8;
              BEQ CODE_01BCDF                      ;01BCD8|F005    |01BCDF;
              DEC.W r_entity_extra,X               ;01BCDA|DED805  |0105D8;
              BNE CODE_01BCBB                      ;01BCDD|D0DC    |01BCBB;
    
        CODE_01BCDF: LDA.W r_entity_PaletteOverride,X     ;01BCDF|BD5404  |010454;
              AND.B #$FB                           ;01BCE2|29FB    |      ;
              STA.W r_entity_PaletteOverride,X     ;01BCE4|9D5404  |010454;
    
        CODE_01BCE7: LDA.W r_entity_mask,X                ;01BCE7|BD7004  |010470;
              AND.B #$FD                           ;01BCEA|29FD    |      ;
              STA.W r_entity_mask,X                ;01BCEC|9D7004  |010470;
    
        CODE_01BCEF: RTS                                  ;01BCEF|60      |      ;
    
    
        CODE_01BCF0: LDA.W r_entity_PaletteOverride,X     ;01BCF0|BD5404  |010454;
              AND.B #$04                           ;01BCF3|2904    |      ;
              BNE CODE_01BD0E                      ;01BCF5|D017    |01BD0E;
              LDA.B #$04                           ;01BCF7|A904    |      ;
    
        CODE_01BCF9: STA.W r_entity_PaletteOverride,X     ;01BCF9|9D5404  |010454;
              LDA.W r_entity_extra,X               ;01BCFC|BDD805  |0105D8;
              BEQ CODE_01BD06                      ;01BCFF|F005    |01BD06;
              DEC.W r_entity_extra,X               ;01BD01|DED805  |0105D8;
              BNE CODE_01BCEF                      ;01BD04|D0E9    |01BCEF;
    
        CODE_01BD06: LDA.B #$03                           ;01BD06|A903    |      ;
              STA.W r_entity_PaletteOverride,X     ;01BD08|9D5404  |010454;
              JMP.W CODE_01BCE7                    ;01BD0B|4CE7BC  |01BCE7;
    
    
        CODE_01BD0E: LDA.B #$03                           ;01BD0E|A903    |      ;
              BNE CODE_01BCF9                      ;01BD10|D0E7    |01BCF9;
    
      collectableData: 
              LDY.W r_misc_movementState,X         ;01BD12|BC4506  |010645;
              LDA.W CHRoffsetItem,Y                ;01BD15|B927BD  |01BD27;
              STA.B r_roomSectionChrBanksDataOffset;01BD18|850F    |00000F;
              LDA.W collectable_dataIdx,Y          ;01BD1A|B947BD  |01BD47;
              TAY                                  ;01BD1D|A8      |      ;
              LDA.W r_0f0,Y                        ;01BD1E|B9F000  |0100F0;
              ORA.B r_roomSectionChrBanksDataOffset;01BD21|050F    |00000F;
              STA.W r_0f0,Y                        ;01BD23|99F000  |0100F0;
              RTS                                  ;01BD26|60      |      ;
    
        CHRoffsetItem: 
              db $01,$02,$04,$08,$10,$20,$40,$80   ;01BD27|        |      ; ??
              db $01,$02,$04,$08,$10,$20,$40,$80   ;01BD2F|        |      ;
              db $01,$02,$04,$08,$10,$20,$40,$80   ;01BD37|        |      ;
              db $01,$02,$04,$08,$10,$20,$40,$80   ;01BD3F|        |      ;
    
    collectable_dataIdx: 
              db $00,$00,$00,$00,$00,$00,$00,$00   ;01BD47|        |      ;
              db $01,$01,$01,$01,$01,$01,$01,$01   ;01BD4F|        |      ;
              db $02,$02,$02,$02,$02,$02,$02,$02   ;01BD57|        |      ;
              db $03,$03,$03,$03,$03,$03,$03,$03   ;01BD5F|        |      ;
  
  
  }
  
  
  if !expandCHRanim == 1
  
    chrAnimRoutine: 
      LDA.B r_roomEffect
      and #$08 
      bne mask48_4F 
  
      DEC.W r_animTimerBG_CHR              ;019F8D|CE8107  |010781;
      bmi failSaveDoorTransitAnim
      BNE mask48_4F                      
    failSaveDoorTransitAnim: 
      LDA.B r_roomEffect                 
      AND.B #$07                        
      ASL A                              
      TAY                                
      LDA.W gearCHRanimPointer,Y       
      STA.B r_IRQFuncAddr                
      LDA.W gearCHRanimPointer+1,Y       
      STA.B $45                          
      LDY.B #$00                         
      LDA.B (r_IRQFuncAddr),Y            
      STA.W r_animTimerBG_CHR            
      LDY.W r_soundModeSongSelected      
      INY                                
    CODE_019FAD: 
      LDA.B (r_IRQFuncAddr),Y            
      CMP.B #$FF                         
      BEQ resetCHRanim                   
      STA.B r_CHR_BankBG_0400            
      STY.W r_soundModeSongSelected      
  
    mask48_4F: 
      RTS                                
    resetCHRanim: 
      LDY.B #$01                         
      BNE CODE_019FAD                    
  
    gearCHRanimPointer: 
      dw CHRanim0,CHRanim1,CHRanim2,CHRanim3    ; This animations can be enabled data_tables.asm effect
      dw CHRanim4,CHRanim5,CHRanim6,CHRanim7    ; Value $3x are with sound and $4x is without.
    
    CHRanim0:
      db $0A,$54,$55,$56,$FF    ; first byte is the speed (how many frames to wait till going to the next bank. FF resets program)
    CHRanim1:
      db $06,$54,$55,$56,$FF
    CHRanim2: 
      db $0A,$80,$81,$82,$83,$FF
    CHRanim3:
      db $0A,$84,$85,$86,$87,$FF
    CHRanim4:
      db $0A,$88,$89,$8a,$8b,$FF
    CHRanim5:
      db $0A,$8c,$8d,$8e,$8f,$FF
    CHRanim6:    
      db $0A,$90,$91,$92,$93,$FF
    CHRanim7:
      db $ff 
  
    
    
    
  { ; -- r_IRQFuncAddr 6D 
    
    IRQ_scrollStuff = $A097
    verticleMirror_extandedNT = $9FCB   
    
    IRQ__2e:
      JSR.W IRQ_scrollStuff                
            JSR.W verticleMirror_extandedNT      
            STA.W $5105                          
            STA.W $5105                                                        
            jsr updateBG_CHR_IRQ                  
            LDA.B $89                            
            STA.W $5203                          
      
      LDA #$2e ; $2E,$1E,$16,$1E 
            STA.W r_soundModeSongSelected        
            
      JSR.W CODE_01A0DD                    
            LDA.B #$04                           
            CLC                                  
            ADC.B $89                            
            STA.B r_IRQScanlineCmpVal            
            INC.B r_IRQFuncDrawIdx               
            jmp backupCurrBank_endIRQ           
                
    
    
    IRQ__2f:
      LDX.B #$01                      
            jsr wait_X_cycles               
            JSR.W CODE_01A121               
            INC.B r_IRQFuncDrawIdx          
    
    CODE_01A144:
      LDA.B #$00                           ;01A144|A900    |      ;
      STA.W $5105                          
      LDA.B r_IRQScanlineCmpVal            
      STA.W $5203                          
      DEC.W r_soundModeSongSelected        
      DEC.W r_soundModeSongSelected        
      BEQ CODE_01A163                      
      LDA.B #$04                           
      CLC                                  
      ADC.B r_IRQScanlineCmpVal            
      STA.B r_IRQScanlineCmpVal            
      JSR.W CODE_01A0DD                    
            jmp backupCurrBank_endIRQ               
  
    CODE_01A121: 
      LDA.W $2002                         
            LDA.B $D5                           
            STA.W $2005                         
            LDA.B #$00                          
            STA.W $2005                         
            RTS                                 
        
        CODE_01A163: 
      LDA.B #$2D                           
            STA.B r_IRQFuncDrawIdx               
            jmp backupCurrBank_endIRQ            
        
    CODE_01A0DD: 
      LDY.W r_soundModeSongSelected       
      LDA.B r_scrollStartOffsetLo         
      CLC                                 
      ADC.W $0783,Y                       
      STA.B $D5                           
      LDA.B r_scrollStartOffsetHi         
      ADC.B #$00                          
      STA.B $D6                           
      RTS     
    
    
    
    IRQ__30:
      LDX.B #$01                          
            jsr wait_X_cycles                     ;01A132|        |0FE001;
            JSR.W CODE_01A121                    ;01A134|2021A1  |01A121;
            INC.B r_IRQFuncDrawIdx               ;01A137|E66D    |00006D;
            JMP.W CODE_01A144                    ;01A139|4C44A1  |01A144;
 
    
    
    
    IRQ__31:
    IRQ__32:
    IRQ__33:      
    IRQ__34:  
    IRQ__35:  
      rts   
  }


endif 



assert pc() <= $C000
pad $8000
}

{ ; bank_02 freeSpace --------------------
org $0BEC2        
base $BEC2      
incsrc "code/data_misc.asm" 



  
assert pc() <= $C000
pad $C000 
} 


; org $FFF8       ; bank_03 freeSpace --------------------
; base $9FF8      ; !! use "boss.asm" 
; assert pc() <= $C000


{ ; bank_04 freeSpace --------------------
org $13AD4            
base $BAD4      



assert pc() <= $C000  
}


;org $17F19       ; bank_05 freeSpace --------------------
;base $BF19       ; !! use "boss.asm" 
;assert pc() <= $C000


{ ; bank_06 freeSpace --------------------
org $1BFF2        
base $BFF2  



assert pc() <= $C000
}


{ ; bank_07 freeSpace --------------------
org $1FFCB        
base $BFCB  



assert pc() <= $C000
}



; org $23F93      ; bank_08 freeSpace --------------------      
; base $BF93      ; !! use "boss.asm" 
; assert pc() <= $C000  
; org $27FEC      ; bank_09 freeSpace --------------------
; base $BFEC      ; !! use "boss.asm" 
; assert pc() <= $C000  


{ ; bank_0a freeSpace --------------------
org $2BA9A        
base $BA9A        ; base $BFF4    ; vanilla free space




assert pc() <= $C000
pad $2C000
}


; org $2FF90      ; bank_0b freeSpace --------------------
; base $BF90      ; !! use "enemy.asm"
; assert pc() <= $C000 
; org $33675      ; !! use "enemy.asm"
; base $B675      ; bank_0c freeSpace --------------------
; assert pc() <= $C000 
; org $37E63      ; !! use "data_sprite.asm"
; base $BE63      ; bank_0d freeSpace --------------------    
; assert pc() <= $C000 


; bank_0e !!player.asm -------------------


org $3DC19
base $DC19
  incsrc code/text.asm
          ; bank_0f $C000-$DFFF freeSpace
          ; this bank is spwaped out doring boss fights

if !sRAM == 1

  initalizeSRAM:
    lda #$a4
    jsr swapPRGbankStore
    
    ldy #$04    ; check to only copy once
  - lda.w SRAM_ClearMark,y 
    cmp.w textClear,y 
    bne CopyToSRAM
    dey 
    bpl - 
    jmp endInitRAM  
  
;   LDX #$03    ;   banks 
  
  CopyToSRAM:     ; sta $5113 Switch SRAM Page
    LDY #$00        ;   Copy code block to SRAM. Run on startup          
  CopyToSRAMLoop:
    LDA.w CodeBlock_0,y              
    STA SRAM_Code,y              
    LDA.w CodeBlock_0+$100,y              
    STA SRAM_Code+$100,y        
    LDA.w CodeBlock_0+$200,y              
    STA SRAM_Code+$200,y      
    LDA.w CodeBlock_0+$300,y              
    STA SRAM_Code+$300,y  
    LDA.w CodeBlock_0+$400,y              
    STA SRAM_Code+$400,y  
    LDA.w CodeBlock_0+$500,y              
    STA SRAM_Code+$500,y  
    LDA.w CodeBlock_0+$600,y              
    STA SRAM_Code+$600,y  
    LDA.w CodeBlock_0+$700,y              
    STA SRAM_Code+$700,y  
    LDA.w CodeBlock_0+$800,y              
    STA SRAM_Code+$800,y  
    LDA.w CodeBlock_0+$900,y              
    STA SRAM_Code+$900,y
    LDA.w CodeBlock_0+$a00,y              
    STA SRAM_Code+$a00,y  
    LDA.w CodeBlock_0+$b00,y              
    STA SRAM_Code+$b00,y  
    LDA.w CodeBlock_0+$c00,y              
    STA SRAM_Code+$c00,y  
    LDA.w CodeBlock_0+$d00,y              
    STA SRAM_Code+$d00,y  
    LDA.w CodeBlock_0+$e00,y              
    STA SRAM_Code+$e00,y
    LDA.w CodeBlock_0+$f00,y              
    STA SRAM_Code+$f00,y      
    iny 
    bne CopyToSRAMLoop
    
  clearSRAM_6000:   
    ldy #$00        ; clear 6000-6fff 
    lda #$00
  - sta $6000,y   ; initalize sRAM 
    sta $6100,y
    sta $6200,y
    sta $6300,y
    sta $6400,y
    sta $6500,y
    sta $6600,y
    sta $6700,y
    sta $6800,y
    sta $6900,y
    sta $6a00,y
    sta $6b00,y
    sta $6c00,y
    sta $6d00,y
    sta $6e00,y
    sta $6f00,y
    iny                       
    bne -      
    
    ldy #$04
  - lda.w textClear,y 
    sta SRAM_ClearMark,y 
    dey 
    bpl -

if !optionScreen == 1   

    lda.w sr_defaultLife  ; set defaults
    bne +
    lda #$02              
    sta.w sr_defaultLife
  + 
  
  endInitRAM:       
    ldy #$06        ; default name 
  - lda.w textTrevor,y 
    sta.w r_playerName,y 
    dey 
    bpl -
  

    JSR initSound   ; hijack fix 
    rts

  textTrevor:
    db $63,$61,$54,$65,$5E,$61,$00  ; db "trevor"
else 

  endInitRAM: 
    JSR initSound   ; hijack fix 
    rts
  
endif 

  textClear:
    db "clear"


  pushPC
  incsrc "code/sram_code.asm" 
  pullPC  

endif 

if !cv3HorizontalAutoscroll == 1
  incsrc "code/custom/horizontal_autoscroll.asm"
endif

assert pc() <= $E000
pad $3E000
org LAST_BANK+$1FCA
base $FFCA



assert pc() <= $FFFA
pad LAST_BANK+$1FFA
 
 
 
 
 
 
 
 
 
