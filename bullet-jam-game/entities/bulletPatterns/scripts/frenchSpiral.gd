extends Node2D

@onready var bulletScene = preload("res://entities/enemies/enemyBullet.tscn")
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var timeBetween = $timeBetween
@onready var rotator = $rotator
@onready var top = $rotator/t
@onready var topLeft = $rotator/tl
@onready var topRight = $rotator/tr
@onready var down = $rotator/d
@onready var downLeft = $rotator/dl
@onready var downRight = $rotator/dr
@onready var right = $rotator/r
@onready var left = $rotator/l

func _physics_process(_delta: float) -> void:
	rotator.rotation_degrees = fmod(rotator.rotation_degrees + 0.5, 360)

func shoot() -> void:
	timeBetween.start()
	await timeBetween.timeout
	
	var i = 1
	
	while i < 50:
		spawnBullet(top)
		spawnBullet(topLeft)
		spawnBullet(topRight)
		spawnBullet(down)
		spawnBullet(downRight)
		spawnBullet(downLeft)
		spawnBullet(left)
		spawnBullet(right)
		
		timeBetween.start()
		await timeBetween.timeout
		
		i += 1

func spawnBullet(spawnPoint):
	var bullet = bulletScene.instantiate()
	get_parent().get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawnPoint.global_rotation
	bullet.global_position = spawnPoint.global_position
	bullet.scale = Vector2(nerfTracker.enemyBulletSize, nerfTracker.enemyBulletSize)
	bullet.z_index = 0

func increaseFireRate():
	timeBetween.wait_time *= 0.8
