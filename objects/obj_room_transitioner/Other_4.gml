if (asset_get_type(destiny.object) == asset_object && ds_map_exists(global.room_player_info,room)) {
	var position = global.room_player_info[? room]
	destiny.object = instance_nearest(position.x,position.y,destiny.object)
}

if (instance_exists(destiny.object)) {
	destiny.x += destiny.object.x;
	destiny.y += destiny.object.y;
}

event_user(0)