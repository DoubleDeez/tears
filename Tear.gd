extends Sprite

export(NodePath) var Collider = "Area2D/CollisionPolygon2D"
export(Vector2) var TearScale = Vector2(0.5, 0.5)
export(float) var ScaleMultiplier = 1.25
export(Vector2) var MinScale = Vector2(0.25, 0.25)
export(bool) var IsMainTear = false

const wave_strength = 2000.0

var TearTrailScene = preload("res://TearTrail.tscn")
var AreaCollider
var BonusTearSpeed = Vector2(0, 15)

func _ready():
	AreaCollider = get_node(Collider)
	set_scale(TearScale)
	set_process(true)
	if IsMainTear:
		get_node("Merge/MergeArea").connect("area_enter", self, "OnHitTear")
	else:
		BonusTearSpeed *= rand_range(0.5, 2.0)
		BonusTearSpeed.x = rand_range(-10.0, 10.0)
		set_fixed_process(true)
		
func _process(delta):
	var TrailDrop = TearTrailScene.instance()
	if !IsMainTear:
		TrailDrop.set_modulate(Color(255, 127, 0))
	get_parent().get_node("Body").add_child(TrailDrop)
	TrailDrop.set_global_pos(get_global_pos())
	TrailDrop.set_scale(get_scale() / 5.0)

func _fixed_process(delta):
	set_pos(get_pos() + BonusTearSpeed)
	
func OnHitObstacle():
	set_scale(get_scale() / ScaleMultiplier)
	if (get_scale() < MinScale):
		if (IsMainTear):
			get_tree().quit()
		else:
			queue_free()

func OnHitGrease():
	get_parent().get_node("Body").OnHitGrease()

func OnHitWave(wave_force, direction):
	self.set_pos(self.get_pos() + Vector2(wave_force * wave_strength * direction, 0))

func OnHitTear(area):
	if (area.get_parent().get_name().find("Merge") > -1):
		set_scale(get_scale() + area.get_parent().get_scale())
		area.get_parent().get_parent().queue_free()