if (live_call()) {return live_result}
setup_menu()

function create_enemy_array() {
	var center = {
		x: room_width/(array_length(enemy)+1), y: room_height/2
	}
	for(var i = 0; i < array_length(enemy); i++) {
		if (asset_get_type(enemy[i]) == asset_object) {
			var previous_enemy = i > 0 ? enemy[i-1].object_index : enemy[0]
			var previous_width = sprite_get_width(object_get_sprite(previous_enemy))
			var spacing = 10+previous_width
			var spr_width = sprite_get_width(object_get_sprite(enemy[i]))
			var spr_height = sprite_get_height(object_get_sprite(enemy[i]))
			var sprite_center = (spr_width/2)
			var x_offset = sprite_get_xoffset(object_get_sprite(enemy[i]))
			var y_offset = sprite_get_yoffset(object_get_sprite(enemy[i]))
			var _x = center.x+x_offset
			var _y = center.y+y_offset
			enemy[i] = instance_create_depth((_x-sprite_center)+spacing*i,(_y-spr_height),0,enemy[i]);
			with(enemy[i]) {event_user(ENEMY_EVENTS.START)}
		}
	}
}

function check_win() {
	if (no_cutscene()) {//If there isn't any cutscene proceed
		if (array_length(enemy) <= 0) {TURN=BATTLE_TURNS.END} else {return false} //If the enemy array is empty, the battle is OVER!!
	} else {return false}
}

function enemy_list(_page=page.current, show_hp=false) {
	//Drawin' the enemy list
	if (event_type == ev_gui || event_type == ev_draw) {
		for(var i = 0; i < array_length(enemy); i++) {
			var __y = txt.y+16*i, __x = txt.x+sprite_get_width(spr_soul)+4
			var c = enemy[i].spareable ? TEXTconfig.color2 : TEXTconfig.color
			if (show_hp) {
				var hp_x = __x+string_width_ext("* "+enemy[i].name,LETTER_SPACING,-1), hp_y = __y+4
				draw_hp(hp_x,hp_y,50,8,enemy[i].hp,enemy[i].hpmax,c_lime,c_red)
			}
			draw_each_letter(__x,__y,"* "+enemy[i].name,LETTER_SPACING,,c,fnt_main)
			if (index.current == i) {set_heart(__x+heart_offset.x,__y+heart_offset.y+2)}
		}
	} else {
		if (input_pressed(vk_enter)) { //If enter is pressed, go to the setted page and set target enemy
			set_target_enemy(index.current)
			set_page(_page)	
		}
	}
}
function no_cutscene() {
	var endd = true //Checking if there isn't any cutscene from myself or the enemies
	with(parEnemy) {
		if (on_battle()) {
			if (instance_exists(my_scene)) {endd = false}
		}
	}
	if (instance_exists(my_cutscene) || instance_exists(parCutscene)) {endd = false}
	if (delay > 0) {endd =false}
	//if (instance_exists(parCutscene) || instance_exists(my_cutscene) || delay > 0) {endd = false}
	return endd
}

function set_target_enemy(_index) {
	//Set the target enemy
	target_enemy.index = _index //Grabbing index
	target_enemy.instance = enemy[_index] //Grabbing instance
}

function soul_visible(boolean) {
	if (instance_exists(obj_soul)) {obj_soul.visible = boolean}	
}

function soul_state(state) {
	if (instance_exists(obj_soul)) {obj_soul.state = state}	
}
	
function soul_position(_x,_y,_smth=undefined) {
	set_heart(_x,_y,_smth)	
}

function update_enemy_array() {
	with(parEnemy) {
		if (on_battle()) {
			var ind = 0
			for(var i = 0; i < array_length(other.enemy); i++) {
				if (other.enemy[i] == id) {ind = i; break}
			}
			if (spared || dead) {enemy_remove(ind);}
		}
	}

}

TURN = BATTLE_TURNS.PLAYER_INIT
global.BATTLE_TIME = 0;
global.turn = 0;
did_scene = false;
enemy = [];
song = undefined;
event_user(0)

lootbox = {
	xp: 0,
	gold: 0
}

main_button = function(_sprite) constructor {
	sprite = asset_get_type(_sprite) == asset_sprite ? _sprite : spr_bt_fight
	selectable = true
}

actions = []
actions[BATTLE_PAGES.FIGHT] = new main_button(spr_bt_fight)
actions[BATTLE_PAGES.ACT] = new main_button(spr_bt_act)
actions[BATTLE_PAGES.ITEM] = new main_button(spr_bt_item)
actions[BATTLE_PAGES.MERCY] = new main_button(spr_bt_mercy)

mercy_actions = ["Spare","Flee"]
wait_damage = false //For damage animation
my_cutscene = undefined
delay = 1; 
//Delay makes sure that cutscenes created with c_name via enemy works
//And used for when battle_next_turn is called to ensure that it's called once

heart_offset = {
	x: (sprite_get_xoffset(spr_soul)*.5)-16,
	y: (sprite_get_yoffset(spr_soul)*.5)+2
}

target_enemy = {
	instance: undefined,
	index: 0
}
	
txt = {
	x: 0,
	y: 0
}

page.current = BATTLE_PAGES.MAIN