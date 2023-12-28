extends Resource
class_name UnfoldedLevelState

export(Array, int) var ind:Array = []
export(Array, Vector2) var pos:Array = []
export(Array, int) var hand:Array = []

func _init(_ind=null, _pos=null, _hand=null):
	if _ind!=null: ind = _ind
	if _pos!=null: pos = _pos
	if _hand!=null: hand = _hand

func toState()->LS.State:
	var board:Array = []
	for i in ind.size():
		board.append(LS.Spot.new(ind[i], pos[i]))
	return LS.State.new(board, hand)
