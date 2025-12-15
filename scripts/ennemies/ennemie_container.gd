extends CharacterBody2D


@export var smooth_speed = 300.0
@export var target = Node2D

var player: Node2D = null
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	print(player)
	if player:
		print(player.global_position)
		# Move towards the player or follow the player
		var direction = (player.global_position - global_position).normalized()
		# Move with a certain speed
		var speed = 100.0
		velocity = direction * speed
	move_and_slide()
