extends Control

@export var levelNum : int
@onready var text = $RichTextLabel
var textbox1 = ["Oh no! The squares realized you stole their device and shut down the only way out of here!", 
				"You're going to have to take out the squares in order to reopen the portal",
				"Luckily, their device will help you survive their attack!",
				"When you are on your last breath, the device will be able to bring you back",
				"However, as a consequence, it sacrifices some of your power and will make the rest of your journey more difficult",
				"(Use WASD to move around and your mouse to shoot back!)"]
var textbox2 = ["The different squares all have different ways to shoot at you", 
				"Learn their patterns in order to dodge them and continue onwards!"]
var textbox4 = ["Thats one of the elite squares!", "They're blocking the portal to move on to the next part of the lab!"]
signal advance

func _ready() -> void:
	match levelNum:
		1:
			level1()
		2:
			level2()
		4:
			level4()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		advance.emit()

func level1():
	await get_tree().create_timer(2).timeout
	show()
	get_tree().paused = true
	get_parent().get_parent().get_node("Player/CanvasLayer/Minimap").hide()
	text.text = textbox1[0]
	await advance
	text.text = textbox1[1]
	await advance
	text.text = textbox1[2]
	await advance
	text.text = textbox1[3]
	await advance
	text.text = textbox1[4]
	await advance
	text.text = textbox1[5]
	await advance
	text.text = ""
	get_tree().paused = false
	hide()
	get_parent().get_parent().get_node("Player/CanvasLayer/Minimap").show()

func level2():
	await get_tree().create_timer(2).timeout
	show()
	get_tree().paused = true
	get_parent().get_parent().get_node("Player/CanvasLayer/Minimap").hide()
	text.text = textbox2[0]
	await advance
	text.text = textbox2[1]
	await advance
	text.text = ""
	get_tree().paused = false
	hide()
	get_parent().get_parent().get_node("Player/CanvasLayer/Minimap").show()

func level4():
	await get_tree().create_timer(2).timeout
	show()
	get_tree().paused = true
	text.text = textbox4[0]
	await advance
	text.text = textbox4[1]
	await advance
	text.text = ""
	get_tree().paused = false
	hide()
