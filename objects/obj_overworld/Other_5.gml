for(var i = 0; i < array_length(global.party); i++) {
	if (instance_exists(global.party[i])) {
		global.party[i] = global.party[i].object_index	
	}
}

save_player()
room_save_player();