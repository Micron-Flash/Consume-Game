extends MarginContainer

onready var label = $TextureRect3/Label
onready var progress_bar = $TextureRect3/ProgressBar
export (String, "Water","Metal_ore","Fuel","Food","Life","Tech") var type
var type_string = type
var ammount = 0
export (int) var max_limit = 1000000

func _ready():
	progress_bar.max_value = max_limit
	progress_bar.value = 0
	print(type)
func _on_ProgressBar_value_changed(value):
	label.text = String(value)


func update_amount(value):
	progress_bar.value = ResourceManager.resource_count[type]
