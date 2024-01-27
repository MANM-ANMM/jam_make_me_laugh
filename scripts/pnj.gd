extends CharacterBody2D
class_name PNJ

@export var movement_speed: float = 80.0
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
var target_entrance:Marker2D
var commisariat: Marker2D

enum State {
	Normal,
	Fly,
}

var state : State = State.Normal


func _process(_delta):
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
	queue_free()

func fuire():
	state = State.Fly
	set_movement_target(commisariat.global_position)
	navigation_agent.avoidance_mask += 4
	navigation_agent.avoidance_priority = 1.0

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func _on_navigation_agent_2d_set_up_terminated():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	if target_entrance:
		set_movement_target(target_entrance.global_position)
