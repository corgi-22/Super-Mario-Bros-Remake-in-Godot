extends CharacterBody2D

var duration_time = 0.5
var move_speed = 200.0
var elapsed_time = 0.0
var original_position : Vector2

func _ready():
	play_idle_animation()
	
	
func play_idle_animation():
	%AnimatedSprite2D.play("idle")

func _process(delta):
	elapsed_time += delta
	if elapsed_time < duration_time / 2:
		position.y -= move_speed * delta
	elif elapsed_time < duration_time:
		position.y += move_speed * delta
	else:
		queue_free()
