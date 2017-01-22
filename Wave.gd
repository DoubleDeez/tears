extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

var screen_size
var camera_rect

var intensity
var travel_speed
var direction # +1 for left, -1 for right
var BodySpeed

func _ready():
	screen_size = Utils.get_viewport_size(self)
	camera_rect = Utils.get_camera_rect_dict(self)
	var body = get_tree().get_root().get_node("GameRoot").get_node("Body")
	BodySpeed = body.get("BodySpeed")
	set_process(true)

func _process(delta):
	var self_x = self.get_global_pos().x
	# When wave exits, screen, cue deletion
	if(self_x > camera_rect["left"] || self_x < camera_rect["right"]):
		print("Wave crossed border, deleting")
		self.hide()
		self.queue_free()
		set_process(false)

	# Move with the body
	self.set_global_pos(self.get_global_pos() + BodySpeed * delta)

	# Move across the screen
	self.set_global_pos(self.get_global_pos() + Vector2(travel_speed * direction, 0))
