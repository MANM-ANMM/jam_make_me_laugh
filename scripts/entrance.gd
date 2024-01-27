extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	(func ():	BusEvent.i_am_an_entrance.emit(self)).call_deferred()
