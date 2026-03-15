event_inherited();

hsp = 0;
vsp = 0;
spd = PLAYER.overworld_speed;

direction_animation = function() {
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
	
function is_solid(object=obj_collision, h=hsp, v=vsp) {
	var i = instance_place(x+h,y+v,object)
	if (i && variable_instance_exists(i,"colideable")) {
		return i.colideable
	}
	return false
}
	
function frisk_dance(object=obj_collision){
	if (!is_solid(,0,-spd)) {exit};

	if (instance_place(x,y-spd,object)) {
		if (keyboard_check(vk_down) && keyboard_check(vk_up)) {
			if (face == DIR.LEFT || face == DIR.RIGHT) {face = DIR.UP};
			vsp += spd;
		};
	};
}

function collision(object=obj_collision) {
	if (!is_solid()) {exit};

	if (place_meeting(x+hsp,y,object)) {
		if(!place_meeting(x+hsp,y-spd,object)) {y-=spd}
		else if(!place_meeting(x+hsp,y+spd,object)) {y+=spd} else {

			while (!place_meeting(x+sign(hsp),y,object)) {x += sign(hsp);}
			hsp = 0;
		};
	};

	if (place_meeting(x,y+vsp,object)) {
		if(!place_meeting(x-spd,y+vsp,object)) {x-=spd}
		else if(!place_meeting(x+spd,y+vsp,object)) {x+=spd} else {
			
			while (!place_meeting(x,y+sign(vsp),object)) {y += sign(vsp)}
			vsp = 0
		}
	}
}
	
ready_to_cutscene = false