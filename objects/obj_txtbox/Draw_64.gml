if (live_call()) {return live_result}
switch(type) {
	case BOX_TYPE.overworld:
		var text_pos = {
			x: 14,
			y: 10
		}

		draw_sprite(spr_textbox,0,x,y);
	
		if (asset_get_type(portrait) == asset_sprite) {
			var s = 50
			text_pos.x += s;
			draw_sprite_ext(portrait,character.frame,x+character.offset.x+2,y+character.offset.y+4,1,1,0,c_white,1);
		}

		var final_length = (sprite_get_width(spr_textbox)-text_pos.x-16)
		writer.draw(x+text_pos.x,y+text_pos.y,text[curtxt],character.spacing,,,character.font,1,1,0,final_length,character.sound);
	break;
	
	case BOX_TYPE.shop:
		depth = obj_shopManager.depth-1
		var _x = obj_shopManager.txt.x
		var _y = obj_shopManager.txt.y
		writer.draw(_x,_y,text[curtxt],character.spacing,,,character.font,1,1,0,200,character.sound);
	break;
}
