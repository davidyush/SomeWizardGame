extends "res://src/LevelsB/LevelTemplateB.gd"

onready var trigger = $Trigger
onready var wall_triggered = $WallTriggered/WallVert

var once = true

func _on_Trigger_body_entered(body: Node) -> void:
	if once:
		wall_triggered.visible = true
		wall_triggered.set_collision_mask_bit(0, true)

func _on_Necromancer_necromance_died() -> void:
	wall_triggered.visible = false
	wall_triggered.set_collision_mask_bit(0, false)
	once = false
