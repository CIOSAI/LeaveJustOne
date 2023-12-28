extends MovePattern

func algo(pos:Vector2) -> Array:
	var options:Array = []

	for i in range(-Globals.gm.dimensions, Globals.gm.dimensions):
		if i==0: continue
		options.append(pos+Vector2(i, 0))
		options.append(pos+Vector2(0, i))

	var enemy_pieces = get_all_pieces_pos()
	enemy_pieces.erase(pos)
	for i in options:
		var dir = (i-pos).normalized()
		if !(dir in [Vector2(-1,0), Vector2(0,-1), Vector2(1,0), Vector2(0,1)]):
			continue
		var dist = (i-pos).length_squared()
		for j in enemy_pieces:
			if dir==(j-pos).normalized():
				if (j-pos).length_squared()<dist:
					dels.append(i)
					break

	return options
