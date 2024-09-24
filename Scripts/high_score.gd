extends Control

class_name HighScores

@onready var v_box: VBoxContainer = $TextureRect/MarginContainer/VBoxContainer
@onready var back_button: TextureButton = $TextureRect/MarginContainer/HBoxContainer/ExitButton

func _ready() -> void:
	for i : int in GameManager.high_scores.size():
		var label : Label = Label.new()
		var h_s_arr : Array = GameManager.high_scores[i]
		label.text = "%2d." % [i+1] + h_s_arr[0] + " %02d" % [h_s_arr[1]]
		label.label_settings = LabelSettings.new()
		label.label_settings.font_size = 22
		label.label_settings.font_color = Color(0.792, 0.129, 0.427)
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_FILL
		v_box.add_child(label)
