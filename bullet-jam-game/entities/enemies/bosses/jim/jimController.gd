extends CharacterBody2D


@onready var dmgFlashTimer = $dmgFlash
@onready var atkCooldown = $atkCooldown
@onready var nerfTracker = get_node("/root/NerfTracker")
@onready var atk1 = $Spiral
@onready var atk2 = $"sportBall"
@onready var atk3 = $"JimCanon"
@onready var atk4 = $"frenchBread"
@onready var atk5 = $"10ShotDirect"
var maxHp = 300
var hp = 300
var canShoot := true
@onready var explosion1 = $explosions/explosionAnimation
@onready var explosion2 = $explosions/explosionAnimation2
@onready var explosion3 = $explosions/explosionAnimation3
@onready var explosion4 = $explosions/explosionAnimation4
@onready var explosion5 = $explosions/explosionAnimation5
@onready var explosion6 = $explosions/explosionAnimation6
@onready var explosion7 = $explosions/explosionAnimation7
@onready var sprite = $AnimatedSprite2D
func takeDmg():
	hp -= 2
	if hp < 1 and canShoot:
		atk1.queue_free()
		atk2.queue_free()
		canShoot = false
		await explode(explosion1)
		await explode(explosion2)
		await explode(explosion3)
		await explode(explosion4)
		await explode(explosion5)
		await explode(explosion6)
		await explode(explosion7)
		sprite.visible = false
		explosion1.get_node("explosionTimer").start()
		await explosion1.get_node("explosionTimer").timeout
		queue_free()
	
	sprite.frame = 1
	
	dmgFlashTimer.start()
	await dmgFlashTimer.timeout
	
	sprite.frame = 0

func _ready() -> void:
	await get_tree().create_timer(2.8).timeout
	attack()

var currAtk
func attack() -> void:
	if !canShoot:
		return
	match randi_range(0, 4):
		0:
			await atk1.shoot()
		1:
			await atk2.shoot()
		2:
			await atk3.shoot()
		3: 
			await atk4.shoot()
		4: 
			await atk5.shoot()
	
	atkCooldown.wait_time = nerfTracker.enemyShootMulti
	atkCooldown.start()
	await atkCooldown.timeout
	
	attack()

func increaseHpVals():
	maxHp *= 1.2
	hp *= 1.2

func explode(anim):
	anim.play("default")
	anim.get_node("explosionTimer").start()
	await anim.get_node("explosionTimer").timeout
	return
