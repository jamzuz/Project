extends CharacterBody2D

@export var model : int
@export var potion_vendor : bool
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
"Rations and a sturdy rope are your best friends down the well.",
"I once saw a glimmering light deep in the darkness. A lost artifact, maybe?",
"There are whispers of an ancient guardian. Approach with caution.",
"Darkness can play tricks on the mind. Trust your instincts.",
"Some creatures down there are more curious than hostile. Tread cautiously."
]

func _ready():
	$npc_sprite.frame = model
	$interact/interract_area.disabled = true
	if potion_vendor:
		$interact/interract_area.disabled = false
		lines = ["Buy a potion for 20 gold?"]
	
func _on_say_area_body_entered(body):
	
	if body is player_controller and can_trigger:
		if !potion_vendor:
			$char_cd.start()
			can_trigger = false
			var say = ""
			var line = lines.pick_random()
			for x in line:
				await $char_cd.timeout
				say = say + x
				$text_box.text = say
		if potion_vendor:
			$text_box.text = lines[0]
func _on_say_area_body_exited(body):
	if body is player_controller and !potion_vendor:
		$dialogue_cd.start()
	if body is player_controller and potion_vendor:
		$text_box.text = ""
		
func _on_timer_timeout():
	can_trigger = true
	$text_box.text = ""
#buy potion
func _on_interact_interact():
	if PlayerData.potions > 9:
		$text_box.text = "I dont see how you could carry more potions?"
	elif PlayerData.gold > 19:
		PlayerData.use_gold(20)
		PlayerData.potion_gained()
