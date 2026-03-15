if (live_call()) {return live_result}
if (copy_what_i_write) {
	text[curtxt] += keyboard_string	
	keyboard_string=""
	if (keyboard_check_pressed(vk_f12)) {text[curtxt] = ""	}
	if (keyboard_check_pressed(vk_backspace)) {text[curtxt] = string_delete(text[curtxt],string_length(text[curtxt]),1)}
	if (keyboard_check_pressed(vk_enter)) {text[curtxt] += "\n"}
}

if (curtxt < array_length(text)) {
	var txt = text[curtxt]
	if (is_struct(writer)) {
		var is_writing = writer.is_writing;
		
		if (instance_exists(target)) {
			if (object_get_parent(target.object_index) == parActor || target.object_index == parActor) {target.talk = is_writing}
		}
		
		if (asset_get_type(portrait) == asset_sprite) {
			var _spd = sprite_get_speed(portrait)/game_get_speed(gamespeed_fps)
			if (is_writing) {character.frame+= _spd}
			else {character.frame += _spd*(floor(character.frame) != 0)}
			character.frame = clamp_ext(character.frame,0,sprite_get_number(portrait));
		}

		if (input_pressed(vk_enter) && writer.done && writer.can_proceed) {next_page()}		
	}
}