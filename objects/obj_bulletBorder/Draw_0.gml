if (live_call()) {return live_result}
draw_self();

draw_set_mask(1)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale-.2,image_yscale-.2,image_angle,c_red,1)
draw_reset_mask()

draw_on_mask()
	with (parBullet) {event_perform(ev_draw,0)}
draw_not_on_mask()