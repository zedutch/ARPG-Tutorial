extends Node2D

func _ready():
	Player.set_position(self.global_position)
	if $Sprite:
		$Sprite.queue_free()