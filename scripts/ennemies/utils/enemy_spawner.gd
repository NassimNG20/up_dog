extends Node2D

# Enemy scene to spawn (drag enemy.tscn here in the Inspector)
@export var enemy_scene: PackedScene
# Distance from the player where enemies will spawn
@export var spawn_radius := 600.0
# Time (in seconds) between each spawn
@export var spawn_delay := 1.0
# Reference to the player node
var player: Node2D

func _ready():
	# Get the player automatically using the "player" group
	player = get_tree().get_first_node_in_group("player")
	# Start the infinite spawn loop
	spawn_loop()


func spawn_loop() -> void:
	# Infinite loop that spawns enemies every spawn_delay seconds
	while true:
		await get_tree().create_timer(spawn_delay).timeout
		spawn_enemy()


func spawn_enemy():
	# Safety check in case the player doesn't exist
	if not player: return
	# Create a new enemy instance
	var enemy = enemy_scene.instantiate()
	# Add the enemy to the same parent as the spawner
	get_parent().add_child(enemy)
	# Pick a random direction around the player (0 → 360°)
	var angle = randf() * TAU
	
	# Convert the angle to a position offset at spawn_radius distance
	var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	
	# Place the enemy around the player
	enemy.global_position = player.global_position + offset
