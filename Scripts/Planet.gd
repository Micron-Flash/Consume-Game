extends Node2D
var earth = load("res://Animations/Earth.tres")
var gassy = load("res://Animations/Gassy.tres")
var sun = load("res://Animations/Sun.tres")
var PlanetType
onready var planet = $Earth
var stats
var speed
var consumers = []

func _ready():
	ResourceManager.connect("tick",self,"tick")
	speed = MasterScript._rng_randi_range(-10,10)*0.0001
	print(speed)

func _process(delta):
	self.rotate(speed)

func apply_offset(distance):
	print(stats)
	planet.position = distance

func SetPlanetType(type):
	PlanetType = type
	print(type)
	match type:
		"Terran":
			planet.frames = earth
		"Gas":
			planet.frames = gassy
		"Sun":
			planet.frames = sun
		"Terran (Barren)":
			planet.frames = earth
		
func spawn_scripts():
	pass

func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed and not self.PlanetType == "Sun" ):
		MasterScript.set_ui_planet_stats(stats)
		MasterScript.ui_show_planet_stats(true)
		MasterScript.focus(planet)
		MessageBus.on_planet_focused(planet,true)
		MasterScript.camera.set_follower(planet)
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed and self.PlanetType == "Sun" ):
		MasterScript.ui_show_planet_stats(false)
		MasterScript.camera.unset_follower()
		MessageBus.on_planet_focused(planet,false)
		
func _on_RigidBody2D_mouse_entered():
	Input.set_default_cursor_shape (Input.CURSOR_POINTING_HAND)


func _on_RigidBody2D_mouse_exited():
	Input.set_default_cursor_shape (Input.CURSOR_ARROW)

func attach_consumer(consumer):
	consumers.append(consumer)
	

func detach_consumer(consumer):
	consumers.erase(consumer)
	ResourceManager.dettach_intake(consumer)
	consumer.queue_free()

func tick():
	var minus = {}
	for consumer in consumers:
		if (minus.has(consumer.resource_type)):
			minus[consumer.resource_type] += consumer.amout_per_tick
		else:
			minus[consumer.resource_type] = consumer.amout_per_tick
		
		if (stats["Resourses"][consumer.resource_type] == 0):
			detach_consumer(consumer)
		
	for resource in minus:
		if stats["Resourses"].has(resource):
			if ((stats["Resourses"][resource] - minus[resource]) >= 0):
				stats["Resourses"][resource] -= minus[resource]
			else:
				stats["Resourses"][resource] = 0
				
				
func get_avaiable_resources():
	var resources = []
	for resource in stats["Resourses"]:
		resources.append(resource)
	print(resources)
	return resources































