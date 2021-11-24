extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("play"):
		advance()


func _on_Button_pressed():
	advance()

func advance():
	get_tree().change_scene("res://RacingScene.tscn")
