extends WorldEnvironment

var basic_iumination_array = [ "87a800" , "000000" ]
var actual_ilumination_basic = 0
var first_toggled : bool = false;
func Toggle_Basic_Ilumination():
	if not first_toggled:
		actual_ilumination_basic = (actual_ilumination_basic+1)%basic_iumination_array.size()
		environment.ambient_light_color = Color(basic_iumination_array[actual_ilumination_basic])
		first_toggled = true;
		solved_state = "one_state";

func toggle_bullet(body):
	if body.is_in_group("Balas"):
		Toggle_Basic_Ilumination()

func _ready():
	environment.ambient_light_energy = 0.1
	solved_state = "zero_state";
	var solver1 = get_parent().get_node("Cripta_Sala_4/Interruptor1")
	var solver2 = get_parent().get_node("Cripta_Sala_5/Interruptor1")
	var solver3 = get_parent().get_node("Cripta_Sala_6")
	
	solver1.solved.connect(Solve)
	solver2.solved.connect(Solve)
	solver3.solved.connect(Solve)
	
	

var energies : Array = [ 0 , 0.1 , 0.2 , 0.3 , 1 ];
var colors : Array = [ "000000" , "87a800" , "87a800" , "96bb00" , "ffffff" ]
var pos : int = 1;

func Toggle_Env(u : int):
	pos = u;
	Set_Env()
func Set_Env():
	environment.ambient_light_color = Color(colors[pos]);
	environment.ambient_light_energy = energies[pos];


var solved_state : String = "zero_state";
var time_state : float = 0
var random_init_t : float = 0
var sl : float = 20
func _process(delta : float):
	sl = 80
	#sl = 0
	var rsl = randf();
	var random_value : float = randf();
	
	time_state += delta;
	if solved_state == "semi_one":
		environment.ambient_light_color = Color("87a800")
		environment.ambient_light_energy = rsl * sl;
		if time_state >= 5:
			time_state = -0.5
			solved_state = "one_state"
	
	if solved_state == "one_state":
		if random_init_t < 0.4:
			random_init_t += delta/2;
		else:
			solved_state = "two_state";
			time_state = -0.5
		if random_value < random_init_t:
			environment.ambient_light_color = Color("000000")
			environment.ambient_light_energy = 0.1;
		else:
			environment.ambient_light_color = Color("87a800")
			environment.ambient_light_energy = rsl * sl;
	elif solved_state == "two_state":
		if time_state >= 5:
			time_state = -0.5
			solved_state = "three_state"
			var chara = get_parent().get_node("CharaCamera1/Body")
			chara.nowStartExploring();
			var sala2 = get_parent().get_node("Cripta_Sala_2").RemoveLastWall();
		else:
			if random_value < 0.5:
				environment.ambient_light_color = Color("000000")
				environment.ambient_light_energy = 0.1;
			else:
				environment.ambient_light_color = Color("87a800")
				environment.ambient_light_energy = rsl * sl;
	elif solved_state == "three_state":
		environment.ambient_light_color = Color("000000")
		environment.ambient_light_energy = 0.1;
	elif solved_state == "three_and_half_state":
		environment.ambient_light_color = Color("87a800")
		environment.ambient_light_energy = 0.1;
	elif solved_state == "four_state":
		environment.ambient_light_color = Color("ffffff")
		environment.ambient_light_energy += 0.01;
		if environment.ambient_light_energy >= 1.0:
			environment.ambient_light_energy = 1.0;

var Solved_Interruptors : int = 0
func Solve():
	Solved_Interruptors += 1;
	if Solved_Interruptors >= 3:
		solved_state = "four_state";
	elif Solved_Interruptors >=2:
		solved_state = "three_and_half_state";
		var box_revealed = get_parent().get_node("Cripta_Sala_2/NeoPared2");
		box_revealed.Solve();
