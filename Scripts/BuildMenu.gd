extends MarginContainer

var target_plantet
var menu = preload("res://Scenes/Build Menu.tscn")
onready var parent = get_node("../")

func _ready():
	MessageBus.connect("planet_focused",self,"planet_focused")


func planet_focused(planet,state):
	self.visible = state
	if state:
		target_plantet = planet
	else:
		target_plantet = null


func _on_TextureButton_pressed():
	if !(target_plantet == null):
		print(target_plantet)
		var menu_instance = menu.instance()
		menu_instance.target_plantet = target_plantet
		parent.add_child(menu_instance)
