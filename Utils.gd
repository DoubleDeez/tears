static func get_viewport_size(node):
	var root = node.get_tree().get_root().get_node("GameRoot")
	var screen_size = root.get_viewport_rect().size * 7
	return screen_size
