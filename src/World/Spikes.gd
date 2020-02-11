extends Area2D

var disabled = true

onready var hitbox = $Hitbox/Collider

func toggle_disabled():
	disabled = !disabled
	hitbox.disabled = disabled
