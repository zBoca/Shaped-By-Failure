extends CharacterBody2D

@onready var dmgFlashTimer = $dmgFlash
@onready var atkCooldown = $atkCooldown
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var atk1 = $"5ShotDirect"
@onready var atk2 = $Shotgun
var maxHp = 25
var hp = 25
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
	randomize()
	attack()

func attack() -> void:
	var atk = randi_range(0, 1)
	match atk:
		0:
			await atk1.shoot()
		1:
			await atk2.shoot()
	
	atkCooldown.wait_time = nerfTracker.enemyShootMulti
	atkCooldown.start()
	await atkCooldown.timeout
	
	attack()

func increaseHpVals():
	maxHp *= 1.2
	hp *= 1.2
