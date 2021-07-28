extends Control

onready var Food = $Food
onready var Metal_ore = $Metal_ore
onready var Water = $Water
onready var Life = $Life
onready var Tech = $Tech
onready var Fuel = $Fuel

func _ready():
	ResourceManager.connect("Food_update",self,"Food_update")
	ResourceManager.connect("Metal_ore_update",self,"Metal_ore_update")
	ResourceManager.connect("Water_update",self,"Water_update")
	ResourceManager.connect("Life_update",self,"Life_update")
	ResourceManager.connect("Tech_update",self,"Tech_update")
	ResourceManager.connect("Fuel_update",self,"Fuel_update")


func Food_update(amount):
	Food.update_amount(amount)
	
func Metal_ore_update(amount):
	Metal_ore.update_amount(amount)

func Water_update(amount):
	Water.update_amount(amount)

func Life_update(amount):
	Life.update_amount(amount)
	
func Tech_update(amount):
	Tech.update_amount(amount)
	
func Fuel_update(amount):
	Fuel.update_amount(amount)
