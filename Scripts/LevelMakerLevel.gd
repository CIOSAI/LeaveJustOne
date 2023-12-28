extends Node

func start_round():
	get_parent().game_level.start_level(get_level())

func get_level():
	return LevelSave.all_levels[get_parent().get_cursor()]

func sp(a:int, b:int, c:int)->LS.Spot: return LS.Spot.new(a, Vector2(b, c))
