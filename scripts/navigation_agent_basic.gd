extends NavigationAgent2D

signal set_up_terminated()

var agent: RID = get_rid()

func _ready():
	set_up.call_deferred()

func set_up():
	# Enable avoidance
	NavigationServer2D.agent_set_avoidance_enabled(agent, true)
	# Create avoidance callback
	NavigationServer2D.agent_set_avoidance_callback(agent, Callable(self, "_avoidance_done"))

	set_up_terminated.emit()
