extends Node2D

var effect
var recording
var idx
var maxVolume = 0.0

func _ready():
	idx = AudioServer.get_bus_index("Laughter")
	effect = AudioServer.get_bus_effect(idx, 0)
	effect.set_recording_active(true)

func _physics_process(_delta):
	var power = AudioServer.get_bus_peak_volume_left_db(idx, 0)
	power = clamp(db_to_linear(power), 0.0, 1.0)
	if maxVolume < power :
		maxVolume = power

func _on_timer_timeout():
	recording = effect.get_recording()
	effect.set_recording_active(false)
	$AudioStreamRecord.stop()
	print("Max: " + str(maxVolume))
