/// @description  SPARED
c_custom(function() {
	with(creator) {
		audio_play_sound(snd_monster_death,0,0,1,0,.8)
		image_blend = c_gray
		image_speed = 0;
	}
	end_action()
})
