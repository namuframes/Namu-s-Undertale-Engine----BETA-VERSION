event_inherited();

image_alpha = global.debug

if (place_meeting(x,y,obj_player)) {
	if (object_index != obj_player) interaction();
	if (destroy_self) {instance_destroy()}
}