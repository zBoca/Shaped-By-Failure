extends SubViewport


@onready var cam : Camera2D = $minimapCam
@onready var player = get_parent().get_parent().get_parent().get_parent()
@onready var minimapContainer = get_parent().get_parent()
@onready var debugMap = $debugLevel
@onready var map1_1 = $map1_1
@onready var map1_2 = $map1_2
@onready var map1_3 = $map1_3
@onready var map2_1 = $map2_1
@onready var map2_2 = $map2_2
@onready var map2_3 = $map2_3
@onready var map3_1 = $map3_1
@onready var map3_2 = $map3_2
@onready var map3_3 = $map3_3
@onready var map4_1 = $map4_1
@onready var map4_2 = $map4_2
@onready var map4_3 = $map4_3
@onready var map5_1 = $map5_1
@onready var map5_2 = $map5_2
@onready var map5_3 = $map5_3

func _ready() -> void:
	match player.get_parent().name:
		"Debug Level" : debugMap.show()
		
		"1_1" : map1_1.show()
		"1_2" : map1_2.show()
		"1_3" : map1_3.show()
		"1_Boss" : minimapContainer.hide()
		
		"2_1" : map2_1.show()
		"2_2" : map2_2.show()
		"2_3" : map2_3.show()
		"2_Boss" : minimapContainer.hide()
		
		"3_1" : map3_1.show()
		"3_2" : map3_2.show()
		"3_3" : map3_3.show()
		"3_Boss" : minimapContainer.hide()
		
		"4_1" : map4_1.show()
		"4_2" : map4_2.show()
		"4_3" : map4_3.show()
		"4_Boss" : minimapContainer.hide()
		
		"5_1" : map5_1.show()
		"5_2" : map5_2.show()
		"5_3" : map5_3.show()
		"5_Boss" : minimapContainer.hide()

func _physics_process(_delta: float) -> void:
	cam.position = player.position
