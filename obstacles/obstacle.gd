extends Node

func _ready():
	get_node("Area2D").connect("area_enter", self, "OnEnterArea")

func OnEnterArea(area):
	if (area.get_parent().get_name() == "Tear"):
		area.get_parent().OnHitObstacle()
		self.hide()
		self.queue_free()