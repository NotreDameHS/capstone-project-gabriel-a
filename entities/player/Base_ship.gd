class_name  Player extends Area2D
@onready var bulletSpawn = $Marker2D
@onready var attacktimer = $Timer
@export var attackrate = 100
@export var projectilePerShot = 1
@export var homing = false
@export var damage = 50
@export var bulletScene: PackedScene
@export var playerHealth = 100
var speed := 1200.0
var velocity = Vector2(0, 0)
var steering_factor := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attacktimer.start(attackrate/100.0) #this lets me edit the attackrate easier


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

func _explode() -> void:
	spawn_poof(global_position)
	queue_free()

func spawn_poof(projectile_position: Vector2): #Copied from Tower_Defence
	# Create a new CPUParticles2D node 
	var particles = CPUParticles2D.new()
	# Spawn it on the WORLD scene (not a child of the projectile)
	get_tree().current_scene.add_child(particles)
	# Now that it's in the world, global_position works perfectly
	particles.global_position = projectile_position
	# Create a particle cloud (a "poof" of particles from the center)
	particles.z_index = 100 
	particles.z_as_relative = false 
	particles.amount = 20
	particles.lifetime = 0.5
	particles.explosiveness = 1.0
	particles.one_shot = true
	particles.scale_amount_min = 10.0 
	particles.scale_amount_max = 20.0
	particles.spread = 180.0
	particles.gravity = Vector2(0, 0)
	particles.initial_velocity_min = 80.0
	particles.initial_velocity_max = 150.0
	particles.damping_min = 50.0 
	# Design the shape of the cloud (the "poof")
	var curve = Curve.new()
	curve.add_point(Vector2(0, 1.0)) 
	curve.add_point(Vector2(1, 0.0))
	particles.scale_amount_curve = curve
	# Design the colours of the cloud
	var gradient = Gradient.new()
	gradient.add_point(0.0, Color(1.0, 0.367, 0.0, 1.0)) #I wanted different colors
	gradient.add_point(1.0, Color(1.0, 0.0, 0.0, 0.729)) 
	particles.color_ramp = gradient 
	# Turn on the particle cloud
	particles.emitting = true
	# Tell the particles to delete themselves after their lifetime.
	var timer = get_tree().create_timer(particles.lifetime + 0.5)
	timer.timeout.connect(particles.queue_free) 

func _on_timer_timeout() -> void:
	var bullet = bulletScene.instantiate()
	bullet.damage = damage
	bullet.direction = 1
	bullet.groupToAttack = "Mob"
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = bulletSpawn.global_position #this sets the location
	bullet.global_rotation = bulletSpawn.global_rotation #this sets the rotation.

func _take_Damage(damageTaken) -> void:
	print("Player's Ship health at: ",playerHealth)
	playerHealth =- damageTaken
	print("Player's Ship took ",damageTaken," damage!")
	print("Player's Ship new health at: ",playerHealth)
	if playerHealth <= 0:
		print("Player defeated!")
		_explode()
	else:
		pass

func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
