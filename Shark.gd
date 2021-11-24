extends KinematicBody2D

export var rotation_speed = 1.0

func _process(delta):
	rotation += -rotation_speed*delta
