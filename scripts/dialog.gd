extends Node2D

var skippable = false
var profile
var joke

func _ready():
	$CanvasLayer/Joke.text = joke

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
			
	if Input.is_action_just_pressed("ui_accept"):
		#$Profile.speak("oOoOoOoooOOOOoooooOOoOOOOoOOOoOOOOOoooooOOOOOoooooOOOoooOOoOOOOOOooOoOoO")
		$Profile.flee(Profil.FLEE_DIR.Down)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_face(delta)
	if skippable and Input.is_action_just_released("interaction"):
		BusEvent.end_dialog.emit()
		queue_free()

func _on_timer_timeout():
	skippable = true
