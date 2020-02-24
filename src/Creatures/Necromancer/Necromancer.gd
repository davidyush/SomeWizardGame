extends "res://src/Creatures/CreatureStriking.gd"

const Skelet = preload("res://src/Creatures/Skelet/CreatureSkelet.tscn")

onready var eye_left = $EyeLeft
onready var eye_right = $EyeRight

onready var position_left = $LeftPosition
onready var position_right = $RightPosition
onready var position_top = $TopPosition
onready var position_bottom = $BottomPosition

onready var ray_left = $RayCastLeft
onready var ray_right = $RayCastRight
onready var ray_top = $RayCastTop
onready var ray_bottom = $RayCastBottom

enum {
	RAISE_SKELETONS,
	PORTAL
}

signal necromance_died

func _ready() -> void:
	._ready()
	SPEED = MAX_SPEED


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
			
	set_eyes_coords()
	
func _on_RaisingTimer_timeout() -> void:
	if ray_left.is_colliding():
		Utils.instance_scene_on_main(Skelet, position_right.global_position)
	else:
		Utils.instance_scene_on_main(Skelet, position_left.global_position)
		
	if ray_top.is_colliding():
		Utils.instance_scene_on_main(Skelet, position_bottom.global_position)
	else:
		Utils.instance_scene_on_main(Skelet, position_top.global_position)

func set_eyes_coords():
	if sprite.flip_h:
		eye_left.position.x = -4
		eye_right.position.x = 0
	else:
		eye_left.position.x = 0
		eye_right.position.x = 4

func dead() -> void:
	emit_signal("necromance_died")
	.dead()
	

