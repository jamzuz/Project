extends Area2D

@export var xp_amount : int

func _on_body_entered(body):
	if body is player_controller:
		PlayerData.gain_xp(xp_amount)
		queue_free()
