extends State

@export
var idle_state: State

func process_physics(delta: float) -> State:
	
	var horizontal_movement = Input.get_axis('move_left', 'move_right') * move_speed
	var vertical_movement = Input.get_axis("move_up","move_down")*move_speed
	
	if horizontal_movement == 0 and vertical_movement== 0:
		return idle_state
	
	parent.velocity.x = horizontal_movement
	parent.velocity.y = vertical_movement
	parent.move_and_slide()
	
	return null
