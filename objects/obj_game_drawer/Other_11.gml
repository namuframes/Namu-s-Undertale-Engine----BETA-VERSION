/// @description BORDER
if (live_call()) {return live_result}
var game_width  = WINDOW_WIDTH
var game_height = WINDOW_HEIGHT
display_set_gui_size(BORDER_WIDTH,BORDER_HEIGHT);
draw_rectangle_colour(border_offset.x,border_offset.y,border_offset.x+game_width,border_offset.y+game_height,c_black,c_black,c_black,c_black,false)
draw_surface_stretched_ext(application_surface,border_offset.x,border_offset.y,game_width,game_height,c_white,1)

correct_gui_size()