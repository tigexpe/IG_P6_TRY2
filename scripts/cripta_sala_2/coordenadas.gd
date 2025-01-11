extends Node3D


func Cilindricas(r1 : float , r2 : float , h : float , texture) -> Vector3:
	var circ_avg : float = PI * (r1+r2)
	if false:
		var tex_width = texture.get_width()
		var tex_height = texture.get_height()
		var v = Vector2(tex_width/circ_avg , tex_height / h)
		return Vector3(v.x,v.y,1)
	return Cubicas1(circ_avg,h,texture)

func Esfericas(r : float , h : float , texture) -> Vector3:
	var half_perimeter : float = PI * (3 * (r + h) - sqrt((3 * r + h) * (3 * r + h))) / 2
	return Cilindricas(r,r,half_perimeter,texture)

func Cubicas1(l1 : float , l2 : float , texture) -> Vector3:
	var tex_width = texture.get_width()
	var tex_height = texture.get_height()
	var v = Vector2(tex_width/l1 , tex_height / l2)
	return Vector3(v.x,v.y,1)

func Vec_Esfericas(r : float , h : float) -> Vector3:
	var half_perimeter : float = PI * (3 * (r + h) - sqrt((3 * r + h) * (3 * r + h))) / 2
	return Vec_Cilindricas(r,r,half_perimeter)

func Vec_Cilindricas(r1 : float , r2 : float , h : float):
	var circ_avg : float = PI * (r1+r2)
	return Vec_Cubicas1(circ_avg,h)

func Vec_Cubicas1(l1 : float , l2 : float) -> Vector3:
	var v = Vector2(l1 , l2)
	return Vector3(v.x,v.y,1)
