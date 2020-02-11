extends Control

var PlayerStats = ResourceLoader.PlayerStats

onready var manaBar = $ManaBar

func _ready() -> void:
	PlayerStats.connect('player_mana_changed', self, '_on_player_mana_change')
	manaBar.value = Utils.getPercentValue(PlayerStats.mana, PlayerStats.max_mana) 
	
func _on_player_mana_change(value):
	manaBar.value = Utils.getPercentValue(value, PlayerStats.max_mana)
