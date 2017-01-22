static func get_root(node):
	var root = node.get_tree().get_root().get_node("GameRoot")
	return root

static func get_camera(node, root=null):
	if root == null:
		root = get_root(node)
	var camera = root.get_node("Camera2D")
	return camera

static func get_viewport_size(node, root=null):
	if root == null:
		root = get_root(node)
	var camera = root.get_node("Camera2D")
	var camera_zoom = camera.get_zoom()
	var screen_res = root.get_viewport_rect().size
	return Vector2(screen_res.x*camera_zoom.x, screen_res.y*camera_zoom.y)

static func place_on_screen(node, x_pct, y_pct, viewport_size=null):
	if viewport_size == null:
		viewport_size = get_viewport_size(node)
	var camera = get_camera(node)
	var center = camera.get_camera_screen_center()
	x_pct -= 0.5
	y_pct -= 0.5
	var pos = Vector2(viewport_size.x*(x_pct), viewport_size.y*(y_pct))  + center
	node.set_pos(pos)

static func get_camera_rect_dict(node):
	var camera = get_camera(node)
	var center = camera.get_camera_screen_center()
	var viewport_size = get_viewport_size(node)
	return {
		"top": center.y + viewport_size.y/2,
		"bottom": center.y - viewport_size.y/2,
		"left": center.x + viewport_size.x/2,
		"right": center.x - viewport_size.x/2
	}
