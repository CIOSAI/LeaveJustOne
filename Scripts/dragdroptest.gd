extends Panel

onready var controller = $"Control"

var old_pos = rect_global_position

func _process(delta):
	if controller.holding:
		rect_global_position = get_global_mouse_position()

func _on_Control_picked_up():
	old_pos = rect_global_position


func _on_Control_set_down():
	rect_global_position = old_pos

func _input(event):
	print(event)
