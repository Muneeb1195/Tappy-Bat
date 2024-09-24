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

func _ready() -> void:
	# main menu buttons
	main_menu.play.pressed.connect(_display_in_game_ui.bind(main_menu))
	main_menu.high_scores.pressed.connect(_display_high_scores.bind(main_menu))
	main_menu.exit.pressed.connect(_fade_to._quit_game)
	
	#high Score button
	high_score.back_button.pressed.connect(_display_main_menu.bind(high_score))
	
	# in game ui buttons
	in_game_ui.pause.pressed.connect(_display_pause_menu.bind(in_game_ui))
	
	# pause menu buttons
	pause_menu.resume.pressed.connect(_display_in_game_ui.bind(pause_menu))
	pause_menu.exit_button.pressed.connect(_fade_to._quit_game)
	pause_menu.main_menu.pressed.connect(_fade_to._unpause_game)
	pause_menu.main_menu.pressed.connect(_on_restart_pressed)
	
	# lose screen buttons
	lose_screen.exit_button.pressed.connect(_fade_to._quit_game)
	lose_screen.restart.pressed.connect(_on_restart_pressed)

func _display_main_menu(h_node: Control) -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_tween_menu(h_node,main_menu)

func _display_high_scores(h_node : Control) -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_tween_menu(h_node,high_score)

func _display_in_game_ui(h_node: Control) -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	get_input = true
	_fade_to._unpause_game()
	_tween_menu(h_node,in_game_ui)

func _display_pause_menu(h_node: Control) -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	await Audio.tap.finished
	_tween_menu(h_node,pause_menu)
	_fade_to._pause_game()

func _display_lose_screen(h_node : Control) -> void:
	lose_screen.current_score.text += "%02d" % [level.points]
	Audio.game_over.play()
	_tween_menu(h_node,lose_screen)

func _on_restart_pressed() -> void:
	Audio.tap.pitch_scale = randf_range(0.85,1.0)
	Audio.tap.play()
	_fade_to._reload_level()
	print("home")

func _display_points(value : int) -> void:
	points.text = "%02d" % [value]

func _tween_menu(h_node : Control,s_node : Control) -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(h_node,"modulate:a",0.0,0.5).from(1.0)
	tween.tween_callback(h_node.hide)
	tween.tween_callback(s_node.show)
	tween.tween_property(s_node,"modulate:a", 1.0,0.5).from(0.0)
	tween.connect("finished",tween.kill)

#func _on_lose_screen__main_menu() -> void:
	#_fade_to._reload_level()
	#main_menu.visible = true
	
