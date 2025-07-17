extends Node2D

@onready var name_label = $pulls

var index := 0
var items := []

func _ready():
	items = Global.pulled_results
	show_item(0)

func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			show_next()

func show_item(i: int):
	if i < items.size():
		var item = items[i]
		name_label.text = item.name
	else:
		name_label.text = "no more items"
		print("All items shown")
		$next.visible = true

func show_next():
	index += 1
	show_item(index)
