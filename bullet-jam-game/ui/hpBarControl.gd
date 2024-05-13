extends Control

@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var hpBar = get_node("hpBar")
@onready var lowerMaxBar = get_node("lowerMaxBar")
func _process(_delta: float) -> void:
	hpBar.value = nerfTracker.hp
	lowerMaxBar.value = 10 - nerfTracker.maxHp
