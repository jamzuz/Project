extends CharacterBody2D
class_name player_controller

var speed = 100

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if velocity.length():
		$dust.emitting = true
	
func _input(event):
	if event.is_action_pressed("attack"):
		$weapon_pivot.look_at(get_global_mouse_position())

func _physics_process(delta):
	get_input()
	move_and_slide()

func level_up():
	$level_up/Label.visible = true
	$level_up.emitting = true
	$level_up/Label/level_up_timer.start()

func _on_level_up_timer_timeout():
	$level_up/Label.visible = false
