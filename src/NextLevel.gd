extends Area2D

export (String, FILE, "*.tscn") var target_stage 

func _on_NextLevel_body_entered(body: Node) -> void:
	if "Wizard" in body.name:
		get_tree().change_scene(target_stage)
