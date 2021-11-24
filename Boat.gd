extends KinematicBody2D

# Wind velocity (relative to BOAT) puts a force on the sails
#   - Part of force is perpendicular to wind velocity (relative to boat)
#   - Part is in same direction as relative wind vel, as drag
# This force from sails acts on boat, but keel will direct force along boat dir
export var wind_vec = Vector2.ZERO
export var mass = 8 # F = m*a, F/m = a
export var accel = Vector2.ZERO
var target = Vector2.ZERO

var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("rotate_left"):
		rotation -= delta
	if Input.is_action_pressed("rotate_right"):
		rotation += delta
	
	var wind_angle = ApparentWind().angle()
	$Sail.set_rotation(wind_angle)
	if wind_angle > 0:
		$Sail/SailSprite.set_flip_v(false)
	else:
		$Sail/SailSprite.set_flip_v(true)

	var force = SailForce().rotated(rotation)
	force += Drag()
	accel = force/mass
	velocity += accel*delta
	
	var emitting = false
	if velocity.length() > 50:
		emitting = true
	

	$wake.set_emitting(emitting)
	#$Debug.set_rotation(accel.rotated(-rotation).angle())
	#$Debug.scale.x = accel.length()

	$Compass.rotation = (target-position).angle()-rotation

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func ApparentWind(): #Wind velocity apparent
	# Actual wind vec - boat
	return (wind_vec-velocity).rotated(-rotation)

func SailLift():
	var aw = ApparentWind()
	if aw.angle() > 0:
		return aw.rotated(-3.14/2.0)
	else:
		return aw.rotated(3.14/2.0)

func SailDrag():
	return ApparentWind() * 0.01

func SailForce():
	return SailLift()+SailDrag()

func Drag():
	var uniform = velocity * -0.01
	var v = uniform.rotated(-rotation)
	v.y *= 1000
	v = v.rotated(rotation)
	return v
