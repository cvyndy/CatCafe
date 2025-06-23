extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_laptop_pressed():
	var loaded_scene = ResourceLoader.load("res://scenes/laptop_menu.tscn")
	var instance = loaded_scene.instantiate()
	get_tree().root.add_child(instance)
	pass # Replace with function body.

func _on_gacha_pressed():
	get_tree().change_scene_to_file('res://scenes/gacha_pull.tscn')
	pass # Replace with function body.
