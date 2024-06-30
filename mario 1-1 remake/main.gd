extends Node2D

func _process(delta):
	game_start()
	
func game_start():
	if Input.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://game.tscn")

