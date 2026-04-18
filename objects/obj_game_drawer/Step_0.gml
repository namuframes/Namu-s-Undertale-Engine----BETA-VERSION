if (global.border) {
	if (array_length(borders) > 0) {
		var copy=0
		for(var i = 0; i < array_length(borders); i++) {
			if (!is_struct(borders[i])) {
				copy = variable_clone(border_template)
				if (asset_get_type(borders[i]) == asset_sprite) {
					copy.sprite_index = borders[i]
					borders[i] = copy;
				}
			}
			
			borders[i].image_index += sprite_get_speed(borders[i].sprite_index)/FPS
			
			if (array_last(borders).image_alpha >= 1) {
				if (i == array_length(borders)-1) {continue}
				borders[i].image_alpha-=(1/borders[i].ease_time*2)*global.delta
				if (borders[i].image_alpha <= 0) {array_delete(borders,i,1)};
			}
		}

		var v = array_last(borders)
		if (v.image_alpha < 1) {
			v.image_alpha += (1/v.ease_time)*global.delta
		};
	} else if (array_length(borders) <= 0) {border_set_sprite(spr_border)}
} else {borders=[]}