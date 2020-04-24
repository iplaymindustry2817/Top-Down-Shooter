extends KinematicBody2D

var in_hands = false
var collider_position
var collider

func grab():
	in_hands = true
	
func release():
	in_hands = false
func _process(delta):
	if in_hands == true:
		self.global_position = collider_position
		
func _on_Area2D_area_entered(body):
	if body.name == "Hand":
		collider_position = body.get_global_position()
		
