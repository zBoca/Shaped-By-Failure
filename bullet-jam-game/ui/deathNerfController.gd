extends Control



@onready var player = get_parent().get_parent()
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var musicPlayer = get_node("/root/MusicPlayer")

func option1Chosen() -> void:
	player.chooseNerf(player.option1)


func option2Chosen() -> void:
	player.chooseNerf(player.option2)


func option3Chosen() -> void:
	player.chooseNerf(player.option3)


func giveUp() -> void:
	get_tree().paused = false
	player.get_parent().get_node("Player Cam/Camera2D/fadeAnimator").play("fadeOut")
	await get_tree().create_timer(.7).timeout
	nerfTracker.fullReset()
	musicPlayer.stream_paused = false
	get_tree().change_scene_to_file("res://menus/titleScreen/titleScreen.tscn")
