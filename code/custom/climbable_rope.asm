; SPDX-License-Identifier: MIT
; Copyright (c) 2026 Hoshiruna
; Adapted from cv3-asm/asm/US/climbable_rope.asm for Funvania Asar.
; Target CPU is the NES Ricoh 2A03. See LICENSE in this directory.

; Hold Up or Down near a rope to grab it from the ground or while descending.
; Up/Down climbs one pixel per frame. A jumps off using native character
; physics. Down+A lets go immediately, with re-grab enabled when Down is
; released. The upper end stops ascent. Down at the lower end lets go.
; Rope graphics belong in the room's background tiles. The coordinate table
; below supplies the climbable segments independently of those graphics.

cv3_rope_STATE_ROPE             = $4A ; Beyond Grant's native state table, intercepted here.
cv3_rope_STATE_DUCK             = $0A
cv3_rope_ROPE_ATTACH_TOLERANCE   = $06
cv3_rope_ROPE_RECORD_SIZE        = 9
cv3_rope_ROPE_DROP_LOCK          = $80 ; High phase bit during a manual airborne release.

cv3_rope_stage             = $32
cv3_rope_block             = $33
cv3_rope_room              = $34
cv3_rope_sprite            = $0400
cv3_rope_animation_timer   = $057C
cv3_rope_sprite_offset     = $0593
cv3_rope_jump_timer        = $05D8
cv3_rope_grant_jump_flag   = $9D
cv3_rope_landing_timer     = $B9
cv3_rope_tile_collision = playerCollusionCheck ; A = signed X probe, X = signed Y probe.

; Scratch is shared with the stair search and dies before native dispatch.
; The fixed-bank collision reader uses $10-$14 and preserves these bytes.
cv3_rope_delta_x           = $08
cv3_rope_original_x        = $0A
cv3_rope_probe_y           = $0B
cv3_rope_record_index      = $0C

; C=1 consumes this frame's stair input, including jump/release frames.
; The custom state itself owns attachment. Native damage, death and
; character changes replace that state and immediately end rope control.
cv3_rope_controls_update:
    LDA.B cv3_stair_game_state
    CMP.B #$04
    BNE cv3_rope_controls_unavailable
    LDA.B cv3_stair_cinematic_controller
    BNE cv3_rope_controls_unavailable
    LDA.B cv3_stair_gameplay_substate
    CMP.B #$03
    BEQ cv3_rope_controls_gameplay
    CMP.B #$05
    BEQ cv3_rope_controls_gameplay
    CMP.B #$0A
    BEQ cv3_rope_controls_gameplay
cv3_rope_controls_unavailable:
    LDA.W cv3_stair_player_state
    CMP.B #cv3_rope_STATE_ROPE
    BNE cv3_rope_controls_unused
    JMP.W cv3_rope_release
cv3_rope_controls_unused:
    CLC
    RTS

cv3_rope_controls_gameplay:
    LDA.W cv3_stair_player_state
    CMP.B #cv3_rope_STATE_ROPE
    BNE cv3_rope_controls_try_grab
    JMP.W cv3_rope_controls_attached

cv3_rope_controls_try_grab:
    ; Native jump/fall handlers use phase zero for ascent and nonzero for
    ; descent. Its high bit holds the manual-release latch while airborne.
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_JUMP
    BEQ cv3_rope_controls_check_drop
    CMP.B #cv3_stair_STATE_FALL
    BNE cv3_rope_controls_grab_buttons
cv3_rope_controls_check_drop:
    LDA.W cv3_stair_player_phase
    BPL cv3_rope_controls_grab_buttons
    LDA.B cv3_stair_joy_held
    AND.B #cv3_stair_PAD_DOWN
    BNE cv3_rope_controls_unused
    LDA.W cv3_stair_player_phase
    AND.B #($FF ^ cv3_rope_ROPE_DROP_LOCK)
    STA.W cv3_stair_player_phase
cv3_rope_controls_grab_buttons:
    ; A held prevents catching the rope during jump preparation.
    LDA.B cv3_stair_joy_held
    AND.B #(cv3_stair_PAD_A | cv3_stair_PAD_UP | cv3_stair_PAD_DOWN)
    CMP.B #cv3_stair_PAD_UP
    BEQ cv3_rope_controls_grab_direction
    CMP.B #cv3_stair_PAD_DOWN
    BNE cv3_rope_controls_unused
cv3_rope_controls_grab_direction:
    LDA.B cv3_stair_joy_pressed
    AND.B #cv3_stair_PAD_B
    BNE cv3_rope_controls_unused
    LDA.W cv3_stair_player_state
    CMP.B #cv3_stair_STATE_IDLE
    BEQ cv3_rope_controls_find
    CMP.B #cv3_stair_STATE_WALK
    BEQ cv3_rope_controls_find
    CMP.B #cv3_rope_STATE_DUCK
    BEQ cv3_rope_controls_find
    CMP.B #cv3_stair_STATE_JUMP
    BEQ cv3_rope_controls_descending
    CMP.B #cv3_stair_STATE_FALL
    BNE cv3_rope_controls_unused
cv3_rope_controls_descending:
    LDA.W cv3_stair_player_phase
    BEQ cv3_rope_controls_unused
    LDA.W cv3_stair_player_speed_y
    BMI cv3_rope_controls_unused

cv3_rope_controls_find:
    JSR.W cv3_stair_get_player_position
    BCC cv3_rope_controls_unused
    LDY.B #$00
cv3_rope_controls_find_record:
    LDA.W cv3_rope_segments,Y
    CMP.B #$FF
    BEQ cv3_rope_controls_unused
    JSR.W cv3_rope_record_matches
    BCC cv3_rope_controls_next_record
    STY.B cv3_rope_record_index
    JSR.W cv3_rope_try_snap
    BCS cv3_rope_controls_grabbed
    LDY.B cv3_rope_record_index
cv3_rope_controls_next_record:
    TYA
    CLC
    ADC.B #cv3_rope_ROPE_RECORD_SIZE
    TAY
    JMP.W cv3_rope_controls_find_record

cv3_rope_controls_grabbed:
    LDA.B #cv3_rope_STATE_ROPE
    STA.W cv3_stair_player_state
    LDA.B cv3_rope_record_index
    STA.W cv3_stair_player_phase ; Record byte offset, only while state is STATE_ROPE.
    LDA.B #$00
    STA.W cv3_stair_player_stair_step ; Animation distance counter while attached.
    STA.W cv3_rope_sprite_offset
    STA.W cv3_rope_animation_timer
    JMP.W cv3_rope_controls_hold

cv3_rope_controls_attached:
    JSR.W cv3_stair_get_player_position
    BCC cv3_rope_controls_lost
    LDY.W cv3_stair_player_phase
    CPY.B #(cv3_rope_segments_end - cv3_rope_segments - 1)
    BCS cv3_rope_controls_lost
    JSR.W cv3_rope_record_matches
    BCS cv3_rope_controls_input
cv3_rope_controls_lost:
    JMP.W cv3_rope_release

cv3_rope_controls_input:
    LDA.B cv3_stair_joy_pressed
    AND.B #cv3_stair_PAD_A
    BEQ cv3_rope_controls_hold
    LDA.B cv3_stair_joy_held
    AND.B #cv3_stair_PAD_DOWN
    BNE cv3_rope_controls_drop
    JSR.W cv3_rope_clear_motion
    LDA.B #cv3_stair_STATE_JUMP_START
    STA.W cv3_stair_player_state
    SEC
    RTS

cv3_rope_controls_drop:
    JSR.W cv3_rope_release
    LDA.W cv3_stair_player_phase
    ORA.B #cv3_rope_ROPE_DROP_LOCK
    STA.W cv3_stair_player_phase
    SEC
    RTS

cv3_rope_controls_hold:
    JSR.W cv3_rope_clear_motion
    LDA.B cv3_stair_joy_held
    AND.B #(cv3_stair_PAD_UP | cv3_stair_PAD_DOWN)
    CMP.B #cv3_stair_PAD_UP
    BEQ cv3_rope_controls_up
    CMP.B #cv3_stair_PAD_DOWN
    BEQ cv3_rope_controls_down
    JMP.W cv3_rope_controls_pose

cv3_rope_controls_up:
    LDY.W cv3_stair_player_phase
    LDA.B cv3_stair_player_y
    CMP.W cv3_rope_segments+5,Y
    BNE cv3_rope_controls_up_probe
    LDA.B cv3_stair_player_y+1
    CMP.W cv3_rope_segments+6,Y
    BEQ cv3_rope_controls_pose
cv3_rope_controls_up_probe:
    LDY.W cv3_stair_current_character
    LDA.W cv3_rope_head_probe,Y
    STA.B cv3_rope_probe_y
    JSR.W cv3_rope_probe_sides
    BCS cv3_rope_controls_pose
    LDA.B #$FF
    STA.W cv3_stair_player_speed_y
    JMP.W cv3_rope_controls_animate

cv3_rope_controls_down:
    LDY.W cv3_stair_player_phase
    LDA.B cv3_stair_player_y
    CMP.W cv3_rope_segments+7,Y
    BNE cv3_rope_controls_down_probe
    LDA.B cv3_stair_player_y+1
    CMP.W cv3_rope_segments+8,Y
    BEQ cv3_rope_controls_lost
cv3_rope_controls_down_probe:
    ; Grant's native foot probes are four pixels above the others'.
    LDY.W cv3_stair_current_character
    LDA.W cv3_rope_foot_probe,Y
    STA.B cv3_rope_probe_y
    JSR.W cv3_rope_probe_sides
    BCS cv3_rope_controls_lost
    LDA.B #$01
    STA.W cv3_stair_player_speed_y
cv3_rope_controls_animate:
    INC.W cv3_stair_player_stair_step
cv3_rope_controls_pose:
    LDY.W cv3_stair_current_character
    LDA.W cv3_stair_player_stair_step
    AND.B #$08
    BEQ cv3_rope_controls_pose_first
    INY
    INY
    INY
    INY
cv3_rope_controls_pose_first:
    LDA.W cv3_rope_pose_indices,Y
    STA.W cv3_rope_sprite
    SEC
    RTS

; Y is a record offset and is preserved. C=1 means the room, X tolerance
; and inclusive Y bounds match the normalized player origin.
cv3_rope_record_matches:
    LDA.W cv3_rope_segments,Y
    CMP.B cv3_rope_stage
    BNE cv3_rope_record_miss
    LDA.W cv3_rope_segments+1,Y
    CMP.B cv3_rope_block
    BNE cv3_rope_record_miss
    LDA.W cv3_rope_segments+2,Y
    CMP.B cv3_rope_room
    BNE cv3_rope_record_miss
    SEC
    LDA.B cv3_stair_player_x
    SBC.W cv3_rope_segments+3,Y
    STA.B cv3_rope_delta_x
    LDA.B cv3_stair_player_x+1
    SBC.W cv3_rope_segments+4,Y
    BEQ cv3_rope_record_right
    CMP.B #$FF
    BNE cv3_rope_record_miss
    LDA.B cv3_rope_delta_x
    CMP.B #($100 - cv3_rope_ROPE_ATTACH_TOLERANCE)
    BCC cv3_rope_record_miss
    BCS cv3_rope_record_y
cv3_rope_record_right:
    LDA.B cv3_rope_delta_x
    CMP.B #(cv3_rope_ROPE_ATTACH_TOLERANCE + 1)
    BCS cv3_rope_record_miss
cv3_rope_record_y:
    LDA.B cv3_stair_player_y+1
    CMP.W cv3_rope_segments+6,Y
    BCC cv3_rope_record_miss
    BNE cv3_rope_record_bottom
    LDA.B cv3_stair_player_y
    CMP.W cv3_rope_segments+5,Y
    BCC cv3_rope_record_miss
cv3_rope_record_bottom:
    LDA.W cv3_rope_segments+8,Y
    CMP.B cv3_stair_player_y+1
    BCC cv3_rope_record_miss
    BNE cv3_rope_record_hit
    LDA.W cv3_rope_segments+7,Y
    CMP.B cv3_stair_player_y
    BCC cv3_rope_record_miss
cv3_rope_record_hit:
    SEC
    RTS
cv3_rope_record_miss:
    CLC
    RTS

; Snap only through empty space at the head, torso and feet. The largest
; correction is six pixels, so each side can cross at most one tile edge.
cv3_rope_try_snap:
    LDA.W cv3_stair_screen_x
    STA.B cv3_rope_original_x
    SEC
    SBC.B cv3_rope_delta_x
    STA.W cv3_stair_screen_x
    LDY.W cv3_stair_current_character
    LDA.W cv3_rope_head_probe,Y
    CLC
    ADC.B #$01 ; Check the current head position before the first upward step.
    STA.B cv3_rope_probe_y
    JSR.W cv3_rope_probe_sides
    BCS cv3_rope_snap_blocked
    LDA.B #$00
    STA.B cv3_rope_probe_y
    JSR.W cv3_rope_probe_sides
    BCS cv3_rope_snap_blocked
    LDY.W cv3_stair_current_character
    LDA.W cv3_rope_foot_probe,Y
    SEC
    SBC.B #$02 ; Leave the supporting floor outside the grab probes.
    STA.B cv3_rope_probe_y
    JSR.W cv3_rope_probe_sides
    BCS cv3_rope_snap_blocked
    SEC
    RTS
cv3_rope_snap_blocked:
    LDA.B cv3_rope_original_x
    STA.W cv3_stair_screen_x
    CLC
    RTS

; C=1 for a nonempty tile at either side of the requested height.
; Collision probes overwrite Y and $10-$14.
cv3_rope_probe_sides:
    LDA.B #$FB
    LDX.B cv3_rope_probe_y
    JSR.W cv3_rope_tile_collision
    BNE cv3_rope_probe_blocked
    LDA.B #$05
    LDX.B cv3_rope_probe_y
    JSR.W cv3_rope_tile_collision
    BNE cv3_rope_probe_blocked
    CLC
    RTS
cv3_rope_probe_blocked:
    SEC
    RTS

cv3_rope_release:
    JSR.W cv3_rope_clear_motion
    LDA.B #$00
    STA.W cv3_stair_player_stair_direction
    STA.W cv3_stair_player_stair_alignment
    STA.B cv3_rope_grant_jump_flag
    STA.B cv3_rope_landing_timer
    LDA.B #$01
    STA.W cv3_stair_player_phase
    STA.W cv3_stair_player_stair_step
    LDA.B #cv3_stair_STATE_FALL
    STA.W cv3_stair_player_state
    STA.W cv3_rope_jump_timer
    LDA.W cv3_stair_current_character
    CMP.B #cv3_stair_CHAR_GRANT
    BNE cv3_rope_release_ready
    ; Grant indexes a different jump curve. $38 starts its falling half.
    LDA.B #$38
    STA.W cv3_rope_jump_timer
cv3_rope_release_ready:
    LDA.B #$02
    STA.W cv3_rope_sprite
    SEC
    RTS

cv3_rope_clear_motion:
    LDA.B #$00
    STA.W cv3_stair_player_speed_x
    STA.W cv3_stair_player_subspeed_x
    STA.W cv3_stair_player_speed_y
    STA.W cv3_stair_player_subspeed_y
    STA.W cv3_stair_player_fraction_x
    STA.W cv3_stair_player_fraction_y
    RTS

; Probe one pixel beyond each character's native head/foot collision edge.
; Character order is Trevor, Sypha, Grant, Alucard.
cv3_rope_head_probe:
    DB $E7, $E7, $EF, $E7
cv3_rope_foot_probe:
    DB $11, $11, $0D, $11

; Two OAM-spec frames per character, eight moved pixels per frame.
; Trevor uses the appended climbing poses. Other characters use idle.
cv3_rope_pose_indices:
    DB $70, $02, $02, $02 ; First frame.
    DB $72, $02, $02, $02 ; Second frame.

; Each record is stage, block, room, followed by 16-bit little-endian X,
; top Y and bottom Y. The three IDs match RAM $32/$33/$34.
; X is the rope center. Y bounds describe the normalized player origin.
; Grant's origin is normalized four pixels upward, as for stairs.
; Horizontal rooms use world X = screen X + $56 + 256*$57, Y = screen Y.
; Vertical rooms use X = screen X, world Y = screen Y - $33 + $56 + 240*$57.
;
; Example for horizontal room 00/00/00, X=$0180, origin Y=$0060..$00B0
;     DB $00, $00, $00
;     DW $0180, $0060, $00B0
;
; Insert records before $FF. Put ropes in open columns with head clearance.
; The room artwork must draw the corresponding rope at these coordinates.
cv3_rope_segments:
    DB $FF
cv3_rope_segments_end:

assert (cv3_rope_segments_end-cv3_rope_segments) <= $FD
assert ((cv3_rope_segments_end-cv3_rope_segments-1)%cv3_rope_ROPE_RECORD_SIZE) == 0
