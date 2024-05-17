extends SubViewport


@onready var cam : Camera2D = $minimapCam
@onready var player = get_parent().get_parent().get_parent().get_parent()
@onready var debugMap = $debugLevel
@onready var map1_1 = $map1_1

func _ready() -> void:
	match player.get_parent().name:
		"Debug Level" : debugMap.show()
		"1_1" : map1_1.show()

func _physics_process(_delta: float) -> void:
	cam.position = player.position
