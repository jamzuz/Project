extends Node2D
@onready var spawns = [
	$NavigationRegion2D/spawn.position,
	$NavigationRegion2D/spawn2.position,
	$NavigationRegion2D/spawn3.position
]
#var random_rotations : Array[float] = [
	#0,
	#90,
	#180
#]

func _ready():
	#$NavigationRegion2D.rotation_degrees = random_rotations.pick_random()
	PlayerData.well_location = $NavigationRegion2D/town_portal.position
	PlayerData.spawn_player(spawns.pick_random())
	PlayerData.add_dialogue("Echo cavern level 1 entered")
	PlayerData.player.light_on()
