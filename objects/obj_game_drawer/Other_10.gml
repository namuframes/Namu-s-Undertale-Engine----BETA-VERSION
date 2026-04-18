/// @description NO BORDER
if (live_call()) {return live_result} 
var width  = window_get_width()
var height = window_get_height()
	
var factor = min(width/WINDOW_WIDTH, height/WINDOW_HEIGHT)/4

	
var final_width = WINDOW_WIDTH*factor
var final_height = WINDOW_HEIGHT*factor
var offset = {
	x: width/2-final_width/2,
	y: height/2-final_height/2
}
display_set_gui_size(width,height)
draw_surface_stretched_ext(application_surface,offset.x,offset.y,final_width,final_height,c_white,image_alpha)
display_set_gui_maximise(factor*(WINDOW_WIDTH/BASE_WIDTH),factor*(WINDOW_HEIGHT/BASE_HEIGHT),offset.x,offset.y)