extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/LevelMaker.tscn")


func _on_Button2_pressed():
	if $"HBoxContainer2/LineEdit".text.is_valid_integer():
		Globals.current_level = int($"HBoxContainer2/LineEdit".text)
	else:
		Globals.current_level = 0
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://Scenes/Arranger.tscn")
