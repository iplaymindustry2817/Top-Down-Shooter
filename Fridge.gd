extends KinematicBody2D


var Item = preload("res://src/objects/Junk/Sandwich.tscn")

var hand_in: = false
var collider_layer
var open: = false

func _process(delta):
	if Input.is_action_just_pressed("search") and hand_in == true and open == false:
		$Anim.play("search")
		
	elif Input.is_action_just_released("search"):
		$Anim.stop(true)
		$Node2D/ColorRect.visible = false
	
	if hand_in == true and open == false:
		$Node2D/instructions.visible = true
		
	if hand_in == false:
		$Node2D/instructions.visible = false

func finish_search(): 
	open = true
	$Node2D/ColorRect.visible = false
	var it = Item.instance()
	it.position = $item_point.get_global_position()
	get_tree().get_root().add_child(it)
	$closed.visible = false
	$open.visible = true
	$Node2D/instructions.visible = false

func _on_SearchBox_area_entered(area: Area2D):
	if area.name == "Hand":
		hand_in = true

func _on_SearchBox_area_exited(area: Area2D):
	if area.name == "Hand":
		hand_in = false


