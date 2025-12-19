extends Node2D

# Enemy scene to spawn (drag enemy.tscn here in the Inspector)
@export var enemy_scene: PackedScene
# Distance from the player where enemies will spawn
@export var spawn_radius := 600.0
# Time (in seconds) between each spawn
@export var spawn_delay: float
# Reference to the player node
var player: Node2D
var enemies_num: int = 0

func _ready():
	# Get the player automatically using the "player" group
	player = get_tree().get_first_node_in_group("player")
	# Start the infinite spawn loop
	spawn_loop()


func spawn_loop() -> void:
	# Infinite loop that spawns enemies every spawn_delay seconds
	while enemies_num < 400:
		await get_tree().create_timer(spawn_delay).timeout
		spawn_enemy()


func spawn_enemy():
	# Safety check in case the player doesn't exist
	if not player: return
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemies_num = enemies_num + 1
	Global.enemies_on_screen = enemies_num
	var angle = randf() * TAU
	
	# Convert the angle to a position offset at spawn_radius distance
	var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	
	# Place the enemy around the player
	enemy.global_position = player.global_position + offset
