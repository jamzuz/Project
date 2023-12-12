extends enemy_component

var projectile : PackedScene = preload("res://Enemy/enemy_projectile.tscn")

func shoot():
	var instanced_projectile = projectile.instantiate()
	instanced_projectile.position = position
	instanced_projectile.direction = position.direction_to(target.global_position).normalized()
	get_tree().current_scene.add_child(instanced_projectile)
	instanced_projectile.look_at(target.position)
