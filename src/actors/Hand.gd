extends Area2D

var this: = self

func _process(delta):
	if this.is_colliding():
		print("hand")
