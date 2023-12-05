extends Marker2D
class_name mob_spawner

@export var area_level : int
var mob_type = preload("res://Enemy/mob_base.tscn")

func _ready():
	var chance = randi_range(1,100)
	if chance < 40:
		var mob_spawn : mob = mob_type.instantiate()
		mob_spawn.ranged = true
		mob_spawn.model = 0
		get_tree().current_scene.get_parent().add_child(mob_spawn)
		mob_spawn.position = position
