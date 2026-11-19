; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/trevor_rope_sprites.asm for Funvania Asar.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

cv3_trevor_rope_pose_table:
            dw sprite_00
            dw trevorSpr_idle_02
            dw trevorSpr_walk_04
            dw trevorSpr_walk_06
            dw trevorSpr_walk_04
            dw trevorSpr_stairDown_0A
            dw trevorSpr_stairUp_0C
            dw trevorSpr_duck_0E
            dw trevorSpr_hurt_10
            dw trevorSpr_hurt_12
            dw trevorSpr_dead_14
            dw trevorSpr_jump_16
            dw trevorSpr_whipWindup_18
            dw trevorSpr_whipWindup_1A
            dw trevorSpr_whipWindup_1C
            dw trevorSpr_whipWindupDuck_1E
            dw trevorSpr_whipWindupDuck_20
            dw trevorSpr_whipWindupDuck_22
            dw trevorSpr_whipWindup_24
            dw trevorSpr_whipWindup_26
            dw trevorSpr_whip_28
            dw trevorSpr_whipWindup_2A
            dw trevorSpr_whipChainWindup_2C
            dw trevorSpr_whipChainWindup_2E
            dw trevorSpr_whipChainShort_30
            dw trevorSpr_whipChainShort_32
            dw trevorSpriteAssemb_34
            dw trevorSpr_whipWindupStairDown_36
            dw trevorSpr_whipWindupStairDown_38
            dw trevorSpr_whipWindupStairUp_3A
            dw trevorSpr_whipWindupStairUp_3C
            dw trevorSpr_whipWindupStairUp_3E
            dw trevorSpr_cross_40
            dw trevorSpr_cross_42
            dw trevorSpr_cross_44
            dw trevorSpr_axe_46
            dw trevorSpr_axe_r_48
            dw trevorSpr_axe_dr_4A
            dw trevorSpr_axe_d_4C
            dw trevorSpr_knife_4E
            dw trevorSpr_holyWater_HUD_50
            dw trevorSpriteAssemb_holyWater_52
            dw trevorSpr_whipUpgrade_54
            dw trevorSpr_flame_56
            dw trevorSpr_flame_58
            dw trevorSpr_flame_5A
            dw trevorSpr_flame_58
            dw trevorSpriteAssemb_5E
            dw trevorSpr_flameFull_60
            dw trevorSpriteAssemb_62
            dw trevorSpriteAssemb_64
            dw sprite_00
            dw trevor_boss_appear_68
            dw trevor_boss_appear_6A
            dw trevor_boss_appear_6C
            dw trevor_boss_appear_6E
            dw cv3_trevor_rope_frame_1,cv3_trevor_rope_frame_2

cv3_trevor_rope_frame_1:
            db $04,$E0,$4A,$00,$F8,$E1,$70,$00
            db $01,$72,$F8,$01,$60,$00
cv3_trevor_rope_frame_2:
            db $04,$E0,$64,$00,$F8,$E1,$6A,$00
            db $01,$6C,$F8,$01,$6E,$00
