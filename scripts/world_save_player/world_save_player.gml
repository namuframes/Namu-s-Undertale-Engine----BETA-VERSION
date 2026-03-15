function world_save_player() {
	with(obj_global) {
		if (instance_exists(obj_player)) {
			global.world.x = obj_player.x
			global.world.y = obj_player.y
			global.world.room = room
		}
	}
}