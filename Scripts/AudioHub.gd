extends Node2D

onready var button_select = $UIButton/ButtonSelect
onready var button_confirm = $UIButton/ButtonConfirm
onready var effects_swoosh = $Effects/Swoosh
onready var effects_stats = $"Effects/Stats(UpgradeBoost8)"
onready var effects_swipe = $Effects/Swip1


func play_ui_button_select():
	button_select.play()

func play_ui_button_confirm():
	button_confirm.play()

func play_effect_swoosh():
	effects_swoosh.play()

func play_effects_stats():
	effects_stats.play()

func play_effects_swipe():
	effects_swipe.play()
