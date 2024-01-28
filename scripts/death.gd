extends Node2D

var audio_death
var chosen_death

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_death = [get_node("Death"), get_node("Death2"), get_node("Death3")]
	audio_death.shuffle()
	chosen_death = audio_death[0]
	chosen_death.play()

func _on_death_finished():
	queue_free()
