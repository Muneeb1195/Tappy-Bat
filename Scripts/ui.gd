extends CanvasLayer

class_name GameUI

var get_input : bool = false

@onready var level: Level = get_tree().get_first_node_in_group("Level")
@onready var lose_screen: LoseScreen = $Control/MarginContainer/LoseScreen
@onready var main_menu: MainMenu = $Control/MarginContainer/MainMenu
@onready var pause_menu: PauseMenu = $Control/MarginContainer/PauseMenu
@onready var in_game_ui: InGameUI = $Control/MarginContainer/InGameUI
@onready var high_score: HighScores = $Control/MarginContainer/HighScore
@onready var points: Label = in_game_ui.points
@onready var game_manager : GM = GameManager

@onready var menus : Array = [main_menu,lose_screen,pause_menu,in_game_ui,high_score]

func _ready() -> void:
	_tween_menu(main_menu)
	
	# main menu buttons
	main_menu.play.pressed.connect(_display_in_game_ui)
	main_menu.high_scores.pressed.connect(_display_high_scores)
	main_menu.exit.pressed.connect(_fade_to._quit_game)
	
	#high Score button
	high_score.back_button.pressed.connect(_display_main_menu)
	
	# in game ui buttons
	in_game_ui.pause.pressed.connect(_display_pause_menu)
	
	# pause menu buttons
	pause_menu.resume.pressed.connect(_display_in_game_ui)
	pause_menu.exit_button.pressed.connect(_fade_to._quit_game)
	pause_menu.main_menu.pressed.connect(_on_restart_pressed)
	
	# lose screen buttons
	lose_screen.exit_button.pressed.connect(_fade_to._quit_game)
	lose_screen.restart.pressed.connect(_on_restart_pressed)

func _display_main_menu() -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_tween_menu(main_menu)

func _display_high_scores() -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_tween_menu(high_score)

func _display_in_game_ui() -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_tween_menu(in_game_ui)

func _display_pause_menu() -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_tween_menu(pause_menu)

func _display_lose_screen() -> void:
	Audio.game_over.play()
	_fade_to._black()
	lose_screen.current_score.text += "%02d" % [level.points]
	_tween_menu(lose_screen)

func _on_restart_pressed() -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_fade_to._reload_level()
	game_manager.level_points = 0

func _display_points(value : int) -> void:
	points.text = "%1d" % [value]

func _tween_menu(s_node : Control) -> void:
	for menu : Control in menus:
		if menu.visible:
			menu.hide()
		else:
			pass
	
	if s_node == pause_menu:
		_fade_to._pause_game()
	else:
		_fade_to._unpause_game()
	
	if s_node == in_game_ui: 
		get_input = true
	else: 
		get_input = false
	
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_callback(s_node.show)
	tween.tween_property(s_node,"modulate:a", 1.0,0.25).from(0.0)
	tween.connect("finished",tween.kill)
