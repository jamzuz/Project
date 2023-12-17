extends Node2D

@onready var timer : Timer = $Timer
var can_attack : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$".".visible = false

func  _input(event):
	if event.is_action_pressed("attack") and can_attack:
		timer.start()
		can_attack = false
		$sword_anims.play("attack_2")
	if event.is_action_pressed("special_attack") and can_attack:
		$sword_anims.play("special")
		timer.start()
		can_attack = false
		



func _on_timer_timeout():
	can_attack = true
