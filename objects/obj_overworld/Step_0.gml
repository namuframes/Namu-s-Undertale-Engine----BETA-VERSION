if (!player_cantmove()) {
	if (!instance_exists(obj_menu) && input_pressed(vk_control)) {
		instance_create_depth(0,0,0,obj_menu);	
	}
}