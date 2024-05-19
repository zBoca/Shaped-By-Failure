extends Node2D

@onready var dmgFlashTimer = $dmgFlash
@onready var atkCooldown = $atkCooldown
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var atk1 = $Spiral
@onready var atk2 = $"10ShotDirect"
var maxHp = 150
var hp = 150
@onready var sprite = $AnimatedSprite2D
func takeDmg():
	hp -= 2
	if hp < 1:
		queue_free()
	
	sprite.frame = 1
	
	dmgFlashTimer.start()
	await dmgFlashTimer.timeout
	
	sprite.frame = 0

func _ready() -> void:
	attack()

var currAtk
func attack() -> void:
	match randi_range(0, 1):
		0:
			await atk1.shoot()
		1:
			await atk2.shoot()
			await atk2.shoot()
			await atk2.shoot()
	
	atkCooldown.wait_time = nerfTracker.enemyShootMulti
	atkCooldown.start()
	await atkCooldown.timeout
	
	attack()

func increaseHpVals():
	maxHp *= 1.2
	hp *= 1.2
