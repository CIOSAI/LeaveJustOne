extends MovePattern

func algo(pos:Vector2)->Array:
	var options:Array = []
	
	for i in [-2, -1, 1, 2]:
		for j in [-2, -1, 1, 2]:
			if abs(i)==abs(j): continue
			options.append(pos+Vector2(i, j))

	return options
