extends Node2D

func _ready():
	%AnimationPlayer.play("Dead")
	await %AnimationPlayer.animation_finished
	queue_free()
