extends Control

func _ready() -> void:
	$fadeAnimator.play("fadeIn")

func level1() -> void:
	$fadeAnimator.play("fadeOut")
	$fadeAnimator/fadeOutTimer.start()
	await $fadeAnimator/fadeOutTimer.timeout
	get_tree().change_scene_to_file("res://levels/stages/1/1_1.tscn")
func level2() -> void:
	$fadeAnimator.play("fadeOut")
	$fadeAnimator/fadeOutTimer.start()
	await $fadeAnimator/fadeOutTimer.timeout
	get_tree().change_scene_to_file("res://levels/stages/2/2_1.tscn")
func level3() -> void:
	$fadeAnimator.play("fadeOut")
	$fadeAnimator/fadeOutTimer.start()
	await $fadeAnimator/fadeOutTimer.timeout
	get_tree().change_scene_to_file("res://levels/stages/3/3_1.tscn")
func level4() -> void:
	$fadeAnimator.play("fadeOut")
	$fadeAnimator/fadeOutTimer.start()
	await $fadeAnimator/fadeOutTimer.timeout
	get_tree().change_scene_to_file("res://levels/stages/4/4_1.tscn")
func level5() -> void:
	$fadeAnimator.play("fadeOut")
	$fadeAnimator/fadeOutTimer.start()
	await $fadeAnimator/fadeOutTimer.timeout
	get_tree().change_scene_to_file("res://levels/stages/5/5_1.tscn")


func backPressed() -> void:
	$fadeAnimator.play("fadeOut")
	
	$fadeAnimator/fadeOutTimer.start()
	await $fadeAnimator/fadeOutTimer.timeout
	
	get_tree().change_scene_to_file("res://menus/titleScreen/titleScreen.tscn")
