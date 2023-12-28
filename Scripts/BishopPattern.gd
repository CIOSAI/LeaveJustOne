extends MovePattern

func algo(pos:Vector2)->Array:
	var options:Array = []
	
	for i in range(-Globals.gm.dimensions, Globals.gm.dimensions):
		if i==0: continue
		options.append(pos+Vector2(i, i))
		options.append(pos+Vector2(i, -i))

	for i in options:
		var dir:Vector2 = (i-pos).normalized()
		var dist:float = (i-pos).length_squared()
		var other_pieces:Array = get_all_pieces_pos()
		other_pieces.erase(pos)
		for j in other_pieces:
			if dir.is_equal_approx( (j-pos).normalized()):
				if (j-pos).length_squared()<dist:
					dels.append(i)
					break

	return options
