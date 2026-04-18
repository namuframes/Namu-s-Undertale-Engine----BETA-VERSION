function typer() constructor{
	map = undefined;
	creator = noone;
	index = 0;

	blip = {
		asset: noone,
		pitchMin: 1,
		pitchMax: 1
	};
	
	done=false
	
	skipable = false
	can_proceed = true;
	is_writing = false;
	do_end=false
	
	wait= {
		time: 0,
		input: false,
		allowed: true
	}
	speed=1
	static commands = function(argmuents) {
		var arg = argmuents
		var arg_count = array_length(arg)-1;
		if (ds_map_exists(global.TYPEWRITER_EVENT,arg[0])) {
			//If you want to make your own command, go to typer_commands
			script_execute_ext(global.TYPEWRITER_EVENT[? arg[0]],arg,1)
		}
	}
	
	static reset = function() {
		index=0
		wait.input = false; wait.time=0;
	}
	
	static add_index = function(_value=1) {
		index += _value;
		index = clamp(index,0,map.length)
	}
	
	static __skip = function() {
		if (skipable && can_proceed && index >= 2) {
			while(index < map.length) { //Executing certain commands
				var glyph = map.letters[floor(index)]
				if (struct_exists(glyph,"command")) {
					if (wait.input) {break}
					commands(glyph.command)
				}

				add_index(1)
			}
			index = clamp(index,0,map.length)
		}
	}
	
	static sound = function(sound,pitchMin=1,pitchMax=pitchMin) {
		blip.asset = sound;
		blip.pitchMin = pitchMin;
		blip.pitchMax = pitchMax;
	}
	
	static step = function() {
		var length = map.length;
		if (!done) {
			var glyph = map.letters[floor(index)]
			var is_command = struct_exists(glyph,"command")
			var prev_index = index;
		
			while (struct_exists(map.letters[floor(index)],"command") && !wait.input && wait.time <= 0) {
				commands(map.letters[floor(index)].command)
				add_index(1)
			};
		
			if (index < length && wait.time<=0 && !wait.input && !is_command) {
				add_index(speed*global.delta)
			};
			wait.time -= (wait.time>0)*global.delta;

			if (wait.input) {if (InputPressed(INPUT_VERB.CONFIRM) || InputCheck(INPUT_VERB.SPECIAL)) {wait.input=false}}
			
			if (InputPressed(INPUT_VERB.CANCEL) || InputCheck(INPUT_VERB.SPECIAL)) {__skip()}

			is_writing = floor(index) != floor(prev_index)
			if (is_writing) {
				var is_valid = string_count(glyph.char," !?.,*<>[]/´'\"():;{}$") <= 0
				var snd = blip.asset
				if (is_valid && asset_get_type(snd) == asset_sound) {
					if (snd != snd_txtgaster && snd != snd_txtsans) {audio_stop_sound(blip.asset)}
					audio_play_sound(blip.asset,0,0,1,0,random_range(blip.pitchMin,blip.pitchMax))
				}
				wait.allowed=true;
				
				if (creator.object_index == obj_txtbox) {
					if (do_end) {creator.next_page()}
				}	
			}
		} else {is_writing=false}
		
		done = (index >= length)
		index = min(index,map.length)
	}
}