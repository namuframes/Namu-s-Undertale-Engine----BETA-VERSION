event_inherited()
image_xscale = .5;
image_yscale = .5
image_speed = 0
inv_frame = 0;

hsp = 0; vsp = 0;
spd = PLAYER.soul_speed;

follow_border = true

state = STATE.free

function collision(object=obj_collision) {
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