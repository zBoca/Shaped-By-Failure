extends Camera2D


@export var randStr : float = 30.0
@export var shakeFade : float = 5.0

var rng = RandomNumberGenerator.new()

var shakeStr : float = 0.0

func _process(delta: float) -> void:
	if shakeStr > 0.0:
		shakeStr = lerpf(shakeStr, 0, shakeFade * delta)
		
		offset = randOffset()

func doShake():
	shakeStr = randStr

func randOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStr, shakeStr), rng.randf_range(-shakeStr, shakeStr))
