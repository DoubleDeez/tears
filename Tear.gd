extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(Vector2) var TearSpeed = Vector2(0,0)
export(int) var WaveStrength = 5

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	set_pos(get_pos() + TearSpeed * delta)
	
func _input(event):
	if(event.is_action_pressed("wave_tear_right")):
		set_pos(get_pos() + Vector2(WaveStrength, 0))
	elif(event.is_action_pressed("wave_tear_left")):
		set_pos(get_pos() - Vector2(WaveStrength, 0))