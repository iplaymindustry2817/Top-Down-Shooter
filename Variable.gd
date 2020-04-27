extends Node2D

var objectives_finished: = 0
var actionMusic: = false

func _ready():
	$GameMusic.play()

func _process(delta):
	if objectives_finished == 3:
		$GameMusic.stop()
		yield(get_tree().create_timer(0.1), "timeout")
		$Action.play()

