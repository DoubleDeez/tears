static func load_tscn(path):
	# path: "res://WaveEmitter.tscn"
	var tscn = load(path)
	var instance = tscn.instance()
	add_child(instance)
