class_name State
extends Node

@export
var move_speed: float = 350

## Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D
var animation_player: AnimationPlayer

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
