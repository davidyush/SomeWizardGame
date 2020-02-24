extends Camera2D

var MainInstances = ResourceLoader.MainInstances

var shake = 0

onready var timer = $Timer
onready var animPlayer = $AnimationPlayer

enum {
	IDLE,
	TOP,
	BOTTOM,
	LEFT,
	RIGHT
}
var offsets = {
	top = Vector2(0, -100),
	bottom = Vector2(0, 100),
	right = Vector2(100, 0),
	left = Vector2(-100, 0),
	idle = Vector2(0, 0)
}

var state = IDLE

func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("add_screen_shake", self, "_on_Events_add_screenshake")
	MainInstances.WorldCamera = self

#func _input(event: InputEvent) -> void:
#	if event.is_action_released("camera_top"):
#		set_camera_position('to_top', offsets.top)
#	elif event.is_action_released("camera_bottom"):
#		set_camera_position('to_bottom', offsets.bottom)
#	elif event.is_action_released("camera_right"):
#		set_camera_position('to_right', offsets.right)
#	elif event.is_action_released("camera_left"):
#		set_camera_position('to_left', offsets.left)
	#else:
	#	set_camera_position('idle', offsets.idle)


func set_camera_position(animName: String, offset_pos: Vector2) -> void:
	animPlayer.play(animName)
	yield(animPlayer, "animation_finished")
	offset = offset_pos

func queue_free() -> void:
	MainInstances.WorldCamera = null
	.queue_free()

# warning-ignore:unused_argument
func _process(delta: float) -> void:
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)
	
func screeshake(amount: float, duration: float) -> void:
	shake = amount
	timer.wait_time = duration
	timer.start()

func _on_Timer_timeout() -> void:
	shake = 0

func _on_Events_add_screenshake(amount: float, duration: float) -> void:
	screeshake(amount, duration)
