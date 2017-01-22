extends Node

func _ready():
	get_node("Area2D").connect("area_enter", self, "OnEnterArea")

func OnEnterArea(area):
	if (area.get_parent().get_name().find("Tear") > -1):
		area.get_parent().OnHitObstacle()
		get_node("Area2D").queue_free()