extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 150
var damage_dealt = false 

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is player_controller and !damage_dealt:
		damage_dealt = true
		PlayerData.take_damage(10)
