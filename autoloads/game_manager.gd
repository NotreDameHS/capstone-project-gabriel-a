extends Node
const mob_spawner = preload("res://entities/Mobs/MobSpawner/mob_spawner.tscn")
var waveData: Array = []
var maxWaves: int # This will be extracted from the WaveData.txt File!
var currentWave = 5
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	print("Game manager Started!")
	load_wave_file("res://WaveData.txt")
	wave_manager(currentWave) #this is here temporary to test wave manager


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func load_wave_file(path: String) -> void: #
	if not FileAccess.file_exists(path):
		push_error("Wave file missing: " + path)
		return
	var file = FileAccess.open(path, FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		# Skipping empty lines and comments starting with '#'
		if line == "" or line.begins_with("#"): 
			continue
		if line.begins_with("@"):
			line.remove_chars("@ maximum waves = ")
			maxWaves = int(line)
			continue
		var wave_dict = {}
		# Split different enemy groups in the same wave (separated by ';')
		var enemy_groups = line.split(";")
		for group in enemy_groups:
			var data = group.split(",") # Split enemy_name and amount
			if data.size() == 2:
				var enemy_type = data[0].strip_edges()
				var amount = int(data[1].strip_edges()) # Cast string to integer
				wave_dict[enemy_type] = amount
		waveData.append(wave_dict) #finally adds WaveData to a list.
	file.close()

func get_wave_instructions(wave_index: int) -> Dictionary:
	if wave_index >= 0 and wave_index < waveData.size():
		return waveData[wave_index]
	return {} # Return empty dictionary if wave doesn't exist

func wave_manager(requestedWavenumber: int) -> void:
	var requestedWave = get_wave_instructions(requestedWavenumber)
	print(requestedWave)
	
	
