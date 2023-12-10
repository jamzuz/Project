extends Node

var player_scene : PackedScene = preload("res://player/player.tscn")
var player : player_controller = null
var ui_scene : PackedScene = preload("res://hud.tscn")
var user_interface : hud = null
var armor : int = 0
var hp : int = 100
var max_hp : int = 100
var base_hp : int = 100
var xp : int = 0
var xp_to_level : int = 30
var level : int = 1
var level_multiplier : float  = 1.05
var gold : int = 0
var potions : int = 0
var well_location : Vector2 = Vector2(0,0)

func _ready():
	create_player_instance()

func restart():
	hp = 100
	max_hp = 100
	base_hp = 100
	xp = 0
	xp_to_level = 50
	level = 1
	level_multiplier = 1.05
	gold = 0
	get_tree().call_deferred("change_scene_to_file","res://debug/debug.tscn")

func create_player_instance():
	player = player_scene.instantiate()
	user_interface = ui_scene.instantiate()

func spawn_player(spawn_position : Vector2 = Vector2(430,300)):
	if !player:
		create_player_instance() 
	get_tree().current_scene.add_child(player)
	player.add_child(user_interface)
	player.position = spawn_position

func gain_xp(amount):
	xp += amount
	if xp >= xp_to_level:
		level_up()
	user_interface.update_xp()
	user_interface.update_hp()

func gain_gold(amount : int):
	gold = gold + amount
	user_interface.update_gold()

func use_gold(amount : int):
	gold = gold - amount
	user_interface.update_gold()


func level_up():
	player.level_up()
	level += 1
	level_multiplier += 0.05
	user_interface.update_level()
	xp = xp - xp_to_level
	xp_to_level = roundi(xp_to_level * level_multiplier)
	base_hp += 5
	max_hp = roundi(base_hp * level_multiplier)
	hp = max_hp
	user_interface.update_xp()
	user_interface.update_hp()
	if xp >= xp_to_level :
		level_up()

func take_damage(amount):
	hp -= (amount - armor)
	player.get_hurt()
	if hp < 1:
#fix this shit
		get_tree().paused = true
		for x in get_tree().get_nodes_in_group("mob"):
			x.call_deferred("queue_free")
		get_tree().call_deferred("change_scene_to_file","res://debug/dead.tscn")
	else:
		user_interface.update_hp()

func heal(amount: int):
	if hp + amount > max_hp:
		hp = max_hp
	else:
		hp += (amount + hp)
	user_interface.update_hp()

func potion_gained():
	if potions < 10:
		potions += 1
		user_interface.update_potion()

func use_potion():
	potions -= 1
	heal(100)
	user_interface.update_potion()

