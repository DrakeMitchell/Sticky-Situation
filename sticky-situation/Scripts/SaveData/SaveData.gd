extends Node
class_name SaveData

var json_path = "user://SaveData.json"
var playerStats = {
	"Level":{
		"id": null,
		"Completion": [bool(),bool(),bool()]
	},
	"globalLevel": int(),
	"subLevel": int(),
	"totalCoins": int()}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_json_file()
	print(playerStats)
	#playerStats["globalLevel"] = 1
	print(playerStats)
	write_to_json_file()
	pass
	
func addCoin():
	playerStats["totalCoins"] += 1
#func load_level(glevel,slevel)
func Complete():
	playerStats["Level"]["Completion"][playerStats["subLevel"]] = true


func load_json_file():
	var file = FileAccess.open(json_path, FileAccess.READ)
	
	if file == null:
		file = FileAccess.open(json_path,FileAccess.WRITE)
		file.store_string("{}")
	else:
		var json = file.get_as_text()
		var json_object = JSON.new()
		
		json_object.parse(json)
		
		playerStats = json_object.data
	
func write_to_json_file():
	if FileAccess.file_exists(json_path):
		print("File Exists")
	else:
		print("File doesnt exist")
		
	var file = FileAccess.open(json_path, FileAccess.WRITE)
	
	if file:
		
		var json_text = JSON.stringify(playerStats, "\t")
		
		file.store_string(json_text)
		print("Data Written")
		
	else:
		print("Failed to Open or Create")
		
func clearData():
	var data = {
	"Level":{
		"id": null,
		"Completion": [bool(),bool(),bool()]
	},
	"globalLevel": int(),
	"subLevel": int(),
	"totalCoins": int()}
	
	if FileAccess.file_exists(json_path):
		print("File Exists")
	else:
		print("File doesnt exist")
		
	var file = FileAccess.open(json_path, FileAccess.WRITE)
	
	if file:
		
		var json_text = JSON.stringify(data, "\t")
		
		file.store_string(json_text)
		print("Data Written")
		
	else:
		print("Failed to Open or Create")

	
	
