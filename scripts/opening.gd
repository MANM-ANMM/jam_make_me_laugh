extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if Input.is_action_pressed("start"):
		_on_start_button_button_down()
	if Input.is_action_pressed("quit"):
		_on_close_button_button_down()

func _on_start_button_button_down():
	if get_tree().change_scene_to_file("res://scenes/level.tscn") != OK:
		print ("Error passing from Opening scene to main scene")

func _on_close_button_button_down():
	get_tree().quit()
