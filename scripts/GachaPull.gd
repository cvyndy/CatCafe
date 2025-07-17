extends Node2D

@onready var coins_label = $coinsLabel

func _process(_delta):
	coins_label.text = "Coins: %d" % Global.coins

@export var item_pool: Array[GachaItem] 

const one_pull_cost := 5
const five_pull_cost := 25 
const PITY_THRESHOLD := 50
var pulls_since_last_meme_cat := 0
	
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_fivepull_pressed():
	if Global.coins >= five_pull_cost:
		Global.coins -= five_pull_cost
		var results: Array[GachaItem] = []
		for i in range(5):
			var result = roll_item()
			results.append(result)
			print("Item %d: %s" % [i + 1, result.name])
		Global.pulled_results = results
		get_tree().change_scene_to_file("res://scenes/summoning.tscn")
	else:
		print("AHHHHH YOU R TOO POOR FOR 5 pull!")

func _on_onepull_pressed():
	if Global.coins >= one_pull_cost:
		Global.coins -= one_pull_cost
		var result = roll_item()
		Global.pulled_results = [result]
		print("You got:", result.name)
		get_tree().change_scene_to_file("res://scenes/summoning.tscn")
	else:
		print("AHHHHH YOU R TOO POOR FOR 1 pull!")

func roll_item() -> GachaItem:
	var is_pity = pulls_since_last_meme_cat >= PITY_THRESHOLD
	var pool = Global.all_items
	var filtered_pool: Array[GachaItem] = []
	if is_pity:
		# Only include Meme Cats in the pity pool
		for item in pool:
			if item.type.to_lower() == "cat" and item.rarity.to_lower() == "meme":
				filtered_pool.append(item)
	else:
		filtered_pool = pool
	var total = 0.0
	for item in filtered_pool:
		total += item.probability
	var rand_value = randf() * total
	var accum = 0.0
	for item in filtered_pool:
		accum += item.probability
		if rand_value <= accum:
			# Reset pity if it's a Meme Cat
			if item.type.to_lower() == "cat" and item.rarity.to_lower() == "meme":
				pulls_since_last_meme_cat = 0
			else:
				pulls_since_last_meme_cat += 1
			return item
	if filtered_pool.size() > 0:
		return filtered_pool.back()
	push_error("No items in gacha pool!")
	return null
