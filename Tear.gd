extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(NodePath) var Collider = "Area2D/CollisionPolygon2D"
export(int) var WaveStrength = 5

var AreaCollider

func _ready():
	AreaCollider = get_node(Collider)
	set_process_input(true)

func _input(event):
	if(event.is_action_pressed("wave_tear_right")):
		set_pos(get_pos() + Vector2(WaveStrength, 0))
	elif(event.is_action_pressed("wave_tear_left")):
		set_pos(get_pos() - Vector2(WaveStrength, 0))