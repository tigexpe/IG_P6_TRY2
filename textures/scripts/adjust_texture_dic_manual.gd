extends Node3D

static var dic : Dictionary = {
	"key" : {
		"nuvs" : Vector3.ZERO,
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente2,mesh," : {
		"nuvs" : Vector3(512/16, 512/1.5,100),
		"nuvo" : Vector3(0,512,0)
	},
	",cs3,puente3,mesh," : {
		"nuvs" : Vector3(512/16, 512/1.5,100),
		"nuvo" : Vector3.ZERO
	},
	",cs3,puente4,mesh," : {
		"nuvs" : Vector3(-512/16 * 8/8,512/12 * 12/1,100),
		"nuvo" : Vector3(1,0,0)
	},
	",cs3,puente5,mesh," : {
		"nuvs" : Vector3(512/8,512/5.953488 * 1/8,1),
		"nuvo" : Vector3(1,0,0)
	},
	",cs3,puente2,pared1" : {
		"nuvs" : Vector3(512/16 * 8/8,512/12 * 12/2,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente2,pared2" : {
		"nuvs" : Vector3(512/16 * 8/8,512/12 * 12/2,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente2,pared3" : {
		"nuvs" : Vector3(8,512,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente3,pared1" : {
		"nuvs" : Vector3(512/16 * 8/8,512/12 * 12/2,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente3,pared2" : {
		"nuvs" : Vector3(512/16 * 8/8,512/12 * 12/2,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente3,pared3" : {
		"nuvs" : Vector3(8,512,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente4,pared1" : {
		"nuvs" : Vector3(100/8,512/12 * 12/2,100),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente4,pared2" : {
		"nuvs" : Vector3(100/8,512/2,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs3,puente4,pared3" : {
		"nuvs" : Vector3(8,512,100),
		"nuvo" : Vector3.ZERO,
	},
	
	",cs2,puente1," : {
		"nuvs" : Vector3(512/8,512/5.953488 * 1/8,1),
		"nuvo" : Vector3.ZERO,
	},
	
	
	
	#_j-----------f-----------------------------------------
	
	",cs6,cylinder1,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder2,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder3,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder4,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder5,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder6,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder7,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder8,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs6,cylinder9,cylinder,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs4,interruptor1,refc1_mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs5,interruptor1,refc1_mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	#-------------------------------------
	# trampillas
	#------------------------------------
	",cs5,trap_node_1,mesh," : {
		"nuvs" : Vector3(512/8,512/8,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs5,trap_node_2,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs5,trap_node_3,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs5,trap_node_4,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs5,trap_node_5,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs5,suelo,csgbox," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	
	",cs4,plataforma_lanzadera_1,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs4,plataforma_interruptor_1,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	
	",cs6,plataforma_final_1,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	
	
	
	
	
	
	# RECUPERACIÓN DE LOS ORIGINALES
	",cs5,techo,csgbox," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,pared1,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,pared2,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,pared3,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,pared4frag1,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,pared4frag2,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,pared4frag3,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
	",cs2,techo,mesh," : {
		"nuvs" : Vector3(512,512,1),
		"nuvo" : Vector3.ZERO,
	},
}

