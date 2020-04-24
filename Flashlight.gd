extends KinematicBody2D

var in_hands = false
var collider_position
var collider
var hand

func grab():
	in_hands = true
	$Light2D.visible = true
	
func release():
	in_hands = false
	$Light2D.visible = false

func _process(delta):
	if in_hands == true:
		collider_position = hand.get_global_position()
		self.global_position = collider_position
		self.global_rotation_degrees = hand.get_global_rotation_degrees()
		self.global_rotation_degrees += 90
		
func _on_Area2D_area_entered(body):
	if body.name == "Hand":
		print("handy")
		hand = body
		


