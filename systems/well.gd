extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$E.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_press_e_body_entered(body):
	if body is player_controller:
		$E.visible = true



func _on_press_e_body_exited(body):
	if body is player_controller:
		$E.visible = false
