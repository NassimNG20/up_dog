extends CharacterBody2D

@export var speed: float = 900.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		velocity = direction * speed
		move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Simple_enemie:
		body.simple_enemie_hit(1)
	queue_free()
