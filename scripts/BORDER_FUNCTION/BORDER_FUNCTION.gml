function border_size(width="",height="",_x="",_y="", spd=""){
	if (instance_exists(obj_bulletBorder)) {
		with(obj_bulletBorder) {
			target.width = is_numeric(width) ? width : normal.width;

			target.height = is_numeric(height) ? height : normal.height;

			target.x = is_numeric(_x) ? _x : normal.x;

			target.y = is_numeric(_y) ? _y : normal.y;

			target.spd = is_numeric(spd) ? spd : normal.spd;
		}
	}
}

function border_is_normal() {
	if (instance_exists(obj_bulletBorder)) {
		with(obj_bulletBorder) {
			return (round(x) = normal.x && round(y) = normal.y && round(width) = normal.width && round(height) = normal.height)
		}
	} else {
		return false	
	}
}