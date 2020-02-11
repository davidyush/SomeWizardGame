extends Control

const FIREBALL = preload("res://src/Spells/FireBall.tscn")
const FROSTBALL = preload("res://src/Spells/FrostBall.tscn")
const DEATHBALL = preload("res://src/Spells/DeathBall.tscn")
const POISONBALL = preload("res://src/Spells/PoisonBall.tscn")

onready var fire_sprite = $NinePatchRect/FireBallAnimation/Sprite
onready var frost_sprite = $NinePatchRect/FrostBallAnimation/Sprite
onready var poison_sprite = $NinePatchRect/PoisonBallAnimation/Sprite
onready var death_sprite = $NinePatchRect/DeathBallAnimation/Sprite

onready var fire_anim = $NinePatchRect/FireBallAnimation/AnimationPlayer
onready var frost_anim = $NinePatchRect/FrostBallAnimation/AnimationPlayer
onready var poison_anim = $NinePatchRect/PoisonBallAnimation/AnimationPlayer
onready var death_anim = $NinePatchRect/DeathBallAnimation/AnimationPlayer

onready var fire_lbl = $NinePatchRect/FireLabel
onready var frost_lbl = $NinePatchRect/FrostLabel
onready var poison_lbl = $NinePatchRect/PoisonLabel
onready var death_lbl = $NinePatchRect/DeathLabel

var PlayerStats = ResourceLoader.PlayerStats

func _ready() -> void:
	PlayerStats.connect("player_spell_change", self, "_on_player_spell_change")
	fill_alfa()
	mark_current_spell(PlayerStats.spell)
	
func _on_player_spell_change(val):
	fill_alfa()
	mark_current_spell(val)

func fill_alfa():
	fire_sprite.self_modulate = Color(1, 1, 1, 0.3)
	frost_sprite.self_modulate = Color(1, 1, 1, 0.3)
	poison_sprite.self_modulate = Color(1, 1, 1, 0.3)
	death_sprite.self_modulate = Color(1, 1, 1, 0.3)
	fire_lbl.self_modulate = Color(1, 1, 1, 0.3)
	frost_lbl.self_modulate = Color(1, 1, 1, 0.3)
	poison_lbl.self_modulate = Color(1, 1, 1, 0.3)
	death_lbl.self_modulate = Color(1, 1, 1, 0.3)
	fire_anim.play("idle")
	frost_anim.play("idle")
	poison_anim.play("idle")
	death_anim.play("idle")

func mark_current_spell(choosen):
	match choosen:
		FIREBALL:
			fire_sprite.self_modulate = Color(1, 1, 1, 1)
			fire_lbl.self_modulate = Color(1, 1, 1, 1)
			fire_anim.play("fire")
		FROSTBALL:
			frost_sprite.self_modulate = Color(1, 1, 1, 1)
			frost_lbl.self_modulate = Color(1, 1, 1, 1)
			frost_anim.play("fire")
		POISONBALL:
			poison_sprite.self_modulate = Color(1, 1, 1, 1)
			poison_lbl.self_modulate = Color(1, 1, 1, 1)
			poison_anim.play("fire")
		DEATHBALL:
			death_sprite.self_modulate = Color(1, 1, 1, 1)
			death_lbl.self_modulate = Color(1, 1, 1, 1)
			death_anim.play("fire")
