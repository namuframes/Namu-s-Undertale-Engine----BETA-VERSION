
if (global.debug) {
	draw_set_font(fnt_main)
	draw_text(2,2,$"fps: {fps}\nDelta: {global.delta}")
	draw_set_font(-1)
}