extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

var screen_size
var camera_rect
var BodySpeed

const fade_speed = 0.3

var travel_speed
var direction # +1 for left, -1 for right

func _ready():
	screen_size = Utils.get_viewport_size(self)
	camera_rect = Utils.get_camera_rect_dict(self)
	var body = get_tree().get_root().get_node("GameRoot").get_node("Body")
	BodySpeed = body.get("BodySpeed")
	set_process(true)

func die():
	self.hide()
	set_process(false)
	self.queue_free()

func _process(delta):
	# Adjust alpha to fade wave over time
	var color = self.get_modulate()
	color.a -= fade_speed*delta
	# If completely faded, die
	if color.a <= 0.0:
		print("I have now disappeared; dying...")
		self.die()
		return
	self.set_modulate(color)

	var self_x = self.get_global_pos().x
	# When wave exits, screen, cue deletion
	if(self_x > camera_rect["left"] || self_x < camera_rect["right"]):
		print("Wave crossed border, deleting")
		self.die()
		return

	# Move with the body
	self.set_global_pos(self.get_global_pos() + BodySpeed * delta)

	# Move across the screen
	self.set_global_pos(self.get_global_pos() + Vector2(travel_speed * direction * delta, 0))
