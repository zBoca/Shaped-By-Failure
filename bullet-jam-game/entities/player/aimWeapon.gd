extends Node2D

var canShoot := true
@onready var shootCooldown = get_parent().get_node("shootCooldown")
@onready var bulletScene = preload("res://entities/player/bullet.tscn")
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var player
@onready var shootMark = $Marker2D
var bullet
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if canShoot and Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	shootCooldown.wait_time = nerfTracker.fireRate
	canShoot = false
	
	bullet = bulletScene.instantiate()
	get_parent().get_parent().add_child(bullet)
	bullet.rotation = rotation
	bullet.global_position = shootMark.global_position
	
	shootCooldown.start()
	await shootCooldown.timeout
	
	canShoot = true
