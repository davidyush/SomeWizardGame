extends MarginContainer

func _physics_process(delta):
	$VBoxContainer/Stat1.text = 'FPS:' + str(Performance.get_monitor(Performance.TIME_FPS))
	$VBoxContainer/Stat2.text = 'RAM:' + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + 'MB'
