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
	save_file.close()

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
		return
	var saved_data : Variant = json.get_data()
	if saved_data is Dictionary and (saved_data as Dictionary).has("High Scores"):
		high_scores = (saved_data as Dictionary)["High Scores"]
	save_file.close()
