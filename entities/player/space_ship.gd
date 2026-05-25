class_name  player extends Node2D
@onready var projectileSpawn = $Marker2D
@onready var timer = $Timer
@export var attackrate = 1
@export var projectilePerShot = 1
@export var homing = false
@export var damage = 50
var speed := 1200.0
var velocity = Vector2(0, 0)
var steering_factor := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(attackrate)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Vector2(0,0)
	direction.x = Input.get_axis("Left","Right")
	direction.y = Input.get_axis("Upward","Downward")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	var desired_velocity := direction * speed
	var steering_vector = desired_velocity - velocity
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta



func _on_timer_timeout() -> void:
	print("bullet shot!")
