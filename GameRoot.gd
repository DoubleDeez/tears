extends Node2D

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

const numPlayers = 1

export(NodePath) var BodyPath = "Body"

var screen_size = Vector2(0,0)
var player_emitters = []
var body


func _ready():
	screen_size = get_viewport_rect().size
	get_tree().connect("screen_resized", self, "handle_screen_resize")
	body = get_node(BodyPath)

	load_emitter_players()


func handle_screen_resize():
	screen_size = get_viewport_rect().size
	for emitters in player_emitters:
		var right = emitters[0]
		var left = emitters[1]
		right.set_pos(Vector2(screen_size.x*(0.9), screen_size.y/2))
		left.set_pos(Vector2(screen_size.x*(0.1), screen_size.y/2))


func load_emitter_players():
	# Load initial players
	var waveEm = load(Constants.SCENE_WAVEEMITTER)
	var RT_texture = load(Constants.TEXTURE_RIGHTEMITTER)
	var LT_texture = load(Constants.TEXTURE_LEFTEMITTER)
	for i in range(numPlayers):
		var waveEmNode_Right = waveEm.instance()
		add_child(waveEmNode_Right)
		waveEmNode_Right.set_pos(Vector2(screen_size.x*(0.9), screen_size.y/2))
		waveEmNode_Right.set_texture(RT_texture)
		waveEmNode_Right.set("side", "R")

		var waveEmNode_Left = waveEm.instance()
		add_child(waveEmNode_Left)
		waveEmNode_Left.set_pos(Vector2(screen_size.x*(0.1), screen_size.y/2))
		waveEmNode_Left.set_texture(LT_texture)
		waveEmNode_Left.set("side", "L")

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
