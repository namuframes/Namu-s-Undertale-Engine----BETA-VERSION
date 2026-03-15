///@description fullscreen
global.fullscreen = !global.fullscreen

//window_set_fullscreen(!window_get_fullscreen())
if (global.fullscreen) {
	window_set_showborder(false)
	window_set_size(display_get_width(),display_get_height())
	window_center()
} else {
	window_set_showborder(true)
	window_set_size(WINDOW_WIDTH,WINDOW_HEIGHT)
	window_center()
}