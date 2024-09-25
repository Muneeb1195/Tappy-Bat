extends Node2D

class_name Level

@onready var background: Node2D = $Background
@onready var fore_ground: Node2D = $ForeGround
@onready var ground: StaticBody2D = $Ground
@onready var player: Player = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var cliff_spawner: CliffSpawner = $CliffSpawner
@onready var _light: DirectionalLight2D = $DirectionalLight2D
@onready var ui : GameUI = $UI
@onready var game_manager : GM = GameManager

var points : int = 0:
	set(value) :
		points = value
		game_manager.level_points = points
		ui.call("_display_points",points)
		if fmod(points,10.0) < 0.1 and _light.energy < 0.9:
			var tween : Tween = create_tween()
			tween.tween_property(_light, "energy",_light.energy+0.1,0.5)
			tween.connect("finished", tween.kill)

func _on_game_started() -> void:
	cliff_spawner.start_spawning_cliffs()
	var tween : Tween = create_tween()
	tween.tween_property(camera_2d, "offset:x", 15, 1.0)
	tween.connect("finished",tween.kill)

func _on_player_death() -> void:
	_stop_moving_objects()
	Audio.death.play()
	ui._display_lose_screen()

func _stop_moving_objects() -> void:
	for cliffs : Object in cliff_spawner.get_children().filter(func (child : Object) -> bool: return child is CliffPair):
		cliffs.call("_set_speed",0)
	var parallax_bg : Parallax2D = background.get_child(0)
	parallax_bg.autoscroll = Vector2.ZERO
	var parallax_fg : Parallax2D = fore_ground.get_child(0)
	parallax_fg.autoscroll = Vector2.ZERO
	var parallax_g : Parallax2D = ground.get_child(0)
	parallax_g.autoscroll = Vector2.ZERO
	var cliff_spawn_timer : Timer = cliff_spawner.get_child(0)
	cliff_spawn_timer.stop()
