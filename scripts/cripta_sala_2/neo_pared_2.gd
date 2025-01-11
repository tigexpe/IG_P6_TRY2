extends Node3D
signal hitted

func Toggle_Basic_Illumination(node_world_env,body):
	hitted.emit();


func _ready():
	Instance_Box()

var box1 : CSGBox3D;
var box2 : CSGBox3D;
var box3 : CSGBox3D;

func Instance_Box():
	var box = $CSGBox3D
	var door_cut = CSGBox3D.new()
	door_cut.operation = CSGShape3D.OPERATION_SUBTRACTION
	door_cut.position = Vector3.ZERO
	door_cut.size = Vector3(2,2,80000)
	box1 = door_cut;
	
	door_cut = CSGBox3D.new()
	door_cut.operation = CSGShape3D.OPERATION_SUBTRACTION
	door_cut.position = Vector3(-3,3,0)
	door_cut.size = Vector3(2,2,80000)
	box2 = door_cut;
	
	door_cut = CSGBox3D.new()
	door_cut.operation = CSGShape3D.OPERATION_SUBTRACTION
	door_cut.position = Vector3(3,-3,0)
	door_cut.size = Vector3(2,2,80000)
	box3 = door_cut;

func Solve():
	var box = $CSGBox3D
	box.add_child(box1);
	box.add_child(box2);
	box.add_child(box3);
