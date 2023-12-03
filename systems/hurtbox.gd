extends Area2D
class_name hurtbox

@export var damage : int

func _on_area_entered(area):
	if area is hitbox:
		var target : hitbox = area
		var hit_damage = roundi(damage * PlayerData.level_multiplier)
		hit_damage = damage + randi_range(2, (PlayerData.level * 2)) * PlayerData.level_multiplier
		target.damage(hit_damage)
