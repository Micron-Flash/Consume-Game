extends Control

var target_plantet
var consumership = preload("res://Scenes/ConsumerShip.tscn")

func _ready():
	MessageBus.connect("planet_focused",self,"planet_focused")


func planet_focused(planet,state):
	self.visible = state
	if state:
		target_plantet = planet
	else:
		target_plantet = null


func _on_Extractor_pressed():
	var consumership_instance = consumership.instance()
	consumership_instance.planet_assigned = target_plantet
	consumership_instance.All = false
	consumership_instance.amout_per_tick = 5
	consumership_instance.resource_type = "Water"
	target_plantet.add_child(consumership_instance)
	consumership_instance.start_up()

func _on_Exit_pressed():
	self.queue_free()
