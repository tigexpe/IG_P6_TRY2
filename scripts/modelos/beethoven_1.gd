extends Node3D

var LectorPly = preload("res://LeerPly.gd").new()
var vertices
var indices

var PackedVertices : PackedVector3Array
var PackedIndices : PackedVector3Array

func End_First_Light():
	queue_free();


var first_interruptor
func _ready():
	var file1 : String = "res://modelos_p2/beethoven.ply"
	var file2 : String = "res://modelos_p2/armadillo.ply"
	
	var pair = LectorPly.LeerPly(file1)
	if pair:
		vertices = pair[0]
		indices = pair[1]
		
		MeshFromVertex(vertices,indices)
	first_interruptor = get_parent().get_node("Cripta_Sala_2/NeoPared2");
	first_interruptor.hitted.connect(End_First_Light)



func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func RandomAssignMaterial(mesh):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color_Aleatorio()
	mesh.material_override = material


func MeshFromVertex(vertices,triangulos):
	var mult : float = 3
	var V = PackedVector3Array()
	for v in vertices:
		V.push_back(v * mult)
	
	
	var indices = []
	for t in triangulos:
		indices.append_array(t)
	var I = PackedInt32Array(indices)
	
	
	var modo : String = "NOP"
	modo = "Flat"
	modo = "Smooth"
	var N = Calculate_Normals(vertices,indices,modo)
	
	
	
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = V
	arrays[Mesh.ARRAY_INDEX] = I
	if N:
		arrays[Mesh.ARRAY_NORMAL] = N
	
	
	
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,arrays)
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	
	
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(1,0,0)
	material.albedo_color = Color(0,0,1)
	material.albedo_color = Color("0000ff")
	m.material_override = material
	
	
	
	
	add_child(m)


func Calculate_Normals(vertices : PackedVector3Array , indices : PackedInt32Array , modo : String):
	if modo != "Flat" and modo != "Smooth":return null
	var normals = PackedVector3Array()
	normals.resize(vertices.size())
	for i in range(0,indices.size(),3):
		var i1 = indices[i]
		var i2 = indices[i+1]
		var i3 = indices[i+2]
		var v1 = vertices[i1]
		var v2 = vertices[i2]
		var v3 = vertices[i3]
		
		var vec1 = v2 - v1
		var vec2 = v3 - v1
		var normal = vec1.cross(vec2).normalized()
		
		if modo == "Flat":
			normals[i1] = normal
			normals[i2] = normal
			normals[i3] = normal
		elif modo == "Smooth":
			normals[i1] += normal
			normals[i2] += normal
			normals[i3] += normal
		
	for i in range(normals.size()):
		normals[i] = normals[i].normalized()
	
	return normals
