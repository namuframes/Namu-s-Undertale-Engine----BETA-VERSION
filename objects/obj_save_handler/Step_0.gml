var prev_index = index;
index += InputPressed(INPUT_VERB.RIGHT)-InputPressed(INPUT_VERB.LEFT);
index = clamp_ext(index,0,array_length(options)-1);
if (index != prev_index) {
	audio_play_sound(snd_select,0,0)	
}

if (InputPressed(INPUT_VERB.CONFIRM)) {
	if (is_method(options[index].script)) {
		script_execute(options[index].script);
	}
	instance_destroy();
}