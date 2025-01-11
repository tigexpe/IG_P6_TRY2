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

const dim1 : float = 200
const dim2 : float = 100
const dim3 : float = 200
const dim4 : float = 4
const dimpx : float = 8
const dimpy : float = 12
const dimpz : float = 4

func edit_node(node : Node3D , name : String):
	var body = node.get_node("Body")
	var collider = node.get_node("Collider")
	var mesh = node.get_node("Mesh")


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


func _ready():
	Statues_For_Room_5();

func Instantiate():
	
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
	
	var csgbox
	var size_csgbox : Vector3
	var position_csgbox : Vector3
	var door_cut
	var position_door_cut : Vector3
	var size_door_cut : Vector3
	
	# SUELO
	size = Vector3(dim1,dim4,dim3)
	position = Vector3.ZERO
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpx,dim4+2,dimpz)
	position_door_cut = Vector3(39,0,39)
	position_door_cut = Vector3(25,0,35)
	
	node = $Suelo
	node.position = position
	csgbox = $Suelo/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.z)
	nuvo = Vector3.ZERO
	nss = ",cs5,suelo,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	
	# TRAMPILLA
	var h : float = 10
	var L : float = 2 * dimpz + 20
	var ct : Vector3 = position_door_cut - node.position
	
	var dx : float = dimpx
	var dy : float = dimpy
	var dz : float = dimpz
	var d4 : float = dim4
	
	var trap_node_1 : Node3D = Node3D.new()
	var trap_node_2 : Node3D = Node3D.new()
	var trap_node_3 : Node3D = Node3D.new()
	var trap_node_4 : Node3D = Node3D.new()
	var trap_node_5 : Node3D = Node3D.new()
	
	var c1 : Vector3 = ct + Vector3(0,-(h+d4),(-L+dz)/2)
	var c2 : Vector3 = c1 + Vector3((dx+d4)/2,(h+d4)/2,0)
	var c3 : Vector3 = c1 + Vector3(-(dx+d4)/2,(h+d4)/2,0)
	var c4 : Vector3 = c1 + Vector3(0,(h+d4)/2,-(L+d4)/2)
	var c5 : Vector3 = c1 + Vector3(0,(h+d4)/2,(L+d4)/2)
	
	var s1 : Vector3 = Vector3(dx,d4,L)
	var s2 : Vector3 = Vector3(d4,h,L)
	var s3 : Vector3 = Vector3(d4,h,L)
	var s4 : Vector3 = Vector3(dx,h,dz)
	var s5 : Vector3 = Vector3(dx,h,dz)
	
	var b1 : StaticBody3D = StaticBody3D.new()
	var b2 : StaticBody3D = StaticBody3D.new()
	var b3 : StaticBody3D = StaticBody3D.new()
	var b4 : StaticBody3D = StaticBody3D.new()
	var b5 : StaticBody3D = StaticBody3D.new()
	
	var k1 : CollisionShape3D = CollisionShape3D.new()
	var k2 : CollisionShape3D = CollisionShape3D.new()
	var k3 : CollisionShape3D = CollisionShape3D.new()
	var k4 : CollisionShape3D = CollisionShape3D.new()
	var k5 : CollisionShape3D = CollisionShape3D.new()
	
	var m1 : MeshInstance3D = MeshInstance3D.new()
	var m2 : MeshInstance3D = MeshInstance3D.new()
	var m3 : MeshInstance3D = MeshInstance3D.new()
	var m4 : MeshInstance3D = MeshInstance3D.new()
	var m5 : MeshInstance3D = MeshInstance3D.new()
	
	var t1 : StandardMaterial3D = StandardMaterial3D.new()
	var t2 : StandardMaterial3D = StandardMaterial3D.new()
	var t3 : StandardMaterial3D = StandardMaterial3D.new()
	var t4 : StandardMaterial3D = StandardMaterial3D.new()
	var t5 : StandardMaterial3D = StandardMaterial3D.new()
	
	k1.shape = BoxShape3D.new()
	k2.shape = BoxShape3D.new()
	k3.shape = BoxShape3D.new()
	k4.shape = BoxShape3D.new()
	k5.shape = BoxShape3D.new()
	
	m1.mesh = BoxMesh.new()
	m2.mesh = BoxMesh.new()
	m3.mesh = BoxMesh.new()
	m4.mesh = BoxMesh.new()
	m5.mesh = BoxMesh.new()
	
	k1.shape.size = s1
	k2.shape.size = s2
	k3.shape.size = s3
	k4.shape.size = s4
	k5.shape.size = s5
	
	m1.mesh.size = s1
	m2.mesh.size = s2
	m3.mesh.size = s3
	m4.mesh.size = s4
	m5.mesh.size = s5
	
	trap_node_1.position = c1
	trap_node_2.position = c2
	trap_node_3.position = c3
	trap_node_4.position = c4
	trap_node_5.position = c5
	
	t1.albedo_color = Color_Aleatorio()
	t2.albedo_color = Color_Aleatorio()
	t3.albedo_color = Color_Aleatorio()
	t4.albedo_color = Color_Aleatorio()
	t5.albedo_color = Color_Aleatorio()
	
	m1.material_override = t1
	m2.material_override = t2
	m3.material_override = t3
	m4.material_override = t4
	m5.material_override = t5
	
	b1.add_child(k1)
	b2.add_child(k2)
	b3.add_child(k3)
	b4.add_child(k4)
	b5.add_child(k5)
	
	b1.add_child(m1)
	b2.add_child(m2)
	b3.add_child(m3)
	b4.add_child(m4)
	b5.add_child(m5)
	
	trap_node_1.add_child(b1)
	trap_node_2.add_child(b2)
	trap_node_3.add_child(b3)
	trap_node_4.add_child(b4)
	trap_node_5.add_child(b5)
		
	self.add_child(trap_node_1)
	self.add_child(trap_node_2)
	self.add_child(trap_node_3)
	self.add_child(trap_node_4)
	self.add_child(trap_node_5)
	
	
	nuvs = MYT.Vec_Cubicas1(m1.mesh.size.x,m1.mesh.size.z)
	nuvo = Vector3.ZERO
	nss = ",cs5,trap_node_1,mesh,"
	DCM2(m1,nss,nuvs,nuvo)
	nuvs = MYT.Vec_Cubicas1(m2.mesh.size.z,m2.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,trap_node_2,mesh,"
	DCM2(m2,nss,nuvs,nuvo)
	nuvs = MYT.Vec_Cubicas1(m3.mesh.size.z,m3.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,trap_node_3,mesh,"
	DCM2(m3,nss,nuvs,nuvo)
	nuvs = MYT.Vec_Cubicas1(m4.mesh.size.x,m4.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,trap_node_4,mesh,"
	DCM2(m4,nss,nuvs,nuvo)
	nuvs = MYT.Vec_Cubicas1(m5.mesh.size.x,m5.mesh.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,trap_node_5,mesh,"
	DCM2(m5,nss,nuvs,nuvo)
	
	
	# INTERRUPTOR DE LA HABITACIÓN
	var cylinder_height : float = 4.3
	var radius_height : float = 1.8
	var cc1 : Vector3 = c1 + Vector3(0,(h+d4)/2,-(L+d4)/2)
	cc1 = c1 + Vector3(0,(h+d4)/2,0)
	var refc1 = $Interruptor1
	var refc1_collider = $Interruptor1/Body/Collider
	var refc1_mesh = $Interruptor1/Body/Mesh
	refc1.position = cc1
	refc1_collider.shape = CylinderShape3D.new()
	refc1_collider.shape.radius = radius_height
	refc1_collider.shape.height = cylinder_height
	refc1_mesh.mesh = CylinderMesh.new()
	refc1_mesh.mesh.top_radius = radius_height
	refc1_mesh.mesh.bottom_radius = radius_height
	refc1_mesh.mesh.height = cylinder_height
	RandomAssignMaterial(refc1_mesh)
	nuvs = MYT.Vec_Cilindricas(refc1_mesh.mesh.top_radius,refc1_mesh.mesh.bottom_radius,refc1_mesh.mesh.height)
	nuvo = Vector3.ZERO
	nss = ",cs5,interruptor1,refc1_mesh,"
	DCM2(refc1_mesh,nss,nuvs,nuvo)
	
	#---------------------------------------------------------------
	#-
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
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.z)
	nuvo = Vector3.ZERO
	nss = ",cs5,techo,csgbox,"
	DCM2(mesh,nss,nuvs,nuvo)
	
	#---------------------------------------------------------------
	# PARED 1
	size = Vector3(dim1,dim2,dim4)
	position = Vector3(0,dim2/2,dim3/2)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpx,dimpy,dimpz)
	position_door_cut = Vector3(0,dim2*0.12,dim3/2)
	
	node = $Pared1
	node.position = position
	csgbox = $Pared1/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,pared1,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	
	#--------------------------------------------------
	# PARED 2
	size = Vector3(dim4,dim2,dim3)
	position = Vector3(-dim1/2,dim2/2,0)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	
	node = $Pared2
	node.position = position
	csgbox = $Pared2/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.z,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,pared2,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	
	#--------------------------------------------------
	# PARED 3
	size = Vector3(dim1,dim2,dim4)
	position = Vector3(0,dim2/2,-dim3/2)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	
	node = $Pared3
	node.position = position
	csgbox = $Pared3/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,pared3,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
		
	#--------------------------------------------------
	# PARED 4
	size = Vector3(dim4,dim2,dim3)
	position = Vector3(dim1/2,dim2/2,0)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	
	node = $Pared4
	node.position = position
	csgbox = $Pared4/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.z,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs5,pared4,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	
	#--------------------------------------------------
	
	
var file_mesh : String = "res://MeshFile.gd"
func Instance_And_Add_From_Ply(pos : Vector3 , rot : Vector3 , file_mesher : String , file : String , modo : String , scale : Vector3):
	var Mesher = load(file_mesher).new()
	var mesh = Mesher.LoadMesh(file,modo,scale)
	var collider
	
	if mesh:
		var pair = Mesher.More_Or_Less_Collider(Mesher.vertices);
		var vec_coll : Vector3 = pair[0];
		var vec_centre : Vector3 = pair[1];
		if vec_coll != Vector3.ZERO:
			collider = CollisionShape3D.new()
			collider.shape = BoxShape3D.new()
			collider.shape.size = vec_coll;
			
			var body = StaticBody3D.new()
			var node = Node3D.new()
			node.position = pos;
			node.rotation = rot;
			
			mesh.position -= vec_centre;
			body.add_child(mesh)
			body.add_child(collider)
			node.add_child(body)
			return node;
		return null;
	return null;
	
func Statues_For_Room_5():
	var pos : Vector3;
	var rot : Vector3;
	var file_mesher : String = "res://MeshFile.gd";
	var file : String;
	var node : Node3D;
	var modo : String;
	var scale : Vector3
	
	pos = Vector3.ZERO
	pos = Vector3(-51.3,31.43,-39.4);
	pos = Vector3(-51.3,11.43,-39.4);
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(37.1),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(37.1));
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/beethoven.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_1 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	pos = Vector3.ZERO;
	pos = Vector3(-51.3,31.43,-5.41)
	pos = Vector3(-51.3,11.43,-5.41)
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(20),deg_to_rad(0),deg_to_rad(0));
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/beethoven.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_2 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	pos = Vector3.ZERO;
	pos = Vector3(-51.3,23,28.26)
	pos = Vector3(-51.3,6.23,28.26)
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(-17.6),deg_to_rad(0),deg_to_rad(0))
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/beethoven.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_3 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	pos = Vector3.ZERO;
	pos = Vector3(-51.3,18.29,92.73);
	pos = Vector3(-51.3,12.29,92.73);
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(26.5),deg_to_rad(0),deg_to_rad(0));
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/beethoven.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_4 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	pos = Vector3.ZERO;
	pos = Vector3(65.76,0,72.34);
	pos = Vector3(65.76,10,72.34);
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(32.4));
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/armadillo.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_5 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	pos = Vector3.ZERO;
	pos = Vector3(-18.1,3.35,-66.5);
	#pos = Vector3(-18.1,8.35,-66.5);
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(81.8));
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/big_dodge.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_6 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	pos = Vector3.ZERO;
	pos = Vector3(40.83,0,-49.3);
	pos = Vector3(40.83,5,-49.3);
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(0));
	rot = Vector3(deg_to_rad(0),deg_to_rad(0),deg_to_rad(-21.3));
	file_mesher = "res://MeshFile.gd";
	file = "res://modelos_p2/big_dodge.ply";
	modo = "Flat";
	scale = Vector3(1,1,1);
	scale = Vector3(2,2,2);
	var node_7 = Instance_And_Add_From_Ply(pos,rot,file_mesher,file,modo,scale);
	
	
	
	var en : float;
	var r : float;
	var color : String;
	var se : bool;
	
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_1:
		var light = AddInteriorLight(node_1,en,r,color,se);
		node_1.add_child(light);
		self.add_child(node_1);
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_2:
		var light = AddInteriorLight(node_2,en,r,color,se);
		node_2.add_child(light);
		self.add_child(node_2);
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_3:
		var light = AddInteriorLight(node_3,en,r,color,se);
		node_3.add_child(light);
		self.add_child(node_3);
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_4:
		var light = AddInteriorLight(node_4,en,r,color,se);
		node_4.add_child(light);
		self.add_child(node_4);
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_5:
		var light = AddInteriorLight(node_5,en,r,color,se);
		node_5.add_child(light);
		self.add_child(node_5);
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_6:
		var light = AddInteriorLight(node_6,en,r,color,se);
		node_6.add_child(light);
		self.add_child(node_6);
	en = 2
	en = 20
	r = 8
	r = 80
	color = "0000ff"
	se = true;
	if node_7:
		var light = AddInteriorLight(node_7,en,r,color,se);
		node_7.add_child(light);
		self.add_child(node_7);



func Set_Start(light : OmniLight3D , en : float , r : float , color : String , se : bool):
	light.light_energy = en
	light.omni_range = r
	light.light_color = Color(color)
	light.shadow_enabled = se
func AddInteriorLight(node : Node3D , en : float , r : float , color : String , se : bool):
	var light = OmniLight3D.new()
	Set_Start(light,en,r,color,se);
	return light;
