extends Node2D

func _physics_process(delta: float) -> void:
	var moveVector = transform.x * 500
	position += moveVector * delta


func onHit(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.takeDmg()
		queue_free()
	elif body.is_in_group("camBorder"):
		queue_free()
