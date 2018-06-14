extends KinematicBody2D

var _d_input      = Vector2()
var _d_input_norm = Vector2()
export(float) var move_speed = 40.0

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

func _physics_process(delta):
	move_and_slide(_d_input_norm * move_speed)