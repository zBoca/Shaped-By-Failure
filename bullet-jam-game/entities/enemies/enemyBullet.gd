extends Area2D

@onready var nerfTracker = get_node("/root/NerfTracker")
func _physics_process(delta: float) -> void:
	var moveVector = transform.x * nerfTracker.enemyBulletSpeed
	position += moveVector * delta


func onHit(body: Node2D) -> void:
	if body.is_in_group("player"):
		if !body.hasIFrames:
			body.takeDmg()
			queue_free()
	elif body.is_in_group("wall"):
		queue_free()
