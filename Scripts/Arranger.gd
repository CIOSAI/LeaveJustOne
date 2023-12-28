extends Control

const level_order_dir:String = "res://levelOrder.tres"

onready var card = preload("res://Scenes/LevelCard.tscn")
onready var tm = $"TileMap"

var order:LevelOrder

func spawn_card(pos:Vector2, t:String):
	var n = card.instance()
	n.global_position = pos
	n.set_text(t)
	n.connect("set_down", self, "on_card_set_down")
	add_child(n)

func on_card_set_down(level_name:String, pos:Vector2):
	order.mov_level(level_name, get_pos_index(pos))
	save_order()
	render_cards()

func get_pos_index(pos:Vector2)->int:
	var coord:Vector2 = wtm(pos)
	return int(coord.y*12+coord.x)

func get_card_pos(n:int)->Vector2:
	return mtw(Vector2(n%12, n/12))+tm.cell_size*tm.scale/2.0

func save_order():
	ResourceSaver.save(level_order_dir, order)

func load_order():
	order = load(level_order_dir)

func render_cards():
	for i in get_children():
		if i is LevelCard:
			i.queue_free()
	
	for i in order.levelNames.size():
		spawn_card(get_card_pos(i), order.levelNames[i])

func _ready():
	load_order()
	render_cards()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		LevelSave.load_levels()
		get_tree().change_scene("res://Scenes/TempMenu.tscn")

func mtw(v:Vector2)->Vector2:
	return tm.map_to_world(v)*tm.scale

func wtm(v:Vector2)->Vector2:
	return tm.world_to_map(v/tm.scale)

func in_bound(v:Vector2)->bool:
	return Rect2(Vector2.ZERO, Vector2.ONE*12).has_point(v)

func _process(delta):
	for i in tm.get_used_cells_by_id(1):
		tm.set_cellv(i, 0)
	var target:Vector2 = wtm(get_global_mouse_position())
	if in_bound(target): tm.set_cellv(target, 1)
	
