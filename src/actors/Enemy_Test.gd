extends KinematicBody2D

export var health: = 100
onready var Blood_Particles = preload("res://src/objects/blood_effect.tscn")

func damage(amount):
	health -= amount
	var BloodI = Blood_Particles.instance()
	BloodI.position = $Blood.global_position
	BloodI.rotation_degrees = $Blood.global_rotation_degrees
	BloodI.emitting = true
	get_tree().get_root().add_child(BloodI)
	if health <= 0:
		kill()
func kill():
	$Die.emitting = true
	$Sprite.visible = false
	$CollisionShape2D.queue_free()
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
