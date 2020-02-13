extends "res://src/Creatures/CreatureWalking.gd"

enum {
	IDLE,
	WALKING
}

var state = IDLE

func _physics_process(delta: float) -> void:
	match state:
		IDLE:
			animPlayer.play('nope')
		WALKING:
			walking(delta)
			animPlayer.play('run')
			
	._physics_process(delta)


func _on_viewport_entered(viewport: Viewport) -> void:
	state = WALKING
	._on_viewport_entered(viewport)


func _on_viewport_exited(viewport: Viewport) -> void:
	state = IDLE
	._on_viewport_exited(viewport)


func walking(delta: float) -> void:
	velocity = move_and_slide(
		CreatureUtils.get_walk_velocity(current_move, SPEED, direction),
		Vector2.ZERO
	)
	
	.walking(delta)
