extends Area2D

var is_colliding: = 0
var collider
var collider_layer
var has_item: = false
var holding

func _process(delta):
	if is_colliding and collider_layer >= 2^(6 - 1):
		if has_item == false:
			$Hand.visible = true
			$Sprite.visible = false
		if Input.is_action_just_pressed("Interact") and has_item == false:
			holding = collider
			collider.grab()
			has_item = true
			$Hand.visible = false
			$Sprite.visible = true
		elif Input.is_action_just_pressed("Interact") and has_item == true:
			holding.release()
			has_item = false
			
	else:
		$Hand.visible = false
		$Sprite.visible = true

func _on_Hand_body_entered(body: PhysicsBody2D):
	is_colliding += 1
	collider = body
	collider_layer = body.get_collision_layer()


func _on_Hand_body_exited(body):
	is_colliding -= 1
