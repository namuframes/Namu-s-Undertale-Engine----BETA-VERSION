if (player_cantmove()) {
	state = STATE.frozen
} else {state = STATE.free}

{
	/*
if (place_meeting(x+sign(hsp),y,obj_slope)) {
	var off = 1;
	while(true) {
		show_debug_message("HSP")
		var dir_h = sign(hsp); // horizontal movement direction
		var dir_v = sign(vsp); // vertical movement direction

		if (!place_meeting(x+hsp, y+off, obj_collision) && !place_meeting(x + hsp, y + off + 1, obj_collision)) {
			y += off;
			break;
		}
		else if (!place_meeting(x+hsp, y-off, obj_collision) && !place_meeting(x+ hsp, y - off - 1, obj_collision)) {
			y -= off;
			break;
		}

		if (off > 32) {break};
		off++;
	}
}
		
if (place_meeting(x,y+sign(vsp),obj_slope)) {
	var off = 1;
	while(true) {
		show_debug_message("VSP")
		if (!place_meeting(x+off,y+vsp,obj_collision)) {x += off; break;}
		if (!place_meeting(x-off,y+vsp,obj_collision)) {x -= off; break;}
		if (off > 32) {break};
		off++;
	}
}

*/
}
switch(state) {
	case STATE.free:
		var col
		ready_to_cutscene = false
		hsp = (keyboard_check(vk_right)-keyboard_check(vk_left))*spd
		vsp = (keyboard_check(vk_down)-keyboard_check(vk_up))*spd
		
		if (keyboard_check(vk_left) && keyboard_check(vk_right)) {hsp = -1*spd}
		if (keyboard_check(vk_up)  && keyboard_check(vk_down))  {vsp = -1*spd}

		direction_animation();

		collision()
		frisk_dance()

		x += hsp*global.delta;
		y += vsp*global.delta;

		var h = x-xprevious;
		var v = y-yprevious;

		direction_animation();
		do_walk_animation();
		sprite_index = sprite[face]
		if (input_pressed(vk_enter)) {
			instance_create_depth(x-sprite_xoffset,y-sprite_yoffset,depth-1,obj_player_interactor)	
		}
	break;
	
	case STATE.frozen:
		if (!ready_to_cutscene) {
			if (wait_frame([0,2])) {image_speed = 0; ready_to_cutscene = true}
		}
	break;
}

