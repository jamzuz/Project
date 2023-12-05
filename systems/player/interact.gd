extends Area2D

signal interact

func _input(event):
	if event.is_action_pressed("interract") and $E.visible:
		interact.emit()

func _ready():
	$E.visible = false
	$Panel.visible = false
func _on_body_entered(body):
	if body is player_controller:
		$E.visible = true
		$Panel.visible = true

func _on_body_exited(body):
	if body is player_controller:
		$E.visible = false
		$Panel.visible = false
