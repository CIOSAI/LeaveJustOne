extends TextEdit

export(NodePath) var target_hand_path

var target_hand

var held
var focused:bool = false

func _ready():
	target_hand = get_node(target_hand_path)

func _on_AddToHand_mouse_entered():
	focused = true
	held = get_parent().get_piece_held()
	if held:
		self_modulate = Color(1.4, 1.4, 1.4)

func _on_AddToHand_mouse_exited():
	focused = false
	self_modulate = Color(1.0, 1.0, 1.0)

func _input(event):
	if focused:
		if event.is_action_released("MouseClick"):
			if held:
				target_hand.add_piece(held.piece_index)
