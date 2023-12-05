extends Node2D

func _on_interact_interact():
	for x in get_tree().get_nodes_in_group("mob"):
		x.queue_free()
	get_tree().call_deferred("change_scene_to_file","res://debug/debug.tscn")
