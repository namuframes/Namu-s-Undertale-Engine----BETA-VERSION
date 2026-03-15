function typewriter(__creator=id,__write_speed=1) constructor {
	write_speed = __write_speed;
	creator = __creator;
	
	index = 0;
	prev_index = index;

	time = 0;
	wait_input = false;
	wait = 0;
	
	
	final_speed = write_speed;
	mod_blip = undefined;
	
	map = undefined;
	
	done = false;
	
	portrait_handler = "";
	sound_handler = "";
	textbox_target_handler = undefined;

	skipable = true
	can_proceed = true
	is_writing = false
	
	static draw = function(_x,_y,text,char_spacing=0,line_spacing="",color=c_white,font=get_draw_font(),xscale=1,yscale=1,angle=0 ,line_length=infinity,blip=undefined) {
		map = draw_each_letter(_x,_y,text,char_spacing,line_spacing,color,font,xscale,yscale,angle,line_length,index, creator);
		static commands = function(argmuents) {
			var arg = argmuents
			var arg_count = array_length(arg)-1;
			switch(arg[0]) {
				case "w": case "wait":
					var wait_time = arg_count >= 1 ? real(arg[1]) :5
					wait += wait_time*max(1,final_speed)
				break;
		
				case "z":
					wait_input = true
				break;
		
				case "spd":
					if (arg_count >= 1) {
						var percentIndex = string_last_pos("%",arg[1])
						if (!percentIndex) {
							final_speed = write_speed*real(arg[1])
						} else {
							var val = string_delete(arg[1],percentIndex,1)
							var percentage = real(val)/100
							final_speed = write_speed*percentage
						}
					} else {final_speed = write_speed}
				break;
			
				case "noskip":
					skipable=false
				break;
				
				case "noproceed":
					can_proceed = false
				break;
		
				case "blip":
					if (arg_count >= 1) {
						mod_blip = asset_get_index(arg[1])
					} else {mod_blip=""}
				break;
				
				case "sound": case "snd":
					var asset = asset_get_index(arg[1])
					if (asset_get_type(asset) == asset_sound) {
						sound_handler = asset //Saving the sound to play it later
					}
				break
			
				case "face":
					var s = arg_count > 0 ? asset_get_index(arg[1]) : "";
					portrait_handler = s; //Saving the portrait
				break;
			
				case "speaker": case "talk": case "talker": case "spk":
					var obj = arg[1];
					if (is_string(obj)) {
						if (string_length(string_digits(obj)) < 5) {
							obj = asset_get_index(obj);
						} else {
							obj = real(string_digits(obj));
						}
					}
		
				    if (instance_exists(obj)) {
						textbox_target_handler = obj
				    }
				break;
			}
		}
		if (map != undefined) {
			done = (index >= map.length)
			if (!done) {
				{// commands
					while (struct_exists(map.letters[index],"command")) {
						commands(map.letters[index].command)
						index+=.5;
					}
				}
				var glyph = map.letters[index]
				prev_index = index;

				if (keyboard_check_pressed(vk_shift) && skipable) { //Skip text
					while(index < map.length) { //Executing certain commands
						if (struct_exists(map.letters[index],"command")) {
							var arg = map.letters[index].command;
							var arg_count = array_length(arg)-1;
							if (arg[0] == "z" || arg[0] == "noskip") {break;}
							commands(map.letters[index].command)
						}
						index+=.5;
					}
				}
				
				wait -= (wait>0)*global.delta
				if (keyboard_check_pressed(vk_enter) && wait_input) {wait_input = false}
				
				if (!wait_input && wait <= 0) {index += final_speed*global.delta}
				
				is_writing = floor(index) != floor(prev_index)
				if (is_writing) {
					if (creator.object_index == obj_txtbox) { //If the creator is txt_box
						if (creator.portrait != portrait_handler) {
							with(creator) {
								//If it isn't paused, update the portrait
								portrait = other.portrait_handler; 
								set_writer_info(portrait); blip = character.sound
							}
						}

						if (instance_exists(textbox_target_handler) && creator.target != textbox_target_handler) {
							creator.change_target(textbox_target_handler)
						}
						
					}
					if (asset_get_type(sound_handler) == asset_sound) {
						audio_play_sound(sound_handler,0,0)	
						sound_handler=""
					}
					if (asset_get_type(blip) == asset_sound && string_count(glyph.char," !?.,*<>[]/´'\"():;{}$") <= 0) {
						audio_play_sound(asset_get_type(mod_blip) != asset_sound ? blip : mod_blip,0,false);
					}

				}
			} else {is_writing = false}
		}
		
	}
}