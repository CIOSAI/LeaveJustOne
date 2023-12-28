extends MovePattern

func algo(pos:Vector2) -> Array:
	var options:Array = []

	for i in Globals.gm.dimensions:
		for j in Globals.gm.dimensions:
			options.append(Vector2(i, j))

	dels.append(pos)

	return options
