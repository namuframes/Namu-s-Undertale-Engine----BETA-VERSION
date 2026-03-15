function switch_room(room,x="",y="",object=noone){
	if (!instance_exists(obj_room_transitioner)) {
		world_save_player()
		var t = instance_create_depth(0,0,0,obj_room_transitioner);
		t.destiny.object = object;
		t.destiny.rm = room;
		if (is_numeric(x)) {t.destiny.x = x;}
		if (is_numeric(y)) {t.destiny.y = y;}
	}
}