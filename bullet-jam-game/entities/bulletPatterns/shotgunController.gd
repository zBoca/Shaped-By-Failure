extends Node2D

@onready var bulletScene = preload("res://entities/enemies/enemyBullet.tscn")
@onready var spawn1 = $"1"
@onready var spawn2 = $"2"
@onready var spawn3 = $"3"
@onready var spawn4 = $"4"
@onready var spawn5 = $"5"

func _process(_delta: float) -> void:
	look_at(get_parent().get_parent().get_node("Player").global_position)

func shoot() -> void:
	var bullet = bulletScene.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawn1.global_rotation
	bullet.global_position = spawn1.global_position
	bullet.z_index = 0
		
	bullet = bulletScene.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawn2.global_rotation
	bullet.global_position = spawn2.global_position
	bullet.z_index = 0
	
	bullet = bulletScene.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawn3.global_rotation
	bullet.global_position = spawn3.global_position
	bullet.z_index = 0
	
	bullet = bulletScene.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawn4.global_rotation
	bullet.global_position = spawn4.global_position
	bullet.z_index = 0
	
	bullet = bulletScene.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = spawn5.global_rotation
	bullet.global_position = spawn5.global_position
	bullet.z_index = 0
