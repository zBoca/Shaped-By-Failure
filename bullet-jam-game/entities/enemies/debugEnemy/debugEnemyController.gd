extends Node2D

@onready var colorRect = $ColorRect
@onready var dmgFlashTimer = $dmgFlash
@onready var atkCooldown = $atkCooldown
@onready var atk1 = $"5ShotDirect"
@onready var atk2 = $Spiral
@onready var atk3 = $Shotgun
var hp = 50
var red = Color("ce718b")
var white = Color("ffffff")
func takeDmg():
	hp -= 2
	if hp < 1:
		queue_free()
	
	colorRect.color = red
	
	dmgFlashTimer.start()
	await dmgFlashTimer.timeout
	
	colorRect.color = white

func _ready() -> void:
	randomize()
	attack()

func attack() -> void:
	var atk = randi_range(0, 2)
	match atk:
		0:
			await atk1.shoot()
		1:
			await atk2.shoot()
		2:
			await atk3.shoot()
	
	atkCooldown.start()
	await atkCooldown.timeout
	
	attack()
