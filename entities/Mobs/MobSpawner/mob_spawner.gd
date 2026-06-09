extends Node2D
@onready var timer = $Timer
@export var mob_types: Array[PackedScene] 
@export var spawnRate: float
@export var mobsSpawned =  0
@export var padding: float = 50.0 #adjusts the location of where mobs of spawned due to camera padding
signal wave_completed
func _ready() -> void:
	timer.start(1) #Temporary code to debug with!

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _spawn_selected_mob(mobToSpawn: String) -> void:
	var selected_scene_resource: PackedScene = null
	if mobToSpawn == "normal":
		selected_scene_resource = mob_types[0]
	elif mobToSpawn == "fast":
		selected_scene_resource = mob_types[1]
	elif mobToSpawn == "gunner":
		selected_scene_resource = mob_types[2]
	elif mobToSpawn == "boss":
		selected_scene_resource = mob_types[3]
	else:
		print("invalid parameter given")
		return
	var mob_instance = selected_scene_resource.instantiate()
	get_tree().current_scene.add_child(mob_instance)
	var viewport = get_viewport()
	var camera = viewport.get_camera_2d()
	var visible_size = viewport.get_visible_rect().size / camera.zoom
	var camera_center = camera.get_screen_center_position()
	var top_y = camera_center.y - (visible_size.y / 2.0)
	var bottom_y = camera_center.y + (visible_size.y / 2.0)
	var right_x = camera_center.x + (visible_size.x / 2.0)
	var spawn_x = right_x + padding
	var spawn_y = randf_range(top_y, bottom_y)
	mob_instance.global_position = Vector2(spawn_x, spawn_y)



func _wave_reader(waveData: Array) -> Array:
	var formatedData: Array
	var counter = 0
	var wavesize = waveData.size() - 1
	while counter < wavesize:
		var item = waveData[counter]
		if item == String:
			formatedData.append(item)
		else:
			formatedData[counter-1[0]] = item
			
	
	

func deployWave(waveData: Array) -> void:
	pass

func _on_timer_timeout() -> void:
	_spawn_selected_mob("normal")
