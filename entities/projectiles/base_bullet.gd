extends Area2D
@export var max_distance := 900.0 #This will be changed after the level scene is made
@export var speed := 1000.0
var velocity: Vector2 = Vector2(0, 0)
var _distance_traveled := 0.0
var damage: float 
var targetRotation = 0.0
var direction: int  #positive means right, minus means left
var groupToAttack: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void: #this is to get the bullet facing the right direction.
	if direction == -1:
		targetRotation = -90.0
	elif direction == 1:
		targetRotation = 90.0
	else:
		print("direction variable invalid!")
	$Sprite2D.rotation_degrees = targetRotation
	$CollisionShape2D.rotation_degrees = targetRotation
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = transform.x * speed
	position += (velocity * direction)  * delta 
	_distance_traveled += speed * delta
	if _distance_traveled  > max_distance:
		_explode()

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
	gradient.add_point(0.0, Color(1, 1, 1, 1)) 
	gradient.add_point(1.0, Color(1, 1, 1, 0)) 
	particles.color_ramp = gradient 
	# Turn on the particle cloud
	particles.emitting = true
	# Tell the particles to delete themselves after their lifetime.
	var timer = get_tree().create_timer(particles.lifetime + 0.5)
	timer.timeout.connect(particles.queue_free) 



func _on_area_entered(area: Area2D) -> void:
	print("scene: ",area," Entered")
	if area.is_in_group(groupToAttack):
		area._take_Damage(damage)
		_explode()
