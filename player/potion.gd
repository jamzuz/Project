extends Area2D



func _on_body_entered(body):
	if body is player_controller and PlayerData.potions < 10:
		PlayerData.potion_gained()
		queue_free()
