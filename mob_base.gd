extends CharacterBody2D
class_name mob

@export var model : int = 0
@export var detection_radius : float = 100.0
@export var level : int = 1
@export var speed : int = 40

@onready var nav : NavigationAgent2D = $nav_agent
@onready var anim : AnimationTree = $mob_anims/AnimationTree
var xp_dropped : PackedScene = preload("res://systems/xp/xp_drop.tscn")
var target : player_controller = null


func _physics_process(_delta):
	if target:
		if position.distance_to(target.position) > 20:
			var next_path_position: Vector2 = nav.get_next_path_position()
			velocity = position.direction_to(next_path_position) * speed
			move_and_slide()
			anim["parameters/conditions/is_moving"] = true
			anim["parameters/conditions/idle"] = false
		else:
			anim["parameters/conditions/is_moving"] = false
			anim["parameters/conditions/idle"] = true

func _ready():
	$model_sprite.frame = model
	$detection/detection_range.shape.radius = detection_radius

func _on_detection_body_entered(body):
	if body is player_controller:
		target = body
		$nav_agent/nav_timer.start()
		
#func _on_detection_body_exited(body):
	#if body is player_controller:
		#target = null

func die():
	var drop : xp_drop = xp_dropped.instantiate()
	get_tree().current_scene.get_parent().add_child(drop)
	drop.position = position
	drop.xp_amount = level * 10
	queue_free()


func _on_nav_timer_timeout():
	if target:
		nav.target_position = target.position

func _on_hitbox_got_hit():
		anim["parameters/conditions/is_moving"] = false
		anim["parameters/conditions/idle"] = false
		anim["parameters/conditions/hit"] = true
