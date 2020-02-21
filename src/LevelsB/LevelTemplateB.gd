extends Node2D

const WORLD = preload("res://src/World/World.gd")

func _ready() -> void:
	var parent = get_parent()
	if parent is WORLD:
		parent.currentLevel = self
