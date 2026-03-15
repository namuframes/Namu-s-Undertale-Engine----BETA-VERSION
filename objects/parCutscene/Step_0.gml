if (wait.time > -1) {wait.time-=global.delta}
for(var i = 0; i < array_length(my_box); i++) {
	if (!instance_exists(my_box[i])) {array_delete(my_box,i,1)}
}

do_action()

do_movement();