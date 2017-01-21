extends Area2D


func _ready():
	connect("area_enter",get_parent().get_parent(),"OnEnterFloor")
