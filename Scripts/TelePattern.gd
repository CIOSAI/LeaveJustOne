extends MovePattern

func algo(pos:Vector2)->Array:
	var options:Array = []
	var corners:Array = []
	
	for i in [0, Globals.gm.dimensions-1]:
		for j in [0, Globals.gm.dimensions-1]:
			corners.append(Vector2(i, j))
	
	if pos in corners:
		for i in Globals.gm.dimensions:
			for j in Globals.gm.dimensions:
				if Vector2(i, j) in corners: continue
				options.append(Vector2(i, j))
		return options
	else:
		return []
