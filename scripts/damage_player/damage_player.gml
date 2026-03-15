function damage_player(amount,invincibility_frames=4){
	global.stat.hp -= amount;
	if (instance_exists(obj_soul)) {
		obj_soul.inv_frame = invincibility_frames
	}
}