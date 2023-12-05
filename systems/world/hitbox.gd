extends Area2D
class_name hitbox

@export var mob_hp : int = 50
@onready var hp_bar : ProgressBar = $hp_bar
signal got_hit

func _ready():
	hp_bar.max_value = mob_hp
	hp_bar.value = mob_hp

	
func damage(amount : int):
	got_hit.emit()
	mob_hp = mob_hp - amount
	hp_bar.value = mob_hp
	if mob_hp < 1:
		get_parent().call_deferred("die")

