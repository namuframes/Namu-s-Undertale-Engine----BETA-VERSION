if (keyboard_check(vk_alt)) {
	var w = (mouse_wheel_up()-mouse_wheel_down())
	refalpha += 0.25*w;
	refalpha = clamp(refalpha,0,1)
	
	index += InputPressed(INPUT_VERB.RIGHT)-InputPressed(INPUT_VERB.LEFT)
}