norom   
check bankcross off 
 
    incsrc "code/labels.asm"                

{ ; notes 
    
    ; 00000 00: palette text expansions => patches.asm (!expandCHRanim)
    ; 04000 01: IRQ, Animation CHR => patches.asm
    ; 08000 02: data_misc.asm
    ; 0c000 03:
    ; 10000 04:
    ; 14000 05: 
    ; 18000 06: 
    ; 1c000 07: 
    ; 20000 08: boss.asm 
    ; 24000 09: boss.asm 
    ; 28000 0a: text.asm 
    ; 2c000 0b: enemy.asm  
    ; 30000 0c: music.asm | boss.asm 
    ; 34000 0d: data_sprite.asm 
    ; 38000 0e: player.asm 
    ; LAST_BANK => label.asm    ; data_screens_compressed.asm has FreeSpace -> newLoad_X_preserveAll, MMC5Init

    ; expand PRG 40000-43fff    ; a0 main hijacks (pause, all_bank_free_space "code/patches.asm")
    ; expand PRG 44000-47fff    ; a2 cv3-asm stair controls
    ; expand PRG 48000-4dfff    ; a4 sram code
    ; expand PRG 4c000-4ffff    ; a6 data screens
    ; expand PRG 50000-53fff    ; a8 data moved

}

{ ; rom expansion insert empty banks    
org $3e000
    pad $3e000+($4000*(HEADER_PRG-$10))
    incbin "rom/Castlevania_3.nes":$3e010..$60010 

org ROM_CHRstart+ROM_CHRsize
    pad ROM_CHRstart+ROM_CHRsize+($2000*(HEADER_CHR-$10))
}

{ ; patch options 
    
    !fast_options = 1               ; -- general --------------------
    !removeTimer = 1
    !deathCouter = 1
    !subweaponDrop = 1
    !expandCHRanim = 1
    !optionScreen = 1
    !alienPatchRemove = 1   


    !jumpControllDirection = 1      ; -- player ---------------------
    !jumpControllHight = 0
    !jumpControllMovment = 1
    
    !grantSaveClimbSpeed = 1
    !grantNinjaStar = 1
    !grantDaggerSpiderSilkFreez = 1
    
    !alucardStairAttack = 1         ; -- tweaks ---------------------
    !duckableProjectiles = 1
    !noRandomDrop = 1



    
    !CHR_paralex = 1                ; -- game elements --------------    
    !putAllSpritesBehindFog = 0

    !debuggMenu = 0                 ; -- debug ---------------------
    !levelSelect = 1    
    !sprite_viewer = 0   

    !cv3BetterStairs = 1            ; -- cv3-asm --------------------
    !cv3HorizontalAutoscroll = 1
    !cv3HorizontalScrollSpeed = $0030 ; $0001-$0100 (8.8 pixels/frame)

}

{ ; text symbols game 

    ' ' = $40
    '0' = $41
    '1' = $42
    '2' = $43
    '3' = $44
    '4' = $45
    '5' = $46
    '6' = $47
    '7' = $48
    '8' = $49
    '9' = $4A
    'A' = $50
    'B' = $51
    'C' = $52
    'D' = $53
    'E' = $54
    'F' = $55
    'G' = $56
    'H' = $57
    'I' = $58
    'J' = $59
    'K' = $5A
    'L' = $5B
    'M' = $5C
    'N' = $5D
    'O' = $5E
    'P' = $5F
    'Q' = $60
    'R' = $61
    'S' = $62
    'T' = $63
    'U' = $64
    'V' = $65
    'W' = $66
    'X' = $67
    'Y' = $68
    'Z' = $69
    '.' = $4B
    '=' = $4C
    '-' = $4D
    '"' = $4E
    '!' = $6A
    '?' = $6B
    ',' = $78
    ''' = $4F   ; '
}

org $40000          ; free space 
base $8000
    correntBankIDX: 
        db $A0      
pushPC  
    
    incsrc "code/patches.asm"
    incsrc "code/data_tables_transit.asm"
    
pullPC 
if !cv3BetterStairs == 1
    assert pc() <= $C000            ; bank $A0 limit
else
    assert pc() <= $4c000
endif
org $50000          ; free space 
base $8000
        db $A8      ; bankIDX mark 
pushPC 

    incsrc "code/player.asm"        
    incsrc "code/enemy.asm"         
    incsrc "code/boss.asm"          
    
    incsrc "code/data_screens_compressed.asm"
    incsrc "code/data_sprite.asm"
    
    
    
pullPC 
assert pc() <= $54000

if !cv3BetterStairs == 1
    incsrc "code/custom/better_stair.asm"
endif


{ ; CHR patching

  { ; CHR defines
      CHR_SP_trevor_00 = $00
      CHR_SP_trevorSub_01 = $01
      CHR_SP_grant_02 = $02
      CHR_SP_grantSub_03 = $03
      CHR_SP_sypha_04 = $04
      CHR_SP_symphaSub_05 = $05
      CHR_SP_alucard_06 = $06
      CHR_SP_alucardSub_07 = $07
      CHR_SP_zomb_bird_08 = $08
      CHR_SP_bat_axeknight_09 = $09
      CHR_SP_flee_spiter_0a = $0a
      CHR_SP_sword_deamon_0b = $0b
      CHR_SP_spider_owl_0c = $0c
      CHR_SP_knight_jelly_0d = $0d
      CHR_SP_eye_mummy_0e = $0e
      CHR_SP_medusa_doran_0f = $0f
      CHR_SP_frog_mudman_10 = $10
      CHR_SP_bat_drag_11 = $11
      CHR_SP_misc_12 = $12
      CHR_SP_skelly_13 = $13
      CHR_SP_gear_dusa_14 = $14
      CHR_SP_drip_fire_15 = $15
      CHR_SP_prayer_16 = $16
      CHR_SP_synpha_bird_17 = $17
      CHR_SP_Boss_boneKing_18 = $18
      CHR_SP_Boss_boneKing_19 = $19
      CHR_SP_Boss_grant_1a = $1a
      CHR_SP_Boss_grant_1b = $1b
      CHR_SP_Boss_hammerGuy_1c = $1c
      CHR_SP_Boss_mamaBat_1d = $1d
      CHR_SP_Boss_alucard_1e = $1e
      CHR_SP_Boss_alucard_1f = $1f
      CHR_SP_Boss_boneSnake_20 = $20
      CHR_SP_Boss_boneSnake_21 = $21
      CHR_SP_Boss_monster_22 = $22
      CHR_SP_Boss_monster_23 = $23
      CHR_SP_Boss_medusa_24 = $24
      CHR_SP_Boss_medusa_25 = $25
      CHR_SP_Boss_devil_26 = $26
      CHR_SP_Boss_devil_27 = $27
      CHR_SP_Boss_mamaBat_28 = $28
      CHR_SP_Boss_mummy_29 = $29
      CHR_SP_Boss_encounter_2a = $2a
      CHR_SP_Boss_encounter_2b = $2b
      CHR_SP_Boss_death_2c = $2c
      CHR_SP_Boss_death_2d = $2d
      CHR_SP_Boss_deathBGskull_2e = $2e
      CHR_SP_Boss_hurpy_clone_2f = $2f
      CHR_SP_Boss_dracula_30 = $30
      CHR_SP_Boss_dracula_31 = $31
      CHR_SP_Boss_dracula_BG_32 = $32
      CHR_SP_Boss_dracula_BG_33 = $33
      CHR_SP_Boss_dracula2nd_34 = $34
      CHR_SP_Boss_dracula2nd_35 = $35
      CHR_SP_2ndQuest_36 = $36
      CHR_letters_37 = $37
      CHR_spriteEnding_38 = $38
      CHR_spriteEnding_39 = $39
      CHR_spriteEnding_3a = $3a
      CHR_spriteEnding_3b = $3b
      CHR_BG_intro_3c = $3c
      CHR_BG_intro_3d = $3d
      CHR_BG_intro_3e = $3e
      CHR_BG_intro_3f = $3f
      CHR_BG_door_40 = $40
      CHR_BG_textHUD_41 = $41
      CHR_BG_iconHUD_42 = $42
      CHR_SP_Candle_43 = $43
      CHR_BG_0_44 = $44
      CHR_BG_0_45 = $45
      CHR_BG_0_window_46 = $46
      CHR_BG_0_47 = $47
      CHR_BG_0_48 = $48
      CHR_BG_1_gear_49 = $49
      CHR_BG_1_gear_4a = $4a
      CHR_BG_3_mod_4b = $4b
      CHR_BG_2_wood_4c = $4c
      CHR_BG_2_wood_4d = $4d
      CHR_BG_3_ship_4e = $4e
      CHR_BG_3_ship_4f = $4f
      CHR_BG_3_ship_50 = $50
      CHR_BG_cofine_51 = $51
      CHR_BG_castle_52 = $52
      CHR_BG_monster_53 = $53
      CHR_BG_anim_54 = $54
      CHR_BG_anim_55 = $55
      CHR_BG_anim_56 = $56
      CHR_BG_castle_57 = $57
      CHR_BG_mod_58 = $58
      CHR_BG_mod_59 = $59
      CHR_BG_mod_5a = $5a
      CHR_BG_mod_5b = $5b
      CHR_BG_alucard_5c = $5c
      CHR_BG_alucard_5d = $5d
      CHR_BG_city_5e = $5e
      CHR_BG_city_5f = $5f
      CHR_BG_city_60 = $60
      CHR_BG_gravy_61 = $61
      CHR_BG_gravy_62 = $62
      CHR_BG_gravy_63 = $63
      CHR_BG_yard_64 = $64
      CHR_BG_yard_65 = $65
      CHR_BG_web_66 = $66
      CHR_BG_web_67 = $67
      CHR_BG_mountain_68 = $68
      CHR_BG_mountain_69 = $69
      CHR_BG_moon_6a = $6a
      CHR_BG_moon_6b = $6b
      CHR_BG_armor_6c = $6c     
      CHR_BG_armor_6d = $6d
      CHR_BG_konami_6e = $6e
      CHR_BG_allLetter_6f = $6f
      CHR_BG_title_70 = $70
      CHR_BG_title_71 = $71
      CHR_BG_title_72 = $72
      CHR_BG_name_PW_73 = $73
      CHR_BG_map_74 = $74
      CHR_BG_map_75 = $75
      CHR_BG_map_76 = $76
      CHR_BG_map_77 = $77
      CHR_BG_map2_78 = $78
      CHR_BG_map2_79 = $79
      CHR_BG_map2_7a = $7a
      CHR_SP_mapMark_7b = $7b
      CHR_BG_path_7c = $7c
      CHR_BG_path_7d = $7d
      CHR_SP_map_ship_7e = $7e
      CHR_BG_empty_7f = $7f
  }


  if !grantDaggerSpiderSilkFreez == 1 
  
  org (CHR_SP_grant_02*$400)+ROM_CHRstart
      incbin "gfx/CHR/spiderGrant.chr"
  
  org $22DB     ; palette 
     ; db $0F,$0C,$13,$30
      db $0f,$01,$16,$20
  
  org (CHR_SP_Boss_encounter_2a*$400)+ROM_CHRstart
      incbin "gfx/CHR/spiderGrantEncounter.chr"
  
  endif 


}







