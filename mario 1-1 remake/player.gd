extends CharacterBody2D

const speed = 150
const jump_power = -500
var is_jumping = false
var currentY = 0

var is_dead = false

const acc = 15
const friction = 5

const gravity = 40

var killing_mob = false



func _process(delta):
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		if input_dir.x < 0:
			flip_x(true)
		else:
			flip_x(false)
		
		break_operator(input_dir)
		accelerate(input_dir)

	else:
		add_friction()
		play_idle_animation()
		
	if abs(currentY - position.y) > 60:
		is_jumping = false
		
	player_movement()
	jump()
	dead()
	killing_effect()
	

func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	input_dir = input_dir.normalized()
	return input_dir
	
func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acc)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
func player_movement():
	move_and_slide()
	
func play_jump_animation():
	%AnimationPlayer.play("jump")
	
func play_idle_animation():
	%AnimationPlayer.play("Idle")
	
func play_walk_animation():
	%AnimationPlayer.play("walk")
	
func play_break_animation():
	%AnimationPlayer.play("break")
	
func play_dead_animation():
	%AnimationPlayer.play("dead")
	
func flip_x(flip:bool):
	%AnimatedSprite2D.flip_h = flip

func jump():
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_power
		is_jumping = true
		currentY = position.y
		
	elif Input.is_action_pressed("jump") && is_jumping == true:
		velocity.y = jump_power
		velocity.y *= 0.5
		
	elif Input.is_action_just_released("jump"):
		is_jumping = false
		
	else:
		velocity.y += gravity
		
	if not is_on_floor():
		play_jump_animation()

func break_operator(input_dir: Vector2):
	if velocity != Vector2.ZERO and velocity.x * input_dir.x < 0:
		play_break_animation()
	else:
		play_walk_animation()

func _on_top_collision_detect_body_entered(body):
	is_jumping = false


func _on_hurt_box_body_entered(body):
	if body.has_method("take_damage"):
		is_dead = true
		await get_tree().create_timer(1.0).timeout
		Global.HP -= 1
		


func dead():
	if is_dead == true:
		play_dead_animation() 


func _on_killing_detect_body_exited(body):
	if body.name == "Mushroom":
		print("Killed a Mob!")
		killing_mob = true
		
func killing_effect():
	if killing_mob == true:
		velocity.y += jump_power/2
		killing_mob = false
