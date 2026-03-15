if (state == STATE.frozen) {exit}
if (inv_frame > 0) {
	image_speed = 1;
	var m = (delta_time / 1000000)*1.5
	inv_frame -= m;
} else {image_speed = 0; image_index = 0}

hsp = ((keyboard_check(vk_right)-keyboard_check(vk_left))*spd)*global.delta
vsp = ((keyboard_check(vk_down)-keyboard_check(vk_up))*spd)*global.delta

if (keyboard_check(vk_left) && keyboard_check(vk_right)) {hsp = -1*spd}
if (keyboard_check(vk_up)  && keyboard_check(vk_down))  {vsp = -1*spd}

collision();

x += hsp;
y += vsp;

