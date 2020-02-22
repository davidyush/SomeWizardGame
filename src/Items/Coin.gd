extends Area2D

var PlayerStats = ResourceLoader.PlayerStats

# warning-ignore:unused_argument
func _on_Coin_body_entered(body):
	PlayerStats.coins += 1
	queue_free()
