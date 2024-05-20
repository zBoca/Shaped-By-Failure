extends Control

@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var hpBar : TextureProgressBar = get_node("hpBar")
@onready var lowerMaxBar = get_node("lowerMaxBar")
@onready var dashBar : TextureProgressBar = get_node("dashBar")
@onready var dashTimer : Timer = get_parent().get_parent().get_node("dashCooldown")
func _ready() -> void:
	hpBar.max_value = nerfTracker.DEFAULT_maxHp

func _process(_delta: float) -> void:
	hpBar.value = nerfTracker.hp
	lowerMaxBar.value = 10 - nerfTracker.maxHp
	
	if dashTimer.is_stopped():
		dashBar.value = 0
	dashBar.value = (nerfTracker.dashCooldown - dashTimer.time_left) * 100

func resetDash():
	dashBar.max_value = nerfTracker.dashCooldown * 100
