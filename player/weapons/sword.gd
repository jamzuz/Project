extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".visible = false

func  _input(event):
	if event.is_action_pressed("attack"):
		$sword_anims.play("attack")
