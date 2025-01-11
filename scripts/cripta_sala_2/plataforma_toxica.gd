class_name Plataforma_Toxica
extends Node3D

var Total_State : String = "Limbus"

var start_position : Vector3
var end_position : Vector3
var here_position
var speed : float
var vector_speed : Vector3
var wait_time_speed : float
var speed_state : String
var speed2_state : String
var time_speed_now : float = 0.0

var damage_force : float = 10

var time_toxic : float
var time_toxic_now : float = 0.0
var toxic_state : bool


var body : AnimatableBody3D
var collider : CollisionShape3D
var mesh : MeshInstance3D

var size : Vector3


var color_veneno = "7c007c"
var color_no_veneno = "1b3837"



func _ready():
	Activate_Node()

func _process(delta_time : float):
	
	if Total_State == "Nullified":
		queue_free()
	elif Total_State == "Active":
	
		
		#pass
		time_toxic_now += delta_time
		if time_toxic_now >= time_toxic:
			toxic_state = !toxic_state
			time_toxic_now = 0
			if toxic_state:
				mesh.material_override.albedo_color = Color(color_veneno)
			else:
				mesh.material_override.albedo_color = Color(color_no_veneno)
		
		time_speed_now += delta_time
		if speed2_state == "Pendulus":
			if speed_state == "Forward":
				body.position += vector_speed * speed * delta_time
				here_position = body.position
				var diff_n = (here_position - start_position).length()
				var diff_t = (end_position - start_position).length()
				if diff_n >= diff_t:
					speed_state = "Wait_Forward"
					time_speed_now = 0.0
			elif speed_state == "Wait_Forward":
				if false:
					if body.global_transform.origin != end_position:
						body.global_transform.origin = end_position
				if body.position != end_position:
					body.position = end_position
				if time_speed_now >= wait_time_speed:
					speed_state = "Backward"
					time_speed_now = 0.0
					vector_speed = (-vector_speed).normalized()
			elif speed_state == "Backward":
				body.position += vector_speed * speed * delta_time
				here_position = body.position
				var diff_n = (here_position - end_position).length()
				var diff_t = (start_position - end_position).length()
				if diff_n >= diff_t:
					speed_state = "Wait_Backward"
					time_speed_now = 0.0
			elif speed_state == "Wait_Backward":
				if false:
					if body.global_transform.origin != start_position:
						body.global_transform.origin = start_position
				if body.position != start_position:
					body.position = start_position
				if time_speed_now >= wait_time_speed:
					speed_state = "Forward"
					time_speed_now = 0.0
					vector_speed = (-vector_speed).normalized()
				
			
		elif speed2_state == "Linear_Create_End":
			if false:
				if speed_state == "Start_Forward":
					speed_state = "Forward"
			if speed_state == "Forward":
				if false:
					body.global_transform.origin += vector_speed * speed * delta_time
					here_position = body.global_transform.origin
				body.position += vector_speed * speed * delta_time
				here_position = body.position
				var diff_n = (here_position - start_position).length()
				var diff_t = (end_position - start_position).length()
				if diff_n >= diff_t:
					Deactivate_Node()

func Activate_Node():
	if Total_State == "Prepared":
		if speed2_state == "Pendulus":
			var r = "Active"
			var s = "Forward"
			set_vars(r,s)
		elif speed2_state == "Linear_Create_End":
			var r = "Active"
			var s = "Forward"
			set_vars(r,s)
		else:
			Deactivate_Node()
func Deactivate_Node():
	Total_State = "Nullified"
	queue_free()

func Default_Variables():
	here_position = start_position
	time_speed_now = 0.0
	time_toxic_now = 0.0

func set_vars(t_state : String , state : String):
	Total_State = t_state
	speed_state = state
	Default_Variables()
	
	body = AnimatableBody3D.new()
	collider = CollisionShape3D.new()
	collider.shape = BoxShape3D.new()
	collider.shape.size = self.size
	mesh = MeshInstance3D.new()
	mesh.mesh = BoxMesh.new()
	mesh.mesh.size = self.size
	mesh.material_override = StandardMaterial3D.new()
	mesh.material_override.albedo_color = Color(0.8,0.8,0.8)
	
	body.position = here_position
	
	body.add_child(collider)
	body.add_child(mesh)
	self.add_child(body)

func PrepareNode(sp : Vector3 , ep : Vector3 , s : float , wts : float , tt : float , sz : Vector3 , s2 : String):
	start_position = sp
	end_position = ep
	speed = s
	vector_speed = (ep - sp).normalized()
	wait_time_speed = wts
	time_toxic = tt
	size = sz
	Total_State = "Prepared"
	speed2_state = s2
