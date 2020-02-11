extends Node

func get_walk_velocity(move: String, speed: int, direction: int) -> Vector2:
	match move:
		'horizontal':
			return Vector2(speed * direction, 0)
		'vertical':
			return Vector2(0, speed * direction)
	
	return Vector2.ZERO


func get_rand_elem(options: Array) -> String:
	return options[rand_range(0, options.size())]

	
func get_state_color(state: Dictionary) -> Color:
	if state.poisoned and state.freezed:
		return Color8(255, 255, 0, 255)
	elif state.poisoned:
		return Color8(0, 255, 0, 255)
	elif state.freezed:
		return Color8(0, 0, 255, 255)
	
	return Color8(255, 255, 255, 255)


func chase_object(object: KinematicBody2D, delta: float, position: Vector2, speed: int) -> Vector2:
	var velocity = Vector2.ZERO
	if object != null:
		var direction = (object.global_position - position)
		velocity += direction * speed * delta
		velocity = velocity.clamped(speed * rand_range(1.3, 1.7))
	return velocity
