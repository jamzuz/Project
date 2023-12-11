extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.well_location = $well.position
	PlayerData.spawn_player()
	PlayerData.add_dialogue("Welcome to camp Echo")
