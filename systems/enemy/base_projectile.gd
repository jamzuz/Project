extends Node2D

class_name base_projectile

var direction : Vector2 = Vector2.RIGHT
@export var speed : float = 150
@export var damage : int = 10
func _physics_process(delta):
	position += direction * speed * delta

#remove projectile on impact instead of this
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_projectile_body_entered(body):
	if body is player_controller:
		PlayerData.take_damage(damage)
		queue_free()
