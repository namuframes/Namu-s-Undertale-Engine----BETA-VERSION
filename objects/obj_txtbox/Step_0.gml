if (live_call()) {return live_result}
if (copy_what_i_write) {
	text[curtxt] += keyboard_string	
	keyboard_string=""
	if (keyboard_check_pressed(vk_f12)) {text[curtxt] = ""	}
	if (keyboard_check_pressed(vk_backspace)) {text[curtxt] = string_delete(text[curtxt],string_length(text[curtxt]),1)}
	if (InputPressed(INPUT_VERB.CONFIRM)) {text[curtxt] += "\n"}
}

if (curtxt < array_length(text)) {
	if (is_struct(writer)) {
		var is_writing = writer.is_writing;
		
		var confirm = InputPressed(INPUT_VERB.CONFIRM) || InputCheck(INPUT_VERB.SPECIAL)
		if (confirm && writer.done && writer.can_proceed) {next_page()}
		
		if (instance_exists(target)) {
			if (object_get_parent(target.object_index) == parActor || target.object_index == parActor) {
				target.talk = is_writing
			}
		}

		if (asset_get_type(portrait) == asset_object) {
			if (!instance_exists(portrait)) {portrait = instance_create_depth(0,0,0,portrait)}	
		}

		if (instance_exists(portrait)) {
			writer.sound(portrait.voice,portrait.voice_pitchMin,portrait.voice_pitchMax)
			portrait.talking = is_writing;	
			
		} else {writer.sound(voice)};
	}
}