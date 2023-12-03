extends CharacterBody2D
class_name player_controller

var speed = 100

#region states

enum player_state {IDLE, RUN, HURT, ATTACK}
var current_state : player_state = player_state.IDLE

@onready var anim_tree : AnimationTree = $AnimationTree
func handle_player_state(new_state : player_state):
	if new_state != current_state:
		if new_state == player_state.IDLE:
			current_state = player_state.IDLE
			anim_tree["parameters/conditions/idle"] = true
			anim_tree["parameters/conditions/is_moving"] = false
			anim_tree["parameters/conditions/attacking"] = false
		if new_state == player_state.RUN:
			current_state = player_state.RUN
			anim_tree["parameters/conditions/is_moving"] = true
			anim_tree["parameters/conditions/idle"] = false
			anim_tree["parameters/conditions/attacking"] = false
		if new_state == player_state.ATTACK:
			current_state = player_state.ATTACK
			anim_tree["parameters/conditions/is_moving"] = false
			anim_tree["parameters/conditions/idle"] = false
			anim_tree["parameters/conditions/attacking"] = true
#endregion

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if velocity.length():
		handle_player_state(player_state.RUN)
		$dust.emitting = true
	else:
		handle_player_state(player_state.IDLE)
	
func _input(event):
	if event.is_action_pressed("attack"):
		handle_player_state(player_state.ATTACK)
		$weapon_pivot.look_at(get_global_mouse_position())

func _physics_process(_delta):
	get_input()
	move_and_slide()

func level_up():
	$level_up/Label.visible = true
	$level_up.emitting = true
	$level_up/Label/level_up_timer.start()

func _on_level_up_timer_timeout():
	$level_up/Label.visible = false
