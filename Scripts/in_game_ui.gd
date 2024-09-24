extends Control

class_name InGameUI

@onready var pause: TextureButton = $VBox/Pause
@onready var points: Label = $VBox/Points
@onready var ui : GameUI = get_tree().get_first_node_in_group("UI")

func _on_pause_mouse_entered() -> void:
	ui.get_input = false


func _on_pause_mouse_exited() -> void:
	ui.get_input = true
