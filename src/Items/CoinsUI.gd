extends Control

var PlayerStats = ResourceLoader.PlayerStats

onready var coinsCount = $NinePatchRect/CoinsCount

func _ready():
	PlayerStats.connect("player_coins_change", self, "_on_player_coins_change")
	coinsCount.text = str(PlayerStats.coins)

func _on_player_coins_change(value):
	coinsCount.text = str(value)
