extends "res://src/Creatures/Creature.gd"

export (int) var direction = 1
export (int) var MAX_SPEED = 40
export (Array) var moves = ['horizontal', 'vertical']

var SPEED = MAX_SPEED
var velocity = Vector2.ZERO
var current_move = CreatureUtils.get_rand_elem(moves)


func _on_DirectionTimer_timeout() -> void:
	current_move = CreatureUtils.get_rand_elem(moves)

func _on_FreezeTimer_timeout() -> void:
	SPEED = MAX_SPEED
	._on_FreezeTimer_timeout()

# warning-ignore:unused_argument
func walking(delta: float) -> void:
	if is_on_wall():
		direction *= -1
		
	sprite.flip_h = false if direction == 1 else true

func get_frosted(freeze_time: int):
	SPEED = SPEED / 1.5
	.get_frosted(freeze_time)
