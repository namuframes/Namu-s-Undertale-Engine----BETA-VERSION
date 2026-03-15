switch(type) {
	case BOX_TYPE.battle:
		depth = obj_bulletBorder.depth-1
		var _x = obj_battle_control.txt.x+8
		writer.draw(_x,obj_battle_control.txt.y,text[curtxt],character.spacing,,,character.font,1,1,0,obj_bulletBorder.bbox_right-_x,character.sound);
	break;
}

