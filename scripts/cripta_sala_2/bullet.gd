class_name Bullet
extends Node3D

var state = "NOUP"
func _process(delta_f:float):
	if state != "NOUP":
		print(state)

var body : RigidBody3D
var collider : CollisionShape3D
var mesh : MeshInstance3D

var force_shot : Vector3
var radius : float
var height : float
var mass : float = 1.0

func Create():
	body = RigidBody3D.new()
	body.mass = mass
	collider = CollisionShape3D.new()
	mesh = MeshInstance3D.new()
	body.add_child(collider)
	body.add_child(mesh)
	self.add_child(body)
	
	collider.shape = CapsuleShape3D.new()
	collider.shape.height = height
	collider.shape.radius = radius
	mesh.mesh = CapsuleMesh.new()
	mesh.mesh.height = height
	mesh.mesh.radius = radius
	
	body.contact_monitor = true
	body.max_contacts_reported = 5
	body.body_entered.connect(Destroy)

func Destroy(body : Node):
	state = "DESTRUCTIBLE"
	self.queue_free()
	if body.is_in_group("Toggeable"):
		body.get_parent().toggle_bullet(self)
	elif body.is_in_group("BIlluminator"):
		var world_environment = get_tree().root.get_node("Cripta/WorldEnvironment")
		world_environment.toggle_bullet(self)
		var node_touched = body.get_parent();
		node_touched.Toggle_Basic_Illumination(world_environment,self);

func set_vars(p : Vector3 , r : float , h : float , fs : Vector3):
	global_transform.origin = p
	radius = r
	height = h
	force_shot = fs

func shot():
	body.apply_central_impulse(force_shot)

func assign_material(material):
	mesh.material_override = material

func SetAndInstance(father : Node3D , p : Vector3 , r : float , h : float , fs : Vector3 , material):
	set_vars(p,r,h,fs)
	Create()
	assign_material(material)
	father.add_child(self)
	shot()
	add_to_group("Balas")
	pass
