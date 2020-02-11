extends KinematicBody2D

const BloodSpot = preload("res://src/Effects/BloodSpot.tscn")
const ManaPotion = preload("res://src/Items/ManaPotion.tscn")
const HealPotion = preload("res://src/Items/HealthPotion.tscn")
const Coin = preload("res://src/Items/Coin.tscn")
const Bullet = preload("res://src/Enemies/Bullet.tscn")

var MainInstances = ResourceLoader.MainInstances

onready var sprite: = $Sprite
onready var animPlayer: = $AnimationPlayer
onready var strikeTimer: = $StrikeTimer

export (int) var MAX_HP = 20
export (int) var SPEED = 40
export (int) var direction = 1

var velocity = Vector2.ZERO
var moves = ['horizontal', 'vertical']
var current_move = moves[rand_range(0,2)]

var health = MAX_HP setget set_hp

func set_hp(value) -> void:
	health = clamp(value, 0, MAX_HP)

enum {
	IDLE,
	WALKING,
	STRIKING,
	CHASING
}

var can_fire = true
var state = IDLE;

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	var player = MainInstances.Player
	
	match state:
		WALKING:
			walking(delta)
			animPlayer.play("run")
		STRIKING:
			strike(player, delta)
			animPlayer.play("idle")
		IDLE:
			animPlayer.play('idle')

func _on_DirectionTimer_timeout() -> void:
	current_move = moves[rand_range(0,2)]

func _on_VisibilityNotifier2D_screen_entered() -> void:
	state = WALKING
	set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	state = IDLE
	set_physics_process(false)

func _on_Vision_body_entered(body: Node) -> void:
	state = STRIKING
	strikeTimer.start()
	

func _on_Vision_body_exited(body: Node) -> void:
	state = WALKING
	strikeTimer.stop()
	can_fire = true
	

func _on_Hurtbox_hit(damage_obj: Dictionary) -> void:
	if damage_obj.has('pure_damage'):
		get_dmg(damage_obj.pure_damage)
	if damage_obj.has('poison_damage'):
		get_poisoned(damage_obj.poison_damage)
	if damage_obj.has('freeze_time'):
		get_frosted(damage_obj.freeze_time)

func _on_StrikeTimer_timeout() -> void:
	can_fire = true

func strike(player, delta) -> void:
	if can_fire == true and player != null:
		var direction = (player.global_position - global_position)
		var bullet_velocity = direction * 60 * delta
		sprite.flip_h = global_position > player.global_position
		var bullet = Bullet.instance()
		bullet.set_bullet(direction, bullet_velocity)
		get_parent().add_child(bullet)
		bullet.position = global_position
		can_fire = false
	

func dead() -> void:
	velocity = Vector2.ZERO
	set_physics_process(false)
	animPlayer.play("die")
	yield(animPlayer,"animation_finished")
	stayLoot()
	queue_free()

func stayLoot() -> void:
	var loots = [ManaPotion.instance(), HealPotion.instance(), Coin.instance()]
	var loot = loots[rand_range(0,3)]
	get_parent().add_child(loot)
	loot.position = global_position

func get_dmg(dmg_val: int) -> void:
	Utils.instance_scene_on_main(BloodSpot, global_position)
	health -= dmg_val
	if health < 0:
		dead()

func get_poisoned(poison_dmg: int) -> void:
	modulate = Color8(0, 255, 0, 255)
	yield(get_tree().create_timer(1.5), "timeout")
	get_dmg(poison_dmg)
	modulate = Color8(255, 255, 255, 255)
	
func get_frosted(freeze_time: int) -> void:
	var temp_speed = SPEED
	SPEED = 10
	modulate = Color8(0, 0, 255, 255)
	yield(get_tree().create_timer(freeze_time), "timeout")
	SPEED = temp_speed
	modulate = Color8(255, 255, 255, 255)

func walking(delta) -> void:
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
	
	velocity = move_and_slide(velocity, Vector2())
