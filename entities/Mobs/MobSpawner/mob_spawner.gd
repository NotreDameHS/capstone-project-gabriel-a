extends Node2D
@onready var timer = $Timer
@export var mob_types: Array[PackedScene] 
@export var mobsToSpawn: Array #Will receive the mobs that will spawn this round.
@export var spawnRate: float
@export var mobsSpawned =  0
@export var padding: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(spawnRate)
	var viewport_size = get_viewport_rect().size
	var spawn_pos = Vector2(viewport_size.x + padding, randf_range(0, viewport_size.y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	for mob in mobsToSpawn:
		pass

func _wave_ended():
	print("stopped MobSpawner.")
	queue_free()
