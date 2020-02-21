extends "res://src/Creatures/CreatureWalking.gd"

enum {
	IDLE,
	WALKING
}

var state = IDLE

func _ready() -> void:
	._ready()
	SPEED = MAX_SPEED

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
