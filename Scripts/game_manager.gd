extends Node

class_name GM

@onready var high_scores : Array = [["BOT 1 ",10],["BOT 2 ",20],["BOT 3 ",30]]

var level_points : int

func _ready() -> void:
	sort_high_score()
	load_game()

func sort_high_score() -> void:
	high_scores.sort_custom(func (a : Array,b : Array) -> bool : return a[1] > b[1])
	if high_scores.size() > 5:
		high_scores.resize(5)

func save() -> Dictionary:
	var save_dict : Dictionary = {
		"High Scores" : high_scores
	}
	return save_dict

func save_game() -> void:
	var save_file : FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var json_string : String = JSON.stringify(save())
	
	save_file.store_line(json_string)
	print(high_scores)

func load_game() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_file : FileAccess = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string : String = save_file.get_line()
	var json : JSON = JSON.new()
	# Check if there is any error while parsing the JSON string, skip in case of failure
	var parse_result : Error = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	
	var saved_high_scores : Dictionary = json.get_data()
	high_scores = saved_high_scores["High Scores"]
	print(high_scores)
