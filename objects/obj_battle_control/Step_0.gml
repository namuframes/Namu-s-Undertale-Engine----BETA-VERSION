actions[BATTLE_PAGES.ITEM].selectable = !(array_length(global.inventory) <= 0)
var prev_page = page.current
switch(TURN) {
	case BATTLE_TURNS.PLAYER_INIT:
		if (border_is_normal()) {
			global.BATTLE_TIME = 0
			if (!instance_exists(obj_soul)) {instance_create_depth(x,y,DEPTHS.UI,obj_soul)}
			soul_visible(true);
			soul_state(STATE.frozen);

			if (array_length(index.previous) > 0) index.current = array_first(index.previous)
			if (array_length(page.previous) > 0) page.current = array_first(page.previous)
			if (!actions[index.current].selectable) { //If button isn't selectable, search for a selectable one
				var off = 0;
				while(true) {
					if (actions[off].selectable) {index.current = off; break}
					if (off > array_length(actions)) {break}
				}
			}
			target_enemy = {
				instance: undefined,
				index: 0
			}
			did_scene = false;
			index.previous=[]
			page.previous=[]

			battle_next_turn()
		} else { //Reseting the border size
			soul_visible(false)
			border_size()
		} 
		
	break;
	
	case BATTLE_TURNS.PLAYER:
		switch(page.current) {
			case BATTLE_PAGES.MAIN:
				set_controls((keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)),array_length(actions)-1)
				var _action = actions[index.current]
				if (!_action.selectable) {index.current += index.input}
				if (input_pressed(vk_enter)) {
					if (actions[index.current].selectable) {set_page(index.current)} else {audio_play_sound(snd_deny,0,false)}
				}
			break;
			
			case BATTLE_PAGES.ACT:
				set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(enemy)-1)
				enemy_list(BATTLE_PAGES.ACT_CHOOSE)
			break;
			
			case BATTLE_PAGES.ACT_CHOOSE:
				set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(target_enemy.instance.action)-1)
				if (keyboard_check_pressed(vk_enter)) {
					var inst = target_enemy.instance;
					if (is_method(inst.action[index.current].script)) {
						with (inst) {
							script_execute(action[other.index.current].script)
							check_custenceCommands() //Creating the cutscene instantly if there's custscene commands
						}
					} else {
						enemy_event(other.index.current,inst)
					}
					battle_next_turn()
				}
			break;
			
			case BATTLE_PAGES.MERCY:
				set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(mercy_actions)-1)
				if (keyboard_check_pressed(vk_enter)) {
					if (index.current == 0) { // Spare
						with(parEnemy) {
							if (spareable) {spared = true}	
						}
						battle_next_turn()
					}
					
					if (index.current == 1) {battle_next_turn()} //Flee
					audio_play_sound(snd_confirm,0,0)
				}	
			break;

			case BATTLE_PAGES.FIGHT: 
				set_controls((keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)),array_length(enemy)-1);
				enemy_list(BATTLE_PAGES.FIGHT_ACTION);
			break;

			case BATTLE_PAGES.FIGHT_ACTION:
				soul_visible(false)
				if (!instance_exists(obj_attack_grid)) {
					instance_create_depth(0,0,0,obj_attack_grid)	
				}
				
				if (obj_attack_grid.state >= 2 && no_cutscene()) {
					battle_next_turn()	
				}
			break;

			case BATTLE_PAGES.ITEM:
				set_controls(keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up),array_length(global.inventory)-1);
				if (keyboard_check_pressed(vk_enter)) {
					var in = index.current;
					var selected_item = global.inventory[in];
					
					if (selected_item.type == ITEM_TYPES.ARMOR || selected_item.type == ITEM_TYPES.WEAPON) {
						var weapon = global.stat.weapon, armor = global.stat.armor
						my_cutscene = create_dialogue($"* You equipped the {selected_item.name[0]}.")
						array_delete(global.inventory,in,1)
						if (selected_item.type == ITEM_TYPES.WEAPON && is_struct(weapon)) {array_insert(global.inventory,in,weapon)}
						else if (selected_item.type == ITEM_TYPES.ARMOR && is_struct(armor)) {array_insert(global.inventory,in,armor)}
						equip_item(selected_item)
					} else if (selected_item.type == ITEM_TYPES.CONSUMEABLE) {
						var ex = ""
						heal_player(selected_item.stats.heal);
						if (global.stat.hp >= global.stat.hp_max) { 
							ex = "\n<z>Your HP was maxed out!";
							my_cutscene = create_dialogue($"* You ate the {selected_item.name[0]}.{ex}");
						}
						audio_play_sound(snd_heal_c,0,0);
						array_delete(global.inventory,in, 1);
					}
					battle_next_turn()
				}
			break;

			default: set_controls(0,0) break;
		}
		if (input_pressed(vk_shift) && page.current != BATTLE_PAGES.FIGHT_ACTION) {previous_page()}
	break;
	
	case BATTLE_TURNS.PLAYER_END:	
		if (!instance_exists(obj_soul)) {instance_create_depth(x,y,DEPTHS.UI,obj_soul); show_message("A")}
		soul_visible(false)
		soul_state(STATE.frozen)
		if (no_cutscene()) {//If there isn't any cutscene from the enemies and myself, proceed!
			battle_next_turn()
		}
	break;
	
	case BATTLE_TURNS.DIALOGUE:
		if (!did_scene) {
			//Calling the enemies cutscene
			with(parEnemy) {
				if (on_battle()) {
					if (dead) {
					 	other.lootbox.gold += gold;
					 	other.lootbox.xp += xp;
						enemy_event(ENEMY_EVENTS.DEATH,id)
					}
					else if (spared) { //If enemy is spared
					 	other.lootbox.gold += gold/2;
					 	enemy_event(ENEMY_EVENTS.SPARED,id)
					} 
					else {enemy_event(ENEMY_EVENTS.CUTSCENE,id)}
				}
			}
			update_enemy_array() //Updating the list for the next LOOP!

			if (!array_length(enemy) <= 0) {
				//Preparing the player and box
				border_size(80);
				soul_position(obj_bulletBorder.x,obj_bulletBorder.y);
				soul_visible(true);
			}
			did_scene = true;
			delay=1
		};

		if (no_cutscene()) {
			battle_next_turn()
		};
	break;	
	
	case BATTLE_TURNS.ENEMY_INIT:
		enemy_event(ENEMY_EVENTS.ATTACK_START);
		if (!instance_exists(obj_soul)) {instance_create_depth(obj_bulletBorder.x,obj_bulletBorder.y,0,obj_soul)};
		obj_bulletBorder.depth = obj_battle_control.depth-1
		soul_state(STATE.free);
		obj_soul.depth = obj_bulletBorder.depth-1;
		
		battle_next_turn();
	break;	
	
	case BATTLE_TURNS.ENEMY:
		enemy_event(ENEMY_EVENTS.ATTACK)
		global.BATTLE_TIME++;
	break;
	
	case BATTLE_TURNS.ENEMY_END:
		global.turn++
		instance_destroy(parBullet); //Destroying all BULLETs
		obj_bulletBorder.depth = depth+1
		enemy_event(ENEMY_EVENTS.ATTACK_END)
		battle_next_turn()
	break;
	
	case BATTLE_TURNS.END:
		if (no_cutscene() && border_is_normal()) {
			global.stat.gold += lootbox.gold; //Giving the LOOT - YYEEAAAHH BABYYYYY
			global.stat.xp += lootbox.xp;
			my_cutscene = create_cutscene(function() {
				c_dialogue($"<noskip>* YOU WON!<w,10>\nYou earned {obj_battle_control.lootbox.xp} XP and {obj_battle_control.lootbox.gold} GOLD")
				c_wait_dialogue();
				c_custom(function() {
					switch_room(global.world.room)
					if (room != rm_battle) {}
				})
			})
		} else {
			obj_bulletBorder.depth = depth+1
			if (instance_exists(obj_soul)) {instance_destroy(obj_soul)}
			bgm_set(noone,0,0);
			border_size()
		}
	break;
}

	
if (page.current != prev_page) {
	enemy_event(ENEMY_EVENTS.MENU_SWITCH)	
}

	
delay -= (delay>0)
//Reseting the delay (It helps to not skip any turn when battle_next_turn() is called and it Helps with cutscenes shinanigans too)