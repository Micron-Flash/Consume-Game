extends MarginContainer

onready var System = get_node("../")
onready var text = $Label

func _ready():
	self.visible = false


func _on_StaticBody2D_mouse_entered():
	text.text = String(System.planets)
	self.visible = true
	Input.set_default_cursor_shape (Input.CURSOR_POINTING_HAND)


func _on_StaticBody2D_mouse_exited():
	self.visible = false
	Input.set_default_cursor_shape (Input.CURSOR_ARROW)
	


func _on_Button_focus_entered():
	text.text = String(System.planets)
	self.visible = true


func _on_Button_focus_exited():
	self.visible = false
