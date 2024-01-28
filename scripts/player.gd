extends CharacterBody2D

class_name Player
const SPEED = 120.0

@onready var area_detection_pnj := $DetectPNJ
@onready var animated_sprite := $AnimatedSprite2D

func _ready():
	animated_sprite.play()
	animated_sprite.speed_scale = 0.0
	$Vengeance.play()

func _process(_delta):
	if velocity != Vector2.ZERO:
		rotation = velocity.angle()

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
	
	animated_sprite.speed_scale = velocity.length()/SPEED
	
	move_and_slide()

func lose():
	get_tree().change_scene_to_file.call_deferred("res://scenes/ending.tscn")

func _on_timer_timeout():
	$Vengeance.play()

func _on_vengeance_finished():
	$Timer.start()
