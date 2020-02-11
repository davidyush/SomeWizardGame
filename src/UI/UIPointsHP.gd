extends Control

var PlayerStats = ResourceLoader.PlayerStats

onready var potionsCount = $NinePatchRect/PotionsCount

func _ready():
	PlayerStats.connect("player_hp_potions_change", self, "on_hp_potions_count_change")
	potionsCount.text = str(PlayerStats.hp_potions)

func on_hp_potions_count_change(val):
	potionsCount.text = str(val)
