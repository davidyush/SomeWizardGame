extends Resource
class_name PlayerStatsResource

const FIREBALL = preload("res://src/Spells/FireBall.tscn")

var spell = FIREBALL setget set_spell

var max_health = 20
var health = max_health setget set_health

var max_mana = 20
var mana = max_mana setget set_mana

var max_hp_potions = 20
var hp_potions = 10 setget set_hp_potions

var max_mana_potions = 20
var mana_potions = 10 setget set_mana_potions

var coins = 0 setget set_coins

signal player_died
signal player_health_changed(val)
signal player_mana_changed(val)
signal player_hp_potions_change(val)
signal player_mana_potions_change(val)
signal player_coins_change(val)
signal player_spell_change(val)

func set_spell(spell_scene):
	spell = spell_scene
	emit_signal("player_spell_change", spell)

func set_health(value):
	health = clamp(value, 0, max_health)
	emit_signal("player_health_changed", health)
	if health == 0:
		emit_signal("player_died")

func set_mana(value):
	mana = clamp(value, 0, max_mana)
	emit_signal('player_mana_changed', mana)

func set_hp_potions(value):
	hp_potions = clamp(value, 0, max_hp_potions)
	emit_signal("player_hp_potions_change", hp_potions)
	
func set_mana_potions(value):
	mana_potions = clamp(value, 0, max_mana_potions)
	emit_signal("player_mana_potions_change", mana_potions)

func set_coins(value):
	coins = max(0, value)
	emit_signal("player_coins_change", coins)
