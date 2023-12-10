extends Control
class_name ui

var hp : int
var hp_max : int
var maxhp : int
var xp : int
var xp_to_level : int
var potion_amount : int

func _ready():
	hp = PlayerData.hp
	hp_max = PlayerData.max_hp
	xp = PlayerData.xp
	xp_to_level = PlayerData.xp_to_level
	set_hp()
	set_level()

func set_hp(hp_amount = hp, maxhp_amount = hp_max):
	hp = hp_amount
	hp_max = maxhp_amount
	$hp/hpbar.value = hp
	$hp/hpbar.max_value = hp_max
	$hp/hp_amount.text = str(hp) +"/"+ str(hp_max)
	
func set_xp(xp_amount = xp,xp_to_level_amount = xp_to_level):
	xp = xp_amount
	xp_to_level = xp_to_level_amount
	$xp/xp_amount.text = str(xp) +"/"+ str(xp_to_level)
	
func set_gold():
	$gold.text = "gold:"+ str(PlayerData.gold)
	
func set_level():
	$xp/level.text = "level:" + str(PlayerData.level)

func set_potions():
	potion_amount = PlayerData.potions
	$potion/potion_amount.text = str(potion_amount)

func update_dialogue(text_in : String):
	$chat/chatbox.text = text_in
