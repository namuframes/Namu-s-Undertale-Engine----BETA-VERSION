if (live_call()) {return live_result}
var prev_c = c;
c = cos(time*0.05)

var s = sin(time*0.05)
draw_sprite_ext(sprite_index,image_index,x,y-(2*c),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
show_hp();