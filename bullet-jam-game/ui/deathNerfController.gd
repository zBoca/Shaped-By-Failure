extends Control



@onready var player = get_parent().get_parent()

func option1Chosen() -> void:
	player.chooseNerf(player.option1)


func option2Chosen() -> void:
	player.chooseNerf(player.option2)


func option3Chosen() -> void:
	player.chooseNerf(player.option3)
