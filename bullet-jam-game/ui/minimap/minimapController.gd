extends SubViewport


@onready var cam : Camera2D = $minimapCam
@onready var player = get_parent().get_parent().get_parent().get_parent()
@onready var debugMap = $debugLevel
@onready var map2_1 = $map2_1

func _ready() -> void:
	match player.get_parent().name:
		"Debug Level" : debugMap.show()
		"2_1" : map2_1.show()

func _physics_process(_delta: float) -> void:
	cam.position = player.position
