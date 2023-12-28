extends Node

const piece_scenes = [
	preload("res://Scenes/Pieces/Bishop.tscn"),
	preload("res://Scenes/Pieces/Rook.tscn"),
	preload("res://Scenes/Pieces/Remover.tscn"),
	preload("res://Scenes/Pieces/Boulder.tscn"),
	preload("res://Scenes/Pieces/Knight.tscn"),
	preload("res://Scenes/Pieces/Moose.tscn"),
	preload("res://Scenes/Pieces/Snake.tscn"),
	preload("res://Scenes/Pieces/Tele.tscn"),
	preload("res://Scenes/Pieces/OnlyTake.tscn"),
	preload("res://Scenes/Pieces/IntroPickMe.tscn"),
	preload("res://Scenes/Pieces/IntroPutHere.tscn"),
	preload("res://Scenes/Pieces/MenuLevelSelect.tscn"),
	preload("res://Scenes/Pieces/MenuSettings.tscn"),
	preload("res://Scenes/Pieces/MenuPlay.tscn"),
	preload("res://Scenes/Pieces/MenuQuit.tscn"),
	]

enum {WASP, RAM, DAGGER, BOULDER, HARE, MOOSE, SNAKE, BRUH}

class State:
	var board:Array = []
	var hand:Array = []
	
	func _init(theboard:Array, thehand:Array):
		board = theboard
		hand = thehand

class Spot:
	var piece:int
	var pos:Vector2
	func _init(p:int, v:Vector2):
		piece = p
		pos = v
