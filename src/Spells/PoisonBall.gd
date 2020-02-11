extends "res://src/Spells/Ball.gd"

const Explosion = preload("res://src/Effects/PoisonExplosion.tscn")

func _on_PoisonBall_body_entered(body):
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()
