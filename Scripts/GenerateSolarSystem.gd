extends Node2D

export var planets=0;
var planet_list
const planet_obj = preload("res://Scenes/Planet.tscn")
var file
onready var UI = $UI

func _ready():
	MasterScript.connect("save",self,"_save")
	var planet = planet_obj.instance()
	planet.position = Vector2(0,0)
	add_child(planet)
	planet.SetPlanetType("Sun")
	generate_planets()
	



func generate_planets():
	if planet_list == null:
		#planets = MasterScript.planetpassthrough
		file = MasterScript.planetpassthroughfile
		planet_list = MasterScript.generate_planets(planets)
		for i in planet_list:
			var planet = planet_obj.instance()
			if (i["Type"] == "Earth"):
				var size = i["Size"] * 0.1
				planet.scale = Vector2(size,size)
			else:
				var size = i["Size"] * 0.1
				planet.scale = Vector2(size,size)
			planet.stats = i
			add_child(planet)
			planet.SetPlanetType(i["Type"])
			planet.spawn_scripts()
			planet.apply_offset(Vector2(MasterScript._rng_randi_range(-i["Order"]/10*4800-4000,i["Order"]/10*4800+4000),MasterScript._rng_randi_range(-i["Order"]/10*4800-4000,i["Order"]/10*4800+4000)))
		return
	
func _save():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://Saves/"+file+".tscn", packed_scene)
	MasterScript.current_solr_file = "res://Saves/"+file+".tscn"
