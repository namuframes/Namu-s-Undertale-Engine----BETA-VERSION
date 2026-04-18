/// @description 
depth = 9999

border_offset = {
	x: 160,
	y: 30
}
border_template = {
	sprite_index: spr_border,
	image_index: 0,
	ease_time: 20,
	image_alpha: 0
}
borders = [];

correct_gui_size = function(xoffset=undefined,yoffset=undefined) {
	var _w = (window_get_width()/BASE_WIDTH)/1.5
	var _h = (window_get_height()/BASE_HEIGHT)/1.125

	var _x=	is_numeric(xoffset) ? xoffset : (border_offset.x/2)*_w;
	var _y= is_numeric(yoffset) ? yoffset : (border_offset.y/2)*_h;
	display_set_gui_maximise(_w,_h,_x,_y)
}