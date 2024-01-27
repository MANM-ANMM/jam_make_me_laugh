extends Node2D

var skippable = false
var profile
var joke

func _ready():
	$CanvasLayer/Skip.visible = false
	$CanvasLayer/Joke.text = joke
	$Profile.speak("oOoOoOoooOOOOoooooOOoOOOOoOOOoOOO")

func _update_face(_delta):
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

	if skippable and Input.is_action_just_pressed("interaction"):
		$Profile.flee(Profil.FLEE_DIR.Down)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_face(delta)

func _on_timer_timeout():
	skippable = true
	$CanvasLayer/Skip.visible = true

func _on_profile_flee_ends():
	BusEvent.end_dialog.emit()
	queue_free()
