extends CharacterBody2D

class_name Player
const SPEED = 500.0

@onready var area_detection_pnj := $DetectPNJ

func _physics_process(_delta):
	move()
	action()

func action():
	if Input.is_action_just_pressed("interaction"):
		if area_detection_pnj.has_overlapping_bodies():
			print("choppe")
			var npc : PNJ = area_detection_pnj.get_overlapping_bodies().front()
			npc.interact(self)

func move():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func lose():
	if get_tree().change_scene_to_file("res://scenes/ending.tscn") != OK:
		print ("Error passing from Opening scene to main scene")
