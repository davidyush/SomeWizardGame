extends Camera2D

var MainInstances = ResourceLoader.MainInstances

var shake = 0

onready var timer = $Timer

func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("add_screen_shake", self, "_on_Events_add_screenshake")
	MainInstances.WorldCamera = self

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
