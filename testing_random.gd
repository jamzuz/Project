extends Node2D

#@export var tiles : TileMap
var noise : FastNoiseLite = FastNoiseLite.new()
var width = 128
var height = 128
@onready var tiles : TileMap = $TileMap

func _ready():
	noise.seed = randi()
	generate()

func generate():
	for x in width:
		for y in height:
			var i = noise.get_noise_2d(x,y)
			if i < 0:
				tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13))
