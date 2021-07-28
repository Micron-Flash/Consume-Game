extends Node2D
export var All = false
export (String, "Water","Metal_ore","Fuel","Food","Life","Tech") var type
var types = ["Water","Metal_ore","Fuel","Food","Life","Tech"]
export var amout_per_tick = 1
var resource_type
var planet_assigned
var avaiable_resources
var producer = preload("res://Scenes/Producer.tscn")
var cost = {
	"Water":0,
	"Metal_ore":0,
	"Fuel":10,
	"Food":5,
	"Life":0,
	"Tech":0
}

func start_up():
	avaiable_resources = planet_assigned.get_node("../").get_avaiable_resources()
	if All:
		for resourse in types:
			if resourse in avaiable_resources:
				var producer_instance = producer.instance()
				producer_instance.resource_type = resourse
				producer_instance.amout_per_tick = amout_per_tick
				self.add_child(producer_instance)
				ResourceManager.attach_intake(producer_instance)
				planet_assigned.get_node("../").attach_consumer(producer_instance)
	elif (avaiable_resources.has(resource_type)):
		var producer_instance = producer.instance()
		producer_instance.resource_type = resource_type
		producer_instance.amout_per_tick = amout_per_tick
		self.add_child(producer_instance)
		ResourceManager.attach_intake(producer_instance)
		planet_assigned.get_node("../").attach_consumer(producer_instance)
		set_cost_consumers(cost)

func set_cost_consumers(_cost):
	for price in _cost:
		if (_cost[price] > 0):
			var producer_instance = producer.instance()
			producer_instance.resource_type = price
			producer_instance.amout_per_tick = _cost[price]
			self.add_child(producer_instance)
			ResourceManager.attach_outtake(producer_instance)
