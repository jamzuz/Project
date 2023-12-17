@tool
extends Node2D
class_name random_tile

@export var map_size : int
@export var tiles : TileMap
@export var noise : FastNoiseLite = FastNoiseLite.new()
@export var to_draw : bool = false


var ran : bool = false
var random_tiles : Array[Vector2i] = [
	Vector2i(0,15),
	Vector2i(1,15),
	Vector2i(2,15),
	Vector2i(5,2)
]
func _process(_delta):
	if Engine.is_editor_hint():
	# Code to execute when in editor.
		if to_draw and !ran:
			process_image()
		elif !to_draw and ran:
			clear()


func clear():
	var width = map_size
	var height = map_size
	for x in width:
		for y in height:
			@warning_ignore("integer_division")
			tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(-1,-1))
			@warning_ignore("integer_division")
			tiles.set_cell(1, Vector2i(x - width / 2,y - height / 2),0, Vector2i(-1,-1))
	ran = false

func process_image():
	var width = map_size
	var height = map_size
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = randf_range(0.06, 0.07)
	#noise.generate_mipmaps = false
	for x in width:
		for y in height:
			var pixel = noise.get_noise_2d(x,y)
			#if pixel < 0.002 and pixel > 0.001:
				##@warning_ignore("integer_division")
				#tiles.set_cell(1, Vector2i(x - width / 2,y - height / 2),0, random_tiles.pick_random())
			#if pixel < -0.06 and pixel > -0.13:
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13),1)				
			#if pixel < -0.13 and pixel > -0.16:
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13))
			#if pixel < -0.17 and pixel > -0.20:
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13),2)
			#if pixel < -0.20 and pixel > -0.24:
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13),3)
			#if pixel < -0.24:
				##@warning_ignore("integer_division")
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(8,5), 1)
			if pixel < 0.002 and pixel > 0.001:
				#@warning_ignore("integer_division")
				tiles.set_cell(1, Vector2i(x - width / 2,y - height / 2),0, random_tiles.pick_random())
			if pixel < -0.095 and pixel >= -0.2001:
				tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13),randi_range(0,2))				
			if pixel < -0.20:
				tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(8,5), 1)
			#if pixel < -0.17 and pixel > -0.20:
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13),2)
			#if pixel < -0.20 and pixel > -0.24:
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13),3)
			#if pixel < -0.24:
				##@warning_ignore("integer_division")
				#tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(8,5), 1)
	
	ran = true
