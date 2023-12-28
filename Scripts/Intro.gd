extends Control

const intro_level_dir = "res://Special Levels/Intro.tres"

onready var tw = $"Tween"
onready var game_level = $"GameLevel"
onready var level_manager = $"LevelManager"
onready var hand = $"Hand"

var capturing:bool = false

func _ready():
	Globals.editting = false
	
	var level = load(intro_level_dir)
	game_level.start_level(
		LevelSave.unfolded_to_state(
			[level.ind, level.pos, level.hand]
		)
	)
	
	for i in Globals.gm.all_pieces():
		i.controller.connect("picked_up", self, "piece_picked_up")
		i.controller.connect("set_down", self, "piece_set_down")
	
	update_level_text()

func piece_picked_up():
	capturing = true
	yield(get_tree().create_timer(0.2), "timeout")
	capturing = false

func piece_set_down():
	if capturing:
		Globals.mouse_hold = false

func update_level_text():
	$"Label".text = "Welcome"

func victory_particle(v:Vector2):
	$"GridMap/VictoryParticle".position = v
	$"GridMap/VictoryParticle".emitting = true

func _on_GameLevel_won(pos):
	victory_particle(pos)
	
	$"Hinter".text = $"Hinter".text.format(
		{"PLACEHOLDER"
		: "HELD DOWN MOUSE" if Globals.mouse_hold else "TAPPED MOUSE"}
	)
	tw.interpolate_property(
		$"Hinter", "self_modulate:a", 
		0, 1, 
		1, Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tw.start()

func _on_GameLevel_next_level():
	get_tree().change_scene("res://Scenes/Title.tscn")
