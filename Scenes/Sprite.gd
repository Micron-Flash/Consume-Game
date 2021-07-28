tool
extends Sprite
onready var noise_source = get_node("..")
var noise = OpenSimplexNoise.new()

func _process(delta):
	noise.seed = noise_source.seeds
	noise.octaves = noise_source.octave
	noise.period = noise_source.period
	noise.lacunarity = noise_source.lacunarity
	noise.persistence = noise_source.persistence
	self.texture.set_width(noise_source.WIDTH)
	self.texture.set_height(noise_source.HIGHT)
	self.texture.set_noise(noise)
