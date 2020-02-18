extends "res://src/Creatures/CreatureStriking.gd"

onready var eye_left = $EyeLeft
onready var eye_right = $EyeRight

func _ready() -> void:
	._ready()
	SPEED = MAX_SPEED

func _physics_process(delta: float) -> void:
	._physics_process(delta)
	set_eyes_coords()
	print('nector', MAX_SPEED, SPEED)

func set_eyes_coords():
	if sprite.flip_h:
		eye_left.position.x = -4
		eye_right.position.x = 0
	else:
		eye_left.position.x = 0
		eye_right.position.x = 4
