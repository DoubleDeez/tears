extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const numPlayers = 1

func _ready():
	# Generate distance marks
	for i in range(100):
		var Distance = i * 500;
		var DistanceLabel = Label.new()
		DistanceLabel.set_text(String(Distance))
		add_child(DistanceLabel)
		DistanceLabel.set_pos(Vector2(600, Distance))

	var waveEm = load("res://WaveEmitter.tscn")
	for i in range(numPlayers):
		var waveEmNode = waveEm.instance()
		add_child(waveEmNode)
