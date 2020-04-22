extends Node2D

export var start: PackedScene

func _process(delta):
	if Input.is_action_pressed("restart"):
		get_tree().change_scene_to(start)
