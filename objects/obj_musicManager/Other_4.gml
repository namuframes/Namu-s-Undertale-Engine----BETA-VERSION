var room_name = ""
var lettersToSkip = string_pos_ext("_",room_get_name(room),0)+1;
for(var i = lettersToSkip; i < string_length(room_get_name(room))+1;) {
	var char = string_char_at(room_get_name(room),i)
	if ((char >= "A" && char <= "Z") || (char >= "a" && char <= "z")) { room_name += char;	i++;} else {break};
}
switch(room_name) {
	case "battle":
		//set_game_song(mus_battle)
	break;
	
	default:
		bgm_set(noone)
	break;
}