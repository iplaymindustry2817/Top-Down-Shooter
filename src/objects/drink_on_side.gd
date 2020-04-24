extends KinematicBody2D

var in_hands = false
var collider_position
var collider
var hand

func grab():
	in_hands = true
	print(in_hands)
	
func release():
	in_hands = false

func _process(delta):
	if in_hands == true:
		collider_position = hand.get_global_position()
		print("yes")
		self.global_position = collider_position
		
func _on_Area2D_area_entered(body):
	if body.name == "Hand":
		print("handy")
		hand = body
		
