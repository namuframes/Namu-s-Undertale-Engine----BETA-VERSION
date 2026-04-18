function border(boolean) {
	global.border = boolean
	
	if (!global.fullscreen) {
		if (!global.border) {
			window_set_size(WINDOW_WIDTH,WINDOW_HEIGHT)
		} else {
			window_set_size(BORDER_WIDTH,BORDER_HEIGHT)	
		}
		window_center();
	}
}

function border_set_sprite(sprite,ease_time=20) {
	if (global.border) {
		with(obj_game_drawer) {
			var r = variable_clone(border_template);
			r.sprite_index = sprite;
			r.ease_time = ease_time;
			array_push(borders, r)
		}
	}
}