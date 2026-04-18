update_selectable();
if (im_focus) {
	var input = (InputPressed(INPUT_VERB.DOWN) - InputPressed(INPUT_VERB.UP))
	var prev_index = index
	index += input
	if (index != prev_index) {audio_play_sound(snd_select,0,0)}
	index = clamp_ext(index,0,array_length(options)-1)

	if (InputPressed(INPUT_VERB.CANCEL)  || InputPressed(INPUT_VERB.SPECIAL)) {instance_destroy()};

	if (InputPressed(INPUT_VERB.CONFIRM)) {
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
	
if (decided) {
	if ((InputPressed(INPUT_VERB.CANCEL) || InputPressed(INPUT_VERB.SPECIAL))) {decided = false;}
}
	
im_focus = !instance_exists(obj_inv_handler) && !decided && !instance_exists(obj_txtbox)