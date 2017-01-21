extends Node2D

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

const numPlayers = 1

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

	# Load initial players
	var waveEm = load(Constants.SCENE_WAVE)
	for i in range(numPlayers):
		var waveEmNode = waveEm.instance()
		add_child(waveEmNode)
		waveEmNode.set_pos(screen_size.y/2)

func OnEnterBody(area):
	#print(area.get_parent().get_name())
	if (area.get_parent().get_name() == "Tear"):
		print("Tear entered body")

func OnExitBody(area):
	#print(area.get_parent().get_name())
	if (area.get_parent().get_name() == "Tear"):
		print("Tear exited body")
