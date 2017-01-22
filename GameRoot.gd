extends Node2D

const Constants = preload("Constants.gd")
const Utils = preload("Utils.gd")

export(NodePath) var BodyPath = "Body"
export(int) var TearFrequency = 5

var TearScene = preload("res://Tear.tscn")
var screen_size = Vector2(0,0)
var player_emitters = []
var body
var obstacleCounter = 0
var bodyStartPos
var wavesTriggered = 0
const tearVolumeScale_mL = 10.0
const tearVolumeVel_cmps = 0.05
var timeOnBody = 0.0

func _ready():
	screen_size = Utils.get_viewport_size(self)
	get_tree().connect("screen_resized", self, "handle_screen_resize")
	body = get_node(BodyPath)
	bodyStartPos = body.get_pos()
	load_emitter_players()
	load_obstacle_placers()
	handle_screen_resize()

	set_process(true)

func _process(delta):
	var gridContainer = self.get_node("Camera2D").get_node("GridContainer")
	gridContainer.get_node("ObstaclesPlaced").set_text("%d" % obstacleCounter)
	gridContainer.get_node("WavesTriggered").set_text("%d" % wavesTriggered)
	var tearVolume = get_node("Tear").get_scale().x * tearVolumeScale_mL
	gridContainer.get_node("TearVolume").set_text("%.2f mL" % tearVolume)
	var tearSpeed = get_node("Body").Speed.y * tearVolumeVel_cmps * -1
	gridContainer.get_node("TearVelocity").set_text("%.2f cm/s" % tearSpeed)

func handle_screen_resize():
	screen_size = Utils.get_viewport_size(self)
	print("Screen size is %d x %d" % [screen_size.x, screen_size.y])
	for emitters in player_emitters:
		var right = emitters[0]
		var left = emitters[1]
		Utils.place_on_screen(right, 0.95, 0.5)
		Utils.place_on_screen(left, 0.05, 0.5)

func load_obstacle_placers():
	var obsPlacer = load(Constants.SCENE_OBSTACLEPLACER)
	var joysticks = Input.get_connected_joysticks()
	for i in range(joysticks.size()):
		var joystickID = joysticks[i]
		var playerID = i+1

		if not (playerID in [2,3] or playerID >= 5):
			continue

		var obsPlacerInst = obsPlacer.instance()
		obsPlacerInst.set("playerID", playerID)
		obsPlacerInst.set("joystickID", joystickID)

		var textureID = playerID if playerID < 5 else 5
		obsPlacerInst.set("textures", Constants.BULLY_TEXTURES[textureID])

		add_child(obsPlacerInst)
		Utils.place_on_screen(obsPlacerInst, 0.5, 0.9)

func load_emitter_players():
	# Load initial players
	var waveEm = load(Constants.SCENE_WAVEEMITTER)
	var joysticks = Input.get_connected_joysticks()
	for i in range(joysticks.size()):
		var joystickID = joysticks[i]
		var playerID = i+1

		if not (playerID in [1,4]):
			continue

		var waveEmNode_Right = waveEm.instance()
		var RT_textures = Constants.EMITTER_TEXTURES[playerID]["R"]
		waveEmNode_Right.set("textures", RT_textures)
		waveEmNode_Right.set("side", "R")
		waveEmNode_Right.set("playerID", playerID)
		waveEmNode_Right.set("joystickID", joystickID)
		add_child(waveEmNode_Right)

		var waveEmNode_Left = waveEm.instance()
		var LT_textures = Constants.EMITTER_TEXTURES[playerID]["L"]
		waveEmNode_Left.set("textures", LT_textures)
		waveEmNode_Left.set("side", "L")
		waveEmNode_Left.set("playerID", playerID)
		waveEmNode_Left.set("joystickID", joystickID)
		add_child(waveEmNode_Left)

		var emitters = []
		emitters.append(waveEmNode_Right)
		emitters.append(waveEmNode_Left)
		player_emitters.append(emitters)
		
func PlaceObstacle(obstacle):
	obstacleCounter += 1
	CheckSpawnTear()
	body.add_child(obstacle)

func OnEnterBody(area):
	if (area.get_parent().get_name() == "Tear"):
		body.SetOffBody(false)


func OnExitBody(area):
	if (area.get_parent().get_name() == "Tear"):
		body.SetOffBody(true)


func OnEnterFoot(area):
	if (area.get_parent().get_name() == "Tear"):
		#body.Stop()
		pass

func OnEnterFloor(area):
	if (area.get_parent().get_name() == "Tear"):
		#get_tree().quit()
		body.set_pos(bodyStartPos)

func CheckSpawnTear():
	if (obstacleCounter % TearFrequency != 0):
		return
	var tear = TearScene.instance()
	add_child(tear)
	tear.set_name("BonusTear")
	Utils.place_on_screen(tear, rand_range(0.2, 0.8), -0.2)