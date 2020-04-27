extends KinematicBody2D

var can_dash: = false
var speed: = 9000
var dash_rate: = 1.0
var playsteps: = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var direction: = Vector2()
	if Input.is_action_pressed("up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		direction += Vector2(1, 0)
	if Input.is_action_pressed("dash") and can_dash:
		speed = 27000
		can_dash = false
		yield(get_tree().create_timer(0.2), "timeout")
		speed = 9000
		yield(get_tree().create_timer(dash_rate - 0.1), "timeout")
		can_dash = true
	direction = direction.normalized()
	move_and_slide(direction * speed * delta)
	



