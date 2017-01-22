extends Node2D

var BlackHead = preload("res://obstacles/BlackHead.tscn")
var Mole = preload("res://obstacles/Mole.tscn")
var Grease = preload("res://obstacles/Grease.tscn")
var Pimple = preload("res://obstacles/Pimple.tscn")

export(int) var Speed = 100
export(float) var Cooldown = 2

var ObstacleArray = []
var area
var cooldownTimer = 0.0

func _ready():
	area = get_node("Area2D")
	ObstacleArray.append(BlackHead)
	ObstacleArray.append(Mole)
	ObstacleArray.append(Grease)
	ObstacleArray.append(Pimple)
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if event.is_action_pressed("p2_place_obstacle") && cooldownTimer <= 0.0:
		if(area.overlaps_area(get_parent().body.get_node("Area2D"))):
			var obstacle = ObstacleArray[randi()%ObstacleArray.size()].instance()
			get_parent().PlaceObstacle(obstacle)
			obstacle.set_global_pos(get_global_pos())
			cooldownTimer = Cooldown

func _process(delta):
	if abs(Input.get_joy_axis(1, 0)) > 0.1:
		set_pos(get_pos() + Vector2(Speed*Input.get_joy_axis(1, 0), 0))
	cooldownTimer -= delta;