extends Piece

func _on_Boulder_picked_up():
	yield(get_tree().create_timer(0.05), "timeout")
	controller.drop()
