extends CharacterBody2D


@onready var dmgFlashTimer = $dmgFlash
@onready var atkCooldown = $atkCooldown
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var atk1 = $"1ShotDirect"
var maxHp = 25
var hp = 25
var canShoot := true
@onready var explosionAnim = $explosionAnimation
@onready var explosionTimer = $explosionAnimation/explosionTimer
@onready var sprite = $AnimatedSprite2D
@onready var deathSound = $explosionAnimation/AudioStreamPlayer
func takeDmg():
	hp -= 2
	if hp < 1 && canShoot:
		deathSound.play()
		canShoot = false
		explosionAnim.play("default")
		explosionTimer.start()
		await explosionTimer.timeout
		sprite.visible = false
		explosionTimer.start()
		await explosionTimer.timeout
		queue_free()
	
	sprite.frame = 1
	
	dmgFlashTimer.start()
	await dmgFlashTimer.timeout
	
	sprite.frame = 0

func _ready() -> void:
	await get_tree().create_timer(2.8).timeout
	attack()

func attack() -> void:
	await atk1.shoot()
	
	atkCooldown.wait_time = nerfTracker.enemyShootMulti / 2
	atkCooldown.start()
	await atkCooldown.timeout
	
	if canShoot:
		attack()

func increaseHpVals():
	maxHp *= 1.2
	hp *= 1.2
