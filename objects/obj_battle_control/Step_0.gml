//buttons[BATTLE_PAGES.ITEM].selectable = !(array_length(global.inventory) <= 0)
var prev_page = page.current
READY = instance_exists(obj_pre_battle) ? obj_pre_battle.state >= 3 : true
switch(TURN) {
	case BATTLE_TURNS.PLAYER_INIT:
		obj_bulletBorder.depth = depth+1
		if (box_is_normal()) {
			if (!instance_exists(obj_soul)) {instance_create_depth(x,y,DEPTHS.UI,obj_soul)}
			battle_soul_visible(true);
			battle_soul_state(STATE.frozen);
			battle_soul_depth(depth-10)
			battle_soul_variable_set("invincible",0)

			if (array_length(index.previous) > 0) index.current = array_first(index.previous)
			page.current = BATTLE_PAGES.MAIN;
			if (!buttons[index.current].selectable) { //If button isn't selectable, search for a selectable one
				var off = 0;
				while(true) {
					if (buttons[off].selectable) {index.current = off; break}
					if (off > array_length(buttons)) {break}
				}
			}
			target_enemy.instance = undefined
			target_enemy.index = 0

			did_scene = false;
			index.previous=[]
			page.previous=[]

			battle_next_turn()
		} else {
			battle_soul_visible(false)
			box_reset()	
		}
	break;
	
	case BATTLE_TURNS.PLAYER:
		switch(page.current) {
			case BATTLE_PAGES.MAIN:
				if (!READY) {exit}
				set_controls((InputPressed(INPUT_VERB.RIGHT)-InputPressed(INPUT_VERB.LEFT)),array_length(buttons)-1)
				var _action = buttons[index.current]
				if (!_action.selectable) {index.current += index.input}
				if (InputPressed(INPUT_VERB.CONFIRM)) {
					if (buttons[index.current].selectable) {
						with(buttons[index.current]) {event_user(3)}
					} else {audio_play_sound(snd_deny,0,false)}
				}
			break;
			
			case BATTLE_PAGES.ACT:
				set_controls((InputPressed(INPUT_VERB.DOWN)-InputPressed(INPUT_VERB.UP)),array_length(enemy)-1)
				enemy_list(BATTLE_PAGES.ACT_CHOOSE)
			break;
			
			case BATTLE_PAGES.ACT_CHOOSE:
				set_controls((InputPressed(INPUT_VERB.DOWN)-InputPressed(INPUT_VERB.UP)),array_length(target_enemy.instance.action)-1)
				if (InputPressed(INPUT_VERB.CONFIRM)) {
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
				set_controls((InputPressed(INPUT_VERB.DOWN)-InputPressed(INPUT_VERB.UP)),array_length(mercy_actions)-1)
				if (InputPressed(INPUT_VERB.CONFIRM)) {
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
				set_controls((InputPressed(INPUT_VERB.DOWN)-InputPressed(INPUT_VERB.UP)),array_length(enemy)-1);
				enemy_list(BATTLE_PAGES.FIGHT_ACTION);
			break;

			case BATTLE_PAGES.FIGHT_ACTION:
				battle_soul_visible(false)
				if (!instance_exists(obj_attack_grid)) {
					instance_create_depth(0,0,0,obj_attack_grid)	
				}
				
				if (obj_attack_grid.state >= 2 && no_cutscene()) {
					battle_next_turn()	
				}
			break;

			case BATTLE_PAGES.ITEM:
				set_controls(InputPressed(INPUT_VERB.DOWN)-InputPressed(INPUT_VERB.UP),array_length(global.inventory)-1);
				if (InputPressed(INPUT_VERB.CONFIRM)) {
					var in = index.current;
					var selected_item = global.inventory[in];
					my_cutscene = item_use(selected_item);
					battle_next_turn()
				}
			break;

			default: set_controls(0,0) break;
		}
		if (InputPressed(INPUT_VERB.CANCEL) && page.current != BATTLE_PAGES.FIGHT_ACTION) {previous_page()}
	break;
	
	case BATTLE_TURNS.PLAYER_END:	
		if (!instance_exists(obj_soul)) {instance_create_depth(x,y,DEPTHS.UI,obj_soul)};
		battle_soul_visible(false)
		battle_soul_state(STATE.frozen)
		
		if (no_cutscene()) {//If there isn't any cutscene from the enemies and myself, proceed!
			battle_next_turn()
		}
	break;
	
	case BATTLE_TURNS.TURN_PREPARATION:
		if (oneshot) {
			battle_soul_position(obj_bulletBorder.x,obj_bulletBorder.y)
			with(parEnemy) {
				if (on_battle()) {
					if (dead) {
					 	other.lootbox.gold += gold*2;
					 	other.lootbox.xp += xp;
						region_add_kill(1);
						enemy_event(ENEMY_EVENTS.DEATH,id)
					}
					else if (spared) { //If enemy is spared
					 	other.lootbox.gold += gold;
					 	enemy_event(ENEMY_EVENTS.SPARED,id)
					} else {enemy_event(ENEMY_EVENTS.TURN_PREPARAITON,id)}
				}
			}
			turn_event(TURN_EVENTS.TURN_PREPARAITON)
			oneshot=false
		}
		
		update_enemy_array()

		if (no_cutscene()) { //PREPARATION END
			if (array_length(enemy) > 0) {
				enemy_event(ENEMY_EVENTS.TURN_PREPARAITON_END)
				turn_event(TURN_EVENTS.TURN_PREPARAITON_END)
				
				battle_next_turn()
			} else {battle_end()}
		}
	break;

	case BATTLE_TURNS.TURN:
		if (oneshot) {//TURN START
			if (!instance_exists(obj_soul)) {instance_create_depth(obj_bulletBorder.x,obj_bulletBorder.y,0,obj_soul)};
			obj_bulletBorder.depth = obj_battle_control.depth-10
			battle_soul_state(STATE.free);
			battle_soul_depth(obj_bulletBorder.depth-10)
			battle_soul_visible(true)

			enemy_event(ENEMY_EVENTS.TURN_START);
			turn_event(TURN_EVENTS.TURN_START);

			oneshot=false
		};
		
		enemy_event(ENEMY_EVENTS.TURN)
		global.BATTLE_TIME++;

		if (!instance_exists(parTurn)) { //TURN END
			global.turn++
			global.BATTLE_TIME = 0;
			
			battle_soul_visible(false);
			battle_soul_state(STATE.frozen);
			
			instance_destroy(obj_soul_bullet);
			
			enemy_event(ENEMY_EVENTS.TURN_END)
			turn_event(TURN_EVENTS.TURN_END)
			
			
			battle_next_turn()
		}
	break;
	
	case BATTLE_TURNS.END:
		if (oneshot) {
			obj_bulletBorder.depth = depth+1
			if (instance_exists(obj_soul)) {instance_destroy(obj_soul)}
			bgm_set(noone,0,0);
			global.stat.gold += lootbox.gold;
			global.stat.xp += lootbox.xp;	
			oneshot=false
		}
		if (win_writer.done && (InputPressed(INPUT_VERB.CONFIRM) || InputPressed(INPUT_VERB.SPECIAL))) {
			switch_room(global.saved_player.room)	
		}
		box_reset()
	break;
};
	
if (page.current != prev_page) {
	enemy_event(ENEMY_EVENTS.MENU_SWITCH)	
}

with(par_bt_button) {
	var bt = other.buttons[other.index.current]
	var pg = other.page.current == BATTLE_PAGES.MAIN
	hovering = bt == id && pg;
	if (hovering) {
		with(other) {
			set_heart(other.x+9,other.y+10)	
		}
	}
}

if (play_song && READY) {
	bgm_set(song);
	play_song=false;
}

delay -= (delay>0)
//Reseting the delay (It helps to not skip any turn when battle_next_turn() is called and it Helps with cutscenes shinanigans too)