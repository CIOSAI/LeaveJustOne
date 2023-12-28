extends Node

const level_resource_dir:String = "res://Level/"
const level_order_dir:String = "res://levelOrder.tres"

var order:LevelOrder
var all_levels:Array = []

func _ready():
	change_level_name()
	
	load_levels()

func change_level_name():
	#comment out the return to turn it on
	return 0
	
	var change_from:String = "Ram or Grub Introduction"
	var change_to:String = "Leave Just One"
	
	order = load(level_order_dir)
	
	order.change_level_name(change_from, change_to)
	
	ResourceSaver.save(level_order_dir, order)
	
	var dir = Directory.new()
	dir.open(level_resource_dir)
	dir.rename(change_from+".tres", change_to+".tres")

func sortNamesByIndex(a:String, b:String)->bool:
	order = load(level_order_dir)
	return order.levelIndices[a]<order.levelIndices[b]

func sortByNumber(a:String, b:String)->bool:
	return int(a.substr(2))<int(b.substr(2))

func load_levels():
	all_levels = []
	
	var all_paths = []
	
	var dir = Directory.new()
	dir.open(level_resource_dir)
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			var path_name = file_name.substr(0, file_name.find(".tres"))
			if path_name!="lv0": all_paths.append(path_name)
		file_name = dir.get_next()
	
	all_paths.sort_custom(self, "sortNamesByIndex")
	
	for level_path in all_paths:
		var level = load(level_resource_dir+level_path+".tres")
		all_levels.append(
			unfolded_to_state([level.ind, level.pos, level.hand])
		)
	
	print(all_paths)
	
#	for i in 100:
#		var path = level_resource_dir+"lv%d.tres" % i
#		if dir.file_exists(path):
#			all_paths.append(path)
#		else:
#			save_levels(LS.State.new([], []), i)
#			all_paths.append(path)
#
#	for i in all_paths.size():
#		var level = load(all_paths[
##			level_order[i] if i<level_order.size() else i
#			i
#			])
#		all_levels.append(
#			unfolded_to_state([level.ind, level.pos, level.hand])
#		)

func save_levels(n:LS.State, ind:int):
	var u = state_to_unfolded(n)
	
	ResourceSaver.save( #(level_order[ind] if ind<level_order.size() else ind) 
		level_resource_dir+("lv%d.tres" % ind ), 
		UnfoldedLevelState.new(u[0], u[1], u[2]))

func unfolded_to_state(a:Array)->LS.State:
	var ind:Array = a[0]
	var pos:Array = a[1]
	var board:Array = []
	for i in ind.size():
		board.append(LS.Spot.new(ind[i], pos[i]))
	return LS.State.new(board, a[2])

func state_to_unfolded(s:LS.State)->Array:
	if s.board.empty()&&s.hand.empty(): 
		return [[], [], []];
	var ind:Array = []
	var pos:Array = []
	for i in s.board:
		ind.append(i.piece)
		pos.append(i.pos)
	return [ind, pos, s.hand]

