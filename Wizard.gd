extends KinematicBody2D

# TODO:
# bagfix with poison and frozenball, it destroyed with no dealing damage
# make each enemy in its own directory and make the same collission with one resource
# V make health/mana potionts
# V make drop from enemies (potions/coins)
# V make coins
# V make UI of coins
# V make UI of spells
# clear unused files
# V bagfix balls on walls
# bagfix errors with frostball and poisonball
# V make spikes
# necromancer boss fight with raising skeletons
# player can be poisoned and frosted
# math work hp, damage, speed etc 
# player die animations
# enemies with weapons
# range enemies
# V make Utils singleton with addOnScene and getPercent
# make diagonal firespell
# V particles on balls
# V clean up blood and add on any hit
# make doors
# prevent deathball on last health
# V bagfix UI hurts
# V cycle dealing damege if enemy still near


onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer
onready var blinkAnimation = $BlinkAnimation
onready var speellPosition = $SpellPosition
onready var invTimer = $InvTimer

const FIREBALL = preload("res://src/Spells/FireBall.tscn")
const FROSTBALL = preload("res://src/Spells/FrostBall.tscn")
const DEATHBALL = preload("res://src/Spells/DeathBall.tscn")
const POISONBALL = preload("res://src/Spells/PoisonBall.tscn")

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

var invincible = false setget set_invincible
export (int) var SPEED = 50
var velocity = Vector2.ZERO
var desired_x = 0
var desired_y = 0
var can_fire = true

var freezed = false
var poisoned = false

signal hit_door(door)

func set_invincible(value: bool) -> void:
	invincible = value

func _ready() -> void:
	PlayerStats.connect('player_died', self, "_on_died")
	MainInstances.Player = self
	
func _exit_tree():
	MainInstances.Player = null

func _input(event: InputEvent) -> void:
	if event.is_action("go_left"):
		if event.is_pressed():
			desired_x = -SPEED
			sprite.flip_h = true
			animPlayer.play("run")
		elif desired_x < 0:
			desired_x = 0
			animPlayer.play("idle")
	if event.is_action("go_right"):
		if event.is_pressed():
			desired_x = SPEED
			sprite.flip_h = false
			animPlayer.play("run")
		elif desired_x > 0:
			desired_x = 0
			animPlayer.play("idle")
			
	if event.is_action("go_up"):
		if event.is_pressed():
			desired_y = -SPEED
			animPlayer.play("run")
		elif desired_y < 0:
			desired_y = 0
			animPlayer.play("idle")
	if event.is_action("go_down"):
		if event.is_pressed():
			desired_y = SPEED
			animPlayer.play("run")
		elif desired_y > 0:
			desired_y = 0
			animPlayer.play("idle")
			
	if can_fire == true:
		if event.is_action_pressed("fire_right"):
			sprite.flip_h = false
			fire_spell(Vector2(12, 0))
		
		if event.is_action_pressed("fire_left"):
			sprite.flip_h = true
			fire_spell(Vector2(-12, 0))
				
		if event.is_action_pressed("fire_up"):
			fire_spell(Vector2(0, -12))
				
		if event.is_action_pressed("fire_down"):
			fire_spell(Vector2(0, 12))
			
	if event.is_action_pressed("spell_1"):
		PlayerStats.spell = FIREBALL
	
	if event.is_action_pressed("spell_2"):
		PlayerStats.spell = FROSTBALL
			
	if event.is_action_pressed("spell_3"):
		PlayerStats.spell = POISONBALL
	
	if event.is_action_pressed("spell_4"):
		PlayerStats.spell = DEATHBALL
		
	if event.is_action_pressed("drink_hp_potion"):
		if PlayerStats.hp_potions > 0:
			PlayerStats.hp_potions -= 1
			PlayerStats.health += 7
		
	if event.is_action_pressed("drink_mana_potion"):
		if PlayerStats.mana_potions > 0:
			PlayerStats.mana_potions -= 1
			PlayerStats.mana += 10
			
	if event.is_action_pressed("make_hp_potion"):
		if PlayerStats.coins > 1:
			PlayerStats.hp_potions += 1
			PlayerStats.coins -= 2
	
	if event.is_action_pressed("make_mana_potion"):
		if PlayerStats.coins > 1:
			PlayerStats.mana_potions += 1
			PlayerStats.coins -= 2

func fire_spell(vector_postion: Vector2) -> void:
	if PlayerStats.mana > 0 || PlayerStats.spell == DEATHBALL:
		speellPosition.position = vector_postion
		var ballSpell = PlayerStats.spell.instance()
		ballSpell.set_ball_direction(speellPosition.position)
		get_parent().add_child(ballSpell)
		ballSpell.position = speellPosition.global_position
		if PlayerStats.spell == DEATHBALL:
			PlayerStats.health -= 1
		else:
			PlayerStats.mana -= 1
		can_fire = false
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(desired_x, desired_y)
	velocity = move_and_slide(velocity, Vector2())
	
	if poisoned and freezed:
		modulate = Color8(255, 255, 0, 255)
	elif poisoned:
		modulate = Color8(0, 255, 0, 255)
	elif freezed:
		modulate = Color8(0, 0, 255, 255)
	else:
		modulate = Color8(255, 255, 255, 255)


func get_dmg(dmg):
	PlayerStats.health -= dmg
	Events.emit_signal("add_screen_shake", 0.75, 0.25)

func get_poisoned(poison):
	poisoned = true
	yield(get_tree().create_timer(poison.delay), "timeout")
	get_dmg(poison.damage)
	poisoned = false

func get_frosted(freeze_time):
	freezed = true
	var temp_speed = SPEED
	SPEED = SPEED / 2
	yield(get_tree().create_timer(freeze_time), "timeout")
	SPEED = temp_speed
	freezed = false

func _on_Hurtbox_hit(damage_obj) -> void:
	if not invincible:
		if damage_obj.has('pure_damage'):
			get_dmg(damage_obj.pure_damage)
			blinkAnimation.play("blink")
			invincible = true
			invTimer.start()
		if damage_obj.has('poison') and not poisoned:
			get_poisoned(damage_obj.poison)
		if damage_obj.has('freeze_time') and not freezed:
			get_frosted(damage_obj.freeze_time)

func _on_died():
	queue_free()

func _on_InvTimer_timeout() -> void:
	invincible = false
