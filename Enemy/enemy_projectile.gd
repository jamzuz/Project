extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 150

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is player_controller:
		PlayerData.take_damage(10)
		queue_free()
