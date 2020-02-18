extends "res://src/Bullets/BulletSimple.gd"

var MainInstances = ResourceLoader.MainInstances
var Player = MainInstances.Player
func _process(delta: float) -> void:
	Player = MainInstances.Player
	if Player != null:
		var direction = (Player.global_position - position).normalized()
		velocity += (direction * speed * delta)
		velocity = velocity.clamped(speed)
	._process(delta)


func _on_LifeTimer_timeout() -> void:
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()
