
function wait_frame(frames=[]){
	if (array_length(frames) > 0) {
		for(var i = 0; i < array_length(frames); i++) {
			if (floor(image_index) == frames[i]) {return true}
		}
	} else {return true}
}