extends Node2D

@onready var bulletScene = preload("res://entities/enemies/enemyBullet.tscn")
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var timeBefore = $timeBefore
@onready var spawn1 = $"1"
@onready var spawn2 = $"2"
@onready var spawn3 = $"3"
@onready var spawn4 = $"4"
@onready var spawn5 = $"5"

func _process(_delta: float) -> void:
	look_at(get_tree().get_first_node_in_group("player").global_position)

func shoot() -> void:
	timeBefore.start()
	await timeBefore.timeout
	
	spawnBullet(spawn1)
	spawnBullet(spawn2)
	spawnBullet(spawn3)
	spawnBullet(spawn4)
	spawnBullet(spawn5)

func spawnBullet(spawn):
	var bullet = bulletScene.instantiate()
	get_parent().get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawn.global_rotation
	bullet.global_position = spawn.global_position
	bullet.scale = Vector2(nerfTracker.enemyBulletSize, nerfTracker.enemyBulletSize)
	bullet.z_index = 0
