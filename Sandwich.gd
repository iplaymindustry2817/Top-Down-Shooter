extends KinematicBody2D

var in_hands = false
var collider_position
var collider
var hand

func grab():
	in_hands = true
	if Variable.objectives_finished == 0:
		Variable.objectives_finished = 1
	
func release():
	in_hands = false
	if Variable.objectives_finished == 1:
		Variable.objectives_finished = 2
		print("2")
	$Full.visible = false
	$Empty.visible = true
	$eat.play()

func _process(delta):
	if in_hands == true:
		collider_position = hand.get_global_position()
		self.global_position = collider_position
		
func _on_Area2D_area_entered(body):
	if body.name == "Hand":
		print("handy")
		hand = body
		


