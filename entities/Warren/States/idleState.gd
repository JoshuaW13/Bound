extends State

@export
var move_state: State
@export var dash_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	animation_player.play("Idle")

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right') or Input.is_action_pressed('move_up')or Input.is_action_pressed('move_down'):
		return move_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null
