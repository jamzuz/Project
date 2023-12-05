extends Node2D

func _ready():
	get_tree().paused = false

func _on_again_pressed():
	PlayerData.restart()


func _on_quit_pressed():
	get_tree().quit()
