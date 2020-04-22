extends RigidBody2D

var bullet_damage

func _on_Area2D_body_entered(body):
	print(bullet_damage)
	if body.has_method("damage"):
		body.damage(bullet_damage)
		queue_free()
	else:
		queue_free()
	
