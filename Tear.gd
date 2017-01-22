extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(NodePath) var Collider = "Area2D/CollisionPolygon2D"
export(int) var WaveStrength = 200.0
export(Vector2) var TearScale = Vector2(0.5, 0.5)
export(float) var ScaleMultiplier = 1.25
export(Vector2) var MinScale = Vector2(0.25, 0.25)


var AreaCollider

func _ready():
	AreaCollider = get_node(Collider)
	set_scale(TearScale)
	
func OnHitObstacle():
	set_scale(get_scale() / ScaleMultiplier)
	if (get_scale() < MinScale):
		get_tree().quit()

func OnHitGrease():
	get_parent().get_node("Body").OnHitGrease()

func OnHitWave(wave_force, direction):
	self.set_pos(self.get_pos() + Vector2(wave_force * WaveStrength * direction, 0))
