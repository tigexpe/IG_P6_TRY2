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


func RCM():return dic_mat
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

var Frag_Escalera_1 : Node3D
var Frag_Escalera_2 : Node3D

var rtb1 : Vector3
var rtb2 : Vector3
var rtb3 : Vector3
var rtb4 : Vector3
var rtb5 : Vector3
var rtb6 : float
var rtb7 : float
var rtb8 : float

const dim1 : float = 100
const dim2 : float = 100
const dim3 : float = 100
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

func _ready():
	Instantiate()
	
	var nf = load("res://scripts/cripta_sala_2/wall_bridges.gd")
	nf = nf.new()
	var np
	var np_collider
	var vA : Vector3
	var vB : Vector3
	
	
	var ss0 : String
	var ss1 : String
	var ss2 : String
	var ssv : Array
	
	
	np = $Puente2
	np_collider = $Puente2/Body/Collider
	vA = Vector3(dimpx,dimpy,dim4)
	vB = Vector3(1,0,0).normalized()
	ss0 = "cs3,puente2"
	nf.ParedesPalPuente5(np,np_collider.shape.size.x,vA,vB,ss0)
	
	AddWallLights(np_collider, 6,true);
	
	
	np = $Puente3
	np_collider = $Puente3/Body/Collider
	vA = Vector3(dimpx,dimpy,dim4)
	vB = Vector3(1,0,0).normalized()
	ss0 = "cs3,puente3"
	nf.ParedesPalPuente5(np,np_collider.shape.size.x,vA,vB,ss0)
	
	AddWallLights(np_collider, 6,true);
	
	
	np = $Puente4
	np_collider = $Puente4/Body/Collider
	vA = Vector3(dimpx,dimpy,dim4)
	vB = Vector3(-1,0,0).normalized()
	ss0 = "cs3,puente4"
	nf.ParedesPalPuente5(np,np_collider.shape.size.x,vA,vB,ss0)
	
	
	np = $Puente5
	np_collider = $Puente5/Body/Collider
	vA = Vector3(dimpx,dimpy,dim4)
	vB = Vector3(0,0,1).normalized()
	ss0 = "cs3,puente5"
	nf.ParedesPalPuente5(np,np_collider.shape.size.z,vA,vB,ss0)
	
	AddWallLights(np_collider, 4,false);

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


func RandomNewPlatform(body : StaticBody3D , collider : CollisionShape3D , mesh : MeshInstance3D , size : Vector3):
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	RandomAssignMaterial(mesh)
	body.add_child(collider)
	body.add_child(mesh)
func NewPlatform(node : Node3D , pos : Vector3 , rot : Vector3 , size : Vector3):
	node.position = pos
	node.rotation = rot
	var body = StaticBody3D.new()
	var collider = CollisionShape3D.new()
	var mesh = MeshInstance3D.new()
	RandomNewPlatform(body,collider,mesh,size)
	node.add_child(body)


func NewPlatform2(node : Node3D , pos : Vector3 , rot : Vector3 , size : Vector3 , nuvs : Vector3 , nuvo : Vector3 , nss : String):
	node.position = pos
	node.rotation = rot
	var body = StaticBody3D.new()
	var collider = CollisionShape3D.new()
	var mesh = MeshInstance3D.new()
	RandomNewPlatform(body,collider,mesh,size)
	node.add_child(body)
	DCM2(mesh,nss,nuvs,nuvo)

func Instantiate():
	
	var ss0 : String
	var ss1 : String
	var ss2 : String
	var ssv : Array
	var nss : String
	var nuvs : Vector3
	var nuvo : Vector3
	
	var reference_2 : Vector3
	var r2_1 : Vector3
	
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
	node = $Suelo
	node.position = position
	body = $Suelo/Body
	collider = $Suelo/Body/Collider
	mesh = $Suelo/Body/Mesh
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	RandomAssignMaterial(mesh)
	nuvs = MYT.Vec_Cubicas1(mesh.mesh.size.x,mesh.mesh.size.z)
	nuvo = Vector3.ZERO
	nss = ",cs3,suelo,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	
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
	nss = ",cs3,techo,mesh,"
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
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs3,pared1,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	rtb1 = position_door_cut - node.position
	#--------------------------------------------------
	# PARED 2
	size = Vector3(dim4,dim2,dim3)
	position = Vector3(-dim1/2,dim2/2,0)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpz,dimpy,dimpx)
	position_door_cut = Vector3(-dim1/2,dimpy,0)
	
	node = $Pared2
	node.position = position
	csgbox = $Pared2/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.z,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs3,pared2,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	#-----4------
	reference_2 = node.global_transform.origin-self.global_transform.origin
	r2_1 = position_door_cut - node.position
	rtb2 = reference_2 + r2_1
	rtb5 = reference_2
	#--------------------------------------------------
	# PARED 3
	size = Vector3(dim1,dim2,dim4)
	position = Vector3(0,dim2/2,-dim3/2)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpx,dimpy,dimpz)
	position_door_cut = Vector3(0,dim2 * 0.5,-dim3/2)
	
	node = $Pared3
	node.position = position
	csgbox = $Pared3/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs3,pared3,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	#-----4------
	reference_2 = node.global_transform.origin-self.global_transform.origin
	r2_1 = position_door_cut - node.position
	rtb3 = reference_2 + r2_1
	#--------------------------------------------------
	
	# FRAGMENTOS DE ESCALERA
	var VL : Vector3 = position_door_cut
	var DL : float = abs(VL.z)
	var HL : float = abs(VL.y)
	var CL : Vector3 = Vector3.ZERO
	var hl : float = (HL - dim4/2 - dimpy/2)
	var hl2 : float = hl / 2
	var dl : float = (DL - dim4/2)
	var dl2 : float = dl / 2
	
	
	
	var CL1 : Vector3 = CL + Vector3(0,dim4/2+hl2/2,-dl2/2)
	var SL1 : Vector3 = Vector3(dimpx,hl2,dl2)
	var RL1 : Vector3 = Vector3.ZERO
	Frag_Escalera_1 = Node3D.new()
	nuvs = MYT.Vec_Cubicas1(SL1.z,SL1.y)
	nuvo = Vector3.ZERO
	nss = ",cs3,frag_escalera_1,mesh,"
	NewPlatform2(Frag_Escalera_1,CL1,RL1,SL1,nuvs,nuvo,nss)
	var CL2 : Vector3 = CL + Vector3(0,dim4/2+hl2,-(dl2/2+dl2))
	var SL2 : Vector3 = Vector3(dimpx,hl,dl2)
	var RL2 : Vector3 = Vector3.ZERO
	Frag_Escalera_2 = Node3D.new()
	nuvs = MYT.Vec_Cubicas1(SL2.z,SL2.y)
	nuvo = Vector3.ZERO
	nss = ",cs3,frag_escalera_2,mesh,"
	NewPlatform2(Frag_Escalera_2,CL2,RL2,SL2,nuvs,nuvo,nss)
	
	
	#--------------------------------------------------
	# PARED 4
	size = Vector3(dim4,dim2,dim3)
	position = Vector3(dim1/2,dim2/2,0)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpz,dimpy,dimpx)
	position_door_cut = Vector3(dim1/2,dimpy,0)
	
	node = $Pared4
	node.position = position
	csgbox = $Pared4/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.z,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs3,pared4,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	#-----4------
	reference_2 = node.global_transform.origin-self.global_transform.origin
	r2_1 = position_door_cut - node.position
	rtb4 = reference_2 + r2_1
	#--------------------------------------------------
	#--------------------------------------------------
	# REFERENCIAS PARA PUENTES
	rtb5 = rtb2
	var A : float = 45.0
	var vH : Vector3 = rtb5 + Vector3(0,80,0)
	var vE : Vector3 = rtb5
	var H : float = (vH - vE).y
	var tgA : float = tan(deg_to_rad(A))
	var L : float = H / tgA
	
	var C : Vector3 = rtb2
	var O : Vector3 = C + Vector3(-L,H,0)
	var O2 : Vector3 = C + Vector3(-L,H,0)/2
	
	var ar1 = Vector3(0,dim4*(1-sin(A)),0)
	var ar2 = Vector3(dim4*cos(A)/2,0,0)
	
	var Lnow : float
	var rot : Vector3
	
	# REF PUENTE 2
	Lnow = sqrt(H*H + L*L)
	rot = Vector3(0,0,deg_to_rad(-A))
	position = O2 + Vector3(0,-dimpy/2,0) + ar1
	size = Vector3(Lnow,dim4,dimpx)
	node = $Puente2
	nuvs = MYT.Vec_Cubicas1(size.z,size.x)
	nuvo = Vector3.ZERO
	nss = "puente2"
	RandomBridge3(Lnow,position,rot,size,node,nss,nuvs,nuvo)
	
	var ref_p2_var_1 : float = -L
	var ref_p2_var_2 : float = position.y
	
	# REF PUENTE 3
	Lnow = 100
	rot = Vector3.ZERO
	position = O - Vector3(Lnow/2,0,0) + Vector3(0,-dimpy/2,0) + ar2
	size = Vector3(Lnow,dim4,dimpx)
	node = $Puente3
	nuvs = MYT.Vec_Cubicas1(size.z,size.x)
	nuvo = Vector3.ZERO
	nss = "puente3"
	RandomBridge3(Lnow,position,rot,size,node,nss,nuvs,nuvo)
	
	var ref_p3_var_1 : float = -Lnow
	
	# REF PUENTE 4
	Lnow = 100
	rot = Vector3.ZERO
	position = rtb4 + Vector3(Lnow/2,0,0) + Vector3(dim4/2,-(dimpy+dim4)/2,0)
	size = Vector3(Lnow,dim4,dimpx)
	node = $Puente4
	nuvs = MYT.Vec_Cubicas1(size.z,size.x)
	nuvo = Vector3.ZERO
	nss = "puente4"
	RandomBridge3(Lnow,position,rot,size,node,nss,nuvs,nuvo)
	
	var ref_p4_var_1 : float = Lnow
	
	# REF PUENTE 5
	Lnow = 100
	rot = Vector3.ZERO
	position = rtb3 + Vector3(0,0,-Lnow/2)
	position = rtb3 + Vector3(0,0,-Lnow/2) + Vector3(0,-(dimpy+dim4)/2,-dim4/2)
	size = Vector3(dimpx,dim4,Lnow)
	node = $Puente5
	nuvs = MYT.Vec_Cubicas1(size.x,size.z)
	nuvo = Vector3.ZERO
	nss = "puente5"
	RandomBridge3(Lnow,position,rot,size,node,nss,nuvs,nuvo)
	
	var ref_p5_var_1 : float = -Lnow
	var ref_p5_var_2 : float = position.y
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
	# REFERENCIAS SALAS
	var ref_sala_4 = get_parent().get_node("Cripta_Sala_4")
	var ref_sala_5 = get_parent().get_node("Cripta_Sala_5")
	var ref_sala_6 = get_parent().get_node("Cripta_Sala_6")
	
	var tx : float
	var ty : float
	var tz : float
	var rx : float
	var ry : float
	var rz : float
	
	tx = -dim1/2-ref_sala_4.dim3/2+ref_p2_var_1+ref_p3_var_1-ref_sala_4.dim4/4
	ty = H - ref_sala_4.dim2 * 0.7 + dimpy
	tz = 0
	rx = 0
	ry = deg_to_rad(90)
	rz = 0
	ref_sala_4 . position = Vector3(tx,ty,tz)
	ref_sala_4 . rotation = Vector3(rx,ry,rz)
	
	tx = dim1/2+ref_sala_5.dim3/2+ref_p4_var_1+ref_sala_5.dim4
	ty = ref_sala_5.dimpy/2 - ref_sala_5.dim2*0.12 / 2
	tz = 0
	rx = 0
	ry = deg_to_rad(-90)
	rz = 0
	ref_sala_5 . position = Vector3(tx,ty,tz)
	ref_sala_5 . rotation = Vector3(rx,ry,rz)
	
	var tmp : float = (dim4 + dimpy)/2
	tx = 0
	ty = ref_p5_var_2 +tmp -(ref_sala_6.dim2*0.12)
	tz = -dim3/2+ref_p5_var_1-ref_sala_6.dim3/2 -ref_sala_6.dim4
	rx = 0
	ry = 0
	rz = 0
	ref_sala_6 . position = Vector3(tx,ty,tz)
	ref_sala_6 . rotation = Vector3(rx,ry,rz)
	
	ref_sala_4.Instantiate()
	ref_sala_5.Instantiate()
	ref_sala_6.Instantiate()
	ref_sala_6.add_Interruptors()
	
	ref_sala_4.position += global_transform.origin
	ref_sala_5.position += global_transform.origin
	ref_sala_6.position += global_transform.origin
	
	
	# AHORA ESTABLECER LAS PLATAFORMAS
	ref_sala_4.SetAutomaticPlatforms()
	











func RellenarHuecos():
	var r2 = $Puente2
	var r3 = $Puente3
	
	var c2 = r2.global_transform.origin - global_transform.origin
	var c3 = r3.global_transform.origin - global_transform.origin
	
	var v2 = Vector3(-1,1,0).normalized()
	var v3 = Vector3(1,0,0).normalized()
	
	var w2 = Vector3(1,1,0).normalized()
	var w3 = Vector3(0,1,0).normalized()
	
	var s2 : Vector3 = r2.get_node("Body/Collider").shape.size
	var s3 : Vector3 = r3.get_node("Body/Collider").shape.size
	
	var l2 : float = max(s2.x,s2.y,s2.z)
	var l3 : float = max(s3.x,s3.y,s3.z)
	
	Rellenar_Huecos(c2,v2,w2,l2,c3,v3,w3,l3)
	
func Rellenar_Huecos(c1 : Vector3 , v1 : Vector3 , w1 : Vector3 , L1 : float , c2 : Vector3 , v2 : Vector3 , w2 : Vector3 , L2 : float):
	var H1 = dimpy + dim4
	var H2 = dimpy + dim4
	var c3 : Vector3 = c1 + w1 * H1
	var c4 : Vector3 = c2 + w2 * H2
	var result = Solve_Cross_Vector_Equation(c3,v1,c4,v2)
	var k1
	var k2
	if result:
		k1 = result["k1"]
		k2 = result["k2"]

func Solve_Cross_Vector_Equation(c1 : Vector3 , v1 : Vector3 , c2 : Vector3 , v2 : Vector3):
	var r : Vector3 = (c2 - c1)
	var determinant : float = v1.cross(v2).length()
	if determinant == 0:
		return null
	var k1 : float = (r.cross(v2).length()) / determinant
	var k2 : float = (v1.cross(r).length()) / determinant
	return {"k1":k1,"k2":k2}

var state = "fak"
func _process(delta : float):
	if state == "fak":
		state = "unfak"
		RellenarHuecos()

func RandomBridge3(Lnow : float , position : Vector3 , rot : Vector3 , size : Vector3 , node : Node3D , s : String , nuvs : Vector3 , nuvo : Vector3):
	RandomBridge(Lnow,position,rot,size,node)
	var mesh = node.get_node("Body/Mesh")
	var nss = ",cs3,"+s+",mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
func RandomBridge2(Lnow : float , position : Vector3 , rot : Vector3 , size : Vector3 , node : Node3D , s : String):
	RandomBridge(Lnow,position,rot,size,node)
	var mesh = node.get_node("Body/Mesh")
	var nuvs = Vector3.ZERO
	var nuvo = Vector3.ZERO
	var nss = ",cs3,"+s+",csgbox,"
	DCM2(mesh,nss,nuvs,nuvo)
func RandomBridge(Lnow : float , position : Vector3 , rot : Vector3 , size : Vector3 , node : Node3D):
	node.position = position
	node.rotation = rot
	
	var body = node.get_node("Body")
	var collider = node.get_node("Body/Collider")
	var mesh = node.get_node("Body/Mesh")
	
	collider.shape = BoxShape3D.new()
	collider.shape.size = size
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = size
	RandomAssignMaterial(mesh)


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

func Solve1():self.add_child(Frag_Escalera_1)
func Solve2():self.add_child(Frag_Escalera_2)
func Unsolve1():Frag_Escalera_1.queue_free()
func Unsolve2():Frag_Escalera_2.queue_free()


func AddWallLights(bridge_collider , u : int , rot : bool ):
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
