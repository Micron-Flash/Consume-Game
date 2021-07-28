extends Node2D

signal planet_focused(planet,state)

func on_planet_focused(planet,state):
	emit_signal("planet_focused",planet,state) 

