text = [""]
outline_size = 1
curtxt = 0
target = undefined
font = fnt_dotum
writer = new typewriter(id)

length = 0

side = 1
surf = -1
mute = false
blip = snd_txt1
next_page = function() {
	var can_procced = true
	if (instance_number(object_index) > 1) {
		for(var i = 0; i < instance_number(object_index); i++) {
			var bubble = instance_find(object_index,i)
			with(bubble) {
				if (!writer.done) {can_procced=false}
			}
		}
	}
	if (can_procced) {
		curtxt++;
		writer.index = 0;
		writer.timer = 0;
		
		if (curtxt > array_length(text)-1) {instance_destroy(object_index)}
	}
}
check_mute = function() {
	if (instance_number(object_index) > 1) {
		for(var i = 0; i < instance_number(object_index); i++) {
			var bubble = instance_find(object_index,i)
			if (string_length(bubble.text) >= string_length(text)) {
				mute=true
			}
		}
	}
}
check_mute()

depth = -99