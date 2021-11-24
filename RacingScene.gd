extends Node2D

var wind_angle = 0
var wind_speed = 0

var next_checkpoint = 0
var target = null
var total_seconds = 0

var game_over = preload("res://GameOver.tscn").instance()

func _ready():
	randomize()
	wind_angle = 3.14/3
	wind_speed = 150
	var wind_vec = Vector2(1, 0).rotated(wind_angle)*wind_speed
	$WindParticles.direction = wind_vec
	$Boat.wind_vec = wind_vec
	target = $Buoy1.position
	$Boat.target = target
	$CheckpointCircle.position = target

func _process(delta):
	total_seconds += delta
	$WindParticles.position = $Boat.position
	check_race()
	$Camera2D.position = $Boat.position
	$Camera2D.get_node("GUI").get_node("Row").get_node("Speed").text = " Speed: %s" % (round($Boat.velocity.length()/3.3))
	$Camera2D.get_node("GUI").get_node("Row").get_node("Distance").text = " Distance to Checkpoint: %s" % (round($Boat.position.distance_to($Boat.target)/10.0))
	$Camera2D.get_node("GUI").get_node("Row2").get_node("Time").text = " Time: %s" % (round(total_seconds))
	
func check_race():
	if $Boat.position.distance_to(target) < 128:
		next_checkpoint += 1
	
	if next_checkpoint == 1:
		target = $Buoy2.position
		$Boat.target = target
		$CheckpointCircle.position = target
	if next_checkpoint == 2:
		target = $Buoy3.position
		$Boat.target = target
		$CheckpointCircle.position = target
	if next_checkpoint == 3:
		target = $Buoy4.position
		$Boat.target = target
		$CheckpointCircle.position = target
	if next_checkpoint == 4:
		target = $Buoy5.position
		$Boat.target = target
		$CheckpointCircle.position = target
	if next_checkpoint == 5:
		# Game over! Show end screen
		game_over.get_node("Time").text = "Your time was: %s seconds" % (round(total_seconds * 10)/10.0)
		get_tree().get_root().add_child(game_over)
		get_node("/root/RacingScene").queue_free()
