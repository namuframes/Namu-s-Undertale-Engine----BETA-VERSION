var box = obj_bulletBorder
if (time >= 120) {
	var _f = sprite_get_height(spr_soul)
	if (time == 120) box_size(,_f,,,,,.5)
	if (box.height == _f) {instance_destroy()}
}