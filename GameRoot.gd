extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Generate distance marks
	for i in range(50):
		var Distance = i * 1000;
		var DistanceLabel = Label.new()
		DistanceLabel.set_text(String(Distance))
		add_child(DistanceLabel)
		DistanceLabel.set_pos(Vector2(600, Distance))
