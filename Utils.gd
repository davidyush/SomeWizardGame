extends Node

func instance_scene_on_main(scene, position):
	var main = get_tree().current_scene
	var instance = scene.instance()
	main.add_child(instance)
	instance.global_position = position
	return instance

func getPercentValue(current_value: float, max_value: float) -> float:
	return 100 / max_value * current_value 
	
