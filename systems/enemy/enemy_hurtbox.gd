extends Area2D
class_name enemy_hurtbox

@export var damage : int

func _on_body_entered(body):
	if body is player_controller:
		PlayerData.take_damage(damage)
