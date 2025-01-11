extends Node3D
var Texture_Files : Dictionary = {}
var Texture_Loaded : Dictionary = {}


var Crypt_MeshRef : Dictionary = {}
var Crypt_NUVS : Dictionary = {}
var Crypt_NUVO : Dictionary = {}
func AddMergeDic(d : Dictionary , s : Dictionary):
	for k in s.keys():
		d[k] = s[k]

var Cripta_Meshes : Dictionary = {
	",cs3,puente2,mesh," : null,
	",cs3,puente3,mesh," : null,
	",cs3,puente4,mesh," : null,
	",cs3,puente5,mesh," : null,
	",cs3,puente2,pared1" : null,
	",cs3,puente2,pared2" : null,
	",cs3,puente2,pared3" : null,
	",cs3,puente3,pared1" : null,
	",cs3,puente3,pared2" : null,
	",cs3,puente3,pared3" : null,
	",cs3,puente4,pared1" : null,
	",cs3,puente4,pared2" : null,
	",cs3,puente4,pared3" : null,
	",cs2,puente1," : null,
	",cs4,suelo,mesh," : null,
	",cs4,plataforma_interruptor_1,mesh," : null,
	",cs4,plataforma_lanzadera_1,mesh," : null,
	
	",cs6,cylinder1,cylinder,mesh," : null,
	",cs6,cylinder2,cylinder,mesh," : null,
	",cs6,cylinder3,cylinder,mesh," : null,
	",cs6,cylinder4,cylinder,mesh," : null,
	",cs6,cylinder5,cylinder,mesh," : null,
	",cs6,cylinder6,cylinder,mesh," : null,
	",cs6,cylinder7,cylinder,mesh," : null,
	",cs6,cylinder8,cylinder,mesh," : null,
	",cs6,cylinder9,cylinder,mesh," : null,
	",cs4,interruptor1,refc1_mesh," : null,
	",cs5,interruptor1,refc1_mesh," : null,
	",cs5,trap_node_1,mesh," : null,
	",cs5,trap_node_2,mesh," : null,
	",cs5,trap_node_3,mesh," : null,
	",cs5,trap_node_4,mesh," : null,
	",cs5,trap_node_5,mesh," : null,
	
	
	",cs6,plataforma_final_1,mesh," : null,
	
	
	
	",cs5,techo,csgbox," : null,
	
	",cs2,suelo,mesh," : null,
	",cs2,pared1,mesh," : null,
	",cs2,pared2,mesh," : null,
	",cs2,pared3,mesh," : null,
	",cs2,pared4frag1,mesh," : null,
	",cs2,pared4frag2,mesh," : null,
	",cs2,pared4frag3,mesh," : null,
	",cs2,techo,mesh," : null,
}

func AddToIf( s : String , node , nuvs : Vector3 , nuvo : Vector3):
	Crypt_MeshRef[s] = node
	Crypt_NUVS[s] = nuvs
	Crypt_NUVO[s] = nuvo
	if s in Cripta_Meshes.keys():
		Cripta_Meshes[s] = node

func AjustarManual():
	var L = load("res://textures/scripts/adjust_texture_dic_manual.gd")
	for k in L.dic.keys():
		if k in Crypt_MeshRef.keys():
			#print("ADJUSTING ",k)
			var nd = L.dic[k]
			Crypt_NUVS[k] = nd["nuvs"]
			Crypt_NUVO[k] = nd["nuvo"]
			var ref = Crypt_MeshRef[k]
	var count : int = 0
	var yesc : int = 0
	for s in Crypt_MeshRef.keys():
		count += 1
		if s in Cripta_Meshes.keys():
			yesc += 1
			var nref = Crypt_MeshRef[s]
			var nuvs = Crypt_NUVS[s]
			var nuvo = Crypt_NUVO[s]
			var k = sdt1.super_dic1_texturas[s]
			if k:
				var d = sdt2.dic_tokens_textura[k]
				var dfile = d["file"]
				var dnode = d["node"]
				AssignTexture4(nref,dfile,nuvs,nuvo)

func _ready():
	var cs2 = get_parent().get_node("Cripta_Sala_2")
	var cs3 = get_parent().get_node("Cripta_Sala_3")
	var cs4 = get_parent().get_node("Cripta_Sala_4")
	var cs5 = get_parent().get_node("Cripta_Sala_5")
	var cs6 = get_parent().get_node("Cripta_Sala_6")
	LoadTextures()

func LoadTextures():
	Texture_Loaded = {}
	for key in Texture_Files.keys():
		var n = load(Texture_Files[key])
		var m = StandardMaterial3D.new()
		m.albedo_texture = n
		Texture_Loaded[key] = m

func GetMaterial(key):
	if key in Texture_Loaded.keys():
		return Texture_Loaded[key]
	else:
		return null

func LoadFiles():
	var k1 = "key1"
	var k2 = "key2"
	var k3 = "key3"
	var k4 = "key4"
	var k5 = "key5"
	var k6 = "key6"
	var k7 = "key7"
	var k8 = "key8"
	var k9 = "key9"
	Texture_Files[k1] = null
	Texture_Files[k2] = null
	Texture_Files[k3] = null
	Texture_Files[k4] = null
	Texture_Files[k5] = null
	Texture_Files[k6] = null
	Texture_Files[k7] = null
	Texture_Files[k8] = null
	Texture_Files[k9] = null




func TotalMaterialAssignation():
	var cs2 = get_parent().get_node("Cripta_Sala_2")
	var cs3 = get_parent().get_node("Cripta_Sala_3")
	var cs4 = get_parent().get_node("Cripta_Sala_4")
	var cs5 = get_parent().get_node("Cripta_Sala_5")
	var cs6 = get_parent().get_node("Cripta_Sala_6")
	
	var vcsv = [ cs2 , cs3 , cs4 , cs5 , cs6 ]
	for n in vcsv:
		var d1 = n.RCM2(1)
		var d2 = n.RCM2(2)
		var d3 = n.RCM2(3)

func TotalMaterialAssignation2():
	var cs2 = get_parent().get_node("Cripta_Sala_2")
	var cs3 = get_parent().get_node("Cripta_Sala_3")
	var cs4 = get_parent().get_node("Cripta_Sala_4")
	var cs5 = get_parent().get_node("Cripta_Sala_5")
	var cs6 = get_parent().get_node("Cripta_Sala_6")
	
	print("var super_dic1_texturas : Dictionary = {")
	var vcsv = [ cs2 , cs3 , cs4 , cs5 , cs6 ]
	for n in vcsv:
		var d1 = n.RCM2(1)
		var d2 = n.RCM2(2)
		var d3 = n.RCM2(3)

func Ajustar_Lux_Cilindros():
	var cs4_1 = get_parent().get_node("Cripta_Sala_4/Interruptor1")
	var cs5_1 = get_parent().get_node("Cripta_Sala_5/Interruptor1")
	
	var cs6_1 = get_parent().get_node("Cripta_Sala_6/Interruptor1")
	var cs6_2 = get_parent().get_node("Cripta_Sala_6/Interruptor2")
	var cs6_3 = get_parent().get_node("Cripta_Sala_6/Interruptor3")
	var cs6_4 = get_parent().get_node("Cripta_Sala_6/Interruptor4")
	var cs6_5 = get_parent().get_node("Cripta_Sala_6/Interruptor5")
	var cs6_6 = get_parent().get_node("Cripta_Sala_6/Interruptor6")
	var cs6_7 = get_parent().get_node("Cripta_Sala_6/Interruptor7")
	var cs6_8 = get_parent().get_node("Cripta_Sala_6/Interruptor8")
	var cs6_9 = get_parent().get_node("Cripta_Sala_6/Interruptor9")
	
	var ir : float
	var en : float
	var r : float
	var color : String = "2a84ffcb"
	
	ir = 5
	en = 50
	r = 50
	color = "2a84ffcb"
	cs4_1.Set_Start(ir,en,r,color)
	cs5_1.Set_Start(ir,en,r,color)
	
	ir = 2
	en = 10
	r = 10
	color = "2a84ffcb"
	cs6_1.Set_Start(ir,en,r,color)
	cs6_2.Set_Start(ir,en,r,color)
	cs6_3.Set_Start(ir,en,r,color)
	cs6_4.Set_Start(ir,en,r,color)
	cs6_5.Set_Start(ir,en,r,color)
	cs6_6.Set_Start(ir,en,r,color)
	cs6_7.Set_Start(ir,en,r,color)
	cs6_8.Set_Start(ir,en,r,color)
	cs6_9.Set_Start(ir,en,r,color)

var state = "fak"
func _process(d:float):
	if state == "fak":
		state = "unfak"
		
		ApplyTextures()
		AjustarManual()
		Ajustar_Lux_Cilindros()
	var bridge_final = ",cs2,puente1,"
	

var sdt1 = preload("res://textures/scripts/super_diccionario_texturas.gd").new()
var sdt2 = preload("res://textures/scripts/token_texturas.gd").new()
func ApplyTextures():
	var cs2 = get_parent().get_node("Cripta_Sala_2")
	var cs3 = get_parent().get_node("Cripta_Sala_3")
	var cs4 = get_parent().get_node("Cripta_Sala_4")
	var cs5 = get_parent().get_node("Cripta_Sala_5")
	var cs6 = get_parent().get_node("Cripta_Sala_6")
	
	var vcsv = [ cs2 , cs3 , cs4 , cs5 , cs6 ]
	for n in vcsv:
		var d1 = n.RCM2(1)
		var d2 = n.RCM2(2)
		var d3 = n.RCM2(3)
		
		for key in d1.keys():
			var v = d1[key]
			if v in sdt1.super_dic1_texturas.keys():
				var w = sdt1.super_dic1_texturas[v]
				if w in sdt2.dic_tokens_textura.keys():
					var d = sdt2.dic_tokens_textura[w]
					var dfile = d["file"]
					var dnode = d["node"]
					var v2i : Vector3 = d2[key]
					var v3i : Vector3 = d3[key]
					AssignTexture3(key,dfile,d2[key],d3[key])
		
		for key in d1.keys():
			var nk = d1[key]
			AddToIf(nk,key,d2[key],d3[key])
	
				


func AssignTexture3(mesh,file : String,uvs : Vector3,uvo : Vector3):
	if file:
		var texture = load(file)
		var tex_width : float = texture.get_width()
		var tex_height : float = texture.get_height()
		var uvs0 = uvs
		uvs = Vector3(tex_width/uvs.x , tex_height/uvs.y , uvs.z)
		
		var material = StandardMaterial3D.new()
		material.albedo_texture = texture
		material.uv1_scale = uvs
		material.uv1_offset = uvo
		mesh.material_override = null
		mesh.material_override = material


func AssignTexture4(mesh,file : String,uvs : Vector3,uvo : Vector3):
	if file:
		var texture = load(file)
		var tex_width : float = texture.get_width()
		var tex_height : float = texture.get_height()
		var uvs0 = uvs
		var uvo0 = uvo
		uvs = Vector3(tex_width/uvs.x , tex_height/uvs.y , uvs.z)
		
		var material = StandardMaterial3D.new()
		material.albedo_texture = texture
		material.uv1_scale = uvs
		material.uv1_offset = uvo
		mesh.material_override = null
		mesh.material_override = material

func AssignTexture5(mesh,file : String,uvs : Vector3,uvo : Vector3 , rot : float):
	if file:
		var texture = load(file)
		var tex_width : float = texture.get_width()
		var tex_height : float = texture.get_height()
		var uvs0 = uvs
		var uvo0 = uvo
		uvs = Vector3(tex_width/uvs.x , tex_height/uvs.y , uvs.z)
		var material = StandardMaterial3D.new()
		material.albedo_texture = texture
		material.uv1_scale = uvs
		material.uv1_offset = uvo
		mesh.material_override = null
		mesh.material_override = material
