extends CharacterBody2D

@export var model : int
var can_trigger = true

var lines : Array = ["Watch your step down the well, adventurer.",
"I heard there are ancient treasures deep below.",
"The deeper you go, the stranger the creatures become.",
"Stay vigilant, danger lurks in the darkness.",
"The well has claimed many brave souls. Don't become one of them.",
"Remember to stock up on supplies before your descent.",
"May fortune favor your journey into the abyss.",
"Rumor has it, there's a mysterious merchant down there.",
"The well is said to be a gateway to other realms. Intriguing, isn't it?",
"Some say the water down there has healing properties. Worth a try, perhaps?",
"Keep an eye out for fellow adventurers. Teaming up can increase your chances.",
"Rations and a sturdy rope are your best friends down the well.",
"I once saw a glimmering light deep in the darkness. A lost artifact, maybe?",
"There are whispers of an ancient guardian. Approach with caution.",
"Listen closely; the echoes can reveal hidden paths.",
"Don't underestimate the power of a well-placed trap. Craft wisely.",
"Darkness can play tricks on the mind. Trust your instincts.",
"Some creatures down there are more curious than hostile. Trade cautiously."
]

func _ready():
	$npc_sprite.frame = model
	
func _on_say_area_body_entered(body):
	if body is player_controller and can_trigger:
		can_trigger = false
		$text_box.text = lines.pick_random()
		
func _on_say_area_body_exited(body):
	if body is player_controller:
		$Timer.start()
		
func _on_timer_timeout():
	can_trigger = true
	$text_box.text = ""
