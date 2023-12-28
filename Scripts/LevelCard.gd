extends Node2D
class_name LevelCard

onready var controller = $"Control"

var text:String
var orig_pos:Vector2

signal set_down(level_name, pos)

func _ready():
	orig_pos = global_position

func set_text(t:String):
	text = t
	$"Control/Label".text = t

func _process(delta):
	global_position = get_global_mouse_position() if controller.holding else orig_pos

func _on_Control_set_down():
	emit_signal("set_down", text, global_position)
