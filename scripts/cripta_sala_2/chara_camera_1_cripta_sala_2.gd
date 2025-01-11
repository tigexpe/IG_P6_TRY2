extends CharacterBody3D
func Separador(): print("#------------------------------------------------------#")

@onready var Skeleton = $Mesh/PlayerAnimation

var mouse_sensitivity : float = 0.2
var yaw1 : float = 0.0
var pitch1 : float = 0.0
@onready var my_camera1 = $Camera1
var is_mouse_captured : bool = false

var states1 : Dictionary = {
	"idle" : null,
	"walking" : null,
	"running" : null,
}

var states2 : Dictionary = {
	"normal_movements" : null,
	"weightless_testing" : null,
}

var now_second_status : String = "normal_movements"

var states3 : Dictionary

var v_actual : Vector3

var gravity : Vector3 = Vector3(0,-9.8,0)

var horizontal_speed : float
var vertical_speed : float
var state : String
var previous_state : String

var speed_change : float


var mass : float = 80
var jumpable_before : int = 0


func horizontal_direction() -> Vector3:
	var direction = Vector3.ZERO
	if Input.is_action_pressed("chara1_moves_back"):
		direction.z += 1
	if Input.is_action_pressed("chara1_moves_left"):
		direction.x -= 1
	if Input.is_action_pressed("chara1_moves_right"):
		direction.x += 1
	if Input.is_action_pressed("chara1_moves_front"):
		direction.z -= 1
	direction = direction.normalized()
	return direction
	

func horizontal_direction_camera() -> Vector3:
	var r1 : Vector3 = horizontal_direction()
	if r1 == Vector3.ZERO:
		return r1
	var now_basis = my_camera1.global_transform.basis
	var camera_forward : Vector3 = now_basis.z
	var camera_right : Vector3 = now_basis.x
	camera_forward.y = 0
	camera_right .y = 0
	camera_forward = camera_forward.normalized()
	camera_right = camera_right.normalized()
	
	var r2 : Vector3 = camera_forward + camera_right
	var r3 : Vector3 = (r1.z * camera_forward + r1.x * camera_right)
	
	return r3

func capture_mouse():
	is_mouse_captured = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func release_mouse():
	is_mouse_captured = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseMotion and is_mouse_captured:
		Update_Camera(event)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				capture_mouse()
			else:
				release_mouse()
		if event.button_index == MOUSE_BUTTON_WHEEL_UP or event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			Update_Camera_fov(event)

func Update_Camera(event):
	yaw1 -= event.relative.x * mouse_sensitivity
	pitch1 = clamp(pitch1 - event.relative.y * mouse_sensitivity, -89 , 89)
	
	rotation_degrees.y = yaw1
	my_camera1.rotation_degrees.x = pitch1

# Valores para el FOV de la cámara
const MIN_FOV = 20.0  # Más cerca
const MAX_FOV = 90.0  # Más lejos
const FOV_STEP = 2.0  # Incremento 
func Update_Camera_fov(event):
	var fov = my_camera1.fov
	if event.button_index == MOUSE_BUTTON_WHEEL_UP and fov > MIN_FOV:
		my_camera1.fov -= FOV_STEP
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and fov < MAX_FOV:
		my_camera1.fov += FOV_STEP

# ------------------------------------------------------------------------

func Change_Weapon():
	if Input.is_action_just_pressed("chara1_changes_weapon"):
		if pistola == "pistola1": pistola = "pistola2"
		elif pistola == "pistola2": pistola = "pistola1"

func gravity_applied(delta_time : float) -> Vector3:
	var jump_force = 4.9
	var direction = Vector3.ZERO
	if is_on_floor():
		if Input.is_action_just_pressed("chara1_jumps"):
			direction.y = jump_force
	else:
		direction = gravity * delta_time
	return direction

func Jump_Applied() -> Vector3:
	var jf = 10
	jf = 1000
	jf = 100
	jf = 89
	var max_jumpable : int = 2
	max_jumpable = 1
	var min_jumpable : int = 0
	if is_on_floor() and Input.is_action_just_pressed("chara1_jumps"):
		jumpable_before = max_jumpable
		return Vector3(0,jf,0)
	elif jumpable_before > min_jumpable:
		jumpable_before -= 1
		return Vector3(0,jf,0)
	else:
		jumpable_before = min_jumpable
		return Vector3.ZERO

func Watch_Collisions_And_Colliders():
	var now_friction : float = 0
	var count_range = get_slide_collision_count()
	var new_count = count_range
	for i in range(count_range):
		var collision = get_slide_collision(i)
		var objeto = collision.get_collider()
		if objeto:
			if objeto.has_method("get_friction"):
				now_friction += objeto.get_friction()
	if is_on_floor():
		new_count += 1



func normal_this_surface() -> Vector3:
	if is_on_floor():
		return get_floor_normal()
	elif get_slide_collision_count()>0:
		return get_slide_collision(0).get_normal()
	else:
		return Vector3.ZERO

func Contrarrestar_Gravedad(v:Vector3)->Vector3:
	var r = Vector3.ZERO
	var on_floor_now = is_on_floor()
	if on_floor_now:
		r.y = - v_actual.y
	return r

func Horizontal_Velocity(v : Vector3) -> Vector3: return ( v - Vertical_Velocity(v) )

func Horizontal_Speed(v : Vector3) -> float: return Horizontal_Velocity(v).length()

func Vertical_Velocity(v : Vector3) -> Vector3:
	var normal_up = -gravity.normalized()
	return v.dot(normal_up) * normal_up
	
func Vertical_Speed(v : Vector3) -> float: return Vertical_Velocity(v).length()

const collider_radius : float = 0.8
const collider_height : float = 3.2
func add_collider(color : Color):
	
	var collider = $Body/Collider
	collider = $Collider
	var mesh = $Body/Mesh
	mesh = $Mesh
	
	add_just_collider(collider)
func add_just_collider(collider):
	if now_second_status == "normal_movements":
		collider.shape = CapsuleShape3D.new()
		collider.shape.radius = collider_radius
		collider.shape.height = collider_height
func delete_just_collider(collider):
	collider.shape = null


func _ready() -> void:
	state = "idle"
	previous_state = "idle"
	states1 = { "idle" : 0.0, "walking" : 3.5, "running" : 9.2, }
	states1 = { "idle" : 0.0, "walking" : 35.0, "running" : 92.0, }
	states1 = { "idle" : 0.0, "walking" : 15.0, "running" : 30.0, }
	horizontal_speed = states1[state]
	vertical_speed = 0
	speed_change = 1.3
	speed_change *= 5
	mass = 2
	v_actual = Vector3.ZERO
	jumpable_before = 0
	
	# SETTING GAME STATE
	now_second_status = "flying_test"
	now_second_status = "normal_movements"
	
	bullet_material = StandardMaterial3D.new()
	bullet_material.albedo_color = Color_Aleatorio()
	
	var sala6 = get_parent().get_parent().get_node("Cripta_Sala_6");
	sala6.solved.connect(nowCanFly);

func Color_Aleatorio() -> Color:
	var r = randf_range(0,1)
	var g = randf_range(0,1)
	var b = randf_range(0,1)
	return Color(r,g,b)

func Flying_Test(delta : float) -> void:
	v_actual = Vector3.ZERO
	var hd : Vector3 = horizontal_direction()
	hd = horizontal_direction_camera()
	
	# UPDATING KEY STATE
	var run_key_pushed : bool = Input.is_action_pressed("chara1_runs_key")
	var move_key_pushed : bool = hd != Vector3.ZERO
	if not move_key_pushed:
		state = "idle"
	else:
		state = "walking"
		if run_key_pushed:
			state = "running"
	
	
	if state == "idle":
		#Skeleton.way_state = "leviton"
		Skeleton.change_way_state("leviton")
	if state == "walking":
		#Skeleton.way_state = "leviton"
		Skeleton.change_way_state("leviton")
	if state == "running":
		#Skeleton.way_state = "running_flying"
		Skeleton.change_way_state("running_flying")
	
	var Unit_Normal : Vector3 = normal_this_surface()
	var direction_plane
	var path : String
	if hd == Vector3.ZERO: direction_plane = Vector3.ZERO
	elif not is_on_floor(): direction_plane = hd
	else: direction_plane = hd
	
	var hor_actual = Horizontal_Velocity(v_actual)
	var ver_actual = Vertical_Velocity(v_actual)
	v_actual = direction_plane * states1[state] + ver_actual
	horizontal_speed = Horizontal_Speed(v_actual)
	vertical_speed = Vertical_Speed(v_actual)
	
	
	var Fly_Force_UP : Vector3 = Vector3(0,50,0)
	var Fly_Force_DOWN : Vector3 = Vector3(0,-50,0)
	if Input.is_action_pressed("chara1_flys_up"):
		v_actual += Fly_Force_UP
		#Skeleton.way_state = "ascension"
		Skeleton.change_way_state("ascension")
	if Input.is_action_pressed("chara1_flys_down"):
		v_actual += Fly_Force_DOWN
		#Skeleton.way_state = "descenso"
		Skeleton.change_way_state("descenso")
	#if Input.is_action_just_pressed("rueda_arriba"):
	#	v_actual += Fly_Force_UP
	#if Input.is_action_just_pressed("rueda_abajo"):
	#	v_actual += Fly_Force_DOWN
	
	velocity = v_actual * 4
	move_and_slide()
	
	Load_And_Throw_Bomb();
	
			
func Normal_Work(delta : float) -> void:
	
	var vsub0ac : Vector3 = v_actual
	
	var hd : Vector3 = horizontal_direction()
	hd = horizontal_direction_camera()
	
	# UPDATING KEY STATE
	var run_key_pushed : bool = Input.is_action_pressed("chara1_runs_key")
	var move_key_pushed : bool = hd != Vector3.ZERO
	if not move_key_pushed:
		state = "idle"
	else:
		state = "walking"
		if run_key_pushed:
			state = "running"
	
	#if state == "idle": Skeleton.way_state = "idle"
	#if state == "walking": Skeleton.way_state = "walking"
	#if state == "running": Skeleton.way_state = "running"
	#Skeleton.way_state = state;
	Skeleton.change_way_state(state);
	
	
	
	# CALCULATING FORCES
	var Peso : Vector3 = mass * gravity
	
	var Unit_Normal : Vector3 = normal_this_surface()
	
	var direction_plane
	if hd == Vector3.ZERO: direction_plane = Vector3.ZERO
	elif not is_on_floor(): direction_plane = hd
	else: direction_plane = hd
	
	var anti_gravity = Contrarrestar_Gravedad(v_actual)
	v_actual += anti_gravity
	
	var jUMP
	var delta_time : float = 1
	var hor_actual = Horizontal_Velocity(v_actual)
	var ver_actual = Vertical_Velocity(v_actual)
	v_actual = direction_plane * states1[state] + ver_actual
	
	if not is_on_floor(): v_actual += gravity * delta_time
	else: v_actual.y = 0
	
	jUMP = Jump_Applied()
	v_actual += jUMP
	
	if jUMP != Vector3.ZERO:
		Skeleton.change_way_state("jumping")
	
	horizontal_speed = Horizontal_Speed(v_actual)
	vertical_speed = Vertical_Speed(v_actual)
	
	velocity = v_actual
	move_and_slide()
	




#~--------------------------------------------------------------
#~--------------------------------------------------------------
#~--------------------------------------------------------------
#~--------------------------------------------------------------
#~--------------------------------------------------------------
var bullet_radius = 0.1
var bullet_height = 0.3
var bullet_force = Vector3(80,80,-80)
var bullet_material
var bullet = preload("res://scripts/cripta_sala_2/bullet.gd")
func Calculate_Shot():
	var papi = self.get_parent()
	var camera_vector = -$Camera1.transform.basis.z
	camera_vector = $Camera1.project_local_ray_normal(Vector2(0,0))
	
	var viewport_rect = get_viewport().get_visible_rect()
	var screen_center = viewport_rect.size * 0.5
	camera_vector = $Camera1.project_ray_normal(screen_center)
	
	var can_shoot:bool = Skeleton.block_way_state2 == false
	can_shoot = Skeleton.block_way_state == false
	
	if Input.is_action_pressed("chara1_shots") and pistola == "pistola2" and can_shoot:
		Skeleton.change_way_state2("shot2")
		var b = bullet.new()
		var boca_pistola = 2 * collider_radius * camera_vector
		boca_pistola = $Camera1.global_transform.origin
		boca_pistola = global_transform.origin + collider_height * Vector3.UP
		b.SetAndInstance(get_tree().root.get_child(0),boca_pistola,bullet_radius,bullet_height,80*camera_vector,bullet_material)
	elif Input.is_action_just_pressed("chara1_shots") and pistola == "pistola1" and can_shoot:
		Skeleton.change_way_state2("shot")
		var b = bullet.new()
		var boca_pistola = 2 * collider_radius * camera_vector
		boca_pistola = $Camera1.global_transform.origin
		boca_pistola = global_transform.origin + collider_height * Vector3.UP
		b.SetAndInstance(get_tree().root.get_child(0),boca_pistola,bullet_radius,bullet_height,80*camera_vector,bullet_material)
	else:
		Skeleton.change_way_state2("idle")
		
		

var time_from_last_bullet : float = 0
var time_bullet_1 : float = 1
var pistola : String = "pistola1"

func _process(delta : float) -> void:
	Change_Weapon()
	time_from_last_bullet += delta
	Change_Power()
	
	if now_second_status == "normal_movements":
		Normal_Work(delta)
	elif now_second_status == "flying_test":
		Flying_Test(delta)
	
	Calculate_Shot()
	
	Calculate_Illuminate()


var fly_available : bool = false;
func Change_Power():
	#if Input.is_action_just_pressed("chara1_changes_to_power"):
	if Input.is_action_just_pressed("chara1_changes_to_power") and fly_available:
		if now_second_status == "normal_movements":
			now_second_status = "flying_test"
			var collider = $Collider
			#if collider.shape:delete_just_collider(collider)
		elif now_second_status == "flying_test":
			now_second_status = "normal_movements"
			var collider = $Collider
			if not collider.shape:
				add_just_collider(collider)

var illuminating = false
var node_fire_ball : Node3D
var fire : OmniLight3D
func Calculate_Illuminate():
	if not node_fire_ball:
		node_fire_ball = Node3D.new()
		fire = OmniLight3D.new()
		fire.light_energy = 50
		fire.omni_range = 50
		fire.light_color = Color("ff0000")
		fire.shadow_enabled = true
		node_fire_ball.add_child(fire)
	node_fire_ball.position = 3 * Vector3.UP
		
	if Input.is_action_just_pressed("chara1_fires_up"):
		illuminating = ! illuminating
		if illuminating:
			add_child(node_fire_ball)
			Skeleton.change_way_state("mago_invoka_bola")
		else:
			remove_child(node_fire_ball)
			Skeleton.change_way_state("mago_consume_bola")

func Load_And_Throw_Bomb():
	if Input.is_action_just_pressed("chara1_bombs"):
		Skeleton.change_way_state("bomba_cargar")

func nowStartExploring():
	now_second_status = "normal_movements";

func nowCanFly():
	fly_available = true;
