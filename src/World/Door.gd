extends StaticBody2D

onready var anim = $AnimationPlayer
onready var doorCol = $Collision

var state_disabled = false
var state_index = 0
#func _ready() -> void:
#	setDoorState('open', 3)

func setDoorState(animation, index):
	anim.play(animation)
	state_disabled = !state_disabled
	doorCol.disabled = state_disabled
	set_physics_process(!state_disabled)
	z_index = index
	
func _on_ActiveZone_body_entered(body: Node) -> void:
	setDoorState('open', 3)

func _on_ActiveZone_body_exited(body: Node) -> void:
	setDoorState('close', 0)
