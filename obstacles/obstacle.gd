extends Node

var CooldownTime = 3.0

var TimeSinceHit

func _ready():
	get_node("Area2D").connect("area_enter", self, "OnEnterArea")
	set_process(true)
	TimeSinceHit = CooldownTime

func OnEnterArea(area):
	if (area.get_parent().get_name().find("Tear") > -1 && TimeSinceHit >= CooldownTime):
		area.get_parent().OnHitObstacle()
		TimeSinceHit = 0
		
func _process(delta):
	TimeSinceHit += delta
	if (TimeSinceHit < CooldownTime):
		set_opacity(abs(sin(OS.get_unix_time())) / 2.0 + 0.2)
	else:
		set_opacity(1.0)