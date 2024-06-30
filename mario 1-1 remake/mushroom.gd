extends CharacterBody2D

var gravity = 40
var speed = 50
var chase = false
var currentX = 0
@onready var player = get_node("res://player.tscn")

func _ready():
	play_walk_animation()

func _process(delta):
	if is_on_floor():
		if currentX == position.x:
			speed *= -1
		velocity.x = speed * 1
		
	
	currentX = position.x
	
	velocity.y += gravity
	move_and_slide()
	
func play_walk_animation():
	%AnimatedSprite2D.play("walk")


func play_dead_animation():
	%AnimatedSprite2D.play("attacked")


func dead():
	queue_free()
	const deadScene = preload("res://smash_mushroom.tscn")
	var smash_mushroom = deadScene.instantiate()
	get_parent().add_child(smash_mushroom)
	smash_mushroom.global_position = global_position
	Global.scores += 100


func _on_weak_point_body_entered(body):
	if body.name == "player":
		dead()
		
func take_damage():
	pass
