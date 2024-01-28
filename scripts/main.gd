extends Node2D

var scene
var instance

# Called when the node enters the scene tree for the first time.
func _ready():
	scene = preload("res://scenes/dialog.tscn")
	BusEvent.dialog.connect(_on_dialog)
	BusEvent.end_dialog.connect(_on_end_dialog)

func _on_dialog(_profile, _joke):
	$Level/Player/Camera2D.enabled = false
	$Level.get_tree().paused = true
	$Level.visible = false
	instance = scene.instantiate()
	instance.profile = _profile
	instance.joke = _joke
	instance.init()
	add_child(instance)
	
func _on_end_dialog():
	$Level/Player/Camera2D.enabled = true
	$Level.get_tree().paused = false
	$Level.visible = true
	$Level/Player.set_physics_process(false)
	get_tree().create_timer(0.5).timeout.connect(func():$Level/Player.set_physics_process(true))
