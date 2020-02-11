extends Area2D

export (int) var SPEED = 100

var velocity: Vector2 = Vector2.ZERO
var direction: = Vector2.ZERO

func set_ball_direction(dir):
	direction = dir
	
	if sign(dir.y) == 1:
		$Sprite.rotation_degrees = 0
	elif sign(dir.y) == -1:
		$Sprite.rotation_degrees = 180
	elif sign(dir.x) == 1:
		$Sprite.rotation_degrees = 270
	elif sign(dir.x) == -1:
		$Sprite.rotation_degrees = 90


func _physics_process(delta):
	var velocity = Vector2(
		SPEED * 1.5 * delta * sign(direction.x),
		SPEED * 1.5 * delta * sign(direction.y)
	)
	
	translate(velocity)
