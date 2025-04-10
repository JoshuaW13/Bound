extends CharacterBody2D

@onready var movement_state_machine = $StateMachine
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	movement_state_machine.init(self, animation_player)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
