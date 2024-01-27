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
	instance = scene.instantiate()
	add_child(instance)
	
func _on_end_dialog():
	$Level/Player/Camera2D.enabled = true
	$Level.get_tree().paused = false
