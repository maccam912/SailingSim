extends Control


func _on_RotateLeft_button_down():
	Input.action_press("rotate_left")


func _on_RotateLeft_button_up():
	Input.action_release("rotate_left")


func _on_RotateRight_button_down():
	Input.action_press("rotate_right")


func _on_RotateRight_button_up():
	Input.action_release("rotate_right")
