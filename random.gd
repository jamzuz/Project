extends Node2D
class_name random_tile

@export var tiles : TileMap
@export var noise : NoiseTexture2D

func process_image():
	var data = noise.get_image()
	var width = noise.get_width()
	var height = noise.get_height()
	var once = 1
	for x in width:
		for y in height:
			var pixel_color = data.get_pixel(x,y)
			var is_white = pixel_color.r > 0.5
			
			if is_white:
				tiles.set_cell(0, Vector2i(x - width / 2,y - height / 2),0, Vector2i(0,13))
	return 0
