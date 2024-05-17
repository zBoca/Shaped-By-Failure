extends Node

const DEFAULT_maxHp = 10.0
const DEFAULT_spd = 200.0
const DEFAULT_dashCooldown = 1.0
const DEFAULT_dashDistance = 0.2
const DEFAULT_fireRate = 0.5
const DEFAULT_regen = .5
const DEFAULT_enemyHpMulti = 1.0
const DEFAULT_enemyShootMulti = 1.0
const DEFAULT_enemyBulletSize = 1.0
const DEFAULT_enemyBulletSpeed = 500.0

var maxHp
var hp
var spd
var dashCooldown
var dashDistance
var fireRate
var regen
var enemyHpMulti
var enemyShootMulti
var enemyBulletSize
var enemyBulletSpeed

func _ready() -> void:
	fullReset()

func fullReset():
	print("Stats Reset!")
	maxHp = DEFAULT_maxHp
	hp = DEFAULT_maxHp
	spd = DEFAULT_spd
	dashCooldown = DEFAULT_dashCooldown
	dashDistance = DEFAULT_dashDistance
	fireRate = DEFAULT_fireRate
	regen = DEFAULT_regen
	enemyHpMulti = DEFAULT_enemyHpMulti
	enemyShootMulti = DEFAULT_enemyShootMulti
	enemyBulletSize = DEFAULT_enemyBulletSize
	enemyBulletSpeed = DEFAULT_enemyBulletSpeed
