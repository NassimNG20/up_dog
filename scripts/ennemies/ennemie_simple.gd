extends CharacterBody2D


@export var speed = 300.0
@export var target = Node2D

var player: Node2D = null
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta: float) -> void:
	if player:
		# Move towards the player or follow the player
		var direction = (player.global_position - global_position).normalized()
		# Move with a certain speed
# animation 
		velocity = direction * speed
	move_and_slide()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		print( "body : ", body)
		body.player_hit()
	#if body == Player_res:
		#print("hit player")
