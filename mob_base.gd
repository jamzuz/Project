extends CharacterBody2D
class_name mob

@export var model : int = 0
@export var detection_radius : float = 100.0
@export var level : int = 1
@export var speed : int = 20
@export var ranged : bool = false
@onready var nav : NavigationAgent2D = $nav_agent
@onready var anim : AnimationTree = $mob_anims/AnimationTree
var xp_dropped : PackedScene = preload("res://systems/xp/xp_drop.tscn")
var gold_dropped : PackedScene = preload("res://systems/gold/gold_pickup.tscn")
var projectile : PackedScene = preload("res://Enemy/enemy_projectile.tscn")
var target : player_controller = null

func _physics_process(_delta):
	if target and ranged:
		if position.distance_to(target.position) > 79 and anim["parameters/conditions/shoot"] == false:
			var next_path_position: Vector2 = nav.get_next_path_position()
			velocity = position.direction_to(next_path_position) * speed
			move_and_slide()
			anim["parameters/conditions/is_moving"] = true
		if position.distance_to(target.position) < 80 and anim["parameters/conditions/shoot"] == false:
			velocity = Vector2(0,0)
			anim["parameters/conditions/shoot"] = true

func shoot():
	var instanced_projectile = projectile.instantiate()
	instanced_projectile.position = position
	instanced_projectile.direction = position.direction_to(target.global_position).normalized()
	get_tree().current_scene.add_child(instanced_projectile)
	instanced_projectile.look_at(target.position)

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
	var offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
	var xpdrop : xp_drop = xp_dropped.instantiate()
	get_tree().current_scene.get_parent().add_child(xpdrop)
	xpdrop.position = position
	xpdrop.xp_amount = level * 10
	
	var drop_chance = randi_range(1,100)
	if drop_chance < 60:
		var golddrop : gold_drop = gold_dropped.instantiate()
		get_tree().current_scene.get_parent().add_child(golddrop)
		golddrop.position = position+offset
		golddrop.gold_amount = level + randi_range(1,10)
	
	queue_free()

func _on_nav_timer_timeout():
	if target:
		nav.target_position = target.position

func _on_hitbox_got_hit():
		anim["parameters/conditions/is_moving"] = false
		anim["parameters/conditions/idle"] = false
		anim["parameters/conditions/shoot"] = false
		anim["parameters/conditions/hit"] = true
