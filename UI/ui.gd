extends Control
class_name ui

var hp : int
var xp : int

func set_hp(amount):
	hp = amount
	$hp/hp_amount.text = ":" + str(hp)
	
func set_xp(amount):
	xp = amount
	$xp/xp_amount.text = ":" + str(xp)
