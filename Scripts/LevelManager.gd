extends Node

signal won

func start_round():
	get_parent().game_level.start_level(get_level())

func get_level()->Array:
	return LevelSave.all_levels[Globals.current_level]

func sp(a:int, b:int, c:int)->LS.Spot: return LS.Spot.new(a, Vector2(b, c))

func win():
	Globals.current_level+=1
	start_round()
	emit_signal("won")
