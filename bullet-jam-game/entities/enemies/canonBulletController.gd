extends Node2D


func _ready():
	kill()

@onready var nerfTracker = get_node("/root/NerfTracker")
func _physics_process(delta: float) -> void:
	var moveVector = transform.x * (nerfTracker.enemyBulletSpeed * 1.5)
	position += moveVector * delta


func onHit(body: Node2D) -> void:
	if body.is_in_group("player"):
		if !body.hasIFrames:
			body.takeDmg(5)
			queue_free()
	elif body.is_in_group("wall"):
		queue_free()

func kill():
	await get_tree().create_timer(10).timeout
	queue_free()
