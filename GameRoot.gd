extends Node2D

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

const numPlayers = 1

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

	# Generate distance marks
	for i in range(100):
		var Distance = i * 500;
		var DistanceLabel = Label.new()
		DistanceLabel.set_text(String(Distance))
		add_child(DistanceLabel)
		DistanceLabel.set_pos(Vector2(600, Distance))

	# Load initial players
	var waveEm = load(Constants.SCENE_WAVE)
	for i in range(numPlayers):
		var waveEmNode = waveEm.instance()
		add_child(waveEmNode)
		waveEmNode.set_pos(screen_size.y/2)
