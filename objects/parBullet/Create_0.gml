event_inherited();
if (instance_exists(obj_soul)) {
	depth = obj_soul.depth-1
} else if (instance_exists(obj_bulletBorder)) {
	depth = obj_bulletBorder.depth-1	
}

hurt = function() {
	if (place_meeting(x,y,obj_soul)) {
		var c = blue ? (obj_soul.hsp != 0 || obj_soul.vsp != 0) : true
		if (c) {
			if (obj_soul.inv_frame <= 0) {
				audio_play_sound(snd_hurt,0,0,1,0,random_range(1,1.1))
				damage_player(damage,invincibility_frames)
				if (delete_self) {instance_destroy()}
			}
		}
	}	
}
