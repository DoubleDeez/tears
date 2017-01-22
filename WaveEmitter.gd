extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

var wave_scene = load(Constants.SCENE_WAVE)
const movement_speed = 3000*2
const wave_movement_speed = 2000*4

# Set this when creating new instance in GameRoot; MUST be one of "L" or "R"
var side
var playerID
var joystickID
var textures
var texture_open
var texture_closed

var root

func _ready():
	root = get_tree().get_root().get_node("GameRoot")

	texture_open = load(textures["open"])
	texture_closed = load(textures["closed"])
	self.set_texture(texture_open)

	set_process_input(true)
	set_process(true)

func _input(event):
	var wave_create_event
	if side == "L":
		wave_create_event = "p%d_lt" % playerID
	elif side == "R":
		wave_create_event = "p%d_rt" % playerID

	if(event.is_action_pressed(wave_create_event)):
		self.set_texture(texture_closed)
		create_wave()
	elif(event.is_action_released(wave_create_event)):
		self.set_texture(texture_open)

func _process(delta):
	var up_event
	var down_event
	var js_axis
	if side == "L":
		up_event = "p1_left_emitter_up"
		down_event =  "p1_left_emitter_down"
		js_axis = 1
	elif side == "R":
		up_event = "p1_right_emitter_up"
		down_event =  "p1_right_emitter_down"
		js_axis = 3

	if(Input.is_action_pressed(up_event)):
		self.set_pos(self.get_pos() - Vector2(0,movement_speed*delta))
	elif(Input.is_action_pressed(down_event)):
		self.set_pos(self.get_pos() + Vector2(0,movement_speed*delta))
	if abs(Input.get_joy_axis(joystickID, js_axis)) > 0.1:
		set_pos(get_pos() + Vector2(0, delta*movement_speed*Input.get_joy_axis(joystickID, js_axis)))

func create_wave():
	var instance = wave_scene.instance()
	instance.set("travel_speed", wave_movement_speed)
	instance.set("direction", 1 if side == "L" else -1)
	instance.set_global_pos(self.get_global_pos())
	# Rotate wave to face the "right" way
	if side == "R":
		instance.set_rot(3.14)
	root.add_child(instance)
	root.wavesTriggered += 1
