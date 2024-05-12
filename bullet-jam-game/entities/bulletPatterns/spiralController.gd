extends Node2D


@onready var bulletScene = preload("res://entities/enemies/enemyBullet.tscn")
@onready var timeBetween = $timeBetween
@onready var rotator = $rotator
@onready var topSpawn = $rotator/t
@onready var downSpawn = $rotator/d
@onready var rightSpawn = $rotator/r
@onready var leftSpawn = $rotator/l

func _physics_process(_delta: float) -> void:
	rotator.rotation_degrees = fmod(rotator.rotation_degrees + 1, 360)

func shoot() -> void:
	timeBetween.start()
	await timeBetween.timeout
	
	var i = 1
	
	while i < 20:
		var bullet = bulletScene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.rotation = downSpawn.global_rotation
		bullet.global_position = downSpawn.global_position
		bullet.z_index = 0
		
		bullet = bulletScene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.rotation = leftSpawn.global_rotation
		bullet.global_position = leftSpawn.global_position
		bullet.z_index = 0
		
		bullet = bulletScene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.rotation = topSpawn.global_rotation
		bullet.global_position = topSpawn.global_position
		bullet.z_index = 0
		
		bullet = bulletScene.instantiate()
		get_parent().get_parent().add_child(bullet)
		bullet.rotation = rightSpawn.global_rotation
		bullet.global_position = rightSpawn.global_position
		bullet.z_index = 0
		
		timeBetween.start()
		await timeBetween.timeout
		
		i += 1
