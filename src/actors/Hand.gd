extends Area2D

var is_colliding: = false
var collider
var collider_layer

func _process(delta):
	if is_colliding and collider_layer >= 2^(6 - 1):
		$Hand.visible = true
		$Sprite.visible = false
		if Input.is_action_just_pressed("Interact"):
			print("JUNK")
	else:
		$Hand.visible = false
		$Sprite.visible = true

func _on_Hand_body_entered(body: PhysicsBody2D):
	is_colliding = true
	collider = body
	collider_layer = body.get_collision_layer()


func _on_Hand_body_exited(body):
	is_colliding = false
