extends Node2D

func _input(event):
	if event.is_action_pressed("interract") and $E.visible:
		get_tree().change_scene_to_file("res://debug/debug.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$E.visible = false

func _on_interract_radius_body_entered(body):
	if body is player_controller:
		$E.visible = true

func _on_interract_radius_body_exited(body):
	if body is player_controller:
		$E.visible = false
