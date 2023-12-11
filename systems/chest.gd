extends Node2D
class_name chest

var opened : bool = false
var loot : PackedScene = preload("res://player/potion.tscn")

func _on_interact_interact():
	if !opened:
		opened = true
#remove interract
		remove_child($interact)
#change sprite to opened
		$chest_sprite.frame = 1
		var drop = loot.instantiate()
		get_tree().current_scene.get_parent().add_child(drop)
		drop.position = position+Vector2(randf_range(-20, 20), randf_range(-20, 20))
