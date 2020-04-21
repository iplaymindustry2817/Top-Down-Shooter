extends KinematicBody2D

export var health: = 6

func damage(amount):
	health -= amount
	$Blood.emitting = true
	if health <= 0:
		kill()
func kill():
	$Die.emitting = true
	$Sprite.visible = false
	$CollisionShape2D.queue_free()
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
