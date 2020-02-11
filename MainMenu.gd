extends Control

export (String, FILE, "*.tscn") var target_stage 

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)

func _on_Button_pressed() -> void:
	get_tree().change_scene(target_stage)
