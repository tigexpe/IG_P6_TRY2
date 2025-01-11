
extends Node3D

func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func RandomAssignMaterial(mesh):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color_Aleatorio()
	mesh.material_override = material
	
	
	
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
	
func NewPlatform_2(node : Node3D , pos : Vector3 , rot : Vector3 , size : Vector3):
	node.position = pos
	node.rotation = rot
	var body = StaticBody3D.new()
	var collider = CollisionShape3D.new()
	var mesh = MeshInstance3D.new()
	RandomNewPlatform(body,collider,mesh,size)
	node.add_child(body)
	return mesh


func NewPlatform3(node : Node3D , pos : Vector3 , rot : Vector3 , size : Vector3 , nuvs : Vector3 , nuvo : Vector3 , nss : String , caller):
	var mesh = NewPlatform_2(node,pos,rot,size)
	caller.DCM2(mesh,nss,nuvs,nuvo)
	return mesh


const CB : Vector3 = Vector3(0,0,-1)







func ParedesPalPuente2(node : Node3D , Lnow : float , A : Vector3 , B : Vector3):
	var n1 = Node3D.new()
	var n2 = Node3D.new()
	var n3 = Node3D.new()
	ParedesPalPuente2_Pri(node,Lnow,A,B,n1,n2,n3)




func ParedesPalPuente2_Pri(node : Node3D , Lnow : float , A : Vector3 , B : Vector3 , n1 : Node3D , n2 : Node3D , n3 : Node3D):
	Lnow = max(abs(A.x),abs(A.y),abs(A.z),Lnow)
	
	var up = Vector3.UP.normalized()
	var PZL = B.normalized()
	var PXL = up.cross(PZL).normalized()
	var PYL = PZL.cross(PXL).normalized()
	
	var my_transform = Transform3D(Basis(PXL,PYL,PZL))
	var rotation = my_transform
	var basis = rotation
	var c = node.position
	var c0 = node.global_transform.origin - node.get_parent().global_transform.origin
	var c1 = Vector3(-(A.x+A.z)/2,(A.y+A.z)/2,0)
	var c2 = Vector3((A.x+A.z)/2,(A.y+A.z)/2,0)
	var c3 = Vector3(0,(A.y+A.z),0)
	var s1 = Vector3(A.z,A.y,Lnow)
	var s2 = Vector3(A.z,A.y,Lnow)
	var s3 = Vector3(A.x,A.z,Lnow)
	
	if B != CB:
		c1 = basis * c1
		c2 = basis * c2
		c3 = basis * c3
		
		s1 = abs(s1) * basis
		s2 = abs(s2) * basis
		s3 = abs(s3) * basis
		
		s1 = abs(s1)
		s2 = abs(s2)
		s3 = abs(s3)
	var r1 = Vector3.ZERO
	var r2 = Vector3.ZERO
	var r3 = Vector3.ZERO
	
	var C1 = c1 + c0
	var C2 = c2 + c0
	var C3 = c3 + c0
	
	NewPlatform(n1,C1,r1,s1)
	NewPlatform(n2,C2,r2,s2)
	NewPlatform(n3,C3,r3,s3)
	
	n1.rotation = node.rotation
	n2.rotation = node.rotation
	n3.rotation = node.rotation
	node.get_parent().add_child(n1)
	node.get_parent().add_child(n2)
	node.get_parent().add_child(n3)

func ParedesPalPuente3(node : Node3D , Lnow : float , A : Vector3 , B : Vector3):
	var n1 = Node3D.new()
	var n2 = Node3D.new()
	var n3 = Node3D.new()
	ParedesPalPuente2_Pri(node,Lnow,A,B,n1,n2,n3)
	return [n1,n2,n3]
	

func ParedesPalPuente4(node : Node3D , Lnow : float , A : Vector3):
	var n1 = Node3D.new()
	var n2 = Node3D.new()
	var n3 = Node3D.new()
	var t1 = Vector3(0,0,-1).normalized()
	var t2 = Vector3(1,1,0).normalized()
	var t3 = Vector3(1,-1,0).normalized()
	t1 = Vector3(0,0,-1).normalized()
	t2 = Vector3(0,1,0).normalized()
	t3 = Vector3(1,0,0).normalized()
	ParedesPalPuente4_pri(node,Lnow,A,t1,t2,t3,n1,n2,n3)
	return [n1,n2,n3]



func ParedesPalPuente4_pri(node : Node3D , Lnow : float , A : Vector3 , t1 : Vector3 , t2 : Vector3 , t3 : Vector3 , n1 : Node3D , n2 : Node3D , n3 : Node3D):
	var yes : bool = t1 != Vector3(1,0,0) || t2 != Vector3(0,1,0) || t3 != Vector3(0,0,1)
	var basis = Basis(t1,t2,t3)
	print("MATRIZ DE TRANSFORMACIÓN: ",basis)
	var transform = Transform3D(basis)
	var c = node.position
	var c0 = node.global_transform.origin - node.get_parent().global_transform.origin
	var c1 = Vector3(-(A.x+A.z)/2,(A.y+A.z)/2,0)
	var c2 = Vector3((A.x+A.z)/2,(A.y+A.z)/2,0)
	var c3 = Vector3(0,(A.y+A.z),0)
	var s1 = Vector3(A.z,A.y,Lnow)
	var s2 = Vector3(A.z,A.y,Lnow)
	var s3 = Vector3(A.x,A.z,Lnow)
	if yes:
		c1 = transform * c1
		c2 = transform * c2
		c3 = transform * c3
		
		s1 = abs(s1) * transform
		s2 = abs(s2) * transform
		s3 = abs(s3) * transform
		
		s1 = abs(s1)
		s2 = abs(s2)
		s3 = abs(s3)
	var r1 = Vector3.ZERO
	var r2 = Vector3.ZERO
	var r3 = Vector3.ZERO
	var C1 = c1 + c0
	var C2 = c2 + c0
	var C3 = c3 + c0
	NewPlatform(n1,C1,r1,s1)
	NewPlatform(n2,C2,r2,s2)
	NewPlatform(n3,C3,r3,s3)
	n1.rotation = node.rotation
	n2.rotation = node.rotation
	n3.rotation = node.rotation
	node.get_parent().add_child(n1)
	node.get_parent().add_child(n2)
	node.get_parent().add_child(n3)









func ParedesPalPuente6(node : Node3D , Lnow : float , A : Vector3 , B : Vector3 , ss0 : String):
	var n1 = Node3D.new()
	var n2 = Node3D.new()
	var n3 = Node3D.new()
	return ParedesPalPuente5_pri(node,Lnow,A,B,n1,n2,n3,ss0)







func ParedesPalPuente5(node : Node3D , Lnow : float , A : Vector3 , B : Vector3 , ss0 : String):
	var n1 = Node3D.new()
	var n2 = Node3D.new()
	var n3 = Node3D.new()
	ParedesPalPuente5_pri(node,Lnow,A,B,n1,n2,n3,ss0)



func ParedesPalPuente5_pri(node : Node3D , Lnow : float , A : Vector3 , B : Vector3 , \
n1 : Node3D , n2 : Node3D , n3 : Node3D , ss0 : String):
	
	var nuvs : Vector3
	var nuvo : Vector3
	var nss : String
	var caller = node.get_parent()
	
	
	Lnow = max(abs(A.x),abs(A.y),abs(A.z),Lnow)
	
	var up = Vector3.UP.normalized()
	var PZL = B.normalized()
	var PXL = up.cross(PZL).normalized()
	var PYL = PZL.cross(PXL).normalized()
	
	var my_transform = Transform3D(Basis(PXL,PYL,PZL))
	var rotation = my_transform
	var basis = rotation
	var c = node.position
	var c0 = node.global_transform.origin - node.get_parent().global_transform.origin
	var c1 = Vector3(-(A.x+A.z)/2,(A.y+A.z)/2,0)
	var c2 = Vector3((A.x+A.z)/2,(A.y+A.z)/2,0)
	var c3 = Vector3(0,(A.y+A.z),0)
	var s1 = Vector3(A.z,A.y,Lnow)
	var s2 = Vector3(A.z,A.y,Lnow)
	var s3 = Vector3(A.x,A.z,Lnow)
	
	if B != CB:
		c1 = basis * c1
		c2 = basis * c2
		c3 = basis * c3
		
		s1 = abs(s1) * basis
		s2 = abs(s2) * basis
		s3 = abs(s3) * basis
		
		s1 = abs(s1)
		s2 = abs(s2)
		s3 = abs(s3)
	var r1 = Vector3.ZERO
	var r2 = Vector3.ZERO
	var r3 = Vector3.ZERO
	
	var C1 = c1 + c0
	var C2 = c2 + c0
	var C3 = c3 + c0
	
	
	nuvs = Vector3(s1.y,s1.z,1)
	nuvo = Vector3.ZERO
	nss = ","+ss0+",pared1"
	NewPlatform3(n1,C1,r1,s1,nuvs,nuvo,nss,caller)
	nuvs = Vector3(s2.y,s2.z,1)
	nuvo = Vector3.ZERO
	nss = ","+ss0+",pared2"
	NewPlatform3(n2,C2,r2,s2,nuvs,nuvo,nss,caller)
	nuvs = Vector3(s3.x,s3.z,1)
	nuvs = Vector3(s3.z,s3.x,1)
	nuvo = Vector3.ZERO
	nss = ","+ss0+",pared3"
	var ar = NewPlatform3(n3,C3,r3,s3,nuvs,nuvo,nss,caller)
	
	n1.rotation = node.rotation
	n2.rotation = node.rotation
	n3.rotation = node.rotation
	node.get_parent().add_child(n1)
	node.get_parent().add_child(n2)
	node.get_parent().add_child(n3)
	return ar


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
			var pointI = initial_point + incI + inc;
			var pointD = initial_point + incD + inc;
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
			lightD.position = pointI;
			bridge.add_child(lightD);
