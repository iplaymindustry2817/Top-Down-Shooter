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
var reload_time: = 1.0
var reloading: = false
var shooting: = false
var damage: = 20
var pistol_ammo: = 5
var AR_ammo: = 20
var SMG_ammo: = 30
onready var current_ammo: Label = $CanvasLayer/Current_Ammo
onready var max_ammo: Label = $CanvasLayer/Max_Ammo
onready var healthNum: Label = $CanvasLayer/Health
onready var pistol_collision: = $Graphics/Head/SMG/Area2D/CollisionShape2D
onready var SMG_collision: = $Graphics/Head/SMG/Area2D/CollisionShape2D
onready var M4A1_collision: = $Graphics/Head/M4A1/Area2D/CollisionShape2D
var ammo_type: = 0
var current_gun: = "pistol"
var can_switch: = true
var health: = 100

func _ready():
	healthNum.text = "%s" % health
	yield(get_tree(), "idle_frame")
	get_tree().call_group("cops", "set_player", self)

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		reload()
	look_at(get_global_mouse_position())
	if current_gun == "pistol":
		current_ammo.text = ("%s") % pistol_ammo
	if current_gun == "AR":
		current_ammo.text = ("%s") % AR_ammo
	if current_gun == "SMG":
		current_ammo.text = ("%s") % SMG_ammo
	max_ammo.text = ("%s") % clip_size
	
	if Input.is_action_just_pressed("1") and can_switch:
		set_gun(0.3, 5, 1, 20, "pistol")
		if current_gun == "pistol":
			if pistol_ammo <= 0:
				reload()
		
	if Input.is_action_just_pressed("2") and can_switch:
		set_gun(0.15, 20, 2, 15, "AR")
		if current_gun == "AR":
			if AR_ammo <= 0:
				reload()
	
	if Input.is_action_just_pressed("3") and can_switch:
		set_gun(0.1, 30, 1.5, 5, "SMG")
		if current_gun == "SMG":
			if SMG_ammo <= 0:
				reload()
	
	if Input.is_action_pressed("fire") and can_fire:
		fire()
		
	if reloading:
		can_switch = false
	elif !reloading:
		can_switch = true

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
	direction = direction.normalized()
	move_and_slide(direction * speed * delta)
	if direction == Vector2.ZERO and !shooting and !reloading:
		$Graphics/AnimationPlayer.stop()
	else:
		$Graphics/AnimationPlayer.play("Walk")
	
func reload():
	reloading = true
	if current_gun == "pistol":
		$CanvasLayer/AnimationPlayer.play("Pistol_Reload")
		pistol_ammo = clip_size
		$pistol_reload.play()
	if current_gun == "AR":
		$CanvasLayer/AnimationPlayer.play("AR_Reload")
		AR_ammo = clip_size
		$AR_reload.play()
	if current_gun == "SMG":
		$CanvasLayer/AnimationPlayer.play("SMG_Reload")
		SMG_ammo = clip_size
		$pistol_reload.play()
	can_fire = false
	$Graphics/AnimationPlayer.play("Reload")
	yield(get_tree().create_timer(reload_time), "timeout")
	can_fire = true
	reloading = false
	
	
func set_gun(fr, clipS, reload, Gdamage, new_gun):
	fire_rate = fr #AYY 100 lines of code!!
	clip_size = clipS
	reload_time = reload
	damage = Gdamage
	current_gun = new_gun
	if new_gun == "pistol":
		$Graphics/Head/M4A1.visible = false
		M4A1_collision.disabled = true
		SMG_collision.disabled = true
		pistol_collision.disabled = false
		$Graphics/Head/SMG.visible = false
		$BulletPoint.position.x = 23.981
		$Graphics/Muzzle_Flash.position.x = 37.063
		$CanvasLayer/M4A1.visible = false
		$CanvasLayer/SMG.visible = false
		$CanvasLayer/Glock.visible = true
	if new_gun == "AR":
		$Graphics/Head/M4A1.visible = true
		M4A1_collision.disabled = false
		SMG_collision.disabled = true
		pistol_collision.disabled = true
		$Graphics/Head/SMG.visible = false
		$BulletPoint.position.x = 77.211
		$Graphics/Muzzle_Flash.position.x = 77.201
		$CanvasLayer/SMG.visible = false
		$CanvasLayer/M4A1.visible = true
		$CanvasLayer/Glock.visible = false
	if new_gun == "SMG":
		$Graphics/Head/M4A1.visible = false
		M4A1_collision.disabled = true
		SMG_collision.disabled = false
		pistol_collision.disabled = true
		$Graphics/Head/SMG.visible = true
		$BulletPoint.position.x = 51.0
		$Graphics/Muzzle_Flash.position.x = 51.0
		$CanvasLayer/SMG.visible = true
		$CanvasLayer/M4A1.visible = false
		$CanvasLayer/Glock.visible = false
	
func fire():
	shooting = true
	var BulletI = bullet.instance()
	BulletI.bullet_damage = damage
	BulletI.position = $BulletPoint.get_global_position()
	BulletI.rotation_degrees = rotation_degrees
	BulletI.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(BulletI)
	if current_gun == "pistol":
		$pistol_gunshot.play()
	if current_gun == "AR":
		$AR_gunshot.play()
	if current_gun == "SMG":
		$AR_gunshot.play()
	$Graphics/AnimationPlayer.play("Shoot")
	var Flash = Muzzle_Flash.instance()
	Flash.position = $Graphics/Muzzle_Flash.global_position
	Flash.rotation_degrees = $Graphics/Muzzle_Flash.global_rotation_degrees
	Flash.emitting = true
	get_tree().get_root().add_child(Flash)
	can_fire = false
	if current_gun == "pistol":
		pistol_ammo -= 1
	if current_gun == "AR":
		AR_ammo -= 1
	if current_gun == "SMG":
		SMG_ammo -= 1
	yield(get_tree().create_timer(fire_rate), "timeout")
	if current_gun == "pistol":
		if pistol_ammo <= 0:
			reload()
		elif pistol_ammo > 0:
			can_fire = true
	if current_gun == "AR":
		if AR_ammo <= 0:
			reload()
		elif AR_ammo > 0:
			can_fire = true
	if current_gun == "SMG":
		if SMG_ammo <= 0:
			reload()
		elif SMG_ammo > 0:
			can_fire = true
	shooting = false

func damage(amount):
	health -= amount
	healthNum.text = "%s" % health
	$CanvasLayer/AnimationPlayer.play("Hit")
	if health <= 0:
		die()

func die():
	get_tree().reload_current_scene() #200 LINES OF CODE!!!
