extends CanvasLayer
class_name hud

@onready var hpbar : ProgressBar = $player_hud/stats_container/hp/hpbar
@onready var hp_amount : Label = $player_hud/stats_container/hp/hpbar/hp_amount
@onready var xpbar : ProgressBar = $player_hud/stats_container/xp/xpbar
@onready var xp_amount : Label = $player_hud/stats_container/xp/xpbar/xp_amount
@onready var level : Label = $player_hud/stats_container/level
@onready var gold : Label = $player_hud/stats_container/level/gold
@onready var potion_amount : Label = $player_hud/potion/potion_amount
# Called when the node enters the scene tree for the first time.
func _ready():
	set_ui()
	
func set_ui():
	hpbar.max_value = PlayerData.max_hp
	hp_amount.text = str(PlayerData.hp) + "/" + str(PlayerData.max_hp)
	hpbar.value = PlayerData.hp
	xpbar.value = PlayerData.xp
	xpbar.max_value = PlayerData.xp_to_level
	xp_amount.text = str(PlayerData.xp) + "/" + str(PlayerData.xp_to_level)
	level.text = "LEVEL:"+str(PlayerData.level)
	gold.text = "Gold:"+str(PlayerData.gold)
	potion_amount.text = str(PlayerData.potions)
	if PlayerData.potions == 0:
		$player_hud/potion/potion.frame = 1
func update_hp():
	hpbar.max_value = PlayerData.max_hp
	hp_amount.text = str(PlayerData.hp) + "/" + str(PlayerData.max_hp)
	hpbar.value = PlayerData.hp
	
func update_xp():
	xpbar.value = PlayerData.xp
	xpbar.max_value = PlayerData.xp_to_level
	xp_amount.text = str(PlayerData.xp) + "/" + str(PlayerData.xp_to_level)

func update_level():
	level.text = "LEVEL:"+str(PlayerData.level)
	
func update_gold():
	gold.text = "Gold:"+str(PlayerData.gold)

func update_potion():
	potion_amount.text = str(PlayerData.potions)
	if PlayerData.potions == 0:
		$player_hud/potion/potion.frame = 1
	else:
		$player_hud/potion/potion.frame = 0
