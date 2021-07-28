extends Node2D

export var WIDTH = 1920
export var HIGHT = 1080

export var level = 1.0

export var octave = 9
export var period = 0.1
export var lacunarity = 0.1
export var persistence = 0.0
export var seeds = 10000;
var loaded = false

const solarSystem = preload("res://Scenes/SolarSystem.tscn")
var open_simplex_noise

func _ready():
	#MasterScript._load("res://Saves/SaveGameTest.tscn")
	MasterScript.connect("save",self,"_save")
	MasterScript.current_galaxy = self
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = MasterScript._seed
	seeds = open_simplex_noise.seed
	open_simplex_noise.octaves = octave
	open_simplex_noise.period = period
	open_simplex_noise.lacunarity = lacunarity
	open_simplex_noise.persistence = persistence
	if !MasterScript.galaxyLoaded:
		print("not loaded")
		_generate_Galaxy()


func _generate_Galaxy():
	MasterScript.galaxyLoaded = true
	for x in WIDTH:
		for y in HIGHT:
			if (open_simplex_noise.get_noise_2d(float(x),float(y)) <= level):
				var galaxy_instance = solarSystem.instance()
				galaxy_instance.global_position = Vector2(float((x)*(2000/WIDTH)*100),float((y)*(2000/HIGHT)*100))
				var scale = randf()
				galaxy_instance.scale = Vector2(scale,scale)
				self.add_child(galaxy_instance)
	

func _save():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://Saves/SaveGameTest.tscn", packed_scene)
	MasterScript.current_galaxy_file = "res://Saves/SaveGameTest.tscn"
	
