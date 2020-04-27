extends Node2D

var player_in_zone: = false
var coll = null
export var backyard1: PackedScene
var player_at_door = false
var hand_on_laptop = false

func _ready():
	$CanvasLayer/TalkBox.visible = false
	yield(get_tree().create_timer(1), "timeout")
	$CanvasLayer/TalkBox.visible = true
	$Animation.play("Typewriter")
	yield(get_tree().create_timer(7), "timeout")
	$CanvasLayer/Objectives/current.text = "Get something to eat from the kitchen"
	$CanvasLayer/TalkBox.visible = false
	$kitchen_light.visible = true
	$lightswitch.play()

func _process(delta):
	if player_at_door == true and Input.is_action_just_pressed("Interact") and Variable.objectives_finished == 5:
		if Variable.objectives_finished == 5:
			get_tree().change_scene_to(backyard1)
			Variable.objectives_finished = 6
		
	if hand_on_laptop == true and Variable.objectives_finished == 2:
		print("2 done")
		if Input.is_action_just_pressed("Interact"):
			Variable.objectives_finished = 3
			update_objective()
	if player_in_zone == true and Variable.objectives_finished == 3:
		if Input.is_action_just_pressed("Interact"):
			$Animation.play("Sleep")
			$bed_light.visible = false
			yield(get_tree().create_timer(3.1), "timeout")
			Variable.objectives_finished = 4
			$CanvasLayer/TalkBox.visible = true
			$Meteorite.play()
			pause_mode = true
			$CanvasLayer/TalkBox/TalkText.text = "What the heck was that?"
			Variable.actionMusic == true
			$Animation.play("Typewriter")
			yield(get_tree().create_timer(4.1), "timeout")
			$Animation.play("FlashingLight")
			yield(get_tree().create_timer(3), "timeout")
			$CanvasLayer/TalkBox/TalkText.text = "I better check it out, I need a flashlight first though. It's gotta be in one of those boxes"
			$Animation.play("Typewriter")
			$Animation.play("FlashingLight")
			yield(get_tree().create_timer(6), "timeout")
			pause_mode = false
			$CanvasLayer/TalkBox.visible = false
			update_objective()
		
func _on_Bed_body_entered(body: PhysicsBody2D):
	print("Enter")
	player_in_zone = true


func _on_Bed_body_exited(body: PhysicsBody2D):
	print("Exit")
	player_in_zone = false


func _on_Area2D_body_entered(body: PhysicsBody2D):
	player_at_door = true
	
func _on_Area2D_body_exited(body: PhysicsBody2D):
	player_at_door = false

func _on_Laptop_area_entered(area: Area2D):
	hand_on_laptop = true

func _on_Laptop_area_exited(area: Area2D):
	hand_on_laptop = false

func update_objective():
	if Variable.objectives_finished == 2:
		$CanvasLayer/Objectives/current.text = ""
		$CanvasLayer/TalkBox.visible = true
		pause_mode = true
		$CanvasLayer/TalkBox/TalkText.text = "I need to power off my laptop before I go to bed, didn't realise I left it on all day."
		$Animation.play("Typewriter")
		yield(get_tree().create_timer(8), "timeout")
		pause_mode = false
		$CanvasLayer/Objectives/current.text = "Turn off your laptop"
		$CanvasLayer/TalkBox.visible = false
		$kitchen_light.visible = false
		$lightswitch.play()
		$bed_light.visible = true
	if Variable.objectives_finished == 3:
		$laptop_light.visible = false
		$laptop_off.play()
		$CanvasLayer/TalkBox.visible = true
		$CanvasLayer/Objectives/current.text = ""
		pause_mode = true
		$CanvasLayer/TalkBox/TalkText.text = "Okay, bed time for me, what long day. Darn that Carol, always has to make my life so hard."
		$Animation.play("Typewriter")
		yield(get_tree().create_timer(8), "timeout")
		pause_mode = false
		$CanvasLayer/Objectives/current.text = "Go to bed"
		$CanvasLayer/TalkBox.visible = false
	if Variable.objectives_finished == 4:
		$CanvasLayer/Objectives/current.text = "Find a flashlight"
	if Variable.objectives_finished == 5:
		$CanvasLayer/TalkBox.visible = true
		pause_mode = true
		$CanvasLayer/TalkBox/TalkText.text = "Well, here goes nothng."
		$Animation.play("Typewriter")
		$Animation.play("FlashingLight")
		yield(get_tree().create_timer(4), "timeout")
		pause_mode = false
		$CanvasLayer/Objectives/current.text = "Go out the back door"
		$door_light.visible = true
		$lightswitch.play()
	
