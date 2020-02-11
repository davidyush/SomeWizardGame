extends "res://src/Spells/Ball.gd"

const Explosion = preload("res://src/Effects/FrostExplosion.tscn")

func _on_FrostBall_body_entered(body):
	#print(body.name, body.global_position)
	#var explosion = FrostExplosion.instance()
	#get_parent().add_child(explosion)
	#explosion.global_position = body.global_position
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()
