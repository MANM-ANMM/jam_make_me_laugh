extends CharacterBody2D

@export var movement_speed: float = 80.0
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
var fou:Player

enum State {
	Normal,
	Traque
}

var state : State = State.Normal :
	set(value):
		if value == state: return
		
		state = value
		match state:
			State.Traque:
				set_movement_target(fou.global_position)
				$TimerActualiseTraque.start()
			State.Normal:
				$TimerActualiseTraque.stop()

func _process(delta):
	rotate(angle_difference(rotation, velocity.angle())*delta*20.0)

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	
	match state:
		State.Normal:
			move_normal()
		State.Traque:
			move_normal()

func move_normal():
	if navigation_agent.is_navigation_finished():
		var destination := Vector2(randf_range(-646, 2188.0), randf_range(-289.0, 1819.0))
		var dest = NavigationServer2D.map_get_closest_point(navigation_agent.get_navigation_map(), destination)
		set_movement_target(dest)
		return
	
	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func _on_navigation_agent_2d_set_up_terminated():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	set_movement_target(global_position)


func _on_detection_fou_body_entered(body):
	fou = body
	state = State.Traque


func _on_timer_actualise_traque_timeout():
	set_movement_target(fou.global_position)


func _on_detection_perte_fou_body_entered(_body):
	state = State.Normal


func _on_detection_npc_fuyants_body_entered(body):
	if state != State.Traque:
		set_movement_target(body.derniere_position_clown)
