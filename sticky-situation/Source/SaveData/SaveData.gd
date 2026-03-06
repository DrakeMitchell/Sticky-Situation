extends Node
class_name SaveData

var json_path = "user://SaveData.json"
var playerStats = {
	"Levels":{
		"000":{
			"Completion": [bool(),bool(),bool()]
		},
		"001":{
			"Completion": [bool(),bool(),bool()]
		},
		"002":{
			"Completion": [bool(),bool(),bool()]
		}
	},
	#Temp Variables, for use in levels
	"globalLevel": int(),
	"subLevel": int(),
	"freePlay": bool(),
	"savedPos": [int(-1105),int(-147)],
	
	"totalCoins": int()}

var globalLevels = ["000","001","002"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_json_file()
	#print(playerStats)
	#playerStats["globalLevel"] = 1
	#print(playerStats)
	write_to_json_file()
	pass
	
func addCoin():
	playerStats["totalCoins"] += 1
#func load_level(glevel,slevel)
func Complete():
	playerStats["Levels"][globalLevels[playerStats["globalLevel"]]]["Completion"][playerStats["subLevel"]] = true
	write_to_json_file()


func checkCompletion(globallevel, sublevel = null) -> bool:
	if sublevel == null || sublevel == 100:
		for i in len(playerStats["Levels"][globalLevels[globallevel]]["Completion"]):
			if playerStats["Levels"][globalLevels[globallevel]]["Completion"][i] == false:
				return false
		return true
	else:
		if playerStats["Levels"][globalLevels[globallevel]]["Completion"][sublevel] == false:
				return false
		return true
	


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
		
func clear_data():
	var data = {
	"Levels":{
		"000":{
			"Completion": [bool(),bool(),bool()]
		},
		"001":{
			"Completion": [bool(),bool(),bool()]
		},
		"002":{
			"Completion": [bool(),bool(),bool()]
		}
	},
	#Temp Variables, for use in levels
	"globalLevel": int(),
	"subLevel": int(),
	"freePlay": bool(),
	"savedPos": [int(-1105),int(-147)],
	
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
		
		
	
	
