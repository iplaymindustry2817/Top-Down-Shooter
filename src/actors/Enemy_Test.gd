extends KinematicBody2D
export var health: = 100
onready var Blood_Particles = preload("res://src/objects/blood_effect.tscn")
var bullet = preload("res://src/objects/Bullet.tscn")
var Muzzle_Flash = preload("res://src/objects/Muzzle_Flash.tscn")
var player = null
export var move_speed: = 100
var damage: = 15
var bullet_speed: = 300
var can_fire: = true
var ammo: = 5
var clip_size: = 5
var fire_rate: = 0.3
var reload_time: = 1
var reloading: = false

func _ready():
	add_to_group("cops")

func _physics_process(delta):
	if player == null:
		return
	var vec_to_player = player.global_position - global_position
	vec_to_player= vec_to_player.normalized()
	global_rotation = vec_to_player.angle()
	if !$RayCast2D.is_colliding():
		move_and_collide(vec_to_player * move_speed * delta)
	if $RayCast2D.is_colliding()and can_fire:
			shoot()
	print(vec_to_player)
	
func set_player(p):
	player = p

func Edamage(amount):
	health -= amount
	var BloodI = Blood_Particles.instance()
	BloodI.position = $Blood.global_position
	BloodI.rotation_degrees = $Blood.global_rotation_degrees
	BloodI.emitting = true
	get_tree().get_root().add_child(BloodI)
	if health <= 0:
		kill()
func kill():
	queue_free()
	
func shoot():
	var BulletI = bullet.instance()
	BulletI.bullet_damage = damage
	BulletI.position = $BulletPoint.get_global_position()
	BulletI.rotation_degrees = rotation_degrees
	BulletI.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(BulletI)
	$pistol_gunshot.play()
	var Flash = Muzzle_Flash.instance()
	Flash.position = $Sprite/Muzzle_Flash.global_position
	Flash.rotation_degrees = $Sprite/Muzzle_Flash.global_rotation_degrees
	Flash.emitting = true
	get_tree().get_root().add_child(Flash)
	can_fire = false
	ammo -= 1
	yield(get_tree().create_timer(fire_rate), "timeout")
	if ammo <= 0:
		reload()
	elif ammo > 0:
		can_fire = true

func reload():
	reloading = true
	ammo = clip_size
	$pistol_reload.play()
	can_fire = false
	$Sprite/AnimationPlayer.play("Reload")
	yield(get_tree().create_timer(reload_time), "timeout")
	can_fire = true
	reloading = false
