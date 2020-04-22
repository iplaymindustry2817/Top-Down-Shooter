extends Node2D

export var game: PackedScene

func _process(delta):
	if Input.is_action_pressed("dash"):
		get_tree().change_scene_to(game)
