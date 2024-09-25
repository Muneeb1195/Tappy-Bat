extends Node2D

class_name CliffPair

signal point_scored

@onready var top: StaticBody2D = $Top
@onready var bottom: StaticBody2D = $Bottom

var viewport_width : float
var length : float
var flip_top : bool
var flip_bottom : bool 
var speed : float

func _ready() -> void:
	viewport_width = get_viewport_rect().size.x
	length = viewport_width/2
	randomize()
	_setup_top()
	_setup_bottom()


func _setup_top() -> void:
	flip_top = randi_range(0,1)
	if flip_top:
		top.scale.x = -1
	top.position.y = randi_range(-35,-50)

func _setup_bottom() -> void:
	flip_bottom = randi_range(0,1)
	if flip_bottom:
		bottom.scale.x = -1
	bottom.position.y = randi_range(35,50)

func _process(delta: float) -> void:
	position.x += speed * delta

func _set_speed(new_speed : float) -> void:
	speed = new_speed

func _on_point_scored(_body: CharacterBody2D) -> void:
	point_scored.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
