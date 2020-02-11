extends Area2D

onready var timer = $Timer

export (Dictionary) var damage_obj = {
	pure_damage = 1,
	freeze_time = 2.0,
	poison = {
		delay = 2.0,
		damage = 9
	}
}

var body_near = false
var body_instance = null

func call_dmg(hurtbox):
	hurtbox.emit_signal("hit", damage_obj)

func _on_Hitbox_area_entered(hurtbox):
	body_near = true
	body_instance = hurtbox
	call_dmg(hurtbox)
	timer.start()

func _on_Hitbox_area_exited(area: Area2D) -> void:
	body_near = false
	body_instance = null
	timer.stop()

func _on_Timer_timeout() -> void:
	if body_near and body_instance != null:
		call_dmg(body_instance)
