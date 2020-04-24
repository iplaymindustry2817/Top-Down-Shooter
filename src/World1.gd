extends Node2D

var player_in_zone: = false
var coll = null
export var backyard1: PackedScene
var player_at_door = false

func _ready():
	$CanvasLayer/TalkBox.visible = false
	yield(get_tree().create_timer(1), "timeout")
	$CanvasLayer/TalkBox.visible = true
	yield(get_tree().create_timer(5), "timeout")
	$CanvasLayer/TalkBox.visible = false

func _process(delta):
	if player_at_door == true and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to(backyard1)
	if player_in_zone == true:
		if Input.is_action_just_pressed("Interact"):
			$Animation.play("Sleep")
			yield(get_tree().create_timer(3.1), "timeout")
			$CanvasLayer/TalkBox.visible = true
			$CanvasLayer/TalkBox/TalkText.text = "Wtf was that?"
			yield(get_tree().create_timer(1.0), "timeout")
			$Animation.play("FlashingLight")
			$Siren.play()
		
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
