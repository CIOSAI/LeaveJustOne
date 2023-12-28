extends Control

onready var game_level = $"GameLevel"
onready var level_manager = $"LevelManager"
onready var hand = $"Hand"

func _ready():
	Globals.editting = false
	level_manager.start_round()
	update_level_text()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/TrueMenu.tscn")

func update_level_text():
	$"Label".text = LevelSave.order.levelNames[Globals.current_level].to_upper()

func victory_particle(v:Vector2):
	$"GridMap/VictoryParticle".position = v
	$"GridMap/VictoryParticle".emitting = true

func _on_GameLevel_won(pos):
	victory_particle(pos)

func _on_GameLevel_next_level():
	level_manager.win()
