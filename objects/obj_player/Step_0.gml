if (player_cantmove()) {
	state = STATE.frozen
} else {state = STATE.free}

switch(state) {
	case STATE.free:
		var col
		ready_to_cutscene = false
		hsp = (InputCheck(INPUT_VERB.RIGHT)-InputCheck(INPUT_VERB.LEFT))*spd
		vsp = (InputCheck(INPUT_VERB.DOWN)-InputCheck(INPUT_VERB.UP))*spd
		
		if (InputCheck(INPUT_VERB.LEFT) && InputCheck(INPUT_VERB.RIGHT)) {hsp = -1*spd}
		if (InputCheck(INPUT_VERB.UP)  && InputCheck(INPUT_VERB.DOWN))  {vsp = -1*spd}
		face_to_direction(hsp,vsp);
		collision()
		face_to_direction(hsp,vsp);
		frisk_dance()
		
		x += hsp*global.delta;
		y += vsp*global.delta;

		var h = x-xprevious;
		var v = y-yprevious;
		do_walk_animation();
		sprite_index = sprite[face]
		if (InputPressed(INPUT_VERB.CONFIRM)) {
			instance_create_depth(x-sprite_xoffset,y-sprite_yoffset,depth-1,obj_player_interactor)	
		}
	break;
	
	case STATE.frozen:
		if (!ready_to_cutscene) {
			if (wait_frame([0,2])) {image_speed = 0; ready_to_cutscene = true}
		}
	break;
}


