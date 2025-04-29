extends EnemyState

@export var pursuit_state: EnemyState

var target_detected = false

func process_frame(_delta: float) -> State:
	if target_detected:
		pursuit_state.target_area = target_area
		return pursuit_state
	return null

func _on_observation_area_area_entered(area: Area2D) -> void:
	target_area = area
	target_detected = true
