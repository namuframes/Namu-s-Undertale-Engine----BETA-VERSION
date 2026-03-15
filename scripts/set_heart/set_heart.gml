function set_heart(_x,_y,smooth=1,_rounded=false) { //Helpfull for ui things
	
	if (!variable_instance_exists(id,"ui_heart")) {
		variable_instance_set(id,"ui_heart",{
			x: 0,
			y: 0,
		})
	}
	var target = instance_exists(obj_soul) ? obj_soul : ui_heart 
	var dif = ((_x+_y)-(target.x+target.y))
	/*
	if (dif >= (BASE_WIDTH+BASE_HEIGHT)*0.6) {
		target.x = _x;
		target.y = _y;
	}*/
	target.x = lerp(target.x,_x,smooth)
	target.y = lerp(target.y,_y,smooth)

	if (_rounded) {
		target.x = round(target.x);
		target.y = round(target.y);
	}
}