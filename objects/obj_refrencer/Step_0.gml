if (mouse_wheel_up()) {
	refalpha += 0.25;
} else if (mouse_wheel_down()) {
	refalpha -= 0.25;
}

refalpha = clamp(refalpha,0,1)

if (keyboard_check(vk_alt)) {
	index += keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)
}