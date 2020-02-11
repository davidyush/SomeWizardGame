extends Control

var PlayerStats = ResourceLoader.PlayerStats

onready var healthBar = $HealthBar

func _ready() -> void:
	PlayerStats.connect('player_health_changed', self, '_on_player_health_change')
	healthBar.value = Utils.getPercentValue(PlayerStats.health, PlayerStats.max_health)
	
func _on_player_health_change(value) -> void:
	healthBar.value = Utils.getPercentValue(value, PlayerStats.max_health)
