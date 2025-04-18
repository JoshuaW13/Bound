extends State

@export var idle_state: State
@export var dash_state : State

@onready var diagonal_move_timer :Timer = $DiagonalMoveTimer

var moving_diagonal: bool = false

func setup_timer() ->void:
	diagonal_move_timer.one_shot = true
	diagonal_move_timer.wait_time = 0.02

func _ready() -> void:
	setup_timer()

func enter() -> void:
	animation_player.play("Walk")

func process_physics(delta: float) -> State:
	var horizontal_movement = Input.get_axis("move_left", "move_right")
	var vertical_movement = Input.get_axis("move_up", "move_down")
	
	if horizontal_movement !=0 and vertical_movement !=0:
		diagonal_move_timer.stop()
		moving_diagonal = true

	if horizontal_movement == 0 and vertical_movement == 0:
		return idle_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state

	var input_vector = Vector2(horizontal_movement, vertical_movement)
	var velocity = Vector2.ZERO
	
	if moving_diagonal and horizontal_movement ==0 or vertical_movement ==0:
		diagonal_move_timer.start()

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * move_speed
	if !moving_diagonal:
		parent.last_velocity = velocity
	elif moving_diagonal and horizontal_movement != 0 and vertical_movement !=0:
		parent.last_velocity = velocity

	parent.velocity = velocity
	parent.check_facing()
	parent.move_and_slide()
	return null


func _on_diagonal_move_timer_timeout() -> void:
	moving_diagonal = false;
