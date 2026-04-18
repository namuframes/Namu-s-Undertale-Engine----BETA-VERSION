switch(state) {
	case STATE.free:
		if (follow_player) {
			follow_behaviour();
			if (player_cantmove()) {state = STATE.frozen};
		};
		
	break;
	
	case STATE.frozen:
		if (follow_player) {
			if (sprite_index == sprite[face]) {
				if (floor(image_index)%2 == 0) {image_speed=0};
			};
			if (!player_cantmove()) {state = STATE.free};
		};
	break;
}

if (talk) {
	image_speed=1;
	if (set_talk_sprite) {sprite_index = sprite_talk[face]; set_talk_sprite=false}
	done_talking=false;
	reset_sprite=true;
} else  {
	if (!done_talking && sprite_index == sprite_talk[face]) {
		if (floor(image_index) <= 0) {
			image_index=0;
			image_speed=prev_image_speed;
			done_talking=true;
		}
	}
	
	var notxtbox = false;
	with(obj_txtbox) {
		if (target == other.id) {notxtbox=true}	
	}
	if (!notxtbox) {sprite_index = sprite[face]};
}

if (!instance_exists(my_scene)) {
	if (reset_sprite) {
		sprite_index = prev_sprite;
		image_speed = prev_image_speed;
		face = prev_face;
		image_index=0;
		reset_sprite=false;
	} else {
		prev_face = face;
		prev_sprite = sprite_index;
		prev_image_speed = image_speed;	
	}
	set_talk_sprite=true
};

step();