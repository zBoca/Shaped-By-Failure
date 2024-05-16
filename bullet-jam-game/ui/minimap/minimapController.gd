extends SubViewport


@onready var cam : Camera2D = $minimapCam
@onready var player = get_parent().get_parent().get_parent().get_parent()
@onready var debugMap = $debugLevel
@onready var map1 = $map1

func _ready() -> void:
	if player.get_parent().name == "Debug Level":
		debugMap.show()
	elif player.get_parent().name == "1":
		map1.show()

func _physics_process(_delta: float) -> void:
	cam.position = player.position
