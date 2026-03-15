if (live_call()) {return live_result}
if (instance_exists(obj_player)) {
	var center_x = ((obj_player.x-obj_player.sprite_xoffset)+obj_player.sprite_width/2)
	var center_y = ((obj_player.y-obj_player.sprite_yoffset)+obj_player.sprite_height/2)
	x = center_x
	y = center_y
	switch(obj_player.face) {
		case DIR.DOWN: 
			y += (obj_player.bbox_bottom-center_y)+4
		break;
		case DIR.RIGHT: 
			x += (obj_player.bbox_right-center_x)+10
			y += 6
		break;
		case DIR.LEFT: 
			x += (obj_player.bbox_left-center_x)-10
			y += 6
		break;
	}
}