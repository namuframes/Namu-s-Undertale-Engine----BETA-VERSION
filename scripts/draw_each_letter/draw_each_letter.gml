function draw_each_letter(_x,_y,text,separation=0,line_spacing=0,color=c_white,font=get_draw_font(),_xscale=1,_yscale=1,angle=0 ,line_length=infinity, asterisk_rule=false, _typer=undefined,_creator=id,tag=text){
	draw_set_colour(color)
	var map = preload_each_letter(text,separation,line_spacing,font,_xscale,_yscale,line_length,asterisk_rule,_creator,tag);

	if (is_struct(_typer)) {
		if (_typer.map != map) {_typer.map = map}
		if (_typer.creator != _creator) {_typer.creator = _creator}
		_typer.step();
	}
	
	var max_count = is_struct(_typer) ? _typer.index : map.length

	for(var i = 0; i < min(max_count,map.length); i++) {
		var glyph = map.letters[i];
		var wave = glyph.wave, shake = glyph.shake
	
		var fin_x = _x+glyph.space	
		var fin_y = _y+glyph.line+font_rule(glyph.font).yoffset
		
		var offx = 0
		var offy = 0
		
		var char =  map.letters[i].char;
		if (shake.enabled) {
			var val = 10*random_range(-1,1)
			offx += (shake.intensity*_xscale)*(cos(val))
			offy += (shake.intensity*_yscale)*(sin(val))
		}
		
		if (wave.enabled) {
			var index = glyph.waveIndex
			var calc = (global.time*0.2 * wave.speed)
			offy += (wave.range*_yscale) * cos(calc-(index*.25))
			offx -= (wave.range*_xscale) * sin(calc-(index*.25))
		};

		if (struct_exists(glyph,"command")) {
			var arg = glyph.command;
			var arg_count = array_length(arg)-1;
			if (string_char_at(arg[0],1) != "#") {
				switch(arg[0]) {
					case "c_red": case "red":     draw_set_color(c_red) break;
					case "c_green": case "green":   draw_set_color(c_lime) break;
					case "c_yellow": case "yellow":  draw_set_color(c_yellow) break;
					case "c_white": case "white":   draw_set_color(c_white) break;
					case "c_blue": case "blue":    draw_set_color(c_blue) break;
					case "c_purple": case "purple":  draw_set_color(#ad00ff) break;
					case "c_default": case "default": case "/": case "/r": case "/c": draw_set_color(color) break;
					case "c_gray": case "gray":    draw_set_color(c_gray) break;
					case "c_cyan": case "cyan":    draw_set_color(c_aqua) break;
				}
			} else {
				draw_set_color(hex_to_rgb(arg[0]))	
			}

		}

		if (!struct_exists(glyph,"sprite")) {
			draw_set_font(glyph.font)
			draw_text_transformed(fin_x+offx,fin_y+offy,char,_xscale,_yscale,angle)
		} else {
			var spr = glyph.sprite
			var spee = sprite_get_speed(spr)/game_get_speed(gamespeed_fps)
			if (glyph.index < sprite_get_number(spr)) {glyph.index += spee} else {glyph.index=0};
			draw_sprite_ext(spr,glyph.index,fin_x,fin_y+4,_xscale,_yscale,0,draw_get_colour(),draw_get_alpha())	
		}
	}

	draw_set_colour(c_white)
	draw_set_font(-1)
	return map
};

/*
function draw_each_letter(_x,_y,text,separation=0,line_spacing=0,color=c_white,font=get_draw_font(),_xscale=1,_yscale=1,angle=0 ,line_length=infinity, asterisk_rule=false, letterCount=string_length(text),_creator=id,tag=text){
	var map = preload_each_letter(text,separation,line_spacing,font,_xscale,_yscale,line_length,asterisk_rule,_creator,tag);
	draw_set_colour(color)
	draw_set_font(font);
	var max_count = min(floor(letterCount),map.length)//Limiting letter Count since it can leave the array size
	for(var i = 0; i < max_count; i++) {
		var glyph = map.letters[i];
		var wave = glyph.wave, shake = glyph.shake
	
		var fin_x = _x+glyph.space	
		var fin_y = _y+glyph.line+font_rule(glyph.font).yoffset
		
		var offx = 0
		var offy = 0
		
		var char =  map.letters[i].char;
		if (shake.enabled) {
			var val = 10*random_range(-1,1)
			offx += (shake.intensity*_xscale)*(cos(val))
			offy += (shake.intensity*_yscale)*(sin(val))
		}
		
		if (wave.enabled) {
			var index = glyph.waveIndex
			var calc = (global.time*0.2 * wave.speed)
			offy += (wave.range*_yscale) * cos(calc-(index*.25))
			offx -= (wave.range*_xscale) * sin(calc-(index*.25))
		};

		if (struct_exists(glyph,"command")) {
			var arg = glyph.command;
			var arg_count = array_length(arg)-1;
			if (string_char_at(arg[0],1) != "#") {
				switch(arg[0]) {
					case "c_red":     draw_set_color(c_red) break;
					case "c_green":   draw_set_color(c_lime) break;
					case "c_yellow":  draw_set_color(c_yellow) break;
					case "c_white":   draw_set_color(c_white) break;
					case "c_blue":    draw_set_color(c_blue) break;
					case "c_purple":  draw_set_color(#ad00ff) break;
					case "c_default": case "/": case "/r": case "/c": draw_set_color(color) break;
					case "c_gray":    draw_set_color(c_gray) break;
					case "c_cyan":    draw_set_color(c_aqua) break;
				}
			} else {
				draw_set_color(hex_to_rgb(arg[0]))	
			}

		}

		if (!struct_exists(glyph,"sprite")) {
			draw_set_font(glyph.font)
			draw_text_transformed(fin_x+offx,fin_y+offy,char,_xscale,_yscale,angle)
		} else {
			var spr = glyph.sprite
			var spee = sprite_get_speed(spr)/game_get_speed(gamespeed_fps)
			if (glyph.index < sprite_get_number(spr)) {glyph.index += spee} else {glyph.index=0};
			draw_sprite_ext(spr,glyph.index,fin_x,fin_y+4,_xscale,_yscale,0,draw_get_colour(),draw_get_alpha())	
		}
	}
	
	draw_set_colour(c_white)
	draw_set_font(-1)
	return map
};