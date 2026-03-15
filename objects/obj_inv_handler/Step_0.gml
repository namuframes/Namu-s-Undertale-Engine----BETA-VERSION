
var _l = 0
switch(page) {
	case "item":
		input = keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)
		
		if (input_pressed(vk_enter)) {
			selected_item = global.inventory[index.current];
			array_push(index.previous,index.current)
			index.current = 0;
			page = "action"	
			audio_play_sound(snd_confirm,0,0)
		}
		
		if (input_pressed(vk_shift)) {
			instance_destroy();	
		}
		
		_l = array_length(global.inventory)-1
	break;
	
	case "action":
		input = keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)
		_l = array_length(actions)-1
		if (input_pressed(vk_enter)) {
			var in = array_get_index(global.inventory,selected_item);
			audio_play_sound(snd_confirm,0,0)
			switch(index.current) {
				case 0: //USE
					if (selected_item.type == ITEM_TYPES.ARMOR || selected_item.type == ITEM_TYPES.WEAPON) {
						var weapon = global.stat.weapon, armor = global.stat.armor
						create_dialogue($"* You equipped the {selected_item.name[0]}.")
						
						array_delete(global.inventory,in,1)
						
						if (selected_item.type == ITEM_TYPES.WEAPON && is_struct(weapon)) {array_insert(global.inventory,in,weapon)}
						else if (selected_item.type == ITEM_TYPES.ARMOR && is_struct(armor)) {array_insert(global.inventory,in,armor)}
						
						equip_item(selected_item)
					} else if (selected_item.type == ITEM_TYPES.CONSUMEABLE) {
						var ex = ""
						heal_player(selected_item.stats.heal);
						if (global.stat.hp >= global.stat.hp_max) { 
							ex = "\n<z>Your HP was maxed out!";
							create_dialogue($"* You ate the {selected_item.name[0]}.{ex}");
						}
						audio_play_sound(snd_heal_c,0,0);
						array_delete(global.inventory,in, 1);
					}
					
				break;
				
				case 1: //INFO
					create_dialogue(selected_item.description[0])
				break;
				
				case 2: //DROP
					create_dialogue($"* The {selected_item.name[0]} was thrown away.")
					array_delete(global.inventory,in, 1)
				break;
			}
			instance_destroy()
		}

		if (keyboard_check_pressed(vk_shift)) {page = "item"}
	break;
}

if (keyboard_check_pressed(vk_shift)) {
	if (array_length(index.previous) > 0) index.current = array_pop(index.previous)
}

var prev_index = index.current
index.current += input
index.current = clamp_ext(index.current,0,_l);

if (index.current != prev_index) {audio_play_sound(snd_select,0,0)};