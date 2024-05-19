extends SubViewport


@onready var cam : Camera2D = $minimapCam
@onready var player = get_parent().get_parent().get_parent().get_parent()
@onready var minimapContainer = get_parent().get_parent()
@onready var debugMap = $debugLevel
@onready var map1_1 = $map1_1
@onready var map1_2 = $map1_2
@onready var map1_3 = $map1_3
@onready var map2_1 = $map2_1

func _ready() -> void:
	match player.get_parent().name:
		"Debug Level" : debugMap.show()
		
		"1_1" : map1_1.show()
		"1_2" : map1_2.show()
		"1_3" : map1_3.show()
		"1_Boss" : minimapContainer.hide()
		
		"2_1" : map2_1.show()

func _physics_process(_delta: float) -> void:
	cam.position = player.position
