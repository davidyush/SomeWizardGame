extends Sprite

func _ready() -> void:
	var current_frame = get_rand_frame()
	frame = current_frame

func get_rand_frame() -> int:
	var curr_frame = int(rand_range(0,16))
	if curr_frame != 4 && curr_frame != 5 && curr_frame != 7:
		return curr_frame
	return get_rand_frame()
