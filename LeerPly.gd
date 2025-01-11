extends Node3D

func LeerPly(path : String):
	return load_ply(path)

func load_ply(path : String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("Error al abrir el archivo:", file.error_string)
		return null
	
	var vertex_count = -1
	var face_count = -1
	var in_header = true
	var line_count = 0
	
	while not file.eof_reached():
		
		if in_header:
			var line = file.get_line().strip_edges()
			line_count += 1
			if line_count == 1:
				if line != "ply":
					print("Error: El archivo .ply no comienza con 'ply'.")
					return null
			elif line.begins_with("element vertex"):
				vertex_count = int(line.split(" ")[-1])
			elif line.begins_with("element face"):
				face_count = int(line.split(" ")[-1])
			elif line == "end_header":
				in_header = false
				if vertex_count == -1 or face_count == -1:
					print("Error: Faltan elementos 'vertex' o 'face' en la cabecera")
					return null
		else:
			break
	
	if in_header:
		print("Error: No se encontró 'end_header'.")
		return null
	
	print("VERTEX_COUNT : ",vertex_count," | FACE_COUNT : ",face_count," |line_count: ",line_count)
	
	print("READING VERTEX")
	# Leer vértices
	var vertices = []
	for i in range(vertex_count):
		if file.eof_reached():
			print("Error: Se terminó el archivo antes de leer todos los vértices.")
			return null
		
		var l = file.get_line()
		var parts = l.strip_edges().split(" ")
		if parts.size() != 3:
			print("Error: Línea de vértices mal formada en línea : ",line_count + i + 1)
			return null
		
		vertices.append(Vector3(parts[0].to_float(), parts[1].to_float(), parts[2].to_float()))
	
	print("READING FACES")
	# Leer caras
	var indices = []
	var triangle = []
	for i in range(face_count):
		triangle = []
		if file.eof_reached():
			print("Error: Se terminó el archivo antes de leer todas las caras.")
			return null
		
		var l = file.get_line()
		var parts = l.strip_edges().split(" ")
		if int(parts[0]) != 3 or parts.size() != 4:
			print("Error: Línea de caras mal formada en línea: ",line_count + vertex_count + i + 1)
			return null
		
		
		var i1 = int(parts[1])
		var i2 = int(parts[2])
		var i3 = int(parts[3])
		
		# Hay que ordenarlos al revés porque sigue la convención CW
		i1 = int(parts[3])
		i2 = int(parts[2])
		i3 = int(parts[1])
		
		triangle.append(i1)
		triangle.append(i2)
		triangle.append(i3)
		
		indices.append(triangle)
	
	if not file.eof_reached():
		var extra_line = file.get_line().strip_edges()
		if extra_line != "":
			print("Error: El archivo contiene más datos de los esperados.")
			return null
	
	file.close()
	
	return [vertices,indices]
