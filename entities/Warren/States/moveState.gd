extends State

@export var idle_state: State
@export var dash_state : State

func enter() -> void:
	animation_player.play("Walk")

func process_physics(delta: float) -> State:
	var horizontal_movement = Input.get_axis("move_left", "move_right")
	var vertical_movement = Input.get_axis("move_up", "move_down")

	if horizontal_movement == 0 and vertical_movement == 0:
		return idle_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state

	var input_vector = Vector2(horizontal_movement, vertical_movement)
	var velocity = Vector2.ZERO

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * move_speed
		parent.last_velocity = velocity

	parent.velocity = velocity
	parent.check_facing()
	parent.move_and_slide()
	return null
