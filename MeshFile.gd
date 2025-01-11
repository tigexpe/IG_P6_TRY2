extends Node3D
const Default_Lector : String = "res://LeerPly.gd";
var LectorPly = preload(Default_Lector).new()
#var vertices
#var indices

var vertices : PackedVector3Array
var indices : PackedInt32Array
var normals : PackedVector3Array

func _ready():
	pass

func LoadMesh(file : String,modo : String,scale : Vector3):
	#var vertices
	#var indices
	var pair = LectorPly.LeerPly(file)
	var triangulos
	if pair:
		vertices = pair[0]
		#indices = pair[1]
		triangulos = pair[1]
		print("ÉXITO:")
		
		return MeshFromVertex(vertices,triangulos,modo,scale);
	return null;

func _process(d:float):
	pass


func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func RandomAssignMaterial(mesh):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color_Aleatorio()
	mesh.material_override = material



func MeshFromVertex(vertices,triangulos,modo:String,scale:Vector3):
	#print("MESH FORM FVERTEX")
	#var mult : float = 3
	#mult = 1
	var V = PackedVector3Array()
	#for v in vertices:
	for i in range(vertices.size()):
		#V.push_back(v * mult)
		var v = vertices[i];
		var w = Vector3(v.x * scale.x , v.y * scale.y , v.z * scale.z);
		vertices[i] = w;
		V.push_back(vertices[i]);
	
	
	var indices = []
	for t in triangulos:
		indices.append_array(t)
	var I = PackedInt32Array(indices)
	
	
	#var modo : String = "NOP"
	#modo = "Flat"
	var N = Calculate_Normals(vertices,indices,modo)
	
	
	
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = V
	arrays[Mesh.ARRAY_INDEX] = I
	if N:
		#print("NORMALES ESTÁN CON EL MODO ",modo)
		arrays[Mesh.ARRAY_NORMAL] = N
		normals = N
	
	
	
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,arrays)
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	
	return m;
	
	


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
		
		#normals.append(normal)
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



#func More_Or_Less_Collider(vertices : PackedVector3Array) -> Vector3:
func More_Or_Less_Collider(vertices : PackedVector3Array):
	var sum : Vector3 = Vector3.ZERO;
	var num : int = vertices.size()
	var vmin = Vector3.ZERO;
	var vmax = Vector3.ZERO;
	if num > 0:
		for i in range(num):
			var v = vertices[i];
			sum += v;
			if v.x < vmin.x : vmin.x = v.x;
			if v.y < vmin.y : vmin.y = v.y;
			if v.z < vmin.z : vmin.z = v.z;
			if v.x > vmax.x : vmax.x = v.x;
			if v.y > vmax.y : vmax.y = v.y;
			if v.z > vmax.z : vmax.z = v.z;
		sum /= num
	#return sum;
	return [ vmax - vmin , sum ];
