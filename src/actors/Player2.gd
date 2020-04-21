extends KinematicBody2D

onready var Muzzle_Flash = preload("res://src/objects/Muzzle_Flash.tscn")
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
var damage: = 20

func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("1"):
		set_gun(0.3, 5, 5, 1, 20)
		$Graphics/Head/M4A1.visible = false
		$BulletPoint.position.x = 23.981
		$Graphics/Muzzle_Flash.position.x = 37.063
		$CanvasLayer/M4A1.visible = false
		$CanvasLayer/Glock.visible = true
	if Input.is_action_just_pressed("2"):
		set_gun(0.15, 20, 20, 2, 15)
		$Graphics/Head/M4A1.visible = true
		$BulletPoint.position.x = 77.211
		$Graphics/Muzzle_Flash.position.x = 77.201
		$CanvasLayer/M4A1.visible = true
		$CanvasLayer/Glock.visible = false
	if Input.is_action_pressed("fire") and can_fire:
		shooting = true
		var BulletI = bullet.instance()
		BulletI.bullet_damage = damage
		BulletI.position = $BulletPoint.get_global_position()
		BulletI.rotation_degrees = rotation_degrees
		BulletI.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(BulletI)
		$GunshotSound.play()
		$Graphics/AnimationPlayer.play("Shoot")
		var Flash = Muzzle_Flash.instance()
		Flash.position = $Graphics/Muzzle_Flash.global_position
		Flash.rotation_degrees = $Graphics/Muzzle_Flash.global_rotation_degrees
		Flash.emitting = true
		get_tree().get_root().add_child(Flash)
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
		speed = 27000
		can_dash = false
		yield(get_tree().create_timer(0.2), "timeout")
		speed = 9000
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
	
func set_gun(fr, amo, clipS, reload, Gdamage):
	fire_rate = fr
	ammo = amo
	clip_size = clipS
	reload_time = reload
	damage = Gdamage

