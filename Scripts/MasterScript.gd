extends Node

export var _seed = 10000
var focused
var rng = RandomNumberGenerator.new()
var galaxy_dict = {}
var camera;
var planet_values = {
		"Terran":
			{
				"Max_Mass": 5,
				"Min_Mass": 1,
				"Max_Civ": 5,
				"Resourse_Types":
					{
						"Water":true,
						"Metal_ore": true,
						"Life": true,
						"Food": true,
						"Fuel": false,
					},
				"Resourse_Max":
					{
					"Water":100000,
					"Metal_ore": 100000,
					"Life": 100000,
					"Food": 100000,
					"Fuel": 100000,
					}
			},
		"Gas":
			{
				"Max_Mass": 10,
				"Min_Mass": 4,
				"Max_Civ": 0,
				"Resourse_Types":
					{
						"Water":true,
						"Metal_ore": true,
						"Life": false,
						"Food": false,
						"Fuel": true,
					},
				"Resourse_Max":
					{
					"Water":100000,
					"Metal_ore": 100000,
					"Life": 100000,
					"Food": 100000,
					"Fuel": 100000,
					}
			},
		"Terran (Barren)":
			{
				"Max_Mass": 7,
				"Min_Mass": 2,
				"Max_Civ": 1,
				"Resourse_Types":
					{
						"Water":false,
						"Metal_ore": true,
						"Life": false,
						"Food": false,
						"Fuel": true,
					},
				"Resourse_Max":
					{
					"Water":100000,
					"Metal_ore": 100000,
					"Life": 100000,
					"Food": 100000,
					"Fuel": 100000,
					}
			},
	}
export var planetpassthrough = 2
export var planetpassthroughfile = ""
export var current_galaxy_file = "res://Scenes/GenerateSolarSystem.tscn"
export var current_solr_file = "res://Saves/SaveGameTest_solr.tscn"
var hidden_list = []
var current_galaxy
onready var SolarSystem_location = get_node("/root/Game/SolarSystems")
onready var UI = get_node("/root/Game/UI")
var current_focus
signal focus_finished
signal save
signal ui_planet_stats(planet)
signal ui_show_planet_stats(state)
var galaxyLoaded = false


func _ready():
	rng.randomize()
	_seed = rng.seed
	#SeedSetter(462135467431000)

	
func save():
	pass
	#emit_signal("save")
	
func set_camera(cam):
	camera = cam
	
func SeedSetter(seeds):
	rng.seed = seeds
	_seed = rng.seed


func generate_solar_system():
	galaxy_dict["Planets"] = rng.randi_range(1,12)
	galaxy_dict["File_Name"] = str(rng.randi())+"P"
	return galaxy_dict

func focus(object):
	if (current_focus == null):
		current_focus = object
	if (object != current_focus):
		camera.move(object.global_position,object.scale)
		#current_focus.focuse = false
		current_focus = object
	else:
		camera.move(object.global_position,object.scale)
	
func lock_camera():
	camera.locked = true
	 
func unlock_camera():
	camera.drag_margin_h_enabled = true
	camera.drag_margin_v_enabled = true
	camera.locked = false
	
func generate_planets(planet_count):
	var planets = []
	for i in planet_count:
		var planet = {"Resourses":{}}
		planet["Type"] = rand_planet_type()
		planet["Size"] = rand_mass(planet,planet_count)
		#planet["Resourse"]["Metal_Ore"] = rng.randi_range(0,100000*planet["Size"])
		#planet["Resourse"]["Food"] = rng.randi_range(0,100000*planet["Size"])
		planet["Civ_Level"] = rng.randi_range(0,planet_values[planet["Type"]]["Max_Civ"])
		planet["Tech_Level"] = rng.randi_range(0,planet["Civ_Level"])
		planet["Tech"] = rng.randi_range(0,planet["Tech_Level"]*100*planet["Size"])
		#planet["Resourse"]["Life"] = rng.randi_range(0,100000*planet["Size"])
		#planet["Resourse"]["Water"] = rng.randi_range(0,100000*planet["Size"])
		planet["Resourses"] = get_resourse(planet)
		planet["Order"] = i
		planet["Name"] = random_name()
		planets.append(planet)
	return planets
	
func rand_mass(planet,planet_count):
	return rng.randi_range(planet_values[planet["Type"]]["Min_Mass"],planet_values[planet["Type"]]["Max_Mass"])

func rand_planet_type():
	return planet_values.keys()[rng.randi() % planet_values.size()]

func _rng_randi_range(a,b):
	return rng.randi_range(a,b)
	
func _rng_randf_range(a,b):
	return rng.randf_range(a,b)

func _load(file):
	emit_signal("save")
	get_tree().change_scene(file)
	
func hide(object):
	if !(hidden_list.has(object)):
		object.visible = false
		hidden_list.append(object)
	return

func unhide(object):
	if (hidden_list.has(object)):
		object.visible = true
		hidden_list.erase(object)
	return

func activate_main_camera():
	camera.current = true
	
	
func deactivate_main_camera():
	camera.current = false

func set_ui_planet_stats(planet):
	emit_signal("ui_planet_stats",planet)

func ui_show_planet_stats(state):
	emit_signal("ui_show_planet_stats",state)
	
func random_name():
	var letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',"qu",'r','s','t','u','v','w','x','y','z']
	var vowels = ['a','e','i','o','u','y']
	var name = letters[MasterScript._rng_randi_range(0,letters.size()-1)]
	var letter = vowels[MasterScript._rng_randi_range(0,vowels.size()-1)]
	name = name + letter
	for i in range(MasterScript._rng_randi_range(0,3)):
		letter = letters[MasterScript._rng_randi_range(0,letters.size()-1)]
		name = name + letter
	name = name + "-"
	name = name + String(MasterScript._rng_randi_range(0,9999))
	return name

func get_resourse(planet):
	var resources = {}
	for resource in planet_values[planet["Type"]]["Resourse_Types"]:
		print(planet_values[planet["Type"]]["Resourse_Types"].get(resource))
		if (planet_values[planet["Type"]]["Resourse_Types"].get(resource)):
			 resources[resource] = (rng.randi_range(0,planet_values[planet["Type"]]["Resourse_Max"].get(resource)*planet["Size"]))
	return resources
