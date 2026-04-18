if (live_call()) {return live_result}

if (global.border) {
	display_set_gui_size(BORDER_WIDTH,BORDER_HEIGHT);
	for(var i = 0; i < array_length(borders); i++) {
		var brd = borders[i]
		draw_sprite_stretched_ext(brd.sprite_index,brd.image_index,0,0,BORDER_WIDTH,BORDER_HEIGHT,c_white,brd.image_alpha);
	}
	correct_gui_size(0,0)
}