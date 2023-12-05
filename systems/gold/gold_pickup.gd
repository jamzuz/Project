extends Area2D
class_name gold_drop
@export var gold_amount : int

func _on_body_entered(body):
	if body is player_controller:
		PlayerData.gain_gold(gold_amount)
		queue_free()
