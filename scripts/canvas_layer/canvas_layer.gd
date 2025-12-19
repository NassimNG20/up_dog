extends CanvasLayer

@onready var enemies_num: Label = $VBoxContainer/enemies_num
@onready var player_xp: Label = $VBoxContainer/player_xp
#
#	TO DO:
#	enemies num display on screen and every lable health "xp" ex...
#
@export var player_res: Player_res

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	enemies_num.text = "num = " + str(Global.enemies_on_screen)
	player_xp.text = "num = " + str(Global.player_xp)
