x = 16; y = get_if_top() ? 160 : 4
type = BOX_TYPE.overworld;
creator = undefined;
target = undefined;
if (room == rm_battle) {type = BOX_TYPE.battle}

text = [];
curtxt = 0;
writer = new typewriter(id);

character = {
	name: "",
	sound: snd_txt1,
	font: fnt_main,
	frame: 0,
	offset: {x:0, y:0},
	spacing: LETTER_SPACING
}
	
portrait = noone
copy_what_i_write = false


next_page = function() {
	curtxt++;
	if (curtxt < array_length(text)) {
		writer.index = 0;
	} else {
		instance_destroy();	
	}
}
	
portrait_offset = function(_x,_y) {
	character.offset.x = _x; character.offset.y = _y;
}
	
change_target = function(_id) {
	if (instance_exists(target)) {
		if (variable_instance_exists(target,"talk")) {
			target.talk = false
		}
	}

	target = _id;
}

set_writer_info = function(_character="") {
	var output = ""
	var s = string_pos("_",_character)
	if (s > 0) {
		for (var i = s+1; i < string_length(_character); i++) {
			var char = string_char_at(_character,i)
			if ((char >= "A" && char <= "Z") || (char >= "a" && char <= "z")) {output += char} else {break}
		}
	}

	switch(string_lower(output)) {
		case "pap":
			character.sound=snd_txtpap
			character.font=fnt_pap
			portrait_offset(15,10)
			character.spacing = 0
		break;
		
		case "sans":
			character.font = fnt_comic_sans;
			character.sound=snd_txtsans;
			portrait_offset(15,20)
			character.spacing = 0;
		break;
		
		default: 
			character.sound=snd_txt1
			character.font=fnt_main
			portrait_offset(0,0)
			character.spacing = LETTER_SPACING
		break;
	}
}
set_writer_info();