extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

var wave_scene = load(Constants.SCENE_WAVE)
const movement_speed = 30

# Set this when creating new instance in GameRoot; MUST be one of "L" or "R"
var side

var root

func _ready():
	root = get_tree().get_root().get_node("GameRoot")
	set_process_input(true)
	set_process(true)

func _input(event):
	var wave_create_event
	if side == "L":
		wave_create_event = "p1_lt"
	elif side == "R":
		wave_create_event = "p1_rt"

	if(event.is_action_pressed(wave_create_event)):
		create_wave()

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
		self.set_pos(self.get_pos() - Vector2(0,movement_speed))
	elif(Input.is_action_pressed(down_event)):
		self.set_pos(self.get_pos() + Vector2(0,movement_speed))
	if abs(Input.get_joy_axis(0, js_axis)) > 0.1:
		set_pos(get_pos() + Vector2(0, movement_speed*Input.get_joy_axis(0, js_axis)))

func create_wave():
	var instance = wave_scene.instance()
	instance.set("travel_speed", 10.0)
	instance.set("direction", 1 if side == "L" else -1)
	instance.set_global_pos(self.get_global_pos())
	root.add_child(instance)
