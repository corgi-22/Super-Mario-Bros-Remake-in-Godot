extends StaticBody2D


@onready var player = get_node("res://player.tscn")

var triggered = false
var original_position : Vector2
var coinSpawned = false


func _ready():
	original_position = position
	play_idle_animation()


func play_idle_animation():
	%AnimatedSprite2D.play("idle")


func play_triggered_animation():
	%AnimatedSprite2D.play("triggered")


func _on_play_collision_body_entered(body):
	if body.name == "player":
		if triggered == false:
			Global.coins += 1
			Global.scores += 200
		triggered = true


func trigger():
	if triggered == true:
		play_triggered_animation()
		move_and_return()
		spawn_coin()

func move_and_return():
	position.y -= 1
	await get_tree().create_timer(0.1).timeout
	position = original_position
	
func spawn_coin():
	const coin = preload("res://coin.tscn")
	var SpawnedCoin = coin.instantiate()
	if coinSpawned == false:
		get_parent().add_child(SpawnedCoin)
		coinSpawned = true
	SpawnedCoin.global_position = global_position


func _process(delta):
	trigger()
