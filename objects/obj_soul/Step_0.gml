if (live_call()) {return live_result}


if (invincible > 0) {
	image_speed = 1;
	invincible -= 1*global.delta;
} else {image_speed = 0; image_index = 0}


if (mode == SOUL_MODE.YELLOW) {image_angle = 180}
image_blend = mode;

var angle_correct = image_angle-90
if (state == STATE.free) {
	if (InputCheck(INPUT_VERB.CANCEL)) {
		spd = PLAYER.soul_speed/2	
	} else {spd = PLAYER.soul_speed}
	var default_movement = function(use_hsp=true,use_vsp=true) {
		if (use_hsp) {
			hsp = ((InputCheck(INPUT_VERB.RIGHT)-InputCheck(INPUT_VERB.LEFT))*spd)*global.delta
			if (InputCheck(INPUT_VERB.LEFT) && InputCheck(INPUT_VERB.RIGHT)) {hsp = (-1*spd)*global.delta}
		}
		
		if (use_vsp) {
			vsp = ((InputCheck(INPUT_VERB.DOWN)-InputCheck(INPUT_VERB.UP))*spd)*global.delta
			if (InputCheck(INPUT_VERB.UP)  && InputCheck(INPUT_VERB.DOWN))  {vsp = (-1*spd)*global.delta}
		}
	}
	switch(mode) {
		case SOUL_MODE.RED:
			default_movement();			
			collision();
		
			x += hsp;
			y += vsp;
		break;
		
		case SOUL_MODE.YELLOW:
			default_movement()
			collision();
		
			x += hsp;
			y += vsp;
			shoot_timer -= (shoot_timer>0)*global.delta
			if (InputCheck(INPUT_VERB.CONFIRM) && shoot_timer<=0) {
				audio_stop_sound(snd_yellow_shoot)
				audio_play_sound(snd_yellow_shoot,0,0,1,0,random_range(1,.95))
				
				var b = instance_create_depth(x,y,depth+1,obj_soul_bullet)
				b.direction = angle_correct;
				b.image_angle = angle_correct-90
				b.image_blend = image_blend;
				b.speed = 4*global.delta;
				
				shoot_timer=shoot_delay
			}
		break;
		
		case SOUL_MODE.BLUE:
			default_movement(,false)
			var on_floor = place_meeting(x,y+1,obj_collision);
			if (!on_floor) {
				if (InputReleased(INPUT_VERB.UP)) {
					vsp=vsp*0.5
					jump_hold=0
				}
				vsp+=gravity_force*global.delta
			} else {
				jump_hold=4*(jump_force*global.delta)
			}
			
			if (jump_hold > 0) {
				if InputCheck(INPUT_VERB.UP) {
					if (vsp >= 0) {vsp=-jump_force*2} else {
						vsp-=jump_force*global.delta
					}
					jump_hold-=global.delta;
				}
			}
			
			collision();
			//show_debug_message(on_floor)
		
			x += hsp;
			y += vsp;
		break;
	}
	
	

	can_reset=true

} else {
	shoot_timer=shoot_delay
	if (can_reset) {
		jump_hold=0;
		hsp = 0; vsp = 0;
		can_reset=false;
	}
};

