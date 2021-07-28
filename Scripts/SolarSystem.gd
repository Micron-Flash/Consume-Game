extends Node2D

var planets=0;
var generated = false
var focuse = false
signal cont
var file
var file_saved = false
onready var parrent = get_node("../")
var solarSystem_fab = load("res://Scenes/GenerateSolarSystem.tscn")
var solarSystemLink
onready var button = $StaticBody2D

func _ready():
	pass


func _on_StaticBody2D_mouse_entered():
	if !(generated):
		var data = MasterScript.generate_solar_system()
		planets = data["Planets"]
		file = data["File_Name"]
		generated = true;





func _on_StaticBody2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed):
		MasterScript.ui_show_planet_stats(false)
		print("focus")
		AudioHub.play_ui_button_select()
		MasterScript.camera.unset_follower()
		if !(focuse):
			MasterScript.focus(self)
			focuse = true;
		else:
			AudioHub.play_ui_button_confirm()
			MasterScript.planetpassthrough = planets
			#MasterScript.hide(parrent)
			if (solarSystemLink == null):
				solarSystemLink = solarSystem_fab.instance()
				solarSystemLink.planets = planets
				solarSystemLink.position = self.position
				solarSystemLink.scale = self.scale
				MasterScript.SolarSystem_location.add_child(solarSystemLink)
			else:
				solarSystemLink.visible = true
			#solarSystemLink.UI.show()
			MasterScript.camera.set_limits(self.global_position,20000)
			MasterScript.camera.max_zoom = 10
			MasterScript.unlock_camera()
			focuse = false
