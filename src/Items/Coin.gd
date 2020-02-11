extends Area2D

var PlayerStats = ResourceLoader.PlayerStats

func _on_Coin_body_entered(body):
	PlayerStats.coins += 1
	queue_free()
