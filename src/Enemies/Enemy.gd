extends KinematicBody2D

# current problem that enimies are the same
# now as a c1 user i want to make range enemy
# and maybe stand cannon enemy
# so it should be one global Enemy component
# and to inherit from it MeleeEnemy RangeEnemy and StandEnemy
# and to stay it as flexible as it could be, so we can extend him
# later with new feachers

#Enemies should be different

const ManaPotion = preload("res://src/Items/ManaPotion.tscn")
const HealPotion = preload("res://src/Items/HealthPotion.tscn")
const Coin = preload("res://src/Items/Coin.tscn")

const BloodSpot = preload("res://src/Effects/BloodSpot.tscn")

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer

onready var poisonTimer = $PoisonTimer
onready var freezeTimer = $FreezeTimer

export (int) var MAX_HP = 20
export (int) var MAX_SPEED = 40
export (int) var direction = 1


var SPEED = MAX_SPEED
var velocity = Vector2.ZERO
var moves = ['horizontal', 'vertical']
var current_move = moves[rand_range(0,2)]

var poisoned = false
var freezed = false

var poison_dmg = 0

var MainInstances = ResourceLoader.MainInstances

enum {
	IDLE,
	WALKING,
	CHASING
}
var state = IDLE;

var health = MAX_HP setget set_hp

func set_hp(value) -> void:
	health = clamp(value, 0, MAX_HP)

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	var player = MainInstances.Player
	
	if poisoned and freezed:
		modulate = Color8(255, 255, 0, 255)
	elif poisoned:
		modulate = Color8(0, 255, 0, 255)
	elif freezed:
		modulate = Color8(0, 0, 255, 255)
	else:
		modulate = Color8(255, 255, 255, 255)

	match state:
		WALKING:
			walking(delta)
			animPlayer.play("run")
		CHASING:
			chase_player(player, delta)
			animPlayer.play("run")
		IDLE:
			animPlayer.play('idle')


func dead():
	velocity = Vector2.ZERO
	set_physics_process(false)
	animPlayer.play("die")
	yield(animPlayer,"animation_finished")
	stayLoot()
	queue_free()

func stayLoot():
	var loots = [ManaPotion.instance(), HealPotion.instance(), Coin.instance()]
	var loot = loots[rand_range(0,3)]
	get_parent().add_child(loot)
	loot.position = global_position

func get_dmg(dmg_val: int):
	Utils.instance_scene_on_main(BloodSpot, global_position)
	health -= dmg_val
	if health <= 0:
		dead()

func get_poisoned(psn_dmg: int):
	poisoned = true
	poison_dmg = psn_dmg
	poisonTimer.start(1.5)
	
func get_frosted(freeze_time: int):
	freezed = true
	SPEED = SPEED / 4
	freezeTimer.start(freeze_time)

func _on_DirectionTimer_timeout():
	current_move = moves[rand_range(0,2)]

func _on_Hurtbox_hit(damage_obj: Dictionary) -> void:
	if damage_obj.has('pure_damage'):
		get_dmg(damage_obj.pure_damage)
	if damage_obj.has('poison_damage'):
		get_poisoned(damage_obj.poison_damage)
	if damage_obj.has('freeze_time'):
		get_frosted(damage_obj.freeze_time)
		
func chase_player(player, delta):
	if state == CHASING and player != null:
		var direction = (player.global_position - global_position)
		velocity += direction * SPEED * delta
		velocity = velocity.clamped(SPEED * rand_range(1.3, 1.7))
		sprite.flip_h = global_position > player.global_position
		velocity = move_and_slide(velocity) 
	
func walking(delta):
	if is_on_wall():
		direction = direction * -1
		
	if current_move == 'horizontal':
		velocity = Vector2(SPEED * direction, 0)
	elif current_move == 'vertical':
		velocity = Vector2(0, SPEED * direction)
		
	if direction == 1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	velocity = move_and_slide(velocity, Vector2.ZERO)


func _on_VisibilityNotifier2D_screen_entered():
	state = WALKING
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	state = IDLE
	set_physics_process(false)

func _on_Vision_body_entered(body: Node) -> void:
	state = CHASING

func _on_Vision_body_exited(body: Node) -> void:
	state = WALKING

func _on_PoisonTimer_timeout() -> void:
	get_dmg(poison_dmg)
	poisoned = false
	poison_dmg = 0
	
func _on_FreezeTimer_timeout() -> void:
	SPEED = MAX_SPEED
	freezed = false
