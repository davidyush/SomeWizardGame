extends "res://src/Creatures/CreatureWalking.gd"

export (PackedScene) var Bullet = null

var MainInstances = ResourceLoader.MainInstances

onready var strikeTimer = $StrikeTimer

enum {
	IDLE,
	WALKING,
	STRIKING
}

var state = IDLE
var can_fire = true

func _physics_process(delta: float) -> void:
	var player = MainInstances.Player
	
	match state:
		IDLE:
			animPlayer.play('nope')
		WALKING:
			walking(delta)
			animPlayer.play('run')
		STRIKING:
			animPlayer.play('fire')
			strike(delta, player)
			
	._physics_process(delta)


# warning-ignore:unused_argument
func _on_PlayerDetector_body_entered(body: Node) -> void:
	state = STRIKING
	strikeTimer.start()


# warning-ignore:unused_argument
func _on_PlayerDetector_body_exited(body: Node) -> void:
	state = WALKING


func _on_viewport_entered(viewport: Viewport) -> void:
	state = WALKING
	._on_viewport_entered(viewport)


func _on_viewport_exited(viewport: Viewport) -> void:
	state = IDLE
	._on_viewport_exited(viewport)


func _on_StrikeTimer_timeout() -> void:
	can_fire = true


func strike(delta: float, player: KinematicBody2D) -> void:
	if can_fire == true and player != null:
		sprite.flip_h = global_position > player.global_position
		CreatureUtils.strike_to_target(player, self, delta, Bullet, 70)
		can_fire = false

