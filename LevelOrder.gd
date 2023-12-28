extends Resource
class_name LevelOrder

export(Array, String) var levelNames
export(Dictionary) var levelIndices

func insert_level(s:String, id:int):
	levelNames.insert(id, s)
	level_indices_reload()

func mov_level_by_string(s:String, new_id:int):
	del_level(s)
	insert_level(s, new_id)

func mov_level(n, new_id:int):
	if n is String: mov_level_by_string(n, new_id)
	elif n is int: mov_level_by_string(levelNames[n], new_id)
	else: print(str(n) + " is not string or int")

func level_indices_reload():
	levelIndices.clear()
	for i in levelNames.size():
		levelIndices[levelNames[i]] = i

func del_level_by_string(b:String):
	levelNames.erase(b)
	level_indices_reload()

func del_level_by_id(n:int):
	levelNames.remove(n)
	level_indices_reload()

func del_level(n):
	if n is String: del_level_by_string(n)
	elif n is int: del_level_by_id(n)
	else: print(str(n) + " is not string or int")

func change_level_name(from:String, to:String):
	levelNames[levelIndices[from]] = to
	levelIndices[to] = levelIndices[from]
	levelIndices.erase(from)
