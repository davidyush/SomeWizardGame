extends Control

var PlayerStats = ResourceLoader.PlayerStats

onready var potionsCount = $NinePatchRect/PotionsCount

func _ready():
	PlayerStats.connect("player_mana_potions_change", self, "on_mana_potions_count_change")
	potionsCount.text = str(PlayerStats.mana_potions)

func on_mana_potions_count_change(val):
	potionsCount.text = str(val)

