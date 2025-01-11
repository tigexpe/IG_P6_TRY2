extends Node3D

var start_point : Vector3
var end_point : Vector3
var speed : float = 6
var vector_speed : Vector3
var wait_time_speed : float = 2.0
var time_toxic : float = 4
var size : Vector3 = Vector3(8,2,8)
var s2_my_platforms : String = "NOUP"


var time_last_creation : float = 0.0
var time_now : float = 0.0
var creation_delay : float
var MAX_PLATFORMS : int = 1
var num_platforms : int = 0


var Plataforma_Script = preload("res://scripts/cripta_sala_2/plataforma_toxica.gd")



func _process(delta_time : float):
	time_now += delta_time
	num_platforms = self.get_child_count()
	if num_platforms < MAX_PLATFORMS:
		var dt = time_now - time_last_creation
		if dt > creation_delay:
			var child = Plataforma_Toxica.new()
			child.PrepareNode(start_point,end_point,speed,wait_time_speed,time_toxic,size,s2_my_platforms)
			add_child(child)
			time_last_creation = time_now

func prepare(sp : Vector3 , ep : Vector3 , s : float , wts : float , tt : float , sz : Vector3 , s2 : String):
	start_point = sp
	end_point = ep
	speed = s
	wait_time_speed = wts
	time_toxic = tt
	size = sz
	s2_my_platforms = s2

func MaxPrepare(cd : float , M : int , sp : Vector3 , ep : Vector3 , s : float , wts : float , tt : float , sz : Vector3 , s2 : String):
	creation_delay = cd
	MAX_PLATFORMS = M
	prepare(sp,ep,s,wts,tt,sz,s2)
