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
			if collider.name != "Box" and collider.name != "Box_empty":
				holding = collider
				collider.grab()
				has_item = true
				$Hand.visible = false
				$Sprite.visible = true
				if collider.name == "Flashlight" and Variable.objectives_finished == 4:
					Variable.objectives_finished = 5
					get_parent().get_parent().update_objective()
					
		elif Input.is_action_just_pressed("Interact") and has_item == true:
			holding.release()
			has_item = false
	elif is_colliding and collider_layer >= 2 ^(8 - 1):
		$Hand.visible = true
		$Sprite.visible = false
	else:
		$Hand.visible = false
		$Sprite.visible = true

func _on_Hand_body_entered(body: PhysicsBody2D):
	is_colliding += 1
	collider = body
	collider_layer = body.get_collision_layer()


func _on_Hand_body_exited(body):
	is_colliding -= 1
