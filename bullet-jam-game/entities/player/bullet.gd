extends Node2D

func _ready():
	kill()

func _physics_process(delta: float) -> void:
	var moveVector = transform.x * 700
	position += moveVector * delta


func onHit(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.takeDmg()
		queue_free()
	elif body.is_in_group("camBorder"):
		queue_free()

func kill():
	await get_tree().create_timer(10).timeout
	queue_free()
