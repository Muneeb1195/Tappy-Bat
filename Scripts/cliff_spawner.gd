extends Node2D

class_name CliffSpawner

@onready var CliffScene : PackedScene = preload("res://Scenes/Cliffs/cliffs.tscn")
@onready var spawn_timer : Timer = $SpawnTimer
@onready var viewport_rect : Rect2 = get_viewport_rect()
@onready var game_manager: GM = GameManager
@onready var level: Level = get_tree().get_first_node_in_group("Level")

@export var cliff_speed : float = -150

func _ready() -> void:
	randomize()
	spawn_timer.timeout.connect(spawn_cliffs)

func start_spawning_cliffs() -> void:
	spawn_timer.start()

func spawn_cliffs() -> void:
	var cliffs : CliffPair = CliffScene.instantiate()
	spawn_timer.wait_time = randf_range(1.5,2.0)
	cliffs.position.x = viewport_rect.end.x
	cliffs.position.y = randf_range(-160, 50)
	cliffs._set_speed(cliff_speed)
	cliffs.point_scored.connect(_point_scored)
	add_child(cliffs)


func _point_scored() -> void:
	level.points += 1
