extends Control


@onready var anim = $fadeAnimator
func _ready() -> void:
	anim.play("fadeIn")

@onready var fadeTimer = $fadeAnimator/fadeOutTimer
func playButtonPressed() -> void:
	anim.play("fadeOut")
	
	fadeTimer.start()
	await fadeTimer.timeout
	
	get_tree().change_scene_to_file("res://levels/hub/hubLevel.tscn")
