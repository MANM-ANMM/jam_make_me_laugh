extends CanvasLayer

func _ready():
	$Score.text = "Score: " + str(Var.score)

func _physics_process(_delta):
	if Input.is_action_pressed("start"):
		_on_restart_button_button_down()
	if Input.is_action_pressed("quit"):
		_on_close_button_button_down()

func _on_restart_button_button_down():
	if get_tree().change_scene_to_file("res://scenes/main.tscn") != OK:
		print ("Error passing from Opening scene to main scene")

func _on_close_button_button_down():
	get_tree().quit()
