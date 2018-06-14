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

func transition(multiplier):
	var offset = self.get_viewport_rect().size * self.zoom * multiplier
	print("I should transition by ", offset)
	self.position += offset

func _on_Area_Right_body_entered(body):
	if body == Player:
		transition(Vector2( 1, 0))

func _on_Area_Left_body_entered(body):
	if body == Player:
		transition(Vector2(-1, 0))

func _on_Area_Top_body_entered(body):
	if body == Player:
		transition(Vector2(0, -1))

func _on_Area_Bottom_body_entered(body):
	if body == Player:
		transition(Vector2(0,  1))