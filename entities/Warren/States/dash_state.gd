extends State

@export var idle_state: State
@export var move_state: State
@export var dash_speed = 600
@export var dash_time = 0.5

@onready var dash_timer = $DashTimer

var dashing: bool = false

func setup_timer() -> void:
	dash_timer.wait_time = dash_time
	dash_timer.one_shot = true
	dash_timer.start()

func enter() -> void:
	dashing = true
	setup_timer()
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if dashing:
		var dash_direction := Vector2.ZERO

		if parent.last_velocity.length() != 0:
			dash_direction = parent.last_velocity.normalized()
		else:
			dash_direction = Vector2.RIGHT

		parent.velocity = dash_direction * dash_speed
		parent.move_and_slide()
	else:
		if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right') or Input.is_action_pressed('move_up')or Input.is_action_pressed('move_down'):
			return move_state
		return idle_state
	return null


func _on_dash_timer_timeout() -> void:
	dashing = false
