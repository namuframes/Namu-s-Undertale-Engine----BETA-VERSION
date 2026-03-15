function create_dialogue(dialogue, _target=id,_creator=id){
	var box = -1
	var txt = is_array(dialogue) ? dialogue : [dialogue]

	with (obj_txtbox) {
		var match = true;
		for (var i = 0; i < array_length(txt); i++) {
			if (text[i] != txt[i] || target != _target) {match = false break;}
		}
		if (match) {box = id;}
	}

	if (box = -1) {
		box = instance_create_depth(0,0,0,obj_txtbox);
		box.target = _target;
		box.creator = _creator;
		box.text = txt;
	}

	return box;
}


function create_speech_bubble(dialogue, _target=id,_side=-1){
	var box = -1
	var txt = is_array(dialogue) ? dialogue : [dialogue]
	/*
	with (obj_speech_bubble) {
		var match = true;
		for (var i = 0; i < array_length(txt); i++) {
			if (text[i] != txt[i] || target != _target) {match = false break;}
		}
		if (match) {box = id;}
	}
*/
	if (box = -1) {
		box = instance_create_depth(0,0,0,obj_speech_bubble)
		box.target = _target
		//box.side = _side
		box.mp = preload_each_letter(txt,,,fnt_dotum,.5,.5,infinity,id)
		box.text = txt;
	}

	return box;
}