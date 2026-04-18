next_page = function() {
	if (curtxt < array_length(text)-1) {
		writer.reset()
		curtxt++;
	} else {
		instance_destroy()
	};
}
	
text_draw = function(_x,_y,_length=infinity) {
	var _font = font;
	if (instance_exists(portrait)) {
		if (asset_get_type(portrait.font) == asset_font) {
			_font = portrait.font	
		}
	}
	draw_each_letter(_x,_y,text[curtxt],,,,_font,1,1,0,_length,true,writer)
}

change_target = function(_id) {
	if (instance_exists(target)) {
		if (variable_instance_exists(target,"talk")) {
			target.talk = false
		}
	}

	target = _id;
}

set_portrait = function(input="",face=undefined) {
	switch(string_lower(input)) {
		case "gaster":
			portrait=obj_portrait_gaster
		break;
	
		case "": portrait=noone break;
	}

	if (instance_exists(portrait)) {
		portrait.face = input
	} else {
		if (is_string(face)) {portrait.face = face};
	}
}

top = get_if_top()

x = 16; y = top ? 160 : 4
type = BOX_TYPE.overworld;
creator = undefined;
target = undefined;
if (room == rm_battle) {type = BOX_TYPE.battle}

text = [];
curtxt = 0;
	
portrait = noone;

font = lang_font(fnt_main_mono);
voice = snd_txt1;

writer = new typer();
writer.skipable = true;
writer.sound(voice,1)

copy_what_i_write = false;