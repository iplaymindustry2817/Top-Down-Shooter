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
			if collider.name != "Box" and collider.name != "Box_empty" and collider.name != "Fridge":
				holding = collider
				collider.grab()
				has_item = true
				$Hand.visible = false
				$Sprite.visible = true
				if collider.name == "Flashlight" and Variable.objectives_finished == 4:
					Variable.objectives_finished = 5
					get_parent().get_parent().update_objective()
				
		elif Input.is_action_just_pressed("Interact") and has_item == true:
			has_item = false
			if collider.name == "Sandwich" and Variable.objectives_finished == 1:
				Variable.objectives_finished = 2
				get_parent().get_parent().update_objective()
			holding.release()
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
