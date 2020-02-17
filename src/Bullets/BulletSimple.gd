extends Area2D

export (PackedScene) var Explosion = null

var velocity: = Vector2.ZERO
var direction: = Vector2.ZERO

func set_bullet(dir: Vector2, vel: Vector2):
	direction = dir
	velocity = vel

func _process(delta: float) -> void:
	translate(velocity * delta)


func _on_BulletSimple_body_entered(body: Node) -> void:
	Utils.instance_scene_on_main(Explosion, global_position)
	queue_free()
