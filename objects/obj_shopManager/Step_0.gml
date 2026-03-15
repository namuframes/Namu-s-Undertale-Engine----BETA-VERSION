if (live_call()) {return live_result}
if (!instance_exists(shop)) {exit}


switch(page.current) {
		default:
			previous_page()
		break;
		
		case -1:
			set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(options)-1)
			if (input_pressed(vk_enter)) {
				script_execute(options[index.current].script)
			}
			right_text.index = 0;
			buy_speak = speech.buying;
			offy = 75;
			oneshot=true
		break;
		
		case SHOP_OPTIONS.SELL:
			
		break;
	
		case SHOP_OPTIONS.BUY:
			offy = linearVar(offy,0,16)
			if (buy_state == 0) {
				set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(storage)-1)
				if (input_pressed(vk_enter)) {
					buy_state=1; 
					array_push(index.previous,index.current)
					index.current = 0;
					audio_play_sound(snd_confirm,1,0)
				}
			} else {
				set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(buy_options)-1)
				if (input_pressed(vk_enter)) {
					if (index.current == 0) { //Yes
						var cost = storage[index.current].cost
						if (cost > global.stat.gold) {// Can buy?
							//Can't buy! Fuck you!!!!
							buy_speak = speech.no_cash
						} else { //Can buy :)
							buy_speak = speech.buyed
							global.stat.gold -= cost
							array_push(global.inventory,storage[index.current].item)
						};
					} else { //No
						buy_speak = speech.denied;
					}
					index.current = array_pop(index.previous);
					buy_state = 0;
				}
			
				if (input_pressed(vk_shift)) {
					buy_state=0
					index.current = array_pop(index.previous)
				}
			}
		break;
	
		case SHOP_OPTIONS.TALK:
			set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(talk)-1);
			if (input_pressed(vk_enter)) {
				with(shop) {script_execute(talk[other.index.current].script)};
			}
		break;
		
		case SHOP_OPTIONS.EXIT:
			if (oneshot) {with(shop) {event_user(0); check_custenceCommands("cutscene")}; oneshot=false}

			if (!instance_exists(parCutscene)) {
				if (room != rm_shop) {instance_destroy()} else {
					switch_room(global.world.room)	
				}
			}
		break;
		
		case "cutscene":
			if (!instance_exists(cutscene) && !instance_exists(shop.cutscene)) {
				previous_page()
			}
		break;
}

if (input_pressed(vk_shift) && buy_state == 0 && page.current != "cutscene" && page.current != SHOP_OPTIONS.EXIT) {
	if (array_length(page.previous) <= 0 && room != rm_shop) {instance_destroy()}
	previous_page()
}