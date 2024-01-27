extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _update_face(delta):
	if Input.is_action_just_pressed("move_left"):
		$Profile.look_toward(Profil.EYE_POS.Left)
	if Input.is_action_just_pressed("move_right"):
		$Profile.look_toward(Profil.EYE_POS.Right)		
	if Input.is_action_just_pressed("move_down"):
		$Profile.look_toward(Profil.EYE_POS.Center)
	if Input.is_action_just_pressed("move_up"):
		if $Profile.eye_shaking == 0:
			$Profile.eye_shaking = 2
		else:
			$Profile.eye_shaking = 0
			
	if Input.is_action_just_pressed("ui_accept"):
		#$Profile.speak("oOoOoOoooOOOOoooooOOoOOOOoOOOoOOOOOoooooOOOOOoooooOOOoooOOoOOOOOOooOoOoO")
		$Profile.flee(Profil.FLEE_DIR.Down)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_face(delta)
		
