extends Node2D


@onready var bulletScene = preload("res://entities/enemies/enemyBullet.tscn")
@onready var cooldownTimer = $cooldownTimer
@onready var timeBetween = $timeBetween
var currSpawn

func _physics_process(_delta: float) -> void:
	look_at(get_parent().get_parent().get_node("Player").position)

func shoot() -> void:
	timeBetween.start()
	await timeBetween.timeout
	
	var i = 1
	
	while i < 6:
		currSpawn = get_node("spawn" + str(randi_range(1, 3)))
		
		var bullet = bulletScene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.rotation = rotation
		bullet.global_position = currSpawn.global_position
		bullet.z_index = 0
		
		timeBetween.start()
		await timeBetween.timeout
		
		i += 1
