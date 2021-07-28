extends StaticBody2D

onready var parent = get_node("../")

func _input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed):
		parent._on_StaticBody2D_mouse_entered()
		AudioHub.play_ui_button_select()


