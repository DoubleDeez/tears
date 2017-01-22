extends Node2D

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

export(NodePath) var BodyPath = "Body"

var screen_size = Vector2(0,0)
var player_emitters = []
var body


func _ready():
	screen_size = Utils.get_viewport_size(self)
	get_tree().connect("screen_resized", self, "handle_screen_resize")
	body = get_node(BodyPath)

	load_emitter_players()
	handle_screen_resize()

func handle_screen_resize():
	screen_size = Utils.get_viewport_size(self)
	print("Screen size is %d x %d" % [screen_size.x, screen_size.y])
	for emitters in player_emitters:
		var right = emitters[0]
		var left = emitters[1]
		Utils.place_on_screen(right, 0.95, 0.5)
		Utils.place_on_screen(left, 0.05, 0.5)

func load_emitter_players():
	# Load initial players
	var waveEm = load(Constants.SCENE_WAVEEMITTER)
	var RT_texture = load(Constants.TEXTURE_RIGHTEMITTER)
	var LT_texture = load(Constants.TEXTURE_LEFTEMITTER)
	var joysticks = Input.get_connected_joysticks()
	for i in range(joysticks.size()):
		var joystickID = joysticks[i]
		var playerID = i+1

		if not (playerID in [1,4]):
			continue

		var waveEmNode_Right = waveEm.instance()
		add_child(waveEmNode_Right)
		waveEmNode_Right.set_texture(RT_texture)
		waveEmNode_Right.set("side", "R")
		waveEmNode_Right.set("playerID", playerID)
		waveEmNode_Right.set("joystickID", joystickID)

		var waveEmNode_Left = waveEm.instance()
		add_child(waveEmNode_Left)
		waveEmNode_Left.set_texture(LT_texture)
		waveEmNode_Left.set("side", "L")
		waveEmNode_Left.set("playerID", playerID)
		waveEmNode_Left.set("joystickID", joystickID)

		var emitters = []
		emitters.append(waveEmNode_Right)
		emitters.append(waveEmNode_Left)
		player_emitters.append(emitters)
		
func PlaceObstacle(obstacle):
	body.add_child(obstacle)

func OnEnterBody(area):
	if (area.get_parent().get_name() == "Tear"):
		body.SetOffBody(false)


func OnExitBody(area):
	if (area.get_parent().get_name() == "Tear"):
		body.SetOffBody(true)


func OnEnterFoot(area):
	if (area.get_parent().get_name() == "Tear"):
		body.Stop()

func OnEnterFloor(area):
	if (area.get_parent().get_name() == "Tear"):
		get_tree().quit()
