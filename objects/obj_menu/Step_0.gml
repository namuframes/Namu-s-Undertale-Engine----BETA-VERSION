update_selectable();
im_focus = !instance_exists(obj_inv_handler) && !decided && !instance_exists(obj_txtbox)

if (im_focus) {
	var input = (keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up))
	var prev_index = index
	index += input
	if (index != prev_index) {audio_play_sound(snd_select,0,0)}
	index = clamp_ext(index,0,array_length(options)-1)

	if (input_pressed(vk_shift)  || input_pressed(vk_control)) {instance_destroy()};

	if (input_pressed(vk_enter)) {
		if (options[index].selectable) {
			audio_play_sound(snd_confirm,0,0)
			switch(options[index].type) {
				case menu.item:
					instance_create_depth(0,0,0,obj_inv_handler)
				break;
			
				case menu.status: decided = true break;
			
				default:
					audio_stop_sound(snd_confirm)
					audio_play_sound(snd_deny,0,0)	
				break;
			};
		} else {audio_play_sound(snd_deny,0,0)}
	};
}

if ((input_pressed(vk_shift) || input_pressed(vk_control)) && decided) {decided = false;}