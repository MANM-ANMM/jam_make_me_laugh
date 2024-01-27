extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var red_light = $red
@onready var blue_light = $blue
@export_range(0.01, 20,0.01) var light_speed : float = 1.23

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	red_light.rotate(delta*PI*light_speed)
	blue_light.rotate(delta*PI*2*light_speed)
