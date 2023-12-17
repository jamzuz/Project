extends Marker2D
class_name mob_spawner

@export var area_level : int
@export var spawn_chance : int = 70
var mage = preload("res://Enemy/mage_enemy.tscn")
var skeleton = preload("res://Enemy/skeleton.tscn")

func _ready():
	$Timer.start()

func _on_timer_timeout():
	var chance = randi_range(1,100)
	var mob_spawn = null
	if chance < spawn_chance:
		var mob_type = randi_range(1, 2)
		if mob_type == 1:
			mob_spawn = mage.instantiate()
		elif mob_type == 2:
			mob_spawn = skeleton.instantiate()
		get_tree().current_scene.get_parent().call_deferred("add_child",mob_spawn)
		mob_spawn.position = position
