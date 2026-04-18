if (live_call()) {return live_result}
var q = 6;
alarm[0] = q;
if (!proceed) {exit}


var box = obj_bulletBorder
var space = (sprite_get_width(spr_soul)*.5+sprite_get_width(spr_bButterfly)*.5)

t+= (q*.1)*global.delta
pointx = sin(t)
var t_x = box.x+15*pointx
instance_create_depth(t_x-space,box.y+40,0,obj_bullet_butterfly)
instance_create_depth(t_x+space,box.y+40,0,obj_bullet_butterfly)
with(obj_bullet_butterfly) {
	image_angle = 90;
	vspeed = -1.5;
	if (bbox_bottom < box.bbox_top) {instance_destroy();}
}