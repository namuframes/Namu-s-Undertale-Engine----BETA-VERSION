creator = undefined;
index = 0
moves = [];
variable_instance_set(id,CUTSCENE_VARIABLE,[])


player_nocontrol = false

wait = {
	time: -1,
}

tween_list = array_create(0)
my_box = []

do_action = function() {
	var array = variable_instance_get(id,CUTSCENE_VARIABLE)
	if (index > array_length(array)-1) {
		if (array_length(my_box) <= 0) {
			instance_destroy()
		}
	} else {
		var action = array[index]
		var agrs = action.args
		script_execute_ext(action.script,action.args,0);
	}
}

moving_action = [];

do_movement = function() {
	if (array_length(moves) > 0) {
		for (var i = 0; i < array_length(moves); i++) {
			var stru = moves[i];
			stru.target.x = linearVar(stru.target.x,stru.x,stru.speed);
			stru.target.y = linearVar(stru.target.y,stru.y,stru.speed);
			if (stru.auto_sprite) {
				with(stru.target) {
					var hsp = sign(x-xprevious); 
					var vsp = sign(y-yprevious);
					
					if (sprite_index = sprite[DIR.RIGHT] && hsp < 0) {sprite_index = sprite[DIR.LEFT]}  if (sprite_index = sprite[DIR.LEFT] && hsp > 0) {sprite_index = sprite[DIR.RIGHT]}
					if (sprite_index = sprite[DIR.DOWN] && vsp < 0) {sprite_index = sprite[DIR.UP]}		if (sprite_index = sprite[DIR.UP] && vsp > 0) {sprite_index = sprite[DIR.DOWN]}
					
					if (vsp == 0) {
						if (hsp < 0) {sprite_index = sprite[DIR.LEFT]};
						if (hsp > 0) {sprite_index = sprite[DIR.RIGHT]};
					}

					if (hsp == 0) {
						if (vsp < 0) {sprite_index = sprite[DIR.UP]};
						if (vsp > 0) {sprite_index = sprite[DIR.DOWN]};
					}
					
					image_speed = 1
				}
			}	
			if (stru.target.x == stru.x && stru.target.y == stru.y) {
				if (stru.auto_sprite) {
					stru.target.image_speed = 0;
					stru.target.image_index = 0;
				}	
				array_delete(moves,i,1)
			}
		}
	}	
}



