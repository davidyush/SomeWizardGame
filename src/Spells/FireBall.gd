extends "res://src/Spells/Ball.gd"

const Explosion = preload("res://src/Effects/FireExplosion.tscn")

func _on_FireBall_body_entered(body):
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()
