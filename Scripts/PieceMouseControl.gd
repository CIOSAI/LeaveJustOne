extends Control

var controllable:bool = true
var holding:bool = false
var focused:bool = false

signal picked_up
signal set_down

func _on_Control_mouse_entered():
	focused = true

func _on_Control_mouse_exited():
	focused = false

func hand_occupied():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func hand_free():
	mouse_filter = Control.MOUSE_FILTER_STOP if controllable else Control.MOUSE_FILTER_IGNORE

func pickup():
	holding = true
	emit_signal("picked_up")

func drop():
	holding = false
	emit_signal("set_down")

func _input(event):
	if !controllable: return
	if Globals.mouse_hold:
		if event.is_action_pressed("MouseClick")&&focused:
			pickup()
		if event.is_action_released("MouseClick")&&holding:
			drop()
	else:
		if event.is_action_released("MouseClick")&&focused:
			if holding: drop()
			else: pickup()
