extends Node2D

func _process(_delta: float) -> void:
	position = get_parent().get_node("Player").position
