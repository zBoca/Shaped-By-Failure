extends CharacterBody2D

@onready var barUi: Control = $"CanvasLayer/Bar UI"
@onready var minimapUi: Control = $CanvasLayer/Minimap
func _ready() -> void:
	if get_parent().name == "Hub Level":
		inHub = true
		barUi.hide()
		minimapUi.hide()
	elif get_parent().name == "1_Boss" or get_parent().name == "2_Boss" or get_parent().name == "3_Boss" or get_parent().name == "4_Boss" or get_parent().name == "5_Boss":
		get_parent().get_node("Player Cam/Camera2D/Area2D").queue_free()
		get_parent().get_node("Player Cam/Camera2D").zoom = Vector2(0.55, 0.55)

func _physics_process(_delta: float) -> void:
	movement()
	if !inHub:
		if canDash and Input.is_action_just_pressed("dash") and dir:
			dash()
		if !hurtRecently and !dead and nerfTracker.hp < nerfTracker.maxHp:
			doRegen()

var canMove := false
var canDash := false
var dead := false
var hasIFrames := false
var hurtRecently := false
var inHub := false

@onready var nerfTracker = get_node("/root/NerfTracker")
var dir = Vector2(0, 0)
@onready var dashTimer = $dashLength
@onready var dashCooldown = $dashCooldown
@onready var regenTimer = $regenTimer
@onready var regenSpeed = $regenSpeed
@onready var sprite = $AnimatedSprite2D
@onready var cam = get_parent().get_node("Player Cam/Camera2D")
func allowMove():
	canMove = true
	canDash = true
	$weaponHold.canShoot = true

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
	elif canMove:
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

func takeDmg(dmg : float = 1.0) -> void:
	if nerfTracker.hp > 0:
		nerfTracker.hp -= dmg
		hurtRecently = true
		regenTimer.start()
		cam.doShake()
		$dmgSound.play()
	if nerfTracker.hp < 1 and !dead:
		nerfTracker.hp = 0
		dead = true
		die()

func nextLevel(path : String) -> void:
	canMove = false
	$teleportSound.play()
	await get_tree().create_timer(1).timeout
	get_parent().get_node("Player Cam/Camera2D/fadeAnimator").play("fadeOut")
	await get_tree().create_timer(0.7).timeout
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
@onready var musicPlayer : AudioStreamPlayer = get_node("/root/MusicPlayer")
var option1
var option2
var option3
func die():
	musicPlayer.stream_paused = true
	$dieSound.play()
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
	1 : ["Weakened", 				"15% less max health", 					"res://ui/nerfAssets/nerfIcons1.png"],
	2 : ["Out of shape", 			"Dash Cooldown is 25% longer", 			"res://ui/nerfAssets/nerfIcons2.png"],
	3 : ["Armored Enemies", 		"Enemies have 25% more health", 		"res://ui/nerfAssets/nerfIcons3.png"],
	4 : ["Reinforcements", 			"Enemies fire rate is 20% faster", 		"res://ui/nerfAssets/nerfIcons4.png"],
	5 : ["Ball and chain", 			"Dash Distance is 25% less", 			"res://ui/nerfAssets/nerfIcons5.png"],
	6 : ["Higher Heat", 			"Enemy bullets are 10% larger", 		"res://ui/nerfAssets/nerfIcons6.png"],
	7 : ["Buuullleeettt tiiimmmeee","Your fire rate is 15% slower", 		"res://ui/nerfAssets/nerfIcons7.png"],
	8 : ["Hollow Tip Rounds", 		"Enemy Bullets move 10% faster", 		"res://ui/nerfAssets/nerfIcons8.png"],
	9 : ["Difficult Terrain", 		"Your movement is 15% slower", 			"res://ui/nerfAssets/nerfIcons9.png"],
	10 :["Deterioration", 			"Health regeneration is 50% slower", 	"res://ui/nerfAssets/nerfIcons10.png"]
}
func chooseNerf(choice : int) -> void:
	match choice:
		1:
			nerfTracker.maxHp *= 0.85
		2:
			nerfTracker.dashCooldown *= 1.25
		3:
			nerfTracker.enemyHpMulti *= 1.25
			get_tree().call_group("enemy", "increaseHpVals")
		4:
			nerfTracker.enemyShootMulti *= 0.8
			get_tree().call_group("attacks", "increaseFireRate")
		5:
			nerfTracker.dashDistance *= 0.75
		6:
			nerfTracker.enemyBulletSize *= 1.1
			nerfTracker.enemyBulletSpeed *= 0.9
		7:
			nerfTracker.fireRate *= 1.15
		8:
			nerfTracker.enemyBulletSpeed *= 1.1
		9:
			nerfTracker.spd *= 0.85
		10:
			nerfTracker.regen *= 1.5
	
	get_tree().call_group("bullet", "queue_free")
	nerfTracker.hp = nerfTracker.maxHp
	dead = false
	deathNerfChooser.hide()
	musicPlayer.stream_paused = false
	get_tree().paused = false
#endregion
