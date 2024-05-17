extends CharacterBody2D

@onready var barUi: Control = $"CanvasLayer/Bar UI"
@onready var minimapUi: Control = $CanvasLayer/Minimap
func _ready() -> void:
	if get_parent().name == "Hub Level":
		inHub = true
		barUi.hide()
		minimapUi.hide()

func _physics_process(_delta: float) -> void:
	movement()
	if !inHub:
		if canDash and Input.is_action_just_pressed("dash") and dir:
			dash()
		if !hurtRecently and !dead and nerfTracker.hp < nerfTracker.maxHp:
			doRegen()

var canMove := true
var canDash := true
var dead := false
var hasIFrames := false
var hurtRecently := false
var inHub := false

@onready var nerfTracker = get_node("/root/NerfTracker")
var dir
@onready var dashTimer = $dashLength
@onready var dashCooldown = $dashCooldown
@onready var regenTimer = $regenTimer
@onready var regenSpeed = $regenSpeed
@onready var sprite = $AnimatedSprite2D
@onready var cam = get_parent().get_node("Player Cam/Camera2D")
func movement():
	if canMove:
		dir = Input.get_vector("left", "right", "up", "down")
	if dir:
		velocity = dir * nerfTracker.spd
	else:
		velocity.x = move_toward(velocity.x, 0, nerfTracker.spd)
		velocity.y = move_toward(velocity.y, 0, nerfTracker.spd)
	
	if dir.x > 0:
		sprite.play("rollRight")
	elif dir.x < 0:
		sprite.play("rollLeft")
	elif dir.y > 0:
		sprite.play("rollRight")
	elif dir.y < 0:
		sprite.play("rollLeft")
	else:
		sprite.play("idle")
	
	move_and_slide()

func dash():
	dashCooldown.wait_time = nerfTracker.dashCooldown
	dashTimer.wait_time = nerfTracker.dashDistance
	
	canMove = false
	canDash = false
	hasIFrames = true
	dir = dir * 5
	
	$"CanvasLayer/Bar UI".resetDash()
	dashTimer.start()
	await dashTimer.timeout
	
	canMove = true
	hasIFrames = false
	
	dashCooldown.start()
	await dashCooldown.timeout
	
	canDash = true

func takeDmg() -> void:
	if nerfTracker.hp > 0:
		nerfTracker.hp -= 1.0
		hurtRecently = true
		regenTimer.start()
		cam.doShake()
	if nerfTracker.hp < 1 and !dead:
		nerfTracker.hp = 0
		dead = true
		die()

func nextLevel(path : String) -> void:
	get_tree().change_scene_to_file(path)

func doRegen() -> void:
	if regenSpeed.is_stopped():
		regenSpeed.wait_time = nerfTracker.regen
		regenSpeed.start()
		nerfTracker.hp += 1

func _on_regen_timer_timeout() -> void:
	hurtRecently = false

@onready var deathNerfChooser = $"CanvasLayer/Death Nerf Chooser"
@onready var nerf1 = $"CanvasLayer/Death Nerf Chooser/Option1"
@onready var nerf2 = $"CanvasLayer/Death Nerf Chooser/Option2"
@onready var nerf3 = $"CanvasLayer/Death Nerf Chooser/Option3"
@onready var hpBar = $"CanvasLayer/Bar UI/hpBar"
var option1
var option2
var option3
func die():
	option1 = randi_range(1, 10)
	option2 = randi_range(1, 10)
	option3 = randi_range(1, 10)
	while option2 == option1:
		option2 = randi_range(1, 10)
	while option3 == option2 or option3 == option1:
		option3 = randi_range(1, 10)
	
	nerf1.get_node("Sprite2D").texture = load(nerfOptions[option1][2])
	nerf1.get_node("RichTextLabel").text = nerfOptions[option1][0] + "\n\n\n" + nerfOptions[option1][1]
	nerf2.get_node("Sprite2D").texture = load(nerfOptions[option2][2])
	nerf2.get_node("RichTextLabel").text = nerfOptions[option2][0] + "\n\n\n" + nerfOptions[option2][1]
	nerf3.get_node("Sprite2D").texture = load(nerfOptions[option3][2])
	nerf3.get_node("RichTextLabel").text = nerfOptions[option3][0] + "\n\n\n" + nerfOptions[option3][1]
	
	hpBar.value = 0
	
	get_tree().paused = true
	deathNerfChooser.show()

#region NERFING
var nerfOptions : Dictionary = {
	1 : ["", 					"25% less max health", 					"res://icon.svg"],
	2 : ["", 					"Dash Cooldown is 50% longer", 			"res://icon.svg"],
	3 : ["", 					"Enemies have 50% more health", 		"res://icon.svg"],
	4 : ["Reinforcements", 		"Enemies fire rate is 50% faster", 		"res://icon.svg"],
	5 : ["Ball and chain", 		"Dash Distance is 50% less", 			"res://icon.svg"],
	6 : ["Higher Heat", 		"Enemy bullets are 50% larger", 		"res://icon.svg"],
	7 : ["", 					"Your fire rate is 50% slower", 		"res://icon.svg"],
	8 : ["Hollow Tip Rounds", 	"Enemy Bullets move 50% faster", 		"res://icon.svg"],
	9 : ["", 					"Your movement is 25% slower", 			"res://icon.svg"],
	10 :["", 					"Health regeneration is 50% slower", 	"res://icon.svg"]
}
func chooseNerf(choice : int) -> void:
	match choice:
		1:
			nerfTracker.maxHp *= 0.75
		2:
			nerfTracker.dashCooldown *= 1.5
		3:
			nerfTracker.enemyHpMulti *= 1.5
			get_tree().call_group("enemy", "increaseHpVals")
		4:
			nerfTracker.enemyShootMulti *= 0.5
			get_tree().call_group("attacks", "increaseFireRate")
		5:
			nerfTracker.dashDistance *= 0.5
		6:
			nerfTracker.enemyBulletSize *= 1.5
			nerfTracker.enemyBulletSpeed *= 0.5
		7:
			nerfTracker.fireRate *= 1.5
		8:
			nerfTracker.enemyBulletSpeed *= 1.5
		9:
			nerfTracker.spd *= 0.75
		10:
			nerfTracker.regen *= 1.5
	
	get_tree().call_group("bullet", "queue_free")
	nerfTracker.hp = nerfTracker.maxHp
	dead = false
	deathNerfChooser.hide()
	get_tree().paused = false
#endregion
