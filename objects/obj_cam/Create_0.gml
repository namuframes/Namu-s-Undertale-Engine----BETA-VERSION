target = obj_player;
zoom = 1;
final_x = 0;
final_y = 0;
follow_x = true;
follow_y = true;
view=0;


limit_camera = function() {
	var w = BASE_WIDTH/zoom;
	var h = BASE_HEIGHT/zoom;
	
	x = clamp(x,0+w/2,room_width-w/2)
	y = clamp(y,0+h/2,room_height-h/2)
}

update_pos = function(__x,__y) {
	if (follow_x) {x = __x};
	if (follow_y) {y = __y};
	limit_camera();
}



reset_camera = function() {
	var w = BASE_WIDTH/zoom;
	var h = BASE_HEIGHT/zoom;
	if (!view_enabled) {
		view_visible[view_current] = true;
		view_enabled = true;
		camera_set_view_size(view_camera[0],w,h)
	}
	
	if (instance_exists(target)) {
		x = target.x;
		y = target.y;
	} else {
		x = 0;
		y = 0;
	}
	limit_camera();
	final_x = x;
	final_y = y;
}