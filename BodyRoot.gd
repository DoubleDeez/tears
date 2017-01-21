extends Node2D

export(Vector2) var BodySpeed = Vector2(0,-200)

func _ready():
	set_process(true)
	
func _process(delta):
	set_pos(get_pos() + BodySpeed * delta)
	