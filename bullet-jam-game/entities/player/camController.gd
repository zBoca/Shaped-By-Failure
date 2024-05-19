extends Node2D

func _process(_delta: float) -> void:
	if get_parent().name == "1_Boss" or get_parent().name == "2_Boss" or get_parent().name == "3_Boss":
		return
	position = get_parent().get_node("Player").position
