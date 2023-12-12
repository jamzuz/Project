extends RayCast2D
class_name detection_component
@export var sight_range : int
@onready var detection : RayCast2D = $"."
signal player_detected
signal player_lost

func _ready():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for x in enemies:
		detection.add_exception(x)
	detection.target_position = Vector2(sight_range, 0)

func _on_detection_timer_timeout():
	if detection.is_colliding():
		var detected = detection.get_collider()
		if detected is player_controller:
			player_detected.emit()
		else:
			player_lost.emit()
