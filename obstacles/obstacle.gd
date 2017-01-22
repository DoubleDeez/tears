extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("Area2D").connect("area_enter", self, "OnEnterArea")

func OnEnterArea(area):
	if (area.get_parent().get_name() == "Tear"):
		area.get_parent().HitObstacle()
		self.hide()
		self.queue_free()