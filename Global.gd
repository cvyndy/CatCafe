extends Node2D

var current_day := 0

func load_items_from_folder(path: String):
	var dir := DirAccess.open(path)
	if dir == null:
		push_error("Failed to open folder: " + path)
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			var full_path = path + file_name
			var item = load(full_path)
			if item is GachaItem:
				add_item(item)
		file_name = dir.get_next()
	dir.list_dir_end()

func _ready():
	Global.load_items_from_folder("res://resources/Cat Toys/")
	Global.load_items_from_folder("res://resources/Cats/")
	Global.load_items_from_folder("res://resources/Trash/")

var cats: Array[GachaItem] = []
var toys: Array[GachaItem] = []
var junk: Array[GachaItem] = []
var coins: int = 100000000

var pulled_results: Array[GachaItem] = []

func add_item(item: GachaItem):
	match item.type:
		"Cat":
			cats.append(item)
		"Toy":
			toys.append(item)
		"Junk":
			junk.append(item)

var all_items: Array[GachaItem] = [
	preload("res://resources/Cat Toys/ball.tres"),
	preload("res://resources/Cat Toys/floppyfish.tres"),
	preload("res://resources/Cat Toys/mouse.tres"),
	preload("res://resources/Cats/cat1.tres"),
	preload("res://resources/Cats/cat2.tres"),
	preload("res://resources/Cats/cat3.tres"),
	preload("res://resources/Trash/dirt.tres"),
	preload("res://resources/Trash/poop.tres"),
]
