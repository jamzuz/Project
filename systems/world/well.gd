extends Node2D

func _on_interact_interact():
	get_tree().call_deferred("change_scene_to_file","res://levels/level_1.tscn")
