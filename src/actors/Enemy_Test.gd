extends RigidBody2D

export var health: = 6


func damage(amount):
	health -= amount
	if health <= 0:
		kill()
func kill():
	$Particles2D.emitting = true
	$Sprite.visible = false
	$CollisionShape2D.queue_free()
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
