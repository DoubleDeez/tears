extends Sprite

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")


func _ready():
	set_process(true)
	# set_process_input(true)

func _process(delta):
	pass

func _input(event):
	pass

func create_wave():
	var path = Constants.SCENE_WAVEEMITTER
	var tscn = load(path)
	var instance = tscn.instance()
	add_child(instance)
