draw_set_alpha(.5)
draw_rectangle_color(0,0,BASE_WIDTH,BASE_HEIGHT,c_black,c_black,c_black,c_black,false)
draw_set_alpha(1)
var length = array_length(rooms)-1
index += (keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up))
index = clamp_ext(index,0,length-1)

for (var i = 0; i < length; i++)
{
	draw_set_font(fnt_main);
	if (index == i) {
		draw_set_color(c_yellow)} else {draw_set_color(c_white);
	}
	draw_text_transformed(5,5+i*6,room_get_name(rooms[i]),.5,.5,0);
}

if (keyboard_check_pressed(vk_enter)) {switch_room(rooms[index],0,0,obj_player)}

draw_set_font(-1)
draw_set_color(c_white)

draw_text(60,10,index)