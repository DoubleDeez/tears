extends Node2D

export(Vector2) var BodySpeed = Vector2(0,-200)
export(int) var TearOffBodyAcceleration = 5

var Speed
var OffBody

func _ready():
	set_process(true)
	Speed = BodySpeed
	OffBody = false
	
func _process(delta):
	if (OffBody):
		Speed -= Vector2(0, TearOffBodyAcceleration*delta)
	set_pos(get_pos() + Speed * delta)
	
	
func SetOffBody(IsOffBody):
	OffBody = IsOffBody
	if (!OffBody):
		Speed = BodySpeed
		
func Stop():
	Speed = Vector2(0 ,0)