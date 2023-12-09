extends Node2D
@onready var spawns = [
	$spawn.position,
	$spawn2.position,
	$spawn3.position
]
func _ready():
	PlayerData.well_location = $town_portal.position
	PlayerData.spawn_player(spawns.pick_random())
