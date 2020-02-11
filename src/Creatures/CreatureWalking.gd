extends "res://src/Creatures/Creature.gd"

export (int) var direction = 1
export (int) var MAX_SPEED = 40
export (Array) var moves = ['horizontal', 'vertical']

var SPEED = MAX_SPEED

var velocity = Vector2.ZERO

var current_move = CreatureUtils.get_rand_elem(moves)

func _on_DirectionTimer_timeout() -> void:
	current_move = CreatureUtils.get_rand_elem(moves)

func walking(delta: float) -> void:
	if is_on_wall():
		direction *= -1
		
	sprite.flip_h = false if direction == 1 else true
	
	velocity = move_and_slide(
		CreatureUtils.get_walk_velocity(current_move, SPEED, direction),
		Vector2.ZERO
	)
