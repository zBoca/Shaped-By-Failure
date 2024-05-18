extends Node2D


@onready var bulletScene = preload("res://entities/enemies/enemyBullet.tscn")
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var cooldownTimer = $cooldownTimer
@onready var timeBetween = $timeBetween
var currSpawn

func _physics_process(_delta: float) -> void:
	
	look_at(get_tree().get_first_node_in_group("player").position)

func shoot() -> void:
	timeBetween.start()
	await timeBetween.timeout
	
	var i = 0
	var j = 0
	while j < 3:
		while i < 5:
			currSpawn = get_node("spawn" + str(randi_range(1, 3)))
			
			var bullet = bulletScene.instantiate()
			get_parent().get_parent().add_child(bullet)
			bullet.rotation = rotation
			bullet.global_position = currSpawn.global_position
			bullet.scale = Vector2(nerfTracker.enemyBulletSize, nerfTracker.enemyBulletSize)
			bullet.z_index = 0
			
			timeBetween.start()
			await timeBetween.timeout
			
			i += 1
		
		timeBetween.start()
		await timeBetween.timeout
		timeBetween.start()
		await timeBetween.timeout
		timeBetween.start()
		await timeBetween.timeout
		i = 0
		j += 1

func increaseFireRate():
	cooldownTimer.wait_time *= 0.8
	timeBetween.wait_time *= 0.8
