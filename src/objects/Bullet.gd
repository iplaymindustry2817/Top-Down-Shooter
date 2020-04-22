extends RigidBody2D

var bullet_damage

func _on_Area2D_body_entered(body):
	print(bullet_damage)
	if body.has_method("Edamage"):
		body.Edamage(bullet_damage)
		body.get_node("Blood").rotation_degrees = global_rotation_degrees
		queue_free()
	else:
		queue_free()
