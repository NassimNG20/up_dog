extends Camera2D

@export var target: Node2D
@export var smooth_speed := 10.0

func _physics_process(delta: float) -> void:
	if not target: return
	global_position = global_position.lerp(
		target.global_position,
		smooth_speed * delta
	)
