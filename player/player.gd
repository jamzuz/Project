class_name player_controller extends CharacterBody2D

var speed = 100

#region states

enum player_state {IDLE, RUN, HURT, ATTACK}
var current_state : player_state = player_state.IDLE
@onready var sprite = $sprite
@onready var anim_tree : AnimationTree = $AnimationTree
@onready var arrow = $arrow
@onready var timer : Timer = $Timer
var can_attack : bool = true

var well = null
func handle_player_state(new_state : player_state):
		if new_state == player_state.IDLE:
			current_state = player_state.IDLE
			anim_tree["parameters/conditions/idle"] = true
			anim_tree["parameters/conditions/is_moving"] = false
			anim_tree["parameters/conditions/hit"] = false
		if new_state == player_state.RUN:
			current_state = player_state.RUN
			anim_tree["parameters/conditions/idle"] = false
			anim_tree["parameters/conditions/is_moving"] = true
			anim_tree["parameters/conditions/hit"] = false
		if new_state == player_state.HURT:
			current_state = player_state.HURT
			anim_tree["parameters/conditions/idle"] = false
			anim_tree["parameters/conditions/is_moving"] = false
			anim_tree["parameters/conditions/hit"] = true
#endregion

func _ready():
	#if PlayerData.level < 7:
		#sprite.frame = PlayerData.level -1
	call_deferred("handle_player_state",player_state.IDLE)
	well = get_tree().current_scene.find_child("town_portal")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if can_attack:
		velocity = input_direction * speed
	elif !can_attack:
		velocity = input_direction * speed / 2
	if velocity.length():
		if current_state != player_state.HURT :
			handle_player_state(player_state.RUN)
	else:
		if current_state != player_state.HURT:
			handle_player_state(player_state.IDLE)

func get_hurt():
	handle_player_state(player_state.HURT)
	
func _input(event):
	if event.is_action_pressed("attack") and can_attack:
		#handle_player_state(player_state.ATTACK)
		can_attack = false
		timer.start()
		$weapon_pivot.look_at(get_global_mouse_position())
	if event.is_action_pressed("special_attack") and can_attack:
		$weapon_pivot.look_at(get_global_mouse_position())
		can_attack = false
		timer.start()
	if event.is_action_pressed("potion") and PlayerData.potions > 0 and PlayerData.hp != PlayerData.max_hp:
		PlayerData.use_potion()
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(_delta):
	
	arrow.look_at(PlayerData.well_location)
	get_input()
	move_and_slide()
func level_up():
	$level_up/Label.visible = true
	$level_up.emitting = true
	$level_up/Label/level_up_timer.start()
	#Dialogue.add_dialogue("Level up!")
	#if PlayerData.level < 7:
		#sprite.frame = PlayerData.level

func light_on():
	$lighting.visible = true

func _on_level_up_timer_timeout():
	$level_up/Label.visible = false



func _on_timer_timeout():
	can_attack = true
