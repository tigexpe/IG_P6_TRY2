extends Node

var dic_tokens_textura : Dictionary = {
	"suelo1" : {
		"file" : "res://textures/Ground_04.png",
		"node" : null,
	},
	"suelo2" : {
		"file" : "res://textures/Ground_03.png",
		"node" : null,
	},
	"pared1" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_01-512x512.png",
		"node" : null,
	},
	"pared3_sala4" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_12-512x512.png",
		"node" : null,
	},
	"pared4_sala4" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_19-512x512.png",
		"node" : null,
	},
	
	
	"puente4_suelo" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_10-512x512.png",
		"node" : null,
	},
	"puente4_techo" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_13-512x512.png",
		"node" : null,
	},
	"pared5_sala5" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_11-512x512.png",
		"node" : null,
	},
	"pared6_sala6" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_20-512x512.png",
		"node" : null,
	},
	"puente" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_18-512x512.png",
		"node" : null,
	},
	"pared_sala_5" : {
		"file" : "res://pack_icht_1_texturas/512x512/Tile/Tile_08-512x512.png",
		"node" : null,
	},
	"techo_sala_5" : {
		"file" : "res://pack_icht_1_texturas/512x512/Tile/Tile_08-512x512.png",
		"node" : null,
	},
	"suelo_sala_5" : {
		"file" : "res://pack_icht_2_texturas/512x512/Metal/Metal_20-512x512.png",
		"node" : null,
	},
	"laterales_trampilla" : {
		"file" : "res://pack_icht_2_texturas/512x512/Metal/Metal_01-512x512.png",
		"node" : null,
	},
	"frontales_trampilla" : {
		"file" : "res://pack_icht_2_texturas/512x512/Metal/Metal_02-512x512.png",
		"node" : null,
	},
	"suelo_trampilla" : {
		"file" : "res://pack_icht_2_texturas/512x512/Metal/Metal_16-512x512.png",
		"node" : null,
	},
	
	
	"techo_sala_6" : {
		"file" : "res://pack_icht_3_texturas/512x512/Gem/Gem_06-512x512.png",
		"node" : null,
	},
	"suelo_sala_6" : {
		"file" : "res://pack_icht_3_texturas/512x512/Gem/Gem_15-512x512.png",
		"node" : null,
	},
	"pared1_sala_6" : {
		"file" : "res://pack_icht_3_texturas/512x512/Gem/Gem_09-512x512.png",
		"node" : null,
	},
	"pared2_sala_6" : {
		"file" : "res://pack_icht_3_texturas/512x512/Gem/Gem_07-512x512.png",
		"node" : null,
	},
	"pared3_sala_6" : {
		"file" : "res://pack_icht_3_texturas/512x512/Gem/Gem_10-512x512.png",
		"node" : null,
	},
	"pared4_sala_6" : {
		"file" : "res://pack_icht_3_texturas/512x512/Gem/Gem_20-512x512.png",
		"node" : null,
	},
	
	
	"escalon1" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_05-512x512.png",
		"node" : null,
	},
	"escalon2" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_06-512x512.png",
		"node" : null,
	},
	
	
	"techo_sala_2" : {
		"file" : "res://pack_icht_2_texturas/512x512/Stone/Stone_13-512x512.png",
		"node" : null,
	},
	
	
	"sala_4_1pared" : {
		"file" : "res://pack_icht_2_texturas/512x512/Tile/Tile_11-512x512.png",
		"node" : null,
	},
	"sala_4_2pared" : {
		"file" : "res://pack_icht_2_texturas/512x512/Tile/Tile_12-512x512.png",
		"node" : null,
	},
	
	
	
	"techo_1" : {
		"file" : "res://pack_icht_2_texturas/512x512/Stone/Stone_13-512x512.png",
		"node" : null,
	},
	"techo_2" : {
		"file" : "res://pack_icht_2_texturas/512x512/Stone/Stone_14-512x512.png",
		"node" : null,
	},
	
	"techo_puente_5" : {
		"file" : "res://pack_icht_1_texturas/512x512/Bricks/Bricks_10-512x512.png",
		"node" : null,
	},
	
	"suelo_veneno" : {
		"file" : "res://pack_icht_3_texturas/512x512/Elements/Elements_17-512x512.png",
		"node" : null,
	},
	"plat_lanzadera_1" : {
		"file" : "res://pack_icht_1_texturas/512x512/Roofs/Roofs_01-512x512.png",
		"node" : null,
	},
	"plat_sagrada_1" : {
		"file" : "res://pack_icht_1_texturas/512x512/Roofs/Roofs_08-512x512.png",
		"node" : null,
	},
	"plat_lanzadera_2" : {
		"file" : "res://pack_icht_1_texturas/512x512/Roofs/Roofs_13-512x512.png",
		"node" : null,
	},
	"cilindro,sin,mas" : {
		"file" : "res://pack_icht_1_texturas/512x512/Tile/Tile_04-512x512.png",
		"node" : null,
	},
	
	####-----------------------------------------------------------csg3
	"3suelo" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_01-512x512.png",
		"node" : null,
	},
	"3pared1" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_08-512x512.png",
		"node" : null,
	},
	"3pared2" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_14-512x512.png",
		"node" : null,
	},
	"3pared3" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_16-512x512.png",
		"node" : null,
	},
	"3pared4" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_19-512x512.png",
		"node" : null,
	},
	"3techo" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_02-512x512.png",
		"node" : null,
	},
	
	
	
	"4techo" : {
		"file" : "res://pack_icht_3_texturas/512x512/Grating/Grating_21-512x512.png",
		"node" : null,
	},
	
	
	
	"puente23suelo" : {
		"file" : "pack_icht_1_texturas/512x512/Tile/Tile_02-512x512.png",
		"node" : null,
	},
}
