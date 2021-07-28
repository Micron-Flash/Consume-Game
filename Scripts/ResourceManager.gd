extends Node

export (String, "Water","Metal_ore","Fuel","Food","Life","Tech") var type
var resource_type = type
var consumers = []
var producsers = []
export var secondsPerTick = 1
var _timer = null
export var resource_count = {
	"Water":0,
	"Metal_ore":0,
	"Fuel":0,
	"Food":0,
	"Life":0,
	"Tech":0
}
signal tick

signal Water_update(amount)
signal Metal_ore_update(amount)
signal Fuel_update(amount)
signal Food_update(amount)
signal Life_update(amount)
signal Tech_update(amount)



func _ready():
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "tick")
	_timer.set_wait_time(secondsPerTick)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
	
func attach_intake(producer):
	producsers.append(producer)

func dettach_intake(producer):
	producsers.erase(producer)
	

func attach_outtake(consumer):
	consumers.append(consumer)

func dettach_outtake(consumer):
	consumers.erase(consumer)

func update_tick_time(time):
	secondsPerTick = time
	_timer.set_wait_time(secondsPerTick)
	
func tick():
	emit_signal("tick")
	var plus = {}
	var minus = {}
	var combined = {}
	for cons in producsers:
		if (plus.has(cons.resource_type)):
			plus[cons.resource_type] += cons.amout_per_tick
		else:
			plus[cons.resource_type] = cons.amout_per_tick
	
	for pros in consumers:
		if (minus.has(pros.resource_type)):
			minus[pros.resource_type] -= pros.amout_per_tick
		else:
			minus[pros.resource_type] = pros.amout_per_tick * -1
			
	for resource in plus:
		if (combined.has(resource)):
			combined[resource] += plus[resource]
		else:
			combined[resource] = plus[resource]
			
	for resource in minus:
		if (combined.has(resource)):
			combined[resource] += minus[resource]
		else:
			combined[resource] = minus[resource]
	
	
	for resource in combined:
		resource_count[resource] += combined[resource]
		match resource:
			"Water":
				emit_signal("Water_update",combined[resource])
			"Metal_ore":
				emit_signal("Metal_ore_update",combined[resource])
			"Fuel":
				emit_signal("Fuel_update",combined[resource])
			"Food":
				emit_signal("Food_update",combined[resource])
			"Life":
				emit_signal("Life_update",combined[resource])
			"Tech":
				emit_signal("Tech_update",combined[resource])
	
	
	
	
