extends EnemyState

@export var pursuit_speed = 200

func enter() -> void:
	pass

func process_physics(_delta: float) -> State:
	var direction_to_target = (target_area.global_position - parent.position).normalized()
	parent.velocity = direction_to_target * pursuit_speed
	parent.move_and_slide()
	return null

func _on_observation_area_area_entered(area: Area2D) -> void:
	target_area = area
