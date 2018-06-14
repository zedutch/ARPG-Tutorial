extends KinematicBody2D

export(float) var move_speed = 40.0

var _d_input      = Vector2()
var _d_input_norm = Vector2()

onready var anim_player = get_node("AnimationPlayer")

enum DIR {
	UP, DOWN, LEFT, RIGHT
}
var facing = DIR.DOWN

func _ready():
	self.z_index = Data.player_z

func _unhandled_input(event):
	var right = Vector2(1, 0)
	var down  = Vector2(0, 1)
	
	if   event.is_action_pressed("walk_left")  or event.is_action_released("walk_right"):
		_d_input -= right
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("walk_right") or event.is_action_released("walk_left"):
		_d_input += right
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("walk_up")    or event.is_action_released("walk_down"):
		_d_input -= down
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("walk_down")  or event.is_action_released("walk_up"):
		_d_input += down
		get_tree().set_input_as_handled()
	_d_input_norm = _d_input.normalized()
	update_animation()

func _physics_process(delta):
	move_and_slide(_d_input_norm * move_speed)

func update_animation():
	if _d_input.y > 0:
		if facing != DIR.DOWN:
			facing = DIR.DOWN
			anim_player.play("walk_down")
	elif _d_input.y < 0:
		if facing != DIR.UP:
			facing = DIR.UP
			anim_player.play("walk_up")
	elif _d_input.x > 0:
		if facing != DIR.RIGHT:
			facing = DIR.RIGHT
			anim_player.play("walk_right")
	elif _d_input.x < 0:
		if facing != DIR.LEFT:
			facing = DIR.LEFT
			anim_player.play("walk_left")
	else:
		match facing:
			DIR.DOWN:
				anim_player.play("idle_down")
			DIR.UP:
				anim_player.play("idle_up")
			DIR.LEFT:
				anim_player.play("idle_left")
			DIR.RIGHT:
				anim_player.play("idle_right")