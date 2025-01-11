extends Node3D
signal solved

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

var ref_to_solve_1
var ref_to_solve_2
var ref_to_solve_3
var ref_to_solve_4 : String

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

func body_collider(collider , body , node : Node3D , c : Vector3 , r : float , h : float):
	collider.shape = CylinderShape3D.new()
	collider.shape.radius = r
	collider.shape.height = h
	body.add_child(collider)

func body_mesh(mesh , body , node : Node3D , c : Vector3 , r : float , h : float):
	mesh.mesh = CylinderMesh.new()
	mesh.mesh.top_radius = r
	mesh.mesh.bottom_radius = r
	mesh.mesh.height = h
	RandomAssignMaterial(mesh)
	body.add_child(mesh)
	
func body_mesh2(mesh , body , node : Node3D , c : Vector3 , r : float , h : float , nuvs : Vector3 , nuvo : Vector3 , nss : String):
	mesh.mesh = CylinderMesh.new()
	mesh.mesh.top_radius = r
	mesh.mesh.bottom_radius = r
	mesh.mesh.height = h
	RandomAssignMaterial(mesh)
	nss = ",cs6,"+nss+",cylinder,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	body.add_child(mesh)
	
	
func interrupt_body(body , node : Node3D , c : Vector3 , r : float , h : float):
	var collider = CollisionShape3D.new()
	var mesh = MeshInstance3D.new()
	body_collider(collider,body,node,c,r,h)
	body_mesh(mesh,body,node,c,r,h)
	
func interrupt_body2(body , node : Node3D , c : Vector3 , r : float , h : float , nuvs : Vector3 , nuvo : Vector3 , nss : String):
	var collider = CollisionShape3D.new()
	var mesh = MeshInstance3D.new()
	body_collider(collider,body,node,c,r,h)
	body_mesh2(mesh,body,node,c,r,h,nuvs,nuvo,nss)
	
	body.add_to_group("Toggeable")
	

func cylinder_interrupt(node : Node3D , c : Vector3 , r : float , h : float):
	node.position = c
	var body = StaticBody3D.new()
	interrupt_body(body,node,c,r,h)
	node.add_child(body)

func cylinder_interrupt2(node : Node3D , c : Vector3 , r : float , h : float , nuvs : Vector3 , nuvo : Vector3 , nss : String):
	node.position = c
	var body = StaticBody3D.new()
	interrupt_body2(body,node,c,r,h,nuvs,nuvo,nss)
	node.add_child(body)

func static_cylinder(c : Vector3 , r : float , h : float) -> Node3D:
	var node = Node3D.new()
	cylinder_interrupt(node,c,r,h)
	return node
	
#f85700 -> un color naranja
func add_Interruptors():
	var cylinder_height : float = 8.6
	var radius_height : float = 0.8
	var separate_length : float = 16
	var vh = Vector3(separate_length,0,0)
	var vd = Vector3(0,0,separate_length)
	
	var c1 = Vector3(0,(cylinder_height+dim4)/2,0)
	var c2 = c1 -vh -vd
	var c3 = c1  -vd
	var c4 = c1 +vh -vd
	var c5 = c1  +vh
	var c6 = c1 +vh +vd
	var c7 = c1  +vd
	var c8 = c1 -vh +vd
	var c9 = c1  -vh
	
	var ref1 = $Interruptor1
	var ref2 = $Interruptor2
	var ref3 = $Interruptor3
	var ref4 = $Interruptor4
	var ref5 = $Interruptor5
	var ref6 = $Interruptor6
	var ref7 = $Interruptor7
	var ref8 = $Interruptor8
	var ref9 = $Interruptor9
	
	
	var nuvs : Vector3
	var nuvo : Vector3
	var nss : String
	
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder1"
	cylinder_interrupt2(ref1,c1,radius_height,cylinder_height,nuvs,nuvo,nss)
	#_------------------------------------------------------_
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder2"
	cylinder_interrupt2(ref2,c2,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder3"
	cylinder_interrupt2(ref3,c3,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder4"
	cylinder_interrupt2(ref4,c4,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder5"
	cylinder_interrupt2(ref5,c5,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder6"
	cylinder_interrupt2(ref6,c6,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder7"
	cylinder_interrupt2(ref7,c7,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder8"
	cylinder_interrupt2(ref8,c8,radius_height,cylinder_height,nuvs,nuvo,nss)
	nuvs = MYT.Vec_Cilindricas(radius_height,radius_height,cylinder_height)
	nuvo = Vector3.ZERO
	nss = "cylinder9"
	cylinder_interrupt2(ref9,c9,radius_height,cylinder_height,nuvs,nuvo,nss)

func Cylinder_Proof(position : Vector3):
	var node = Node3D.new()
	var mesh = MeshInstance3D.new()
	mesh.mesh = CylinderMesh.new()
	mesh.mesh.top_radius = 2
	mesh.mesh.bottom_radius = 2
	mesh.mesh.height = 1
	node.position = position
	node.add_child(mesh)
	self.add_child(node)

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
	ref_to_solve_4 = "unsolved"


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
	
	var platform
	var platform_size
	var platform_pos
	var platform_rot
	
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
	#---------------------------------------------------------------
	# SUELO
	size = Vector3(dim1,dim4,dim3)
	node = $Suelo
	node.position = Vector3.ZERO
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
	nss = ",cs6,suelo,mesh,"
	DCM2(mesh,nss,nuvs,nuvo)
	#---------------------------------------------------------------
	# TECHO
	size = Vector3(dim1,dim4,dim3)
	node = $Techo
	node.position = Vector3(0,dim2,0)
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
	nss = ",cs6,techo,mesh,"
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
	nss = ",cs6,pared1,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	
	AddingDoorCut(csgbox,position_door_cut-node.position,size_door_cut)
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
	nss = ",cs6,pared2,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	#--------------------------------------------------
	# PARED 3
	size = Vector3(dim1,dim2,dim4)
	position = Vector3(0,dim2/2,-dim3/2-dim4/2)
	size_csgbox = size
	position_csgbox = Vector3.ZERO
	size_door_cut = Vector3(dimpx,dimpy,dimpz)
	position_door_cut = Vector3(0,(dim4+dimpy)/2,-dim3/2-dim4/2)
	
	node = $Pared3
	node.position = position
	csgbox = $Pared3/CajaSolida
	csgbox.position = position_csgbox
	csgbox.size = size_csgbox
	RandomAssignMaterial(csgbox)
	nuvs = MYT.Vec_Cubicas1(csgbox.size.x,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs6,pared3,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	
	ref_to_solve_1 = csgbox
	ref_to_solve_2 = position_door_cut - node.position
	ref_to_solve_3 = size_door_cut
	
	# PLATAFORMA FINAL DE LANZAMIENTO
	platform = Node3D.new()
	platform_size = Vector3(dimpx,dim4,20)
	platform_pos = position_door_cut + Vector3(0,-(size_door_cut.y+platform_size.y)/2,-platform_size.z/2-dim4/2)
	platform_rot = Vector3.ZERO
	nuvs = MYT.Vec_Cubicas1(platform_size.x,platform_size.z)
	nuvo = Vector3.ZERO
	nss = ",cs6,plataforma_final_1,mesh,"
	NewPlatform2(platform,platform_pos,platform_rot,platform_size,nuvs,nuvo,nss)
	self.add_child(platform)
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
	nuvs = MYT.Vec_Cubicas1(csgbox.size.z,csgbox.size.y)
	nuvo = Vector3.ZERO
	nss = ",cs6,pared4,csgbox,"
	DCM2(csgbox,nss,nuvs,nuvo)
	
	RandomAssignMaterial(csgbox)
	#--------------------------------------------------
	
func _process(delta : float) -> void:
	if ref_to_solve_4 == "unsolved":
		var r1 = $Interruptor1
		var r2 = $Interruptor2
		var r3 = $Interruptor3
		var r4 = $Interruptor4
		var r5 = $Interruptor5
		var r6 = $Interruptor6
		var r7 = $Interruptor7
		var r8 = $Interruptor8
		var r9 = $Interruptor9
		var b1 = r1.light_now()
		var b2 = r2.light_now()
		var b3 = !r3.light_now()
		var b4 = !r4.light_now()
		var b5 = !r5.light_now()
		var b6 = r6.light_now()
		var b7 = !r7.light_now()
		var b8 = !r8.light_now()
		var b9 = !r9.light_now()
		
		if b1 and b2 and b3 and b4 and b5 and b6 and b7 and b8 and b9:
			ref_to_solve_4 ="solved"
			AddingDoorCut(ref_to_solve_1,ref_to_solve_2,ref_to_solve_3)
			solved.emit();
