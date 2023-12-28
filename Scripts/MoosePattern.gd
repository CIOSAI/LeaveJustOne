extends MovePattern

func algo(pos:Vector2)->Array:
	var options:Array = []
	
	for i in [-1, 0, 1]:
		for j in [-1, 0, 1]:
			if i==0&&j==0: continue
			options.append(pos+Vector2(i, j))

	return options
