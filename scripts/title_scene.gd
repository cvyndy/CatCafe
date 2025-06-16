extends Control

func hi():
	print("Cindy")
	print("Krish")
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Justin is the goat")
	pass # Replace with function body.

func _on_start_pressed():
	get_tree().change_scene_to_file('res://scenes/main.tscn')
	pass # Replace with function body.
