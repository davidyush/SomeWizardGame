extends Area2D

var PlayerStats = ResourceLoader.PlayerStats

func _on_HealthPotion_body_entered(body):
	PlayerStats.hp_potions += 1
	queue_free()
