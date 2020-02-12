extends KinematicBody2D

const BloodSpot = preload("res://src/Effects/BloodSpot.tscn")

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer
onready var poisonTimer = $PoisonTimer
onready var freezeTimer = $FreezeTimer

var inside_state = {
	poisoned = false,
	freezed = false
}

var poison_dmg = 0

export (int) var MAX_HP = 20
var health = MAX_HP setget set_hp

func set_hp(value: int) -> void:
	health = clamp(value, 0, MAX_HP)

func _ready() -> void:
	set_physics_process(false)


# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	modulate = CreatureUtils.get_state_color(inside_state)

	
# warning-ignore:unused_argument
func _on_viewport_entered(viewport: Viewport) -> void:
	set_physics_process(true)


# warning-ignore:unused_argument
func _on_viewport_exited(viewport: Viewport) -> void:
	set_physics_process(false)


func _on_Hurtbox_hit(damage: Dictionary) -> void:
	if damage.has('pure_damage'):
		get_dmg(damage.pure_damage)
	if damage.has('poison'):
		get_poisoned(damage.poison)
	if damage.has('freeze_time'):
		get_frosted(damage.freeze_time)


func _on_PoisonTimer_timeout() -> void:
	get_dmg(poison_dmg)
	inside_state.poisoned = false
	poison_dmg = 0


func _on_FreezeTimer_timeout() -> void:
	inside_state.freezed = false
	animPlayer.playback_speed = 1


func get_dmg(damage_amount: int) -> void:
	Utils.instance_scene_on_main(BloodSpot, global_position)
	health -= damage_amount
	if health <= 0:
		dead()


func get_poisoned(poison: Dictionary):
	inside_state.poisoned = true
	poison_dmg = poison.damage
	poisonTimer.start(poison.delay)


func get_frosted(freeze_time: int):
	inside_state.freezed = true
	animPlayer.playback_speed = animPlayer.playback_speed / 2
	freezeTimer.start(freeze_time)


func dead() -> void:
	set_physics_process(false)
	animPlayer.play("die")
	yield(animPlayer,"animation_finished")
	queue_free()
	
