extends "res://src/Spells/Ball.gd"

const Explosion = preload("res://src/Effects/DeathExplosion.tscn")


func _on_DeathBall_body_entered(body: Node) -> void:
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()


