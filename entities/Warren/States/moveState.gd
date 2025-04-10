extends State

@export var idle_state: State

var facing = "right"

signal facing_changed

func enter() -> void:
	animation_player.play("Walk")

func check_facing() -> void:
	var new_facing: String = facing  # Default to current

	if parent.velocity.x < 0:
		#print("LEFT")
		new_facing = "left"
	elif parent.velocity.x > 0:
		#print("RIGHT")
		new_facing = "right"
	else:
		return  # Don't update if there's no movement

	if new_facing != facing:
		facing = new_facing
		emit_signal("facing_changed")

func process_physics(delta: float) -> State:
	var horizontal_movement = Input.get_axis("move_left", "move_right")
	var vertical_movement = Input.get_axis("move_up", "move_down")

	if horizontal_movement == 0 and vertical_movement == 0:
		return idle_state

	var velocity = Vector2(horizontal_movement, vertical_movement)
	if velocity.length() > 0:
		velocity = velocity.normalized() * move_speed
	parent.velocity = velocity
	check_facing()
	parent.move_and_slide()

	return null


func _on_facing_changed() -> void:
	parent.scale.x=-1
