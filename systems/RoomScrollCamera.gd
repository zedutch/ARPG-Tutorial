extends Camera2D


func _ready():
	self.position = self.position.snapped(Data.tile_size)
	
	var tiles = self.get_viewport_rect().size * self.zoom / Data.tile_size
	if int(tiles.x) % 2 == 1:
		# There's an odd amount of horizontal tiles -> offset camera by half a tile width
		self.position.x += Data.tile_size.x / 2.0
		
	if int(tiles.y) % 2 == 1:
		# There's an odd amount of vertical tiles -> offset camera by half a tile height
		self.position.y += Data.tile_size.y / 2.0