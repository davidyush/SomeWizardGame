extends Area2D

export (float) var delay = 0.0

var disabled = true

onready var hitbox = $Hitbox/Collider
onready var animPlayer = $AnimationPlayer

func _ready() -> void:
	yield(get_tree().create_timer(delay), "timeout")
	animPlayer.play('idle')

func toggle_disabled():
	disabled = !disabled
	hitbox.disabled = disabled
