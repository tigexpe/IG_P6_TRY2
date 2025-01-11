extends Node3D
var distance_tp : float = 1.5
var player
var body

func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func RandomAssignMaterial(mesh):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color_Aleatorio()
	mesh.material_override = material

func Instanciate(pos : Vector3 , rad : float):
	var raiz = get_tree().root
	var root = raiz.get_child(0)
	player = root.get_node("CharaCamera1")
	body = player.get_node("Body")
	position = pos
	var mesh = MeshInstance3D.new()
	mesh.mesh = SphereMesh.new()
	mesh.mesh.radius = rad
	mesh.mesh.height = rad
	RandomAssignMaterial(mesh)
	add_child(mesh)
	distance_tp = 2 * rad

func _ready():
	Instanciate(Vector3(0,200,0),4)
	pass

func Distance():
	if (body.global_transform.origin - self.global_transform.origin).length() <= distance_tp:
		var newt = player.global_transform
		var gt = Vector3(-100,-100,-100)
		gt = Vector3(-1000,-1000,-1000)
		newt.origin = gt
		player.global_position = gt
		body.global_position = player.global_position

func _process(d : float):
	Distance()
	
