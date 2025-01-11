extends Node3D

const coordinates_file : String = "res://scripts/cripta_sala_2/coordenadas.gd"
var MYT = preload(coordinates_file).new()

var dic_nuvs : Dictionary = {}
var dic_nuvo : Dictionary = {}
func DCM2(first : Variant , second : String , third : Vector3 , fourth : Vector3):
	DCM(first,second)
	dic_nuvs[first] = third
	dic_nuvo[first] = fourth


var dic_mat : Dictionary = {}
func DCM(first : Variant , second : String):dic_mat[first] = second
func GCM(first : Variant) -> Variant:
	if first in dic_mat:return dic_mat[first]
	else:return null

func RCM(): return dic_mat
func RCM2(u : int):
	match u:
		1:
			return dic_mat
		2:
			return dic_nuvs
		3:
			return dic_nuvo
		_:
			return null

const dim1 : float = 100
const dim2 : float = 100
const dim3 : float = 100
const dim4 : float = 4
const dimpx : float = 8
const dimpy : float = 12
const dimpz : float = 4


func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func RandomAssignMaterial(mesh):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color_Aleatorio()
	mesh.material_override = material

func AddingDoorCut(csgbox : CSGBox3D , position_door_cut : Vector3 , size_door_cut : Vector3):
	var door_cut = CSGBox3D.new()
	door_cut.operation = CSGShape3D.OPERATION_SUBTRACTION
	door_cut.position = position_door_cut
	door_cut.size = size_door_cut
	csgbox.add_child(door_cut)

func AssignTexture(mesh,file):
	if file:
		var texture = load(file)
		mesh.material_override.albedo_texture = texture

func AssignTexture2(mesh,file : String,uvs : Vector3,uvo : Vector3):
	if file:
		var texture = load(file)
		var material = StandardMaterial3D.new()
		material.albedo_texture = texture
		material.uv1_scale = uvs
		material.uv1_offset = uvo
		mesh.material_override = material

func AssignTexture3(mesh,file : String,uvs : Vector3,uvo : Vector3):
	if file:
		var texture = load(file)
		var tex_width : float = texture.get_width()
		var tex_height : float = texture.get_height()
		uvs = Vector3(tex_width/uvs.x , tex_height/uvs.y , uvs.z)
		var material = StandardMaterial3D.new()
		material.albedo_texture = texture
		material.uv1_scale = uvs
		material.uv1_offset = uvo
		mesh.material_override = material

func AssignMaterialFromContainer():
	for key in dic_mat.keys():
		var n = get_parent().get_node("MaterialesYTexturas")
		var m = n.GetMaterial(key)
		if m : dic_mat[key].material_override = m

func _ready():
	pass
	Instantiate()
	var nf = load("res://scripts/cripta_sala_2/wall_bridges.gd")
	nf = nf.new()
	var np = $Puente1
	var np_collider = $Puente1/Body/Collider
	var vA = Vector3(dimpx,dimpy,dim4)
	var vB : Vector3 = Vector3(0,0,1)
	var ss0 : String = "cs2,puente1"
	sref = nf.ParedesPalPuente6(np,np_collider.shape.size.z,vA,vB,ss0)
	
	AddWallLights2(np_collider, 6,false);
	
	var mesh_bridge = $Puente1/Body/Mesh
	var nuvs_bridge = MYT.Vec_Cubicas1(mesh_bridge.mesh.size.x,mesh_bridge.mesh.size.z)
	var nuvo_bridge = Vector3.ZERO
	var nss_bridge : String = ",cs2,puente1,"
	DCM2(mesh_bridge,nss_bridge,nuvs_bridge,nuvo_bridge)
	
	AddLastWall();

func Instantiate():
	var rf3_now = get_parent().get_node("Cripta_Sala_3")
	self.position = Vector3(0,rf3_now.dim2*0.12/2-dim4/2,rf3_now.dim4/2)
	
	var ss0 : String
	var ss1 : String
	var ss2 : String
	var ssv : Array
	var nss : String
	var nuvs : Vector3
	var nuvo : Vector3
	
	
	var node : Node3D
	var body
	var collider
	var mesh
	var size : Vector3
	var position : Vector3
	var material : StandardMaterial3D
	var TextureFile : String
	var uv1_scale : Vector3
	var uv1_offset : Vector3
	
	
	# SUELO
	size = Vector3(dim1,dim4,dim3)
	position = Vector3.ZERO
	node = $Suelo
	node.position = position
	body = $Suelo/Body
	collider = $Suelo/Body/Collider
	mesh = $Suelo/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.z)
	nuvo = Vector3.ZERO
	nss = ",cs2,suelo,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_04.png"
	uv1_scale = Vector3(5.1,5.4,1)
	uv1_offset = Vector3.ZERO
	
	# PARED 1
	size = Vector3(dim4,dim2,dim3)
	position = Vector3(-dim1/2,dim2/2,0)
	node = $Pared1
	node.position = position
	body = $Pared1/Body
	collider = $Pared1/Body/Collider
	mesh = $Pared1/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.z,mesh.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs2,pared1,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_03.png"
	uv1_scale = Vector3(1,1,1)
	uv1_offset = Vector3.ZERO
	
	# PARED 2
	size = Vector3(dim1,dim2,dim4)
	position = Vector3(0,dim2/2,dim3/2)
	node = $Pared2
	node.position = position
	body = $Pared2/Body
	collider = $Pared2/Body/Collider
	mesh = $Pared2/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs2,pared2,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_03.png"
	uv1_scale = Vector3(1,1,1)
	uv1_offset = Vector3.ZERO
	
	# PARED 3
	size = Vector3(dim4,dim2,dim3)
	position = Vector3(dim1/2,dim2/2,0)
	node = $Pared3
	node.position = position
	body = $Pared3/Body
	collider = $Pared3/Body/Collider
	mesh = $Pared3/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.z,mesh.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs2,pared3,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_03.png"
	uv1_scale = Vector3(1,1,1)
	uv1_offset = Vector3.ZERO
	
	# PARED 4 FRAG 1
	size = Vector3((dim1-dimpx)/2,dimpy,dim4)
	position = Vector3(-dim1/4-dimpx/2,dimpy/2,-dim3/2)
	node = $Pared4/Fragment1
	node.position = position
	body = $Pared4/Fragment1/Body
	collider = $Pared4/Fragment1/Body/Collider
	mesh = $Pared4/Fragment1/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs2,pared4frag1,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_03.png"
	uv1_scale = Vector3(1,1,1)
	uv1_offset = Vector3.ZERO
	
	# PARED 4 FRAG 2
	size = Vector3((dim1-dimpx)/2,dimpy,dim4)
	position = Vector3(dim1/4+dimpx/2,dimpy/2,-dim3/2)
	node = $Pared4/Fragment2
	node.position = position
	body = $Pared4/Fragment2/Body
	collider = $Pared4/Fragment2/Body/Collider
	mesh = $Pared4/Fragment2/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs2,pared4frag2,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_03.png"
	uv1_scale = Vector3(1,1,1)
	uv1_offset = Vector3.ZERO
	
	# PARED 4 FRAG 3
	size = Vector3(dim1,dim2-dimpy,dim4)
	position = Vector3(0,dimpy/2+dim2/2,-dim3/2)
	node = $Pared4/Fragment3
	node.position = position
	body = $Pared4/Fragment3/Body
	collider = $Pared4/Fragment3/Body/Collider
	mesh = $Pared4/Fragment3/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs2,pared4frag3,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_03.png"
	uv1_scale = Vector3(1,1,1)
	uv1_offset = Vector3.ZERO
	
	
	# TECHO
	size = Vector3(dim1,dim4,dim3)
	position = Vector3(0,dim2,0)
	node = $Techo
	node.position = position
	body = $Techo/Body
	collider = $Techo/Body/Collider
	mesh = $Techo/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	mesh.cast_shadow = true
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.z)
	nuvo = Vector3.ZERO
	nss = ",cs2,techo,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	TextureFile = "res://textures/Ground_04.png"
	uv1_scale = Vector3(512/size.x,512/size.z,1)
	uv1_offset = Vector3.ZERO

func place_bridges():
	var b1 : Node3D = $Puente1
	var b2 : Node3D = $Puente2
	var b3 : Node3D = $Puente3
	var b4 : Node3D = $Puente4
	var b5 : Node3D = $Puente5
	
	var refp1 = get_parent().get_node("Cripta_Sala_2")
	var refp2 = get_parent().get_node("Cripta_Sala_3")
	var refp3 = get_parent().get_node("Cripta_Sala_3")
	var refp4 = get_parent().get_node("Cripta_Sala_3")
	var refp5 = get_parent().get_node("Cripta_Sala_3")

var sref
func _process(d:float):
	pass

var last_wall : Node3D;
func AddLastWall():
	last_wall = Node3D.new()
	var mesh = MeshInstance3D.new();
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = Vector3(dimpx,dimpy,dimpz)
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color("87a800");
	mesh.material_override = mat;
	
	var body = StaticBody3D.new()
	var collider = CollisionShape3D.new()
	collider.shape = BoxShape3D.new()
	collider.shape.size = mesh.mesh.size
	body.add_child(collider)
	mesh.add_child(body)
	
	var negative_light = OmniLight3D.new()
	negative_light.omni_range = 10;
	negative_light.light_energy = 20;
	negative_light.light_negative = true;
	negative_light.position += Vector3(0,0,dimpy/2);
	last_wall.add_child(negative_light);
	
	
	last_wall.add_child(mesh)
	last_wall.position = Vector3(0,dimpy/2,-dim3/2);
	self.add_child(last_wall)
func RemoveLastWall():
	last_wall.queue_free();

func AddWallLights(bridge_collider , u : int):
	if u > 0:
		var bridge = bridge_collider.get_parent().get_parent();
		var size = bridge_collider.shape.size
		var length = max(size.x,size.y,size.z);
		var distance = length / (u+1);
		var initial_point = Vector3(0,size.y/2,length/2);
		var incI = Vector3(-size.x/2,0,0);
		var incD = Vector3(size.x/2,0,0);
		var inc = Vector3(0,0,-distance)
		
		for i in range(1,u+1):
			var pointI = initial_point + incI + i * inc;
			var pointD = initial_point + incD + i * inc;
			var lightI = OmniLight3D.new()
			lightI.omni_range = 10;
			lightI.light_color = Color("e56600");
			lightI.light_energy = 10;
			lightI.shadow_enabled = true;
			lightI.position = pointI;
			bridge.add_child(lightI);
			var lightD = OmniLight3D.new()
			lightD.omni_range = 10;
			lightD.light_color = Color("e56600");
			lightD.light_energy = 10;
			lightD.shadow_enabled = true;
			lightD.position = pointD;
			bridge.add_child(lightD);


func AddWallLights2(bridge_collider , u : int , rot : bool ):
	if u > 0:
		var bridge = bridge_collider.get_parent().get_parent();
		var size = bridge_collider.shape.size
		var length = max(size.x,size.y,size.z);
		var distance = length / (u+1);
		var initial_point = Vector3(0,size.y/2,length/2);
		var incI = Vector3(0,0,-size.z/2);
		var incD = Vector3(0,0,size.z/2);
		var inc = Vector3(0,0,-distance);
		if rot:
			initial_point = Vector3(length/2,size.y/2,0)
			incI = Vector3(-size.x/2,0,0);
			incD = Vector3(size.x/2,0,0);
			inc = Vector3(-distance,0,0);
		
		for i in range(1,u):
			var pointI = initial_point + incI + i * inc;
			var pointD = initial_point + incD + i * inc;
			var lightI = OmniLight3D.new()
			lightI.omni_range = 10;
			lightI.light_color = Color("e56600");
			lightI.light_energy = 10;
			lightI.shadow_enabled = true;
			lightI.position = pointI;
			bridge.add_child(lightI);
			var lightD = OmniLight3D.new()
			lightD.omni_range = 10;
			lightD.light_color = Color("e56600");
			lightD.light_energy = 10;
			lightD.shadow_enabled = true;
			lightD.position = pointD;
			bridge.add_child(lightD);
