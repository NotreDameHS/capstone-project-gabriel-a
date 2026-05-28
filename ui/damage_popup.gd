extends Node2D

@onready var damage_label: Label = $Damage

func display_damage(amount: int) -> void:
	# Slightly shift the x position for every label
	position.x += randf_range(-20.0, 20.0)
	# Set the text to the damage amount
	damage_label.text = str(amount)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
