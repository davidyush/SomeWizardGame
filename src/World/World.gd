extends Node

var MainInstances = ResourceLoader.MainInstances

onready var currentLevel = $LevelB_00
onready var camera = $WorldCamera

#should get this values dinamicaly
const lims = {
	"res://src/LevelsB/LevelB_00.tscn": [-8, -160, 752, 150],
	"res://src/LevelsB/LevelB_01.tscn": [-48, -24, 416, 336],
	"res://src/LevelsB/LevelB_02.tscn": [-64, -230, 688, 288],
	"res://src/LevelsB/LevelB_Boss1.tscn": [-64, -20, 262, 256]
}


func set_camera_limits(limits_arr: Array) -> void:
	for i in 4:
		camera.set_limit(i, limits_arr[i])


func get_current_limits(lvl_position: Vector2, lvl_limits: Array) -> Array:
	var result = lvl_limits.duplicate()
	for i in 4:
		if i % 2 == 0:
			result[i] += lvl_position.x
		else:
			result[i] += lvl_position.y
	return result


func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	MainInstances.Player.connect('hit_door', self, '_on_Player_hit_door')

	var current_limits = get_current_limits(currentLevel.global_position, lims["res://src/LevelsB/LevelB_00.tscn"])
	set_camera_limits(current_limits)


func change_levels(door):
	var offset = currentLevel.position
	currentLevel.queue_free()
	var NewLevel = load(door.new_level_path)
	var newLevel = NewLevel.instance()
	add_child(newLevel)
	var newDoor = get_door_with_connection(door, door.connection)
	var exit_position = newDoor.position - offset
	newLevel.position = door.position - exit_position
	
	#set limit camera
	var current_limits = get_current_limits(newLevel.position, lims[door.new_level_path])
	set_camera_limits(current_limits)


func get_door_with_connection(notDoor, connection):
	var doors = get_tree().get_nodes_in_group("Door")
	for door in doors:
		if door.connection == connection and door != notDoor:
			return door
	return null


func _on_Player_hit_door(door) -> void:
	call_deferred("change_levels", door)


func _on_Player_player_died() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
