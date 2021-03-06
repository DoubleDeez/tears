extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

var screen_size
var camera_rect
var body

const fade_speed = 0.25

var travel_speed
var direction # +1 for left, -1 for right

func _ready():
	screen_size = Utils.get_viewport_size(self)
	camera_rect = Utils.get_camera_rect_dict(self)

	body = get_tree().get_root().get_node("GameRoot").get_node("Body")

	set_process(true)

	get_node("Area2D").connect("area_enter", self, "OnEnterArea")

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
		self.die()
		return
	self.set_modulate(color)

	var self_x = self.get_global_pos().x
	# When wave exits, screen, cue deletion
	if(self_x > camera_rect["left"] || self_x < camera_rect["right"]):
		self.die()
		return

	# Move with the body
	self.set_global_pos(self.get_global_pos() + body.get("BodySpeed") * delta)

	# Move across the screen
	self.set_global_pos(self.get_global_pos() + Vector2(travel_speed * direction * delta, 0))

func get_force():
	####
	# Returns "force" that wave should impart normalized between 0 and 1
	####
	var color = self.get_modulate()
	return color.a

func OnEnterArea(area):
	if (area.get_parent().get_name().find("Tear") > -1):
		area.get_parent().OnHitWave(self.get_force(), self.direction)
		self.direction *= -1
		self.rotate(3.14)
