extends CharacterBody2D
class_name enemy_component

@onready var enemy_sprite : Sprite2D = $enemy_sprite
@onready var pathfinding : NavigationAgent2D = $pathfinding
@onready var pathfinding_timer : Timer = $pathfinding/pathfinding_timer
@onready var attack_cooldown : Timer = $attack_cooldown

var xp_dropped : PackedScene = preload("res://systems/xp/xp_drop.tscn")
var gold_dropped : PackedScene = preload("res://systems/gold/gold_pickup.tscn")
var potion : PackedScene = preload("res://player/potion.tscn")

@export var attack_cooldown_time : float = 1.00
@export var enemy_sprite_frame : int = 0
@export var preferred_distance_to_target : int = 20
@export var detection_radius : float = 100.0

@export var enemy_health : int = 100
@export var level : int = 1
@export var enemy_speed : int = 20

var attack_is_on_cooldown = false

var target : player_controller = null
var last_known_location : Vector2 = Vector2(0,0)
var target_seen : bool = false

signal can_attack

func _ready():
	#enemy_health = enemy_health * level
	target = PlayerData.player
	enemy_sprite.frame = enemy_sprite_frame
	attack_cooldown.wait_time = attack_cooldown_time
	
func _physics_process(_delta):
	if is_instance_valid(target):
		$pivot.call_deferred("look_at",target.position)
	#stop if close
		if position.distance_to(target.position) < preferred_distance_to_target and target_seen:
			if !attack_is_on_cooldown:
				velocity = Vector2(0,0)
				attack_is_on_cooldown = true
				can_attack.emit()
				attack_cooldown.start()
	#else follow pathfinding
		elif !pathfinding.is_target_reached():
			var next_path_position: Vector2 = pathfinding.get_next_path_position()
			velocity =  position.direction_to(next_path_position) * enemy_speed
			move_and_slide()



#region pathfinding

func _on_pathfinding_timer_timeout():
	if target_seen:
		pathfinding.target_position = target.position
	else:
		pathfinding.target_position = last_known_location

func _on_pathfinding_navigation_finished():
	pathfinding.target_position = position
	pathfinding_timer.stop()

func _on_detection_player_detected():
	pathfinding.target_position = target.position
	pathfinding_timer.start()
	target_seen = true

func _on_detection_player_lost():
	if target_seen:
		last_known_location = target.position
		target_seen = false
#endregion

func die():
	var xpdrop : xp_drop = xp_dropped.instantiate()
	get_tree().current_scene.get_parent().add_child(xpdrop)
	xpdrop.position = position
	xpdrop.xp_amount = level * 10
	
	var drop_chance = randi_range(1,100)
	if drop_chance < 60:
		var golddrop : gold_drop = gold_dropped.instantiate()
		get_tree().current_scene.get_parent().add_child(golddrop)
		golddrop.position = position+Vector2(randf_range(-10, 10), randf_range(-10, 10))
		golddrop.gold_amount = level + randi_range(1,10)
	if drop_chance < 20:
		var potiondrop = potion.instantiate()
		get_tree().current_scene.get_parent().add_child(potiondrop)
		potiondrop.position = position+Vector2(randf_range(-10, 10), randf_range(-10, 10))
	queue_free()

func _on_attack_cooldown_timeout():
	attack_is_on_cooldown = false
