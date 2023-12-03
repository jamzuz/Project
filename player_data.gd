extends Node

var player_scene : PackedScene = preload("res://player/player.tscn")
var player : player_controller = null
var ui_scene : PackedScene = preload("res://UI/ui.tscn")
var user_interface : ui = null
var canvas : CanvasLayer = CanvasLayer.new()
var hp : int
var max_hp : int
var xp : int
var xp_to_level : int
var level : int
var level_multiplier : float 
var gold : int 

func _ready():
	create_player_instance()
	call_deferred("spawn_player")
		
func create_player_instance():
	if player == null:
		hp = 100
		max_hp = 100
		xp = 0
		xp_to_level = 100
		level = 1
		level_multiplier = 1.05
		gold = 0
	player = player_scene.instantiate()
	user_interface = ui_scene.instantiate()
	user_interface.set_hp(hp, max_hp)
	user_interface.set_xp(xp, xp_to_level)

func spawn_player():
	get_tree().current_scene.add_child(player)
	canvas.add_child(user_interface)
	player.add_child(canvas)
	player.position = Vector2(430,300)

func gain_xp(amount):
	xp += amount
	if xp >= xp_to_level:
		level_up()
	user_interface.set_xp(xp, xp_to_level)
	user_interface.set_hp(hp, max_hp)

func level_up():
	player.level_up()
	level += 1
	user_interface.set_level()
	level_multiplier += 0.05
	xp = xp - xp_to_level
	xp_to_level = xp_to_level * level_multiplier
	max_hp = max_hp * level_multiplier
	hp = max_hp
	if xp >= xp_to_level :
		level_up()

func take_damage(amount):
	hp -= amount
	if hp < 1:
		print("haha you dead")
	user_interface.set_hp(hp, max_hp)
