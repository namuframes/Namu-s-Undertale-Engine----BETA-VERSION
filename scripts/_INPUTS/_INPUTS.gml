keyboard_set_map(ord("W"),vk_up)
keyboard_set_map(ord("A"),vk_left)
keyboard_set_map(ord("S"),vk_down)
keyboard_set_map(ord("D"),vk_right)
keyboard_set_map(ord("Z"),vk_enter)
keyboard_set_map(ord("X"),vk_shift)
keyboard_set_map(ord("C"),vk_control)

function input_pressed(_button) {	
	if ((global.input_delay <= 0) && keyboard_check_pressed(_button)) {
		global.input_delay = DEFAULT_INPUTDELAY
		return true
	}
	return false
}

function input_released(_button) {
	if (global.input_delay <= 0 && keyboard_check_released(_button)) {
		global.input_delay = DEFAULT_INPUTDELAY
		return true
	}
	return false
}