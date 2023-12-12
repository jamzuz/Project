extends CharacterBody2D
class_name enemy_component

@onready var enemy_sprite : Sprite2D = $enemy_sprite
@onready var pathfinding : NavigationAgent2D = $pathfinding
@onready var pathfinding_timer : Timer = $pathfinding/pathfinding_timer
@export var enemy_sprite_frame : int = 0
@export var enemy_speed : int = 20
@export var enemy_health : int = 100
@export var preferred_distance_to_target : int = 20
@export var detection_radius : float = 100.0

var attack_is_on_cooldown = false

var target : player_controller = null
var last_known_location : Vector2 = Vector2(0,0)
var target_seen : bool = false

func _ready():
	target = PlayerData.player
	enemy_sprite.frame = enemy_sprite_frame
	
func _physics_process(_delta):
	if target:
		$pivot.look_at(target.position)
#stop if close
	if position.distance_to(target.position) < preferred_distance_to_target:
		velocity = Vector2(0,0)
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


func _on_attack_cooldown_timeout():
	attack_is_on_cooldown = false
