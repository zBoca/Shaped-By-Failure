extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	movement()
	if canDash and Input.is_action_just_pressed("dash") and dir:
		dash()

var canMove := true
var canDash := true
var dead := false
var hasIFrames := false

var nerfOptions : Dictionary = {
	1 : ["", "20% less max health", "res://icon.svg"],
	2 : ["", "Dash Cooldown is 20% longer", "res://icon.svg"],
	3 : ["", "Enemies have 20% more health", "res://icon.svg"],
	4 : ["", "Enemies fire rate is 20% faster", "res://icon.svg"],
	5 : ["", "Dash Distance is 20% less", "res://icon.svg"],
	6 : ["", "Enemy bullets are 20% larger", "res://icon.svg"],
	7 : ["", "Your fire rate is 20% slower", "res://icon.svg"],
	8 : ["", "Enemy Bullets move 20% faster", "res://icon.svg"],
	9 : ["", "Your movement is 20% slower", "res://icon.svg"]
}

var hp = 5
var spd = 200.0
var dir
var dashMulti = 5
@onready var dashTimer = $dashLength
@onready var dashCooldown = $dashCooldown
func movement():
	if canMove:
		dir = Input.get_vector("left", "right", "up", "down")
	if dir:
		velocity = dir * spd
	else:
		velocity.x = move_toward(velocity.x, 0, spd)
		velocity.y = move_toward(velocity.y, 0, spd)

	move_and_slide()

func dash():
	canMove = false
	canDash = false
	hasIFrames = true
	dir = dir * dashMulti
	
	dashTimer.start()
	await dashTimer.timeout
	
	canMove = true
	hasIFrames = false
	
	dashCooldown.start()
	await dashCooldown.timeout
	
	canDash = true

func takeDmg() -> void:
	if hp > 0:
		hp -= 1
	if hp < 1 and !dead:
		dead = true
		die()

@onready var deathNerfChooser = $"CanvasLayer/Death Nerf Chooser"
@onready var nerf1 = $"CanvasLayer/Death Nerf Chooser/Option1"
@onready var nerf2 = $"CanvasLayer/Death Nerf Chooser/Option2"
@onready var nerf3 = $"CanvasLayer/Death Nerf Chooser/Option3"
var option1
var option2
var option3
func die():
	option1 = randi_range(1, 9)
	option2 = randi_range(1, 9)
	option3 = randi_range(1, 9)
	while option2 == option1:
		option2 = randi_range(0, 8)
	while option3 == option2 or option3 == option1:
		option3 = randi_range(0, 8)
	
	nerf1.get_node("Sprite2D").texture = load(nerfOptions[option1][2])
	nerf1.get_node("RichTextLabel").text = nerfOptions[option1][0] + "\n\n\n" + nerfOptions[option1][1]
	nerf2.get_node("Sprite2D").texture = load(nerfOptions[option2][2])
	nerf2.get_node("RichTextLabel").text = nerfOptions[option2][0] + "\n\n\n" + nerfOptions[option2][1]
	nerf3.get_node("Sprite2D").texture = load(nerfOptions[option3][2])
	nerf3.get_node("RichTextLabel").text = nerfOptions[option3][0] + "\n\n\n" + nerfOptions[option3][1]
	
	deathNerfChooser.show()
