extends Control

@onready var lvl = get_parent().get_parent()
@onready var title : RichTextLabel = $RichTextLabel
@onready var bar = $ProgressBar
@onready var boss = get_parent().get_parent().get_node("Enemies").get_child(0)
var dead := false
func _ready() -> void:
	match lvl.name:
		"1_Boss" : title.text = "[center]Stormy Jim[/center]"
		"2_Boss" : title.text = "[center]Captain Jim[/center]"
		"3_Boss" : title.text = "[center]French Jim[/center]"
		"4_Boss" : title.text = "[center]Sporty Jim[/center]"
		"5_Boss" : title.text = "[center]Jim Slanderman[/center]"
	
	bar.max_value = boss.maxHp

func _process(_delta: float) -> void:
	if !dead:
		if boss.hp == 0:
			dead = true
		bar.value = boss.hp
