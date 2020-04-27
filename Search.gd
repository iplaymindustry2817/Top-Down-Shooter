extends KinematicBody2D

var hand_in: = false
var collider_layer
var open: = false

func _process(delta):
	if Input.is_action_just_pressed("search") and hand_in == true and open == false:
		$Anim.play("search")
		
	elif Input.is_action_just_released("search"):
		$Anim.stop(true)
		$ColorRect.visible = false
	
	if hand_in == true and open == false:
		$instructions.visible = true
		
	if hand_in == false:
		$instructions.visible = false

func finish_search(): 
	$Peanuts.emitting = true
	open = true
	$ColorRect.visible = false
	$closed.visible = false
	$open.visible = true
	$instructions.visible = false

func _on_SearchBox_area_entered(area: Area2D):
	if area.name == "Hand":
		hand_in = true

func _on_SearchBox_area_exited(area: Area2D):
	if area.name == "Hand":
		hand_in = false


