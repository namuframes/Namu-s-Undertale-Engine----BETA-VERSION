var h = BASE_HEIGHT
for(var i = 0; i < array_length(actions); i++) {
	var sprite = actions[i].sprite
	var f = 0
	if (!actions[i].selectable) {
		if (sprite_get_number(sprite) >= 3) {f=2}	
	}
	if (page.current == BATTLE_PAGES.MAIN && TURN == BATTLE_TURNS.PLAYER) {
		if (i == index.current) {f = 1}	
	}

	var mX = 16+77*i
	draw_sprite_ext(sprite,f,mX, h-24,.5,.5,0,c_white,1)
	if (f == 1) {
		var px = mX+9, py = h-13
		set_heart(px,py)
	}
}
	
var bottom_ui = {
	x: 15,
	y: h-40
}

var hp= {x: bottom_ui.x+123, y: bottom_ui.y, width: (global.stat.hp_max/2)+1, height: 10}
draw_hp(hp.x,hp.y,hp.width,hp.height,global.stat.hp,global.stat.hp_max,c_yellow,c_red)
var p = string_length(string(global.stat.hp)) > 1 ? global.stat.hp : $"0{global.stat.hp}"
draw_set_font(fnt_mars);
draw_text_transformed(bottom_ui.x,bottom_ui.y,$"{global.name}   lv {global.stat.level}",1.5,1.5,0)
draw_text_transformed((hp.x+hp.width)+8,hp.y,$"{p} / { global.stat.hp_max}",1.5,1.5,0)
draw_set_font(-1);
var row_length = 2

switch(TURN) {
	case BATTLE_TURNS.PLAYER:
		switch(page.current) {
			case BATTLE_PAGES.ACT:
				enemy_list(BATTLE_PAGES.ACT_CHOOSE);
			break;
			
			case BATTLE_PAGES.FIGHT:
				enemy_list(BATTLE_PAGES.FIGHT_ACTION,true);
			break;
			
			case BATTLE_PAGES.ACT_CHOOSE:
				var lr = (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left));
				if (lr != 0) {
					var line  = index.current mod row_length, collum = index.current div row_length;
					var _in = (collum+lr) * row_length + line;
					_in = clamp_ext(_in,0,row_length+line)
				    index.current = _in;
				}

				for(var i = 0; i < array_length(target_enemy.instance.action); i++) {
					var act = target_enemy.instance.action[i]
					var __y = txt.y+16*(i mod row_length), __x = (txt.x+sprite_get_width(spr_soul)+4)+125*(i div row_length)
					draw_each_letter(__x,__y,"* "+act.name,LETTER_SPACING,,,fnt_main)
					if (index.current == i) {set_heart(__x+heart_offset.x,__y+heart_offset.y+2)}
				}
			break;
			
			case BATTLE_PAGES.ITEM:
				var lr = (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left));
				if (lr != 0) {
					var line  = index.current mod row_length, collum = index.current div row_length;
					var _in = (collum+lr) * row_length + line;
					_in = clamp_ext(_in,0,row_length+line)
				    index.current = _in;
				}

				for(var i = 0; i < array_length(global.inventory); i++) {
					var itm = global.inventory[i]
					var __y = txt.y+16*(i mod row_length), __x = (txt.x+sprite_get_width(spr_soul)+4)+125*(i div row_length)
					draw_each_letter(__x,__y,"* "+itm.name[0],LETTER_SPACING,,,fnt_main)
					if (index.current == i) {set_heart(__x+heart_offset.x,__y+heart_offset.y+2)}
				}
			break
			
			case BATTLE_PAGES.MERCY:
				for(var i = 0; i < array_length(mercy_actions); i++) {
					var __y = txt.y+18*i, __x = txt.x+sprite_get_width(spr_soul)+4, c = TEXTconfig.color
					for (var j = 0; j < array_length(enemy); j++) {
						if (enemy[j].spareable && i == 0) {
							c = TEXTconfig.color2
						}
					}
					draw_each_letter(__x,__y,"* "+mercy_actions[i],LETTER_SPACING,,c,fnt_main)
					if (index.current == i ) {set_heart(__x+heart_offset.x,__y+heart_offset.y+2)}
				}
			break;
		}
	break;
}
