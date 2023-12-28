extends Piece

const everywhere_pattern = preload("res://Scenes/MovePatterns/EverywherePattern.tscn")

var is_hand_occupied:bool = true
var ind_of_focused:int = 0

signal hand_mouse_entered(n)

func _ready():
	var n = everywhere_pattern.instance()
	add_child(n)
	move_pattern = n
	death_particle.queue_free()
	
	connect("tree_exited", self, "on_tree_exited")
	controller.connect("mouse_entered", self, "emit_hand_mouse_entered")
	controller.connect("picked_up", self, "remove_piece")

func remove_piece():
	queue_free()

func emit_hand_mouse_entered():
	emit_signal("hand_mouse_entered", get_index())

func hand_occupied(n:int):
	is_hand_occupied = true
	ind_of_focused = n

func hold_position():
	pos_animate(get_global_mouse_position()-get_parent().position)

func rest_position():
	pos_animate(Vector2(
		(get_index()-get_parent().get_child_count()/2.0+0.5)*72, 
		-24 if get_index()==ind_of_focused else 0)
	)

func death():
	pass

func queue_free():
	dead = true
	.queue_free()

func set_on_vacant_spot(dest:Vector2):
	var tar:Piece = Globals.gm.piece_at(dest)
	if is_instance_valid(tar):
		tar.death()
	pos = dest
	emit_signal("setted")

func spots_allowed():
	return []

func world_to_grid():
	return Globals.gm.world_to_grid(
		get_global_mouse_position()-Globals.gm.position
	)

func on_tree_exited():
	Globals.gm.clear_grid_display()
