extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

# Set this when creating new instance in GameRoot; MUST be one of "L" or "R"
var side

func _ready():
	set_process_input(true)

func _input(event):
	var up_event
	var down_event
	if side == "L":
		up_event = "p1_left_emitter_up"
		down_event =  "p1_left_emitter_down"
	elif side == "R":
		up_event = "p1_right_emitter_up"
		down_event =  "p1_right_emitter_down"

	if(event.is_action_pressed(up_event)):
		self.set_pos(self.get_pos() - Vector2(0,10))
	elif(event.is_action_pressed(down_event)):
		self.set_pos(self.get_pos() + Vector2(0,10))

func create_wave():
	var path = Constants.SCENE_WAVE
	var tscn = load(path)
	var instance = tscn.instance()
	add_child(instance)
