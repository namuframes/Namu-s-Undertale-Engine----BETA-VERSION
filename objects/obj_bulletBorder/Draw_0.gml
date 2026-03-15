draw_self();
draw_set_mask(1)
draw_rectangle(bbox_left+thickness,bbox_top+thickness,(bbox_left+sprite_width)-thickness-1,(bbox_top+sprite_height)-thickness-1,false)
draw_reset_mask()

draw_on_mask()
with(parBattleObjects) {
	if (draw_on_border) {
		event_perform(ev_draw,0)
	}
}
draw_not_on_mask()