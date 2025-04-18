extends CharacterBody2D

signal facing_changed

@onready var movement_state_machine = $StateMachine
@onready var animation_player = $AnimationPlayer

var last_velocity: Vector2 = Vector2(1,0);
var animationFacing = "right":
	get:
		return animationFacing
	set(value):
		animationFacing = value
		emit_signal("facing_changed")

func check_facing() -> void:
	var new_facing: String = animationFacing  # Default to current

	if velocity.x < 0:
		#print("LEFT")
		new_facing = "left"
	elif velocity.x > 0:
		#print("RIGHT")
		new_facing = "right"
	else:
		return  # Don't update if there's no movement

	if new_facing != animationFacing:
		animationFacing = new_facing
		emit_signal("facing_changed")

func _ready() -> void:
	movement_state_machine.init(self, animation_player)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)


func _on_facing_changed() -> void:
	scale.x=-1
