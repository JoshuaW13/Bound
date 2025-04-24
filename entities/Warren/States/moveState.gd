extends State

@export var idle_state: State
@export var roll_state: State
@onready var diagonal_move_timer: int = 0

var moving_diagonal: bool = false

func get_input_vector() -> Vector2:
	var h = Input.get_axis("move_left", "move_right")
	var v = Input.get_axis("move_up", "move_down")
	return Vector2(h, v)

func is_idle_input(input_vector: Vector2) -> bool:
	return input_vector == Vector2.ZERO

func is_roll_pressed() -> bool:
	return Input.is_action_just_pressed("roll") and parent.can_roll

func calculate_velocity(input_vector: Vector2) -> Vector2:
	if input_vector.length() == 0:
		return Vector2.ZERO
	return input_vector.normalized() * move_speed

func handle_diagonal_tracking(input_vector: Vector2) -> void:
	var is_diagonal = abs(input_vector.x) > 0 and abs(input_vector.y) > 0
	var is_partial_release = moving_diagonal and (input_vector.x == 0 or input_vector.y == 0)

	if is_diagonal:
		diagonal_move_timer = 0
		moving_diagonal = true
	elif is_partial_release:
		diagonal_move_timer += 1

	if diagonal_move_timer >2:
		moving_diagonal = false

func update_last_velocity(input_vector: Vector2, velocity: Vector2) -> void:
	var is_diagonal = abs(input_vector.x) > 0 and abs(input_vector.y) > 0
	if !moving_diagonal or is_diagonal:
		parent.last_velocity = velocity

func apply_movement(velocity: Vector2) -> void:
	parent.velocity = velocity
	parent.check_facing()
	parent.move_and_slide()

func enter() -> void:
	animation_player.play("Walk")

func process_physics(_delta: float) -> State:
	var input_vector = get_input_vector()

	handle_diagonal_tracking(input_vector)

	if is_idle_input(input_vector):
		return idle_state
	if is_roll_pressed():
		return roll_state

	var velocity = calculate_velocity(input_vector)

	update_last_velocity(input_vector, velocity)

	apply_movement(velocity)

	return null
