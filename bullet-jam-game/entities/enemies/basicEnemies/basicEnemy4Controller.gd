extends CharacterBody2D


@onready var dmgFlashTimer = $dmgFlash
@onready var atkCooldown = $atkCooldown
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var atk1 = $"SmallShotgun"
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
	await atk1.shoot()
	
	atkCooldown.wait_time = nerfTracker.enemyShootMulti
	atkCooldown.start()
	await atkCooldown.timeout
	
	attack()

func increaseHpVals():
	maxHp *= 1.2
	hp *= 1.2
