extends Node2D


@onready var player = get_node("Player")
func _ready() -> void:
	player.inHub = true
