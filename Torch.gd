extends Sprite

onready var animPlayer: = $AnimationPlayer

func _ready() -> void:
	yield(get_tree().create_timer(rand_range(0.0, 1.0)), "timeout")
	$AnimationPlayer.play("idle")
