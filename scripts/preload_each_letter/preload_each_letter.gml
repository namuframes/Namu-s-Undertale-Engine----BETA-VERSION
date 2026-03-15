function preload_each_letter(text,separation=0,line_spacing="",font,_xscale=1,_yscale=1,line_length=infinity,_creator=id,tag=text) {
	if (!instance_exists(_creator)) {exit}
	if (!variable_instance_exists(_creator,TEXT_MAP_STRING)) {variable_instance_set(_creator,TEXT_MAP_STRING,ds_map_create())}
	
	draw_set_font(font);
	var textIndex = variable_instance_get(_creator,TEXT_MAP_STRING);
	if (!ds_map_exists(variable_instance_get(_creator,TEXT_MAP_STRING), tag)) { //Create event basically
		var space = 0, line = 0, array=[]
		
		var res = {
			space: 0, line: 0, waveIndex:0,
			char: "", wave: {enabled: false, speed: WAVE_DEFAULT_SPEED, range: WAVE_DEFAULT_RANGE}, shake: {enabled: false, intensity: SHAKE_DEFAULT_INTENSITY, x: 0, y:0}
		}
		
		var ww=0,hh=0
		var precise = true, len = string_length(text);
		
		if (font == fnt_main && separation == LETTER_SPACING) {precise = false}
		if (!is_numeric(line_spacing)) {line_spacing = string_height("i")+2}
		var waveIndex = 1
		for (var i = 1; i <= len; i++) {
			var c = string_char_at(text,i), pc = string_char_at(text,i-1);
			var w = string_width(c)*precise

			if (c == CMD_START) {
				var next_ch = string_char_at(text, i + 1), endLetter = string_pos_ext(CMD_END, text, i);
				if (next_ch != CMD_START) {
					if (string_pos_ext(CMD_END,text,i) > 0) {
						var arg = string_split(string_lower(string_copy(text, i+1, (endLetter - i)-1)),",")
						var arg_count = array_length(arg)-1
						if (asset_get_type(arg[0]) != asset_sprite) {
							var cmd_char = variable_clone(res);
							cmd_char.char = "";
							cmd_char.command = arg;
							switch(arg[0]) {
								case "wave":
									res.wave.enabled = !res.wave.enabled;
									if (arg_count >= 1) {res.wave.range = WAVE_DEFAULT_RANGE*real(arg[1])}
									if (arg_count >= 2) {res.wave.speed = WAVE_DEFAULT_SPEED*real(arg[2])}
								break;
							
								case "shake":
									res.shake.enabled = !res.shake.enabled;
									if (arg_count >= 1) {res.shake.intensity = SHAKE_DEFAULT_INTENSITY*real(arg[1])}
								break;
								
								case "/shake": res.shake.enabled = false break;
								case "/wave": res.wave.enabled = false break;
							
								case "/": case "/r": 
									res.shake = {enabled: false, intensity: SHAKE_DEFAULT_INTENSITY, x: 0, y:0}; 
									res.wave = {enabled: false, speed: WAVE_DEFAULT_SPEED, range: WAVE_DEFAULT_RANGE}; 
								break;
							
							}
							array_push(array,cmd_char)
						} else {
							var customC = variable_clone(res), l = arg_count >= 1 ? arg[1] : "";
							var asset = asset_get_index(arg[0]);
							customC.char = l;
							customC.space = space;	customC.line = line*line_spacing*_yscale;

							customC.sprite = asset_get_index(arg[0]);	customC.index = 0;

							if (customC.char != "*") {
								space += (sprite_get_width(asset)*_xscale)+1*_xscale
							} else {
								space += (separation+w)*_xscale; 
							};
							array_push(array,customC)
						}
					
						i = string_pos_ext(CMD_END,text,i);
						continue;
					}
				} else {
					i++	
				}
			}

			if (pc == " ") {
				if (check_line_break(text,i,line_length,precise,_xscale,separation,space)) {
					space = 0; line++; //waveIndex = 1;
				}
			}

			if (c == "\n") {line++; space=0; /*waveIndex = 1;*/ continue};
				
			if (string_count("*",text) > 0 && c != "*" && space == 0) {
				space += (precise ? string_width("* ")+separation : separation*2)*_xscale
			}
			
			res.space = space;
			res.line = line*line_spacing*_yscale;
			if (font == fnt_pap) {c = string_upper(c)}

			res.char = c;
			res.waveIndex = waveIndex;
			
			array_push(array,variable_clone(res));

			if (res.char != "") {space += (separation+w)*_xscale}  
			waveIndex++;
			ww = max(ww,space);
		}

		textIndex[? tag] = {letters: array, length: array_length(array), width: ww, height: res.line+line_spacing*_yscale, text: text, font: font, line_length: line_length, tag: tag};
	}
	var map = textIndex[? tag]
	if (map.text != text || map.font != font || map.line_length != line_length) {ds_map_clear(textIndex);}
	draw_set_font(-1);
	return map
};