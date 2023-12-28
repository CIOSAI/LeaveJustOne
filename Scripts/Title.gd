extends Control

onready var labels = [$"Label1", $"Label2", $"Label3", $"Label4"]

var increment:int = 0

func _on_Button_pressed():
	increment += 1
	
	if increment>=labels.size()-1:
		get_tree().change_scene("res://Scenes/TrueMenu.tscn")
	
	$"FXpicked".play()
	for i in labels:
		i.hide()
	labels[increment].show()
