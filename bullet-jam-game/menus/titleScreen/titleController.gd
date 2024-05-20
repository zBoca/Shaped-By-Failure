extends Control


@onready var anim = $fadeAnimator
func _ready() -> void:
	anim.play("fadeIn")

@onready var fadeTimer = $fadeAnimator/fadeOutTimer
func playButtonPressed() -> void:
	anim.play("fadeOut")
	
	fadeTimer.start()
	await fadeTimer.timeout
	
	get_tree().change_scene_to_file("res://menus/levelSelect/levelSect.tscn")


func exitPressed() -> void:
	anim.play("fadeOut")
	await get_tree().create_timer(0.7).timeout
	get_tree().quit()
