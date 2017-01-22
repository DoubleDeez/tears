extends Sprite

var TimeToLive = 1.5

var TimeLeft

func _ready():
	TimeLeft = TimeToLive
	set_process(true)
	
func _process(delta):
	TimeLeft -= delta
	var Opacity = TimeLeft / TimeToLive
	if (Opacity <= 0.0):
		queue_free()
	else:
		set_opacity(Opacity)
	
