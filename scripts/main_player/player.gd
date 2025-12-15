extends CharacterBody2D


#var player_movements = Vector2.ZERO

@export var player_res: Player_res


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	player_res.player_movements.x = Input.get_axis("move_left", "move_right")
	player_res.player_movements.y = Input.get_axis("move_up", "move_down")
	
	var input_dir := player_res.player_movements.normalized()

	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(
			input_dir * player_res.player_move_speed,
			player_res.acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			player_res.friction * delta
		)

	
	move_and_slide()
