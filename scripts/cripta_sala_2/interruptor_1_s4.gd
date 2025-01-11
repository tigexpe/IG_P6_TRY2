extends Node3D
signal solved

var State_Solved : String = "Unsolved"
var interaction_radius : float = 8.0
var player : Node3D = null
var is_light_on = false

@onready var light = $Light
@onready var body = $Body
@onready var collider = $Body/Collider

func Set_Start(ir : float , en : float , r : float , color : String):
	interaction_radius = ir
	light.light_energy = en
	light.omni_range = r
	light.light_color = Color(color)
	light.shadow_enabled = true

func _ready():
	is_light_on = false
	if light:
		light.visible = false
	player = get_tree().root.get_child(0).get_node("CharaCamera1/Body")
	body.add_to_group("Toggeable")

func toggle_bullet(body):
	if body.is_in_group("Balas"):
		toggle_light()

func is_player_near() -> bool:
	if not player:return false
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	
	var vec_distance = global_transform.origin - player.global_transform.origin
	var Y_UP_transform : Vector3 = global_transform.basis * Vector3.UP
	var Y_new_dist = Y_UP_transform.dot(vec_distance)
	var V_new_dist = vec_distance.length()
	var a_R = V_new_dist * V_new_dist - Y_new_dist * Y_new_dist
	a_R = sqrt(a_R)
	return a_R <= interaction_radius

func toggle_light():
	is_light_on = !is_light_on
	light.visible = is_light_on
	if is_light_on:
		Solve_Light()

func light_now() -> bool : return is_light_on

func _process(tria : float) -> void:
	if is_player_near():
		if Input.is_action_just_pressed("chara1_interacts"):
			toggle_light()

func Solve_Light():
	if State_Solved == "Unsolved":
		get_parent().get_parent().get_node("Cripta_Sala_3").Solve1()
		State_Solved = "Solved"
		solved.emit();
