extends Node

var HasHit = false

func _ready():
	get_node("Area2D").connect("area_enter", self, "OnEnterArea")

func OnEnterArea(area):
	if (area.get_parent().get_name() == "Tear" && !HasHit):
		area.get_parent().OnHitGrease()
		HasHit = true
