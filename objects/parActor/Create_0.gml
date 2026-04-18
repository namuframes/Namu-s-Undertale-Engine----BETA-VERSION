event_inherited();

function look_at_player() {
	face = direction_to_face(x,y,obj_player.x,obj_player.y)
}

function find_sprite(_sprite,fallback=sprite_index) {
	if (asset_get_type(_sprite) != asset_sprite) {
		return fallback
	}
	return _sprite
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
	if (collision_rectangle(_x1,_y1,_x2,_y2,obj_player_interactor,false,true) && !player_cantmove()) {
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
	if (!instance_exists(my_scene)) {
		look_at_player()
		if (array_length(scenes) > 0) {
			if (is_method(scenes[page])) {
				script_execute(scenes[page])	
			}
			check_custenceCommands()
			page+= (page < array_length(scenes)-1)
		} else {check_custenceCommands(,false)}
		reset_sprite = true
	}
}
	
face_to_direction = function(hsp,vsp) {
	if (hsp != 0 || vsp != 0) {
		if (vsp == 0) {
			if (hsp < 0) {face = DIR.LEFT};
			if (hsp > 0) {face = DIR.RIGHT};
		}

		if (hsp == 0) {
			if (vsp < 0) {face = DIR.UP};
			if (vsp > 0) {face = DIR.DOWN};
		}
	
		if (face = DIR.RIGHT && hsp < 0) {face = DIR.LEFT}		if (face = DIR.LEFT && hsp > 0) {face = DIR.RIGHT}
		if (face = DIR.DOWN && vsp < 0) {face = DIR.UP}		if (face = DIR.UP && vsp > 0) {face = DIR.DOWN}
	}
}
	
follow_behaviour = function() {
	colideable=false
	if (instance_exists(obj_player)) {
		if (array_length(obj_player.party_input) >= follow_index) {
			var input = obj_player.party_input[follow_index-1];
			if (is_struct(input)) {
				x = linearVar(x,input.x,obj_player.spd);
				y = linearVar(y,input.y,obj_player.spd);
				if (x != xprevious || y != yprevious) {
					image_speed = 1; 
					face_to_direction(x-xprevious,y-yprevious)
					sprite_index = sprite[face]
				} else {
					if (floor(image_index) % 2 == 0) {image_speed=0}	
				}
			}
		}
	}
}

state = STATE.free
scenes = [];
page = 0;
talk = false;
done_talking = false;

my_scene = noone

reset_sprite = false;

image_speed=0;

face = DIR.DOWN;
sprite[DIR.DOWN] = find_sprite(sprite_down);
sprite[DIR.LEFT] = find_sprite(sprite_left);
sprite[DIR.UP] = find_sprite(sprite_up);
sprite[DIR.RIGHT] = find_sprite(sprite_right);

sprite_talk[DIR.DOWN] = find_sprite(talk_down,sprite[DIR.DOWN]);
sprite_talk[DIR.LEFT] = find_sprite(talk_left,sprite[DIR.LEFT]);
sprite_talk[DIR.UP] = find_sprite(talk_up,sprite[DIR.UP]);
sprite_talk[DIR.RIGHT] = find_sprite(talk_right,sprite[DIR.RIGHT]);

prev_sprite = find_sprite(sprite_down);
prev_face = face;
prev_image_speed = image_speed;

follow_player = false;
follow_index = 0;
did_scene = false
set_talk_sprite=true