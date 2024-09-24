extends CanvasLayer

class_name Fade

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.color.a = 0.0

func _black() -> void:
	var tween : Tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(color_rect,"color:a",0.9,0.5).from_current()
	tween.connect("finished", tween.kill)

func _normal() -> void:
	var tween : Tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(color_rect,"color:a",0.0,0.5).from_current()
	tween.connect("finished", tween.kill)

func _reload_level() -> void:
	var tween : Tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(color_rect,"color:a",1.0,0.5).from_current()
	tween.tween_callback(get_tree().change_scene_to_file.bind("res://Scenes/Level/level.tscn"))
	tween.tween_property(color_rect,"color:a",0.0,0.5).from_current()
	tween.connect("finished", tween.kill)

func _pause_game() -> void:
	get_tree().paused = true
	_black()

func _unpause_game() -> void:
	get_tree().paused = false
	_normal()

func _quit_game() -> void:
	get_tree().quit()
