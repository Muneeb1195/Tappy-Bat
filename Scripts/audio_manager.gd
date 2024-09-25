extends Node

class_name AudioManager

@onready var bg_audio: AudioStreamPlayer = $BGAudio
@onready var tap: AudioStreamPlayer = $Tap
@onready var death: AudioStreamPlayer = $Death
@onready var fly: AudioStreamPlayer = $Fly
@onready var game_over: AudioStreamPlayer = $GameOver
@onready var score_submit: AudioStreamPlayer = $ScoreSubmit
@onready var timer: Timer = $Timer


func _on_bg_audio_finished() -> void:
	timer.start(randi_range(10,30))


func _on_timer_timeout() -> void:
	bg_audio.play()
