extends Node2D

var currentHP
var HP


func _ready():
	currentHP = Global.HP

func _process(delta):
	HP = Global.HP
	if HP < currentHP:
		get_tree().change_scene_to_file("res://game.tscn")
	
	if HP == 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
