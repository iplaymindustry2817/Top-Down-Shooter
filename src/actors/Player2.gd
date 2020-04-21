extends KinematicBody2D

var can_dash: = true
var can_fire: = true
var bullet = preload("res://src/objects/Bullet.tscn")
export var speed: = 9000
export var bullet_speed: = 300
var fire_rate: = 0.3
var dash_rate: = 1.0
var ammo = 5
var clip_size: = 5
var reload_time: = 1
var reloading: = false
var shooting: = false

func _process(delta):
	look_at(get_global_mouse_position())
	
	
	if Input.is_action_pressed("fire") and can_fire:
		shooting = true
		var BulletI = bullet.instance()
		BulletI.position = $BulletPoint.get_global_position()
		BulletI.rotation_degrees = rotation_degrees
		BulletI.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(BulletI)
		$GunshotSound.play()
		$Graphics/AnimationPlayer.play("Shoot")
		can_fire = false
		ammo -= 1
		yield(get_tree().create_timer(fire_rate), "timeout")
		if ammo <= 0:
			reload()
		elif ammo > 0:
			can_fire = true
		shooting = false

func _physics_process(delta):
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
		speed = 500
		can_dash = false
		yield(get_tree().create_timer(0.2), "timeout")
		speed = 150
		yield(get_tree().create_timer(dash_rate - 0.1), "timeout")
		can_dash = true
	
	move_and_slide(direction * speed * delta)
	if direction == Vector2.ZERO and !shooting and !reloading:
		$Graphics/AnimationPlayer.stop()
	else:
		$Graphics/AnimationPlayer.play("Walk")
	
func reload():
	reloading = true
	can_fire = false
	$Graphics/AnimationPlayer.play("Reload")
	$Reload.play()
	yield(get_tree().create_timer(reload_time), "timeout")
	can_fire = true
	ammo = clip_size
	reloading = false

