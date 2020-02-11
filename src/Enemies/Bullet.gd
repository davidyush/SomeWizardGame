extends Area2D

const Explosion = preload("res://src/Effects/RedExplosion.tscn")


var velocity: = Vector2.ZERO
var direction: = Vector2.ZERO

func set_bullet(dir: Vector2, vel: Vector2):
	direction = dir
	velocity = vel

func _process(delta: float) -> void:
	translate(velocity * delta)

func _on_Bullet_body_entered(body: Node) -> void:
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()
