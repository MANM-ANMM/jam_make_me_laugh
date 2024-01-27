extends CanvasLayer

func _ready():
	TranslationServer.set_locale("en")

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

func _on_language_button_item_selected(index):
		match index:
			0:
				TranslationServer.set_locale("en")
			1:
				TranslationServer.set_locale("fr")
