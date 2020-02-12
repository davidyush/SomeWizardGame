extends "res://src/Creatures/CreatureChasing.gd"

onready var hitbox = $Hitbox

func _ready() -> void:
	hitbox.damage_obj = {
		pure_damage = 1,
		poison = {
			damage = 4,
			delay = 2.0
		}
	}	

func walking(delta: float) -> void:
	velocity = move_and_slide(CreatureUtils.get_diagonal_walk_velocity(current_move, SPEED, direction))
	.walking(delta)


