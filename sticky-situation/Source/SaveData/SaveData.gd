extends Node
class_name SaveData

var playerStats_json_path = "user://SavedPlayerStats.json"
var playerStats:Dictionary = {
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
	"savedPos": [int(-1100),int(-147)],
	
	"totalCoins": int()}

var globalLevels = ["000","001","002"]

var playerSettings_json_path = "user://SavedPlayerSettings.json"
var playerSettings:Dictionary = {
	"MusicVolume": int(100),
	"SFXVolume": int(100),
	"TextSpeed": int(1),
	"Difficulty": int(0),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_all()
	write_all()
	
func write_all():
	write_to_json_file(playerStats_json_path, 0)
	write_to_json_file(playerSettings_json_path,1)

func load_all():
	load_json_file(playerStats_json_path, 0)
	load_json_file(playerSettings_json_path,1)
	
	
func addCoin():
	playerStats["totalCoins"] += 1


func Complete():
	playerStats["Levels"][globalLevels[playerStats["globalLevel"]]]["Completion"][playerStats["subLevel"]] = true
	write_to_json_file(playerStats_json_path,0)


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
	


func load_json_file(jsonPath:String, dictionaryNum:int):
	var file = FileAccess.open(jsonPath, FileAccess.READ)
	
	if file == null:
		file = FileAccess.open(jsonPath,FileAccess.WRITE)
		file.store_string("{}")
	else:
		var json = file.get_as_text()
		var json_object = JSON.new()
		
		json_object.parse(json)
		if dictionaryNum == 0:
			playerStats = json_object.data
		else:
			playerSettings = json_object.data
	
func write_to_json_file(jsonPath:String, dictionaryNum:int):
	#if FileAccess.file_exists(jsonPath):
		#print("File Exists")
	#else:
		#print("File doesnt exist")
		
	var file = FileAccess.open(jsonPath, FileAccess.WRITE)
	
	if file:
		var json_text
		if dictionaryNum == 0:
			json_text = JSON.stringify(playerStats, "\t")
		else:
			json_text = JSON.stringify(playerSettings, "\t")
			
		
		file.store_string(json_text)
		#print("Data Written")
		
	#else:
		#print("Failed to Open or Create")
		

func clear_data():
	var playerStatsData = {
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
	
	#if FileAccess.file_exists(playerStats_json_path):
		#print("File Exists")
	#else:
		#print("File doesnt exist")
		
	var file = FileAccess.open(playerStats_json_path, FileAccess.WRITE)
	
	if file:
		
		var json_text = JSON.stringify(playerStatsData, "\t")
		
		file.store_string(json_text)
		#print("Data Written")
		
#	else:
		#print("Failed to Open or Create")
		
	var playerSettingsData:Dictionary = {
		"MusicVolume": int(100),
		"SFXVolume": int(100),
		"TextSpeed": int(1),
		"Difficulty": int(2),
	}

	#if FileAccess.file_exists(playerSettings_json_path):
		#print("File Exists")
	#else:
		#print("File doesnt exist")
		
	var file2 = FileAccess.open(playerSettings_json_path, FileAccess.WRITE)
	
	if file2:
		
		var json_text = JSON.stringify(playerSettingsData, "\t")
		
		file2.store_string(json_text)
		print("Data Written")
		
	else:
		print("Failed to Open or Create")
		
	
	
