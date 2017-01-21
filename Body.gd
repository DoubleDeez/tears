extends Sprite

export(Vector2) var RGB_RANGE = Vector2(50, 200)
export(int) var RGB_MIN_DISTANCE = 20

func _ready():
	SetBodyColor()
	
	
func SetBodyColor():
	var R = GetRandomRGBValue()
	var G = GetRandomRGBValue()
	var B = GetRandomRGBValue()
	while (abs(R-G) < RGB_MIN_DISTANCE):
		G = GetRandomRGBValue()
	while (abs(R-B) < RGB_MIN_DISTANCE || abs(G-B) < RGB_MIN_DISTANCE):
		B = GetRandomRGBValue()
	set_modulate(Color(R/255, G/255, B/255))
	
func GetRandomRGBValue():
	randomize()
	return randi()%int(RGB_RANGE.y+1)+RGB_RANGE.x
