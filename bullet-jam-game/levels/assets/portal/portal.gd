extends Node2D

@export var nextLevelPath : String
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemyHolder = get_parent().get_node("Enemies")
@onready var nerfTracker = get_node("/root/NerfTracker")
var open : bool = false
var inPortal : bool = false

func _ready() -> void:
	anim.play("default")

func checkPortalOpen() -> void:
	if enemyHolder.get_child_count() == 0 && !open:
		open = true
		openPortal() 

func _process(_delta: float) -> void:
	checkPortalOpen()
	
	if open && inPortal:
		if nextLevelPath == "res://levels/hub/hubLevel.tscn":
			nerfTracker.fullReset()
		get_parent().get_node("Player").nextLevel(nextLevelPath)

func openPortal():
	anim.play("portalOpening")
	await anim.animation_finished
	anim.play("portalOpen")


func bodyEntered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inPortal = true
func bodyLeft(body: Node2D) -> void:
	if body.is_in_group("player"):
		inPortal = false
