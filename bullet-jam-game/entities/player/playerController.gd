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
	1 : ["10% less max health"],
	2 : ["10% longer dash cooldown"],
	3 : ["Enemies have 10% more health"],
	4 : ["Enemies shoot 10% faster"]
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
func die():
	deathNerfChooser.show()
