extends Area2D

var PlayerStats = ResourceLoader.PlayerStats

func _on_ManaPotion_body_entered(body):
	PlayerStats.mana_potions += 1
	queue_free()
