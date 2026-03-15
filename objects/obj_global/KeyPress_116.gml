if (!instance_exists(obj_room_chooser)) {
	instance_create_depth(0,0,-99,obj_room_chooser)	
} else {
	instance_destroy(obj_room_chooser)	
}