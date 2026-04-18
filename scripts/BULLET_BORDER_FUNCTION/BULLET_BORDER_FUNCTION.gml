
function box_size(_width=undefined,_height=undefined,_x=undefined,_y=undefined, angle=undefined, ease_type=EASE_LINEAR,spd=3){
	var tag = "bulletBorder.";
	with (obj_bulletBorder) {
		if (is_numeric(_width)) {do_tween(id,tag+"width","width",_width,ease_type,spd)}
		if (is_numeric(_height)) {do_tween(id,tag+"height","height",_height,ease_type,spd)}
		
		if (is_numeric(_x)) {do_tween(id,tag+"_x","x",_x,ease_type,spd)}
		if (is_numeric(_y)) {do_tween(id,tag+"_y","y",_y,ease_type,spd)}
	
		if (is_numeric(angle)) {do_tween(id,tag+"angle","image_angle",angle,ease_type,spd)}
	}
}

function box_reset(ease_type=undefined,spd=undefined) {
	var nrm = obj_bulletBorder.normal
	box_size(nrm.width,nrm.height,nrm.x,nrm.y,nrm.angle, ease_type,spd)
}

function box_tweening() {
	with(obj_tweenHandler) {
		if (object == obj_bulletBorder) {return true}
	}
	return false;
}

function box_is_normal() {
	if (instance_exists(obj_bulletBorder)) {
		with(obj_bulletBorder) {
			return (round(x) = normal.x && round(y) = normal.y && round(width) = normal.width && round(height) = normal.height)
		}
	} else {
		return false	
	}
}