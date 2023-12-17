extends enemy_component

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _on_can_attack():
	animation_player.play("attack")
