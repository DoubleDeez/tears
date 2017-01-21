extends Node2D

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

const numPlayers = 1

var screen_size = Vector2(0,0)
var player_emitters = []

func _ready():
	screen_size = get_viewport_rect().size
	get_tree().connect("screen_resized", self, "handle_screen_resize")

	# Load initial players
	var waveEm = load(Constants.SCENE_WAVEEMITTER)
	for i in range(numPlayers):
		var waveEmNode_Right = waveEm.instance()
		add_child(waveEmNode_Right)
		waveEmNode_Right.set_pos(Vector2(screen_size.x*(0.9), screen_size.y/2))

		var waveEmNode_Left = waveEm.instance()
		add_child(waveEmNode_Left)
		waveEmNode_Left.set_pos(Vector2(screen_size.x*(0.1), screen_size.y/2))

		var emitters = []
		emitters.append(waveEmNode_Right)
		emitters.append(waveEmNode_Left)
		player_emitters.append(emitters)

func handle_screen_resize():
	screen_size = get_viewport_rect().size
	print("Handling screen resize...")
	for emitters in player_emitters:
		var right = emitters[0]
		var left = emitters[1]
		right.set_pos(Vector2(screen_size.x*(0.9), screen_size.y/2))
		left.set_pos(Vector2(screen_size.x*(0.1), screen_size.y/2))

func OnEnterBody(area):
	#print(area.get_parent().get_name())
	if (area.get_parent().get_name() == "Tear"):
		print("Tear entered body")

func OnExitBody(area):
	#print(area.get_parent().get_name())
	if (area.get_parent().get_name() == "Tear"):
		print("Tear exited body")

func OnEnterFoot(area):
	#print(area.get_parent().get_name())
	if (area.get_parent().get_name() == "Tear"):
		print("Tear entered Foot")
		
func OnEnterFloor(area):
	#print(area.get_parent().get_name())
	if (area.get_parent().get_name() == "Tear"):
		print("Tear entered Floor")
