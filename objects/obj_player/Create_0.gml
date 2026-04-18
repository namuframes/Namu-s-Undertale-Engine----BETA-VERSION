event_inherited();

hsp = 0;
vsp = 0;
spd = PLAYER.overworld_speed;
	
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
		if (InputCheck(INPUT_VERB.DOWN) && InputCheck(INPUT_VERB.UP)) {
			if (face == DIR.LEFT || face == DIR.RIGHT) {face = DIR.UP};
			vsp += spd;
			face=DIR.DOWN
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

party_input_struct = {
	x: x,
	y: y,
	face: face
}

party_input=array_create(array_length(global.party)*10,variable_clone(party_input_struct))