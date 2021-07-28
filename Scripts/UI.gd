extends CanvasLayer

onready var parrent = get_node("../")
onready var stats_node = $Planet_Stats
onready var child = $MarginContainer
onready var type = $Planet_Stats/VBoxContainer/Type
onready var size = $Planet_Stats/VBoxContainer/Size
onready var civ_level = $Planet_Stats/VBoxContainer/Civ_level
onready var tech_level = $Planet_Stats/VBoxContainer/Tech_level
onready var tech = $Planet_Stats/VBoxContainer/Tech
onready var resource = $Planet_Stats/VBoxContainer/Resourse
onready var _name = $Planet_Stats/VBoxContainer2/Name
onready var panel = $StatsContainer

func _ready():
	MasterScript.connect("ui_planet_stats",self,"set_planet_stats")
	MasterScript.connect("ui_show_planet_stats",self,"show_planet_stats")

func _on_Button_pressed():
	#MasterScript.hide(parrent)
	MasterScript.unhide(MasterScript.current_galaxy)
	MasterScript.unlock_camera()
	MasterScript.camera.reset_limits()
	hide()

func hide():
	child.visible = false

func show():
	child.visible = true

func set_planet_stats(planet):
	type.text = "Type: " + planet["Type"]
	size.text = "Size: " + String(planet["Size"])
	civ_level.text = "Civilization Level: " + String(planet["Civ_Level"])
	tech_level.text = "Tech Level: "+ String(planet["Tech_Level"])
	tech.text = "Tech: "+ String(planet["Tech"])
	var resource_count = 0
	for resource in planet["Resourses"]:
		resource_count += planet["Resourses"].get(resource)
	resource.text = "Total Resources: "+ String(resource_count)
	_name.text = "Name: " + planet["Name"]
	


func show_planet_stats(state):
	panel.visible = state
	stats_node.visible = state
	match state:
		true:
			AudioHub.play_effects_stats()
	
	
