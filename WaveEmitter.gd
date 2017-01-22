extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

var wave_scene = load(Constants.SCENE_WAVE)

# Set this when creating new instance in GameRoot; MUST be one of "L" or "R"
var side
var root

func _ready():
	root = get_tree().get_root().get_node("GameRoot")
	set_process_input(true)

func _input(event):
	var up_event
	var down_event
	var wave_create_event
	if side == "L":
		up_event = "p1_left_emitter_up"
		down_event =  "p1_left_emitter_down"
		wave_create_event = "p1_lt"
	elif side == "R":
		up_event = "p1_right_emitter_up"
		down_event =  "p1_right_emitter_down"
		wave_create_event = "p1_rt"

	if(event.is_action_pressed(up_event)):
		self.set_pos(self.get_pos() - Vector2(0,10))
	elif(event.is_action_pressed(down_event)):
		self.set_pos(self.get_pos() + Vector2(0,10))
	elif(event.is_action_pressed(wave_create_event)):
		create_wave()

func create_wave():
	var instance = wave_scene.instance()
	instance.set("travel_speed", 10.0)
	instance.set("direction", 1 if side == "L" else -1)
	#root.add_child(instance)
	add_child(instance)
