extends Node3D

func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func _ready():
	var node = $CharaCamera1
	node.position = Vector3(0,8,0)
	var body = $CharaCamera1/Body
	var collider = $CharaCamera1/Body/Collider
	var mesh = $CharaCamera1/Body/Mesh
	body.add_collider(Color_Aleatorio())
