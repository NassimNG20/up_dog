class_name Simple_enemie
extends CharacterBody2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var simple_enemie_label: Label = $simple_enemie_label

@export var speed = 300.0
@export var simple_enemie_health: float = 2.0

var player: Node2D = null

func _ready() -> void:
	simple_enemie_label.text = str(simple_enemie_health)
	set_physics_process(false)
	player = get_tree().get_first_node_in_group("player")

func _on_visible_on_screen_notifier_2d_screen_entered() -> void: set_physics_process(true)
func _on_visible_on_screen_notifier_2d_screen_exited() -> void: set_physics_process(false)

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.global_position - position).normalized()
		velocity = direction * speed
	move_and_slide()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player: body.player_hit(1.0)

func simple_enemie_hit(dmg: float):
	if simple_enemie_health <= 1: queue_free()
	else :simple_enemie_health -= dmg
	simple_enemie_label.text = str(simple_enemie_health)
