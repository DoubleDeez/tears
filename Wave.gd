extends Sprite

var screen_size

var intensity
var travel_speed
var direction # +1 for left, -1 for right

func _ready():
	set_process(true)

func _process(delta):
	screen_size = OS.get_window_size()
	var self_x = self.get_global_pos().x
	# When wave exits, screen, cue deletion
	if(self_x > screen_size.x || self_x < 0):
		print("Wave crossed border, deleting")
		self.hide()
		self.queue_free()
		set_process(false)

	self.set_global_pos(self.get_global_pos() + Vector2(travel_speed * direction, 0))
