extends Control

class_name LoseScreen

@onready var current_score: Label = %CurrentScore
@onready var player_name: LineEdit = $TextureRect/MarginContainer/VBoxContainer/PlayerName
@onready var exit_button: TextureButton = $TextureRect/MarginContainer/HBoxContainer/ExitButton
@onready var restart: TextureButton = $TextureRect/MarginContainer/HBoxContainer/Restart
@onready var game_manager : GM = GameManager

func _on_line_edit_text_submitted(new_text: String) -> void:
	var _name : String = new_text.to_upper()
	if _name == "":
		player_name.placeholder_text = "Enter Name!!!"
		player_name.modulate = Color.INDIAN_RED
	else:
		Audio.score_submit.play()
		game_manager.high_scores.append([_name,game_manager.level_points])
		game_manager.sort_high_score()
		player_name.editable = false
		game_manager.save_game()
