extends Camera2D

# This script assumes that the zoom.x and zoom.y are always the same.

var current_zoom
export var min_zoom = 1.0
export var max_zoom = 5.0
export var zoom_factor = Vector2(0.25,0.25) # < 1 = zoom_in; > 1 = zoom_out
export var transition_time = 0.1
export var locked = false
export var following = false
var following_object

func _ready():
	MasterScript.set_camera(self)
	current_zoom = get_zoom()
	
func _process(delta):
	if !(locked or following) and Input.is_action_pressed("mouseMiddle"):
		self.position = get_global_mouse_position()
	elif following:
		self.position = following_object.global_position
	
func move(pos,_scale):
	self.drag_margin_h_enabled = false
	self.drag_margin_v_enabled = false
	locked = true
	$Tween.interpolate_property(self, "position", get_position(), pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "zoom", get_zoom(), Vector2(_scale.x,_scale.y), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	AudioHub.play_effect_swoosh()
	return
	
	
func zoom_in(new_zoom):
	new_zoom = get_zoom()-new_zoom
	transition_camera(new_zoom)


func zoom_out(new_zoom):
	new_zoom = get_zoom()-new_zoom
	transition_camera(new_zoom)


func transition_camera(new_zoom):
	if new_zoom != current_zoom:
		current_zoom = new_zoom
		if current_zoom.x <= 0.1:
			current_zoom = Vector2(0.1,0.1)
		$Tween.interpolate_property(self, "zoom", get_zoom(), current_zoom, transition_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
func _unhandled_input(event):
	current_zoom = get_zoom()
	if event.is_action_pressed("zoom_in") and current_zoom.x >= min_zoom:
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		zoom_in(zoom_factor)
	if event.is_action_pressed("zoom_out") and current_zoom.x < max_zoom:
		zoom_out(zoom_factor*-1)

func set_limits(pos,size):
	self.limit_left = (pos.x-size/2)
	self.limit_right = (pos.x+size/2)
	self.limit_top = (pos.y-size/2)
	self.limit_bottom = (pos.y+size/2)
	return

func reset_limits():
	self.limit_left = (-2500)
	self.limit_right = (202500)
	self.limit_top = (-2500)
	self.limit_bottom = (202500)
	return

func set_follower(_follower):
	following_object = _follower
	following = true
	
func unset_follower():
	following = false
