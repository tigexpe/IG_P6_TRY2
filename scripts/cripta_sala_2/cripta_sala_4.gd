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

var ref_entry : Vector3 = Vector3.ZERO

const dim1 : float = 100
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

func High_Door_Entry() -> Vector3: return ref_entry

func _ready():
	pass

func Instantiate():
	
	var ss0 : String
	var ss1 : String
	var ss2 : String
	var ssv : Array
	var nss : String
	var nuvs : Vector3
	var nuvo : Vector3
	
	var platform : Node3D
	var platform_pos : Vector3
	var platform_rot : Vector3
	var platform_size : Vector3
	var platform_ref : Vector3
	
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
	nss = ",cs4,suelo,mesh,"
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
	nss = ",cs4,techo,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	
	#---------------------------------------------------------------
	# PARED 1
	size = Vector3(dim1,dim2,dim4)
	position = Vector3(0,dim2/2,dim3/2)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpx,dimpy,dimpz)
	position_door_cut = Vector3(0,dim2*0.12,dim3/2)
	position_door_cut = Vector3(0,dim2 * 0.7,dim3/2)
	
	node = $Pared1
	node.position = position
	csgbox = $Pared1/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs4,pared1,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	AddingDoorCut(csgbox,position_door_cut - node.position,size_door_cut)
	ref_entry = node.get_child(0).global_transform.origin - node.global_transform.origin
	platform_ref = position_door_cut - node.position
	
	
	# LANZADERA PLATFORM
	platform = Node3D.new()
	platform_size = Vector3(dimpx,dim4,26)
	platform_rot = Vector3.ZERO
	platform_pos = position_door_cut + Vector3(0,-(size_door_cut.y+platform_size.y)/2,-platform_size.z/2-dim4/2)
	nuvs = MYT.Vec_Cubicas1(platform_size.x,platform_size.z)
	nuvo = Vector3.ZERO
	nss = ",cs4,plataforma_lanzadera_1,mesh,"
	NewPlatform2(platform,platform_pos,platform_rot,platform_size,nuvs,nuvo,nss)
	self.add_child(platform)
	
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
	nss = ",cs4,pared2,csgbox,"
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
	nss = ",cs4,pared3,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	platform_ref = node.position ## EEEEH ##
	
	# PLATAFORMA INTERRUPTOR
	platform = Node3D.new()
	platform_size = Vector3(dimpx,dim4,20)
	platform_pos = platform_ref + Vector3(0,0,platform_size.z/2)
	platform_rot = Vector3.ZERO
	nuvs = MYT.Vec_Cubicas1(platform_size.x,platform_size.z)
	nuvo = Vector3.ZERO
	nss = ",cs4,plataforma_interruptor_1,mesh,"
	NewPlatform2(platform,platform_pos,platform_rot,platform_size,nuvs,nuvo,nss)
	self.add_child(platform)
	
	
	# INTERRUPTOR DE LA HABITACIÓN
	var cylinder_height : float = 4.3
	var radius_height : float = 1.8
	var cc1 : Vector3 = platform_pos + Vector3(0,cylinder_height/2+platform_size.y/2,0)
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
	nss = ",cs4,interruptor1,refc1_mesh,"
	DCM2(refc1_mesh,nss,nuvs,nuvo)
	
		
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
	nss = ",cs4,pared4,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	


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


func SetAutomaticPlatforms():
	var now_pos = Vector3(0,40,-60)
	var now_pos_inc = Vector3(0,0,30)
	now_pos = Vector3(0,40,60)
	now_pos = Vector3(0,50,60)
	now_pos_inc = Vector3(0,0,-30)
	now_pos_inc = Vector3(0,0,-15)
	# NOW VAMOS CON LAS PLATAFORMAS AUTOMÁTICAS
	var pf_cd : float
	var pf_M : int
	var pf_sp : Vector3
	var pf_ep : Vector3
	var pf_s : float
	var pf_wts : float
	var pf_tt : float
	var pf_sz : Vector3
	var pf_s2 : String
	
	
	var pf1 = $PlatFila1
	pf1.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(-45,10,0)
	pf_ep = Vector3(45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Pendulus"
	pf1.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	var pf2 = $PlatFila2
	pf2.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 4
	pf_sp = Vector3(45,10,0)
	pf_ep = Vector3(-45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Linear_Create_End"
	pf2.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	var pf3 = $PlatFila3
	pf3.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 8
	pf_sp = Vector3(-45,10,0)
	pf_ep = Vector3(45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Linear_Create_End"
	pf3.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf4 = $PlatFila4
	pf4.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(45,10,0)
	pf_ep = Vector3(-45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Pendulus"
	pf4.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf5 = $PlatFila5
	pf5.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(-45,10,0)
	pf_ep = Vector3(45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Pendulus"
	pf5.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf6 = $PlatFila6
	pf6.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(-45,10,0)
	pf_ep = Vector3(45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Pendulus"
	pf6.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf7 = $PlatFila7
	pf7.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(-45,10,0)
	pf_ep = Vector3(45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Linear_Create_End"
	pf7.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf8 = $PlatFila8
	pf8.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(-45,10,0)
	pf_ep = Vector3(45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Linear_Create_End"
	pf8.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf9 = $PlatFila9
	pf9.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(45,10,0)
	pf_ep = Vector3(-45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Linear_Create_End"
	pf9.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
	
	
	var pf10 = $PlatFila10
	pf10.position = now_pos
	now_pos += now_pos_inc
	pf_cd = 1.0
	pf_M = 1
	pf_sp = Vector3(45,10,0)
	pf_ep = Vector3(-45,10,0)
	pf_s = 20.0
	pf_wts = 1.0
	pf_tt = 4.0
	pf_sz = Vector3(8,2,8)
	pf_s2 = "Pendulus"
	pf10.MaxPrepare(pf_cd,pf_M,pf_sp,pf_ep,pf_s,pf_wts,pf_tt,pf_sz,pf_s2)
