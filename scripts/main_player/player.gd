class_name Player
extends CharacterBody2D

@export var bullet_scene: PackedScene
@export var player_res: Player_res

@onready var player_health_label: Label = $player_health_label

enum InputAxis { HORIZONTAL, VERTICAL }

var enemies_in_range: Array[Node2D] = []

# ---------------- INPUT ----------------
func get_input(axis: InputAxis) -> float:
	match axis:
		InputAxis.HORIZONTAL:
			return Input.get_axis("move_left", "move_right")
		InputAxis.VERTICAL:
			return Input.get_axis("move_up", "move_down")
	return 0.0

# ---------------- MOVEMENT ----------------
func _physics_process(delta: float) -> void:
	var input_vector := Vector2(
		get_input(InputAxis.HORIZONTAL),
		get_input(InputAxis.VERTICAL)
	)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(
			input_vector * player_res.player_move_speed,
			player_res.acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			player_res.friction * delta
		)

	move_and_slide()

# ---------------- SHOOTING ----------------
func _on_timer_timeout() -> void:
	if enemies_in_range.is_empty():
		return

	# Remove invalid enemies (killed / freed)
	enemies_in_range = enemies_in_range.filter(func(e): return is_instance_valid(e))

	if enemies_in_range.is_empty():
		return

	# Pick the closest enemy
	var target := enemies_in_range[0]
	var min_dist := global_position.distance_to(target.global_position)

	for enemy in enemies_in_range:
		var d := global_position.distance_to(enemy.global_position)
		if d < min_dist:
			min_dist = d
			target = enemy

	var bullet := bullet_scene.instantiate() as CharacterBody2D
	bullet.global_position = global_position
	bullet.direction = (target.global_position - global_position).normalized()

	get_tree().current_scene.add_child(bullet)

# ---------------- AREA DETECTION ----------------
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Simple_enemie and not enemies_in_range.has(body):
		enemies_in_range.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if enemies_in_range.has(body):
		enemies_in_range.erase(body)

# ---------------- DAMAGE ----------------
func player_hit(dmg: float) -> void:
	if player_res.player_health > 0:
		player_res.player_health -= dmg
		player_health_label.text = str(player_res.player_health)
	else:
		player_health_label.text = "player dead"
