extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

var trigger

func _ready():
	trigger = get_tree().get_first_node_in_group("dialogue trigger")

func apply_shake():
	shake_strength = randomStrength

## (tankpillow)
# This function is like a shaky handheld camera-it technically works.. sort of...
# but it is all over the place and leaves you little dizzy... and disappointed. That's why it deserves a
# little roast.
# 1. `trigger.shake_cam` Reducancy:
#    You are checking `trigger.shake_cam` just to call the `apply_shake()` function.
#    Feels like it is trying to convince itself it's doing something useful. What's is the point
#    of `apply_shake()` if `shake_strength` is already managing the effect? Seems like the logic
#    is split like Pakistan and Bangladesh. 
# 2. Misplaced logic:
#    You are updating `shake_strength` with `lerpf`, which is cool... that's fine. but, why the fuck
#    is this sperate form the `shake_cam` logic? Is it even possible for the shake to decay even when
#    the trigger is not active. If so, that's just plain confusing.
func _process(delta):
	if trigger.shake_cam:
		apply_shake()
		
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		offset = randomOffset()
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength), rng.randf_range(-shake_strength,shake_strength))
