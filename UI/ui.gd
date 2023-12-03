extends Control
class_name ui

var hp : int
var maxhp : int
var xp : int
var xp_to_level : int

func set_hp(hp_amount, maxhp_amount):
	hp = hp_amount
	$hp/hp_amount.text = str(hp) +"/"+ str(maxhp_amount)
	$hp/hpbar.value = hp
	$hp/hpbar.max_value = maxhp_amount
	
func set_xp(xp_amount,xp_to_level_amount):
	xp = xp_amount
	xp_to_level = xp_to_level_amount
	$xp/xp_amount.text = str(xp) +"/"+ str(xp_to_level)
	
func set_level():
	$xp/level.text = "level:" + str(PlayerData.level)
