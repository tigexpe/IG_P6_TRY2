extends Node3D

const VX : Vector3 = Vector3(1,0,0)
const VY : Vector3 = Vector3(0,1,0)
const VZ : Vector3 = Vector3(0,0,1)

const DVT : int = 1
const DVC : int = 2
const DVBI1 : int = 3
const DVBI2 : int = 4
const DVBD1 : int = 5
const DVBD2 : int = 6
const DVPI1 : int = 7
const DVPI2 : int = 8
const DVPD1 : int = 9
const DVPD2 : int = 10

@onready var _point_tronco : Node3D = $Tronco
@onready var _point_cabeza : Node3D = $Tronco/Cabeza
@onready var _point_bi1 : Node3D = $Tronco/BIzq1
@onready var _point_bi2 : Node3D = $Tronco/BIzq1/BIzq2
@onready var _point_bd1 : Node3D = $Tronco/BDer1
@onready var _point_bd2 : Node3D = $Tronco/BDer1/BDer2
@onready var _point_pi1 : Node3D = $Tronco/PIzq1
@onready var _point_pi2 : Node3D = $Tronco/PIzq1/PIzq2
@onready var _point_pd1 : Node3D = $Tronco/PDer1
@onready var _point_pd2 : Node3D = $Tronco/PDer1/PDer2

func Vindex(u : int) -> Node3D:
	match u:
		DVT:
			return _point_tronco
		DVC:
			return _point_cabeza
		DVBI1:
			return _point_bi1
		DVBI2:
			return _point_bi2
		DVBD1:
			return _point_bd1
		DVBD2:
			return _point_bd2
		DVPI1:
			return _point_pi1
		DVPI2:
			return _point_pi2
		DVPD1:
			return _point_pd1
		DVPD2:
			return _point_pd2
		_:
			return null

func _ready() -> void:
	Containers_Ready()


var _size = 50
var _size2 = 10
func Containers_Ready():
	Ax.resize(_size)
	vi.resize(_size)
	per.resize(_size)
	parte.resize(_size)
	ang.resize(_size)
	ang_i.resize(_size)
	d.resize(_size)
	AxC.resize(_size)
	dC.resize(_size)
	viC.resize(_size)
	V.resize(_size2)

var Ax : Array = [ Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO , Vector3.ZERO ]
var vi : Array = [ int(0) , int(0) , int(0) , int(0) , int(0) , int(0) , int(0) , int(0) , int(0) , int(0)]
var pert : float = 1.0
var per : Array = [ float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0)]
var parte : Array = [ false , false , false , false , false , false , false , false , false , false ]
var ang : Array = [ float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0)]
var ang_i : Array = [ float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0)]
var d : Array = [ float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0) , float(0)]

var AxC : Array = [ [] , [] , [] , [] , [] , [] , [] , [] , [] , [] ]
var dC : Array = [ [] , [] , [] , [] , [] , [] , [] , [] , [] , [] ]
var viC : Array = [ [] , [] , [] , [] , [] , [] , [] , [] , [] , [] ]

var V : Array = [ [] , [] , [] , [] , [] , [] , [] , [] , [] , [] ]

func UF1():
	for i in range(Ax.size()):Ax[i] = Vector3.ZERO
	for i in range(vi.size()):vi[i] = int(0)
	for i in range(per.size()):per[i] = float(0)
	for i in range(parte.size()):parte[i] = false
	for i in range(ang.size()):ang[i] = float(0)
	for i in range(ang_i.size()):ang_i[i] = float(0)
	for i in range(d.size()):d[i] = float(0)
	for i in range(AxC.size()):AxC[i] = []
	for i in range(dC.size()):dC[i] = []
	for i in range(viC.size()):viC[i] = []
	for i in range(V.size()):V[i] = []
	
	for i in range(DVT,DVPD2+1,1):
		var n : Node3D = Vindex(i)
		if n:
			n.rotation = Vector3.ZERO
	Vindex(DVT).position = Vector3.ZERO

func UF2():
	for i in range(d.size()):d[i] = ang[i]*per[i]+ang_i[i]

func Animation_1(p : float):pass
func Body_Func_1(p : float):
	
	Ax[0] = VY
	Ax[10] = -VZ
	Ax[2] = -VZ
	
	
	Ax[4] = -VZ
	
	
	Ax[6] = -VZ
	
	Ax[8] = -VZ
	Ax[9] = -VZ
	
	
	
	ang [0] = 80;
	ang_i[0] = 0
	ang [10] = -20
	ang_i[10] = 0
	
	
	ang [2] = 40
	ang_i[2] = 0
	
	
	ang [4] = -170
	ang_i[4] = 0
	
	
	ang [6] = 40
	ang_i[6] = 0
	
	ang [8] = 0
	ang_i[8] = 0
	
	ang [9] = 35
	ang_i[9] = 0
	
	
	per[0] = p
	per[10] = p
	per[1] = p
	per[2] = p
	per[3] = p
	per[4] = p
	per[5] = p
	per[6] = p
	per[7] = p
	per[8] = p
	per[9] = p
	
	
	V[0] = [0,10]
	V[1] = [1]
	V[2] = [2]
	V[3] = [3]
	V[4] = [4]
	V[5] = [5]
	
	V[6] = [6]
	V[7] = [7]
	V[8] = [8]
	V[9] = [9]


func Animation_2(p : float):pass
func Body_Func_2(p : float):
	
	Ax[0] = VY
	Ax[10] = -VZ
	Ax[2] = -VZ
	Ax[4] = -VZ
	Ax[6] = -VZ
	Ax[8] = -VZ
	Ax[9] = -VZ
	
	
	
	ang [0] = 10
	ang_i[0] = 80
	ang [10] = 20
	ang_i[10] = -20
	
	ang [4] = 90
	ang_i[4] = -170
	
	ang [2] = 60
	ang_i[2] = 40
	
	ang [8] = 0
	ang_i[8] = 0
	
	ang [9] = -35
	ang_i[9] = 35
	
	ang [6] = -25
	ang_i[6] = 40
	
	
	
	per[0] = p
	per[1] = p
	per[2] = p
	per[3] = p
	per[4] = p
	per[5] = p
	per[6] = p
	per[7] = p
	per[8] = p
	per[9] = p
	per[10] = p
	
	V[0] = [0,10]
	V[1] = [1]
	V[2] = [2]
	V[3] = [3]
	V[4] = [4]
	V[5] = [5]
	V[6] = [6]
	V[7] = [7]
	V[8] = [8]
	V[9] = [9]


func Animation_3(p : float):pass
func Body_Func_3(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VZ;
	Ax[3] = VX;
	Ax[4] = VZ;
	Ax[5] = VX;
	Ax[6] = VY;
	Ax[10] = VX;
	Ax[7] = VX;
	Ax[8] = VY;
	Ax[11] = VX;
	Ax[9] = VX;
	
	
	
	ang [0] = -20
	ang_i[0] = 0
	ang [1] = 30
	ang_i[1] = 0
	ang [2] = -60
	ang_i[2] = 0;
	ang [3] = 100
	ang_i[3] = 0
	ang [4] = 70
	ang_i[4] = 0
	ang [5] = 100
	ang_i[5] = 0
	ang [6] = 20
	ang_i[6] = 0
	ang [10] = 80
	ang_i[10] = 0
	ang [7] = -100
	ang_i[7] = 0
	ang [8] = -20
	ang_i[8] = 0
	ang [11] = 80
	ang_i[11] = 0
	ang [9] = -100
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	
	V[0] = [0]
	V[1] = [1]
	V[2] = [2]
	V[3] = [3]
	V[4] = [4]
	V[5] = [5]
	V[6] = [6,10]
	V[7] = [7]
	V[8] = [8,11]
	V[9] = [9]


func Animation_4(p : float):pass
func Body_Func_4(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VZ;
	Ax[10] = VX;
	Ax[3] = VX;
	Ax[4] = VZ;
	Ax[11] = VX;
	Ax[5] = VX;
	Ax[6] = VY;
	Ax[12] = VX;
	Ax[7] = VX;
	Ax[8] = VY;
	Ax[13] = VX;
	Ax[9] = VX;
	
	
	
	ang [0] = -10
	ang_i[0] = 0
	ang [1] = 10
	ang_i[1] = 0
	ang [2] = -20
	ang_i[2] = 0;
	ang [10] = -20;
	ang_i[10] = 0;
	ang [3] = 20
	ang_i[3] = 0
	ang [4] = 20
	ang_i[4] = 0
	ang [11] = -20;
	ang_i[11] = 0;
	ang [5] = 20
	ang_i[5] = 0
	ang [6] = 20
	ang_i[6] = 0
	ang [12] = 20
	ang_i[12] = 0
	ang [7] = -50
	ang_i[7] = 0
	ang [8] = -20
	ang_i[8] = 0
	ang [13] = 20
	ang_i[13] = 0
	ang [9] = -50
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	per[12] = p;
	per[13] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6,12];
	V[7] = [7];
	V[8] = [8,13];
	V[9] = [9];


func Animation_5(p : float):pass
func Body_Func_5(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VZ;
	Ax[10] = VX;
	Ax[3] = VX;
	Ax[4] = VZ;
	Ax[11] = VX;
	Ax[5] = VX;
	Ax[6] = VY;
	Ax[6] = VZ;
	Ax[12] = VX;
	Ax[7] = VX;
	Ax[8] = VY;
	Ax[8] = VZ;
	Ax[13] = VX;
	Ax[9] = VX;
	
	
	
	ang [0] = -40
	ang_i[0] = 0
	ang [1] = 40
	ang_i[1] = 0
	ang [2] = -20
	ang_i[2] = 0;
	ang [10] = -20;
	ang_i[10] = 0;
	ang [3] = 0
	ang_i[3] = 0
	ang [4] = 20
	ang_i[4] = 0
	ang [11] = -20;
	ang_i[11] = 0;
	ang [5] = 0
	ang_i[5] = 0
	ang [6] = -10
	ang_i[6] = 0
	ang [12] = -20
	ang_i[12] = 0
	ang [7] = -10
	ang_i[7] = 0
	ang [8] = 10
	ang_i[8] = 0
	ang [13] = -20
	ang_i[13] = 0
	ang [9] = -10
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	per[12] = p;
	per[13] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6,12];
	V[7] = [7];
	V[8] = [8,13];
	V[9] = [9];


func Animation_6(p : float):pass
func Body_Func_6(p : float):
	
	Ax[0] = VY;
	Ax[1] = VZ;
	Ax[2] = VZ;
	Ax[3] = VZ;
	Ax[4] = VZ;
	Ax[5] = VZ;
	Ax[6] = VZ;
	Ax[7] = VZ;
	Ax[8] = VZ;
	Ax[9] = VZ;
	
	
	
	ang [0] = 720
	ang_i[0] = 0
	ang [1] = 0
	ang_i[1] = 0
	ang [2] = -80
	ang_i[2] = 0;
	ang [3] = 0
	ang_i[3] = 0
	ang [4] = 80
	ang_i[4] = 0
	ang [5] = 0
	ang_i[5] = 0
	ang [6] = -30
	ang_i[6] = 0
	ang [7] = 0
	ang_i[7] = 0
	ang [8] = 30
	ang_i[8] = 0
	ang [9] = 0
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2];
	V[3] = [3];
	V[4] = [4];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];


func Animation_7(p : float):pass
func Body_Func_7(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VZ;
	Ax[3] = VX;
	Ax[10] = -VZ;
	Ax[4] = VZ;
	Ax[5] = VX;
	Ax[11] = -VZ;
	Ax[6] = VY;
	Ax[12] = VX;
	Ax[7] = VX;
	Ax[8] = VY;
	Ax[13] = VX;
	Ax[9] = VX;
	
	
	
	ang [0] = -10
	ang_i[0] = 0
	ang [1] = 0
	ang_i[1] = 0
	
	ang [2] = -100
	ang_i[2] = 0;
	ang [3] = 20
	ang_i[3] = 0
	ang [10] = 40;
	ang_i[10] = 0;
	
	ang [4] = 100
	ang_i[4] = 0
	ang [5] = 20
	ang_i[5] = 0
	ang [11] = -40;
	ang_i[11] = 0;
	
	ang [6] = 20
	ang_i[6] = 0
	ang [12] = 40
	ang_i[12] = 0
	ang [7] = -20
	ang_i[7] = 0
	
	ang [8] = -20
	ang_i[8] = 0
	ang [13] = 40
	ang_i[13] = 0
	ang [9] = -20
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	per[12] = p;
	per[13] = p;
	
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2];
	V[3] = [3,10];
	V[4] = [4];
	V[5] = [5,11];
	V[6] = [6,12];
	V[7] = [7];
	V[8] = [8,13];
	V[9] = [9];


func Animation_8(p : float):pass
func Body_Func_8(p : float):
	
	Ax[0] = VZ
	Ax[1] = VZ
	Ax[2] = VZ
	Ax[3] = VZ
	Ax[4] = VZ
	Ax[5] = VZ
	Ax[6] = VZ
	Ax[7] = VZ
	Ax[8] = VZ
	Ax[9] = VZ
	
	
	
	ang [0] = 60
	ang_i[0] = -30
	ang [1] = 0
	ang_i[1] = 0
	
	ang [2] = 120
	ang_i[2] = -160
	ang [3] = 0
	ang_i[3] = 0
	
	ang [4] = 120
	ang_i[4] = 40
	ang [5] = 0
	ang_i[5] = 0
	
	ang [6] = -100
	ang_i[6] = 50
	ang [7] = 0
	ang_i[7] = 0
	
	ang [8] = -100
	ang_i[8] = 60
	ang [9] = 0
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2];
	V[3] = [3];
	V[4] = [4];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];


func Animation_9(p : float):pass
func Body_Func_9(p : float):
	Ax[0] = VY;
	Ax[1] = VY;
	Ax[2] = VZ;
	Ax[3] = VZ;
	Ax[4] = VZ;
	Ax[5] = VZ;
	Ax[6] = VY;
	Ax[10] = VX;
	Ax[7] = VX;
	Ax[8] = VY;
	Ax[11] = VX;
	Ax[9] = VX;
	
	
	ang [0] = 80
	ang_i[0] = 0
	ang [1] = -80
	ang_i[1] = 0
	ang [2] = -20
	ang_i[2] = 0
	ang [3] = 0
	ang_i[3] = 0
	ang [4] = 90
	ang_i[4] = 0
	ang [5] = 0
	ang_i[5] = 0
	ang [6] = -80
	ang_i[6] = 0
	ang [10] = -10
	ang_i[10] = 0
	ang [7] = 0
	ang_i[7] = 0
	ang [8] = -80
	ang_i[8] = 0
	ang [11] = 10
	ang_i[11] = 0
	ang [9] = 0
	ang_i[9] = 0
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2];
	V[3] = [3];
	V[4] = [4];
	V[5] = [5];
	V[6] = [6,10];
	V[7] = [7];
	V[8] = [8,11];
	V[9] = [9];


func Animation_10(p : float):pass
func Body_Func_10(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VZ;
	Ax[10] = VX;
	Ax[3] = VX;
	Ax[4] = VZ;
	Ax[11] = VX;
	Ax[5] = VX;
	Ax[6] = VZ;
	Ax[12] = VX;
	Ax[7] = VX;
	Ax[8] = VZ;
	Ax[13] = VX;
	Ax[9] = VX;
	
	
	ang [0] = -40
	ang_i[0] = 0
	ang [1] = 40
	ang_i[1] = 0
	ang [2] = -20
	ang_i[2] = 0;
	ang [10] = -20;
	ang_i[10] = 0;
	ang [3] = 0
	ang_i[3] = 0
	ang [4] = 90
	ang_i[4] = 0
	#ang [11] = -20;
	#ang_i[11] = 0;
	#ang [5] = 0
	#ang_i[5] = 0
	ang [6] = -10
	ang_i[6] = 0
	ang [12] = -20
	ang_i[12] = 0
	ang [7] = -10
	ang_i[7] = 0
	ang [8] = 10
	ang_i[8] = 0
	ang [13] = -20
	ang_i[13] = 0
	ang [9] = -10
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	per[12] = p;
	per[13] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6,12];
	V[7] = [7];
	V[8] = [8,13];
	V[9] = [9];


func Animation_11(p : float):pass
func Body_Func_11(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VX;
	Ax[10] = VZ;
	Ax[3] = VY;
	Ax[11] = VX;
	Ax[4] = VX;
	Ax[12] = VZ;
	Ax[5] = VY;
	Ax[13] = VX;
	Ax[6] = VY;
	Ax[14] = VX;
	Ax[7] = VX;
	Ax[8] = VY;
	Ax[15] = VX;
	Ax[9] = VX;
	
	## JAJÁ RALLADO
	#Ax[14] = VZ;
	#Ax[10] = VX;
	#Ax[15] = VZ;
	#Ax[11] = VX;
	#Ax[12] = VX;
	#Ax[13] = VX;
	
	ang [0] = 10
	ang_i[0] = 0
	ang [1] = -10
	ang_i[1] = 0
	ang [2] = 90
	ang_i[2] = 0
	ang [10] = 30;
	ang_i[10] = 0;
	ang [3] = -60
	ang_i[3] = 0
	ang [11] = 40
	ang_i[11] = 0
	ang [4] = 90
	ang_i[4] = 0
	ang [12] = -30;
	ang_i[12] = 0;
	ang [5] = 60
	ang_i[5] = 0
	ang [13] = 60
	ang_i[13] = 0
	ang [6] = 10
	ang_i[6] = 0
	ang [14] = 60
	ang_i[14] = 0
	ang [7] = -130
	ang_i[7] = 0
	ang [8] = -10
	ang_i[8] = 0
	ang [15] = 60
	ang_i[15] = 0
	ang [9] = -130
	ang_i[9] = 0
	
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	per[12] = p;
	per[13] = p;
	per[14] = p;
	per[15] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3,11];
	V[4] = [4,12];
	V[5] = [5,13];
	V[6] = [6,14];
	V[7] = [7];
	V[8] = [8,15];
	V[9] = [9];


func Animation_12(p : float):pass
func Body_Func_12(p : float):
	
	# Recuperar Estado_Anterior
	Body_Func_11(pert)
	
	
	
	# Nueva animación
	Ax[16] = VX;
	Ax[17] = VX;
	Ax[18] = VX;
	Ax[19] = VX;
	Ax[20] = VX;
	Ax[21] = VX;
	Ax[22] = VX;
	Ax[23] = VX;
	Ax[24] = VX;
	Ax[25] = VX;
	
	
	ang [16] = -20
	ang_i[16] = 0
	ang [17] = 20
	ang_i[17] = 0
	ang [18] = -120
	ang_i[18] = 0
	ang [19] = -40
	ang_i[19] = 0
	ang [20] = -120
	ang_i[20] = 0
	ang [21] = -60
	ang_i[21] = 0
	
	ang [22] = -60
	ang_i[22] = 0
	ang [23] = 130
	ang_i[23] = 0
	ang [24] = -60
	ang_i[24] = 0
	ang [25] = 130
	ang_i[25] = 0
	
	per[16] = p;
	per[17] = p;
	per[18] = p;
	per[19] = p;
	per[20] = p;
	per[21] = p;
	per[22] = p;
	per[23] = p;
	per[24] = p;
	per[25] = p;
	
	
	V[0] = [0,16];
	V[1] = [1,17];
	V[2] = [2,10,18];
	V[3] = [3,11,19];
	V[4] = [4,12,20];
	V[5] = [5,13,21];
	V[6] = [6,14,22];
	V[7] = [7,23];
	V[8] = [8,15,24];
	V[9] = [9,25];


func Animation_13(p : float):pass
func Body_Func_13(p : float):
	
	Ax[0] = VX;
	Ax[1] = VX;
	Ax[2] = VX;
	Ax[10] = VZ;
	Ax[3] = VX;
	Ax[4] = VX;
	Ax[11] = VZ;
	Ax[5] = VX;
	Ax[6] = VX;
	Ax[7] = VX;
	Ax[8] = VX;
	Ax[9] = VX;
	
	ang [0] = 10
	ang [0] = 15
	ang_i[0] = 0
	ang [1] = 10
	ang_i[1] = 0
	ang [2] = -20
	ang_i[2] = 0
	ang [10] = -10
	ang_i[10] = 0
	ang [3] = 0
	ang_i[3] = 0
	ang [4] = -20
	ang_i[4] = 0
	ang [11] = 10
	ang_i[11] = 0
	ang [5] = 0
	ang_i[5] = 0
	ang [6] = -20
	ang_i[6] = 0
	ang [7] = -10
	ang [7] = 0
	ang_i[7] = 0
	ang [8] = -20
	ang_i[8] = 0
	ang [9] = -10
	ang [9] = 0
	ang_i[9] = 0
	
	per[0] = p;
	per[1] = p;
	per[2] = p;
	per[3] = p;
	per[4] = p;
	per[5] = p;
	per[6] = p;
	per[7] = p;
	per[8] = p;
	per[9] = p;
	per[10] = p;
	per[11] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];


func Animation_14(p : float):pass
func Body_Func_14(p : float):
	
	Ax[0] = VY;
	Ax[1] = VY;
	Ax[2] = VY;
	Ax[10] = VX;
	Ax[3] = VX;
	Ax[4] = VY;
	Ax[11] = VX;
	Ax[5] = VX;
	Ax[6] = VX;
	Ax[7] = VX;
	Ax[8] = VX;
	Ax[9] = VX;
	
	
	
	ang [0] = 40
	ang_i[0] = -20
	ang [1] = -40
	ang_i[1] = 20
	
	ang [2] = 60
	ang [2] = -60
	ang_i[2] = -15
	ang [10] = 30
	ang_i[10] = -20
	ang [3] = 70
	ang_i[3] = 30
	
	ang [4] = -60
	ang [4] = 60
	ang_i[4] = 15
	ang [11] = 30
	ang_i[11] = -20
	ang [5] = 70
	ang_i[5] = 30
	
	ang [6] = 70
	ang_i[6] = -30
	ang [7] = 15
	ang_i[7] = -15
	
	ang [8] = 70
	ang_i[8] = -30
	ang [9] = 15
	ang_i[9] = -15
	
	
	per[0] = p;
	per[1] = pert - p;
	per[2] = p;
	per[3] = p;
	per[4] = pert - p;
	per[5] = pert - p;
	per[6] = p;
	per[7] = p;
	per[8] = pert - p;
	per[9] = pert - p;
	per[10] = p;
	per[11] = pert - p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2];
	V[3] = [3];
	V[4] = [4];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];


func Animation_15(p : float):pass
func Body_Func_15(p : float):
	Body_Func_14(p)
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];



func Animation_16(p : float):pass
func Body_Func_16(p : float):
	
	Ax[0] = VY;
	Ax[1] = VY;
	Ax[2] = VY;
	Ax[10] = VX;
	Ax[3] = VX;
	Ax[4] = VZ;
	Ax[11] = VX;
	Ax[5] = VX;
	Ax[6] = VX;
	Ax[7] = VX;
	Ax[8] = VX;
	Ax[9] = VX;
	
	
	
	ang [0] = 40
	ang_i[0] = -20
	ang [1] = -40
	ang_i[1] = 20
	
	ang [2] = -60
	ang_i[2] = -15
	ang [10] = 30
	ang_i[10] = -20
	ang [3] = 70
	ang_i[3] = 30
	
	ang [4] = 90
	ang_i[4] = 0
	ang [11] = -90
	ang [11] = -40
	ang_i[11] = 20
	ang [5] = 0
	ang_i[5] = 0
	
	ang [6] = 70
	ang_i[6] = -30
	ang [7] = 15
	ang_i[7] = -15
	
	ang [8] = 70
	ang_i[8] = -30
	ang [9] = 15
	ang_i[9] = -15
	
	
	per[0] = p;
	per[1] = pert - p;
	per[2] = p;
	per[3] = p;
	per[4] = pert - p;
	per[4] = pert;
	per[5] = pert - p;
	per[6] = p;
	per[7] = p;
	per[8] = pert - p;
	per[9] = pert - p;
	per[10] = p;
	per[11] = pert - p;
	per[11] = p;
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];


func Animation_17(p : float):pass
func Body_Func_17(p : float):
	Body_Func_16(p)
	
	V[0] = [0];
	V[1] = [1];
	V[2] = [2,10];
	V[3] = [3];
	V[4] = [4,11];
	V[5] = [5];
	V[6] = [6];
	V[7] = [7];
	V[8] = [8];
	V[9] = [9];



func Animation_18(p : float):pass
func Body_Func_18(p : float):
	Body_Func_4(p)
	
	
	ang [4] = 20
	ang [4] = 90
	ang_i[4] = 0
	ang [5] = 0
	ang_i[5] = 0
	
	Ax[4] = VZ;
	V[4] = [4];


const AN1 : int = 1
const AN2 : int = 2
const AN3 : int = 3
const AN4 : int = 4
const AN5 : int = 5
const AN6 : int = 6
const AN7 : int = 7
const AN8 : int = 8
const AN9 : int = 9
const AN10 : int = 10
const AN11 : int = 11
const AN12 : int = 12
const AN13 : int = 13
const AN14 : int = 14
const AN15 : int = 15
const AN16 : int = 16
const AN17 : int = 17
const AN18 : int = 18



func Animation(u : int , p : float):
	UF1()
	vi[0] = Vindex(DVT)
	vi[1] = Vindex(DVC)
	vi[2] = Vindex(DVBI1)
	vi[3] = Vindex(DVBI2)
	vi[4] = Vindex(DVBD1)
	vi[5] = Vindex(DVBD2)
	vi[6] = Vindex(DVPI1)
	vi[7] = Vindex(DVPI2)
	vi[8] = Vindex(DVPD1)
	vi[9] = Vindex(DVPD2)
	
	
	# AQUÍ VA EL CUERPO DE LA FUNCIÓN Y ASIGNACIÓN
	match u:
		AN1:Body_Func_1(p)
		AN2:Body_Func_2(p)
		AN3:Body_Func_3(p)
		AN4:Body_Func_4(p)
		AN5:Body_Func_5(p)
		AN6:Body_Func_6(p)
		AN7:Body_Func_7(p)
		AN8:Body_Func_8(p)
		AN9:Body_Func_9(p)
		AN10:Body_Func_10(p)
		AN11:Body_Func_11(p)
		AN12:Body_Func_12(p)
		AN13:Body_Func_13(p)
		AN14:Body_Func_14(p)
		AN15:Body_Func_15(p)
		AN16:Body_Func_16(p)
		AN17:Body_Func_17(p)
		AN18:Body_Func_18(p)
		# AQUÍ VA LA ASIGNACIÓN DE V
	UF2()
	
	
	for s in range(V.size()):
		Add_To_AxCYdC(s,V[s])
	var Trigger : Array = []
	var Array_Trigger : Array = [0,1,2,3,4,5,6,7,8,9];
	Add_To_Trigger(Trigger,Array_Trigger)
	Trig_Animation(Trigger)




func Add_To_AxCYdC(u : int , Args):
	for arg in Args:
		AxC[u].append(Ax[arg])
		dC[u].append(d[arg])


func Add_To_Trigger(Super : Array , Args):
	for arg in Args:
		Super.append([vi[arg],AxC[arg],dC[arg]]);

func Trig_Animation(Super : Array):
	for s in range(Super.size()):
		rotate_compound(Super[s][0],Super[s][1],Super[s][2])

func rotate_compound(node : Node3D , axes : Array , angles : Array):
	var basis = Basis()
	for i in range(axes.size()):
		basis = basis * Basis(axes[i],deg_to_rad(angles[i]))
	node.transform.basis = basis



var now_time : float = 0.0
var end_time : float = 2.0
var way_func : int = 3
var way_state : String = "idle"
var way_state_before : String = "idle"
var way_state2 : String = "idle"
var way_state_before2 : String = "idle"
var way_num : int = 0
var way_per : float = 0
var way_per2 : float = 0


var descending : bool = false
var descending_before : bool = false

func CState(s1 : String , s2 : String):
	way_state = s2;
	way_state_before = s1;
func gNowState()-> String : return way_state;
func gNowState2()-> String : return way_state2;

var block_way_state : bool = false;
func change_way_state(s : String):
	if not block_way_state:
		way_state = s;
		
var block_way_state2 : bool = false;
func change_way_state2(s : String):
	if not block_way_state2:
		way_state2 = s;


func _process(delta : float):
	
	now_time += delta
	
	
	
		
		
	var disparando : bool = way_state2 == "shot" || way_state2 == "smooth_descending"
	var disparando2 : bool = way_state2 == "shot2"
	
	if way_state == "idle" or \
	way_state == "walking" or \
	way_state == "running" or \
	way_state == "leviton" or \
	way_state == "running_flying":
		if disparando2:
			way_state = "shooting_from_" + way_state + "_2"
		elif disparando:
			way_state = "shooting_from_" + way_state
	elif way_state == "bomba_transicion":way_state = "bomba_explotar"
	
	
	
	
	
	
	
	if way_state == "idle":
		way_num = 0
		if way_state_before != way_state: now_time = 0
		way_per = now_time / end_time
		if way_per >= 1.0:
			way_per = 1.0
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_idle":
		block_way_state = true;
		way_num = 9;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time
		if way_per >= 1.0:
			way_per = 1.0
			now_time = 0
			end_time = 0.2
			way_state = "shooting_from_idle_keep";
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_idle_keep":
		way_num = 9;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time
		if way_per >= 1.0:
			way_per = 1.0
			block_way_state = false;
		Animation(way_num,pert)
	
	elif way_state == "shooting_from_idle_2":
		way_num = 9;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
	
	
	
	
	elif way_state == "walking":
		way_num = 14
		if way_state_before != way_state: now_time = 0
		way_per = (1+sin(8*now_time))/2
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_walking":
		block_way_state = true;
		way_num = 16;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			now_time = 0;
			end_time = 0.2;
			way_state = "shooting_from_walking_keep"
		Animation(way_num,way_per)
		
	elif way_state == "shooting_from_walking_keep":
		way_num = 16;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			block_way_state = false;
		Animation(way_num,pert)
	
	elif way_state == "shooting_from_walking_2":
		way_num = 16;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			now_time = 0;
			end_time = 0.2;
		Animation(way_num,way_per)
	
	
	
	elif way_state == "running":
		way_num = 15
		if way_state_before != way_state: now_time = 0
		way_per = (1+sin(16*now_time))/2
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_running":
		block_way_state = true;
		way_num = 17;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			now_time = 0;
			end_time = 0.2;
			way_state = "shooting_from_running_keep"
		Animation(way_num,way_per)
		
	elif way_state == "shooting_from_running_keep":
		way_num = 17;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			block_way_state = false;
		Animation(way_num,pert)
	
	elif way_state == "shooting_from_running_2":
		way_num = 17;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			now_time = 0;
			end_time = 0.2;
		Animation(way_num,way_per)
	
	
	
	elif way_state == "jumping":
		block_way_state = true;
		way_num = 3;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time
		if not descending and way_per >= 1.0:
			way_per = 1.0
			now_time = 0
			descending = not descending
		elif descending:
			way_per = pert - way_per
			if way_per <= 0:
				way_per = 0
				now_time = 0
				descending = not descending
				block_way_state = false;
		Animation(way_num,way_per)
	
	
	
	elif way_state == "mago_invoka_bola":
		block_way_state = true
		way_num = 1;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.3
		way_per = now_time / end_time
		if way_per >= 1.0:
			way_per = 1.0;
			block_way_state = false;
		Animation(way_num,way_per)
	
	elif way_state == "mago_consume_bola":
		block_way_state = true
		way_num = 2;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time
		if way_per >= 1.0:
			way_per = 1.0;
			block_way_state = false;
		Animation(way_num,way_per)
	
	
	
	elif way_state == "leviton":
		way_num = 4
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.1
		way_per = now_time / end_time
		if way_per > 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_leviton":
		block_way_state = true;
		way_num = 18;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			now_time = 0;
			end_time = 0.2;
			way_state = "shooting_from_leviton_keep"
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_leviton_keep":
		way_num = 18;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			block_way_state = false;
		Animation(way_num,pert)
	
	elif way_state == "shooting_from_leviton_2":
		way_num = 18;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
	
	
	
	elif way_state == "running_flying":
		way_num = 5
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.1
		way_per = now_time / end_time
		if way_per > 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
	
	elif way_state == "shooting_from_running_flying":
		block_way_state = true;
		way_num = 10;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			now_time = 0;
			end_time = 0.2;
			way_state = "shooting_from_running_flying_keep"
		Animation(way_num,way_per)
		
	elif way_state == "shooting_from_running_flying_keep":
		way_num = 10;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
			block_way_state = false;
		Animation(way_num,pert)
	
	elif way_state == "shooting_from_running_flying_2":
		way_num = 10;
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.2
		way_per = now_time / end_time;
		if way_per >= 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
	
	
	
	elif way_state == "ascension":
		way_num = 13
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.5
			end_time = 0.2
			end_time = 0.1
		way_per = now_time / end_time
		if way_per > 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
		
	elif way_state == "descenso":
		way_num = 7
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.5
			end_time = 0.2
			end_time = 0.1
		way_per = now_time / end_time
		if way_per > 1.0:
			way_per = 1.0;
		Animation(way_num,way_per)
		
	elif way_state == "bomba_cargar":
		block_way_state = true;
		way_num = 11
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.9
		way_per = now_time / end_time
		way_per = sqrt(way_per)
		if way_per > 1.0:
			way_per = 1.0;
			way_state = "bomba_transicion"
		Animation(way_num,way_per)
		
	elif way_state == "bomba_explotar":
		way_num = 12
		if way_state_before != way_state:
			now_time = 0
			end_time = 0.1
		way_per = now_time / end_time
		if way_per > 1.0:
			way_per = 1.0;
			way_state = "leviton"
			block_way_state = false;
		Animation(way_num,way_per)
	
	
	# Updating Variables
	descending_before = descending
	way_state_before = way_state
