extends Node2D

@onready var bulletScene = preload("res://entities/enemies/ballBullet.tscn")
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var aimTime = $aimTime
@onready var timeBetween = $timeBetween

func _physics_process(_delta: float) -> void:
	look_at(get_tree().get_first_node_in_group("player").position)
	
func shoot():
	aimTime.start()
	await aimTime.timeout
	
	var i = 0
	while i < 3:
		var bullet = bulletScene.instantiate()
		get_parent().get_parent().get_parent().add_child(bullet)
		bullet.rotation = rotation
		bullet.global_position = global_position
		bullet.scale = Vector2(nerfTracker.enemyBulletSize, nerfTracker.enemyBulletSize)
		bullet.z_index = 0
		
		timeBetween.start()
		await timeBetween.timeout
		
		i += 1

func increaseFireRate():
	pass
