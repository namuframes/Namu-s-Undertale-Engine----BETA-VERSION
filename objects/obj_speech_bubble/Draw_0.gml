if (live_call()) {return live_result}

draw_set_font(font)
var extra_width = string_height("W")*0.5, extra_height = string_height("I")*0.4;
var textoff_x = 7, textoff_y = 6;
var mp = preload_each_letter(text[curtxt],,,fnt_dotum,.5,.5,length,id)

var str_height= mp.height
var str_width = mp.width

var bubble_width = (mp.width+textoff_x+extra_width);
var bubble_height = max(sprite_get_height(spr_speech_bubble), mp.height+textoff_y)+extra_height;

var pointer = {
	width: sprite_get_width(spr_speech_pointer),
	height: sprite_get_width(spr_speech_pointer),
	xoffset: sprite_get_xoffset(spr_speech_pointer),
	yoffset: sprite_get_yoffset(spr_speech_pointer),
	x_scale: 1,
	angle: 0
}

if (instance_exists(target)) {
	if (object_get_parent(target.object_index) == parEnemy) {
		var t_x=target.speech_bubble.x_left-outline_size, t_y=target.speech_bubble.y+pointer.yoffset //Default position, left

		with(target) { //Checking if i'm not overlaying anyone or leaving the room
			var _x = speech_bubble.x_right-other.outline_size
			var _y = speech_bubble.y
			var right_collision = collision_rectangle(_x,_y,_x+bubble_width+pointer.width,_y+bubble_height,parEnemy,false,true)
			
			_x = speech_bubble.x_left+other.outline_size
			_y = speech_bubble.y			
			var left_collision = collision_rectangle(_x,_y,_x-bubble_width-pointer.width,_y+bubble_height,parEnemy,false,true)
			//Making sure if the enemy is in battle
			if (instance_exists(left_collision)) {
				if (left_collision.spared || left_collision.dead || (bubble_width < 0)) {left_collision=false} 
			}
			if (instance_exists(right_collision)) {
				if (right_collision.spared || right_collision.dead) {right_collision=false}
			}
			var leavingLeft = (floor(speech_bubble.x_left-bubble_width) <= 0)
			if (right_collision) {other.side = 0}
			else if (left_collision) {other.side = 1}
			if ((left_collision && right_collision && speech_bubble.y_top+bubble_height < room_height) || leavingLeft) {other.side = 2}
		}
		
		switch(side) { //Positioning
			case 1: 
				t_x = target.speech_bubble.x_right-outline_size
			break;

			case 2:
				t_x = ((target.bbox_left+target.bbox_right)/2)-bubble_width/2
				t_y = target.speech_bubble.y_top-outline_size
			break;
		}
		x = t_x; y = t_y;
	}
}

var bubble = {x: x,y: y}
//Fixing the bubble position

switch(side) {
	case 0: case 1:
		bubble.y -= bubble_height/2 //Making them stay in the centre
		if (side == 0) { //Left
			length = room_width-x-textoff_x-font_get_size(font)-extra_width;
			bubble.x -= pointer.width+bubble_width-outline_size
			pointer.x_scale = -1; x -= pointer.xoffset
			length = textoff_x+font_get_size(font)+extra_width
		} else if (side == 1) { //Right
			bubble.x += pointer.width-outline_size
			x += pointer.xoffset
		}
	break;
	
	case 2:
		length = room_width-x-textoff_x-font_get_size(font)-extra_width;
		bubble.y -= bubble_height-outline_size
		x += bubble_width/2;
		pointer.angle = 90
	break;
}

var txt = {
	x: bubble.x+textoff_x,
	y: bubble.y+textoff_y,
	str: text[curtxt]
}


draw_sprite_stretched(spr_speech_bubble,side,bubble.x,bubble.y,bubble_width,bubble_height);

draw_sprite_ext(spr_speech_pointer,0,x,y,pointer.x_scale,1,pointer.angle,c_white,1);
var fnBlip = mute ? snd_empty : blip
writer.draw(txt.x,txt.y,txt.str,,,c_black,font,.5,.5,,length,fnBlip)

draw_set_font(-1)