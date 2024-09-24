extends CharacterBody2D

class_name Player

#signal game_started
#signal player_death

const Max_Speed : int = 400

@export var gravity : float = 900
@export var jump_force : float = -300

@onready var state : States = States.IDLE
@onready var animation: Timer = $Animation
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var jump_timer: Timer = $JumpTimer
@onready var level : Level = get_tree().get_first_node_in_group("Level")
@onready var ui : GameUI = get_tree().get_first_node_in_group("UI")

enum States {IDLE,JUMP,FALL,DEATH}

var tween : Tween
var first_jump : bool = false
#var _get_input : bool

func _physics_process(delta: float) -> void:
	match state:
		States.JUMP:
			_jump(delta)
			if tween != null:
				animation.stop()
				tween.kill()
			if not first_jump:
				first_jump = true
				level._on_game_started()
		States.FALL:
			_fall_down(delta)
		States.IDLE:
			if not animation.time_left:
				animation.start()
				_float_up_down()
		States.DEATH:
			_death(delta)
	
	_check_input()
	_check_collision()

func _check_input() -> void:
	if ui.get_input and Input.is_action_just_pressed(&"Jump") and state != States.DEATH:
		state = States.JUMP

func _check_collision() -> void:
	move_and_slide()
	var collision_info : KinematicCollision2D = get_last_slide_collision()
	if collision_info:
		var collider : StaticBody2D = collision_info.get_collider()
		if collider.collision_layer == 1 and state != States.DEATH: 
			state = States.DEATH

func _jump(delta : float) -> void:
	player_sprite.play("Flying")
	Audio.fly.pitch_scale = randf_range(0.85,1.0)
	Audio.fly.play()
	rotation = rotate_toward(rotation, -(PI/4), 20 * delta)
	velocity.y = lerp(velocity.y, jump_force, 20 * delta)
	if not jump_timer.time_left and state != States.DEATH:
		jump_timer.start()

func _fall_down(delta : float) -> void:
	if player_sprite.animation == "Flying" and player_sprite.frame == 3:
		player_sprite.play("Idle")
	rotation = rotate_toward(rotation, (PI/4), delta)
	velocity.y = lerp(velocity.y, gravity, delta)

func _death(delta : float) -> void:
	velocity = Vector2(-0.25,1) * 100
	rotation = rotate_toward(rotation, (PI/4), delta)
	player_sprite.animation = "Death"
	Audio.death.play()
	var dis_tween : Tween = create_tween()
	dis_tween.tween_property(player_sprite, "modulate:a",0.0,0.5)
	await dis_tween.finished
	tween.kill()
	level._on_player_death()
	queue_free()

func _float_up_down() -> void:
	tween = create_tween()
	tween.tween_property(self, "position:y" , -5 , 0.45)
	tween.tween_property(self, "position:y" , 5 , 0.45)
	tween.connect("finished", tween.kill)


func _on_jump_timer_timeout() -> void:
	state = States.FALL
