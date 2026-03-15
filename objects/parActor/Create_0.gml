event_inherited();

function look_at_player() {
	sprite_index = sprite[direction_to_face(x,y,obj_player.x,obj_player.y)]	
}

function find_sprite(_sprite) {
	var res = asset_get_index(_sprite)
	if (res = -1) {res = sprite_index}
	return res
}
	
function do_walk_animation() {
	if (round(x) != round(xprevious) || round(y) != round(yprevious)) {
		image_speed = 1;
	} else if (wait_frame([0,2])) {image_speed = 0}	
}
	
function addscene(s) {
	array_push(scenes, s);
}

interaction_behaviour = function() {
	var _x1 = bbox_left-interaction_left, _y1 = bbox_top-interaction_top, _x2 = bbox_right+interaction_right, _y2 = bbox_bottom+interaction_bottom
	if (collision_rectangle(_x1,_y1,_x2,_y2,obj_player_interactor,false,true)) {
		interaction();
	}
}

step = function() {
	interaction_behaviour();	
}
	
draw = function() {
	event_inherited();
}

interaction = function() {
	if ((array_length(scenes) > 0 || variable_instance_exists(id,CUTSCENE_VARIABLE)) && !instance_exists(my_scene)) {
		look_at_player()
		reset_sprite = true
		if (is_method(scenes[page])) {
			script_execute(scenes[page])	
		}
		check_custenceCommands()
	}
}

state = STATE.free
scenes = [];
page = 0;
talk = false
finished_talk = false

image_speed = 0

my_scene = noone

reset_sprite = false;

prev_sprite = find_sprite(sprite_down)

face = DIR.DOWN;
sprite[DIR.DOWN] = find_sprite(sprite_down);
sprite[DIR.LEFT] = find_sprite(sprite_left);
sprite[DIR.UP] = find_sprite(sprite_up);
sprite[DIR.RIGHT] = find_sprite(sprite_right);