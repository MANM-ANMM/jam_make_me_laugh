extends CharacterBody2D
class_name PNJ

@export var movement_speed: float = 80.0
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
var target_entrance:Marker2D
var commisariat: Marker2D
var derniere_position_clown : Vector2
var audio
var audio_help
var chosen_audio
var chosen_help
var scene
var instance

enum State {
	Normal,
	Fly,
}

var state : State = State.Normal
@onready var animated_sprite := $AnimatedSprite2D

func _ready():
	scene = preload("res://scenes/death.tscn")

	set_anim.call_deferred()
	animated_sprite.speed_scale = 0.0
	audio = [get_node("AudioStreamPlayer2D"), get_node('AudioStreamPlayer2D2'), get_node('AudioStreamPlayer2D3')]
	audio_help = [get_node("Alaide"), get_node("Ayuda"), get_node("Help")]
	
	audio.shuffle()
	audio_help.shuffle()
	
	chosen_audio = audio[0]
	chosen_help = audio_help[0]
	
	chosen_audio.play()

func set_anim():
	animated_sprite.play($Joke.profile)
	

func _process(_delta):
	if velocity != Vector2.ZERO:
		rotation = velocity.angle()

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	move_normal()

func move_normal():
	if navigation_agent.is_navigation_finished():
		if state == State.Fly:
			commisariat.report_aggression()
		queue_free()
		return
	
	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func interact(player:Player):
	match state:
		State.Normal:
			accoster(player)
		State.Fly:
			tuer()

func accoster(player:Player):
	BusEvent.dialog.emit($Joke.profile, $Joke.joke)
	fuire()

func tuer():
	chosen_help.stop()
	Var.score+=1
	instance = scene.instantiate()
	instance.global_position = self.global_position
	add_sibling(instance)
	queue_free()

func fuire():
	chosen_audio.stop()
	chosen_help.play()
	state = State.Fly
	set_movement_target(commisariat.global_position)
	navigation_agent.avoidance_mask += 4
	navigation_agent.avoidance_priority = 1.0
	collision_layer += 16 # npc en fuite
	derniere_position_clown = global_position

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	animated_sprite.speed_scale = safe_velocity.length()/movement_speed
	move_and_slide()

func _on_navigation_agent_2d_set_up_terminated():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	if target_entrance:
		set_movement_target(target_entrance.global_position)

func _on_death_finished():
	queue_free()
