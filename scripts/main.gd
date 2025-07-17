extends Control

var daytime := false
var time := 0.0
var day_duration := 5.0
var money_earned := 0

@onready var next_button := $next
@onready var laptop_button := $Laptop
@onready var gacha_button := $gacha
@onready var toybox_button := $ToyBox
@onready var timer := $temptimer
@onready var earnings := $Earnings
@onready var day_label := $Day
@onready var anim_player := $AnimationPlayer

func _ready():
	update_phase()

func _process(delta):
	earnings.text = "Earnings: %d" % Global.coins
	if daytime:
		time += delta
		var remaining := int(ceil(day_duration - time))
		timer.text = "Time Left: " + str(remaining)
		if time >= day_duration:
			daytime = false
			time = 0.0
			update_phase()
	else:
		timer.text = ""

func _on_laptop_pressed():
	var loaded_scene = ResourceLoader.load("res://scenes/laptop_menu.tscn")
	var instance = loaded_scene.instantiate()
	get_tree().root.add_child(instance)

func _on_gacha_pressed():
	get_tree().change_scene_to_file("res://scenes/gacha_pull.tscn")

func _on_toy_box_pressed():
	pass

func _on_next_pressed():
	if not daytime:
		Global.current_day += 1
		anim_player.play("on_off")      # Fade in light
		anim_player.queue("sunlight")   # Simulate sun rising
		await anim_player.animation_finished
		daytime = true
		time = 0.0
		update_phase()

func type_text(label: Label, full_text: String, delay := 0.05):
	label.text = ""
	for i in full_text.length():
		label.text += full_text[i]
		await get_tree().create_timer(delay).timeout

func update_phase():
	if daytime:
		next_button.visible = false
		laptop_button.visible = false
		gacha_button.visible = false
		toybox_button.visible = true
		await type_text(day_label, "Day " + str(Global.current_day))
	else:
		next_button.visible = true
		laptop_button.visible = true
		gacha_button.visible = true
		toybox_button.visible = true
		if Global.current_day != 0:
			anim_player.play("off_on")
			anim_player.queue("sunset")
			await anim_player.animation_finished
		await type_text(day_label, "Night " + str(Global.current_day))
