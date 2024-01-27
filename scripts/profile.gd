extends Node2D
class_name Profil
enum EYE_POS {Right, Left, Center}
enum FLEE_DIR {Right, Left, Down}

signal speak_ends
signal flee_ends

#childs
@onready var node_face = $Face
@onready var node_pupils = $Pupils
@onready var node_mouth_s = $MouthS
@onready var node_mouth_o = $MouthO


var eye_dest := Vector2.ZERO
var eye_pos := Vector2.ZERO


var flee_dest : Vector2 = Vector2(0, 0)
var fleeing := false
@export var fleeing_time := 1.4
var fleeing_progress := fleeing_time
var start_pos : Vector2
var start_scale : Vector2


var sentence := ""
var word_progress := speak_speed

@export var eye_shaking : int = 0
@export_range(0, 100) var eye_radius : int = 10
@export var speak_speed := .07

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _set_from_angle(angle : float):
	eye_dest.x = cos(angle) * eye_radius
	eye_dest.y = sin(angle) * eye_radius
	
func look_toward(pos : EYE_POS):
	match pos:
		EYE_POS.Right:
			_set_from_angle(0)
		EYE_POS.Left:
			_set_from_angle(PI)
		EYE_POS.Center:
			eye_dest = Vector2.ZERO
			
func speak(tone_sequence : String):
	sentence = tone_sequence.reverse()
	
func flee(dir : FLEE_DIR):
	var bounds = get_tree().root.content_scale_size
	fleeing = true
	start_pos = position
	start_scale = scale
	match dir:
		FLEE_DIR.Left:
			flee_dest = Vector2(-bounds.x - 100, bounds.y / 2)
		FLEE_DIR.Right:
			flee_dest = Vector2(bounds.x + 100, bounds.y / 2)
		FLEE_DIR.Down:
			flee_dest = Vector2(position.x, bounds.y + 100)
			
	
func _set_mouth_pos(open : bool):
	node_mouth_o.visible = open
	node_mouth_s.visible = !open


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ratio = delta * 1.5
	eye_pos = eye_pos * (1 - ratio) + eye_dest * ratio
	if (eye_shaking != 0):
		node_pupils.position = eye_pos + Vector2(randi_range(-eye_shaking, eye_shaking),
									 randi_range(-eye_shaking, eye_shaking))
	else:
		node_pupils.position = eye_pos
	
	
	
	if (sentence != ""):
		word_progress -= delta
		if (word_progress <= 0):
			word_progress = speak_speed
			_set_mouth_pos(sentence.right(1) == "O")
			sentence = sentence.erase(sentence.length()-1)
			if (sentence.length() == 0):
				_set_mouth_pos(false)
				emit_signal("speak_ends")
	
	
	if (fleeing):
		fleeing_progress -= delta
		var progression : float = 1 - fleeing_progress / fleeing_time
		position = start_pos + ease(progression, 2) * (flee_dest - start_pos)
		scale = start_scale + ease(progression, 1./2.) * (Vector2(0.1, 0.1) - start_scale)
		if (progression <= 0):
			fleeing = false
			emit_signal("flee_ends")
