if (talk) {
	image_speed = 1;
	finished_talk=false;
} else {
	if (round(image_index) <= 0 && !finished_talk) {
		image_speed = 0;
		finished_talk = true
	}
}

if (!instance_exists(my_scene) && reset_sprite) {
	sprite_index = prev_sprite;
	page+= (page < array_length(scenes)-1);
	reset_sprite = false
}	
step();

