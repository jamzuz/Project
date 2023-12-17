extends enemy_component

var projectile : PackedScene = preload("res://systems/enemy/fireball.tscn")

func spell():
	var instanced_projectile = projectile.instantiate()
	instanced_projectile.position = position
	instanced_projectile.direction = position.direction_to(PlayerData.player.global_position).normalized()
	get_tree().current_scene.add_child(instanced_projectile)

func _on_can_attack():
	spell()
