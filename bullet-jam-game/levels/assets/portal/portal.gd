extends Node2D


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemyHolder = get_parent().get_node("Enemies")
var open : bool = false
var inPortal : bool = false

func _ready() -> void:
	anim.play("default")


func _process(_delta: float) -> void:
	if enemyHolder.get_child_count() == 0 && !open:
		open = true
		openPortal() 
	
	if open && inPortal:
		get_parent().get_node("Player").nextLevel()

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
