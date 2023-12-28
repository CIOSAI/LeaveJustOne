extends MovePattern


func algo(pos:Vector2)->Array:
	var options:Array = []
	
	for i in [0, Globals.gm.dimensions-1]:
		for j in [0, Globals.gm.dimensions-1]:
			if Vector2(i, j)==pos: continue
			options.append(Vector2(i, j))

	return options
