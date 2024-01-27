extends CharacterBody2D
class_name PNJ

@export var movement_speed: float = 80.0
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
var target_entrance:Marker2D
var fou:Player

enum State {
	Normal,
	Accoste,
	Fly,
}

var state : State = State.Normal


func _process(delta):
	rotation = velocity.angle()

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	match state:
		State.Normal:
			move_normal()
		State.Accoste:
			pass
		State.Fly:
			move_fly()

func move_fly():
	var dir := (global_position - fou.global_position).normalized()
	velocity = dir * movement_speed
	move_and_slide()

func move_normal():
	if navigation_agent.is_navigation_finished():
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
		State.Accoste:
			state = State.Fly
		State.Fly:
			tuer()

func accoster(player:Player):
	navigation_agent.velocity_computed.disconnect(_on_velocity_computed)
	velocity = Vector2.ZERO
	state = State.Accoste
	fou = player

func tuer():
	queue_free()


func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func _on_navigation_agent_2d_set_up_terminated():
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	if target_entrance:
		set_movement_target(target_entrance.global_position)
