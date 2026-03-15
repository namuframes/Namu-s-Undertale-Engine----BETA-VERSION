var target = obj_battle_control.target_enemy.instance;

switch(state) {
	case 0:
		image_xscale = linearVar(image_xscale,.5,.03);
		image_alpha = linearVar(image_alpha,1,	.03);
		if (image_xscale == .5 && image_alpha == 1) {
			state = 1
			if (instance_exists(obj_target_mark)) {obj_target_mark.hspeed = 8*global.delta}
		};
	break;

	case 1:
		if (!instance_exists(mark) || mark.finished) {
			with(obj_target_mark) {
				if (!finished && place_meeting(x,y,obj_attack_grid)) {
					other.mark = id;		
				}
			}
		}
		if (instance_exists(mark) && !mark.finished) {
			if (mark.x > room_width) {instance_destroy(mark)} else {
				var dist = abs(point_distance(mark.x,mark.y,x,y));
				var presision = 1-clamp(dist/x,0,1)
				if ((keyboard_check_pressed(vk_enter)) && place_meeting(x,y,mark)) {
					if (presision >= .99) {mark.image_blend = #B5E61D}
					else if (presision >= .95) {mark.image_blend = c_yellow}
					final_damage += ((global.stat.attack)*presision)+irandom(2)
					final_damage = round((final_damage-target.defense))
					final_damage = clamp(final_damage,0,infinity)
					mark.finished = true
					mark.hspeed = 0;
					missed=false
				}
			}
		} else {
			if (do_animation) {
				if (!missed) {
					enemy_event(ENEMY_EVENTS.BEFORE_HURT,target)
					switch(item_name(global.stat.weapon)) {
						default:
							audio_play_sound(snd_slash,0,0)
							my_instance = instance_create_depth(target.bbox_left/2 + target.bbox_right/2,target.bbox_top-20,target.depth-1,obj_slash)
						break;
					}
				}
				do_animation = false
			}
			if (!instance_exists(my_instance) && !instance_exists(target.my_scene)) {
				damage_enemy(final_damage); //This calls the enemy hurt event
				if (is_numeric(target.damage_taken)) {audio_play_sound(snd_hit,0,0)};

				state = 2
			}
		}
	break;
	
	case 2:
		if (obj_battle_control.TURN >= BATTLE_TURNS.DIALOGUE) {kill_self = true}
		if (kill_self) {
			instance_destroy(obj_target_mark)
			image_alpha = linearVar(image_alpha,0,.1);
			image_xscale = linearVar(image_xscale,.025,.03);
			if (image_alpha <= 0) {instance_destroy();};	
		}
	break;
}


