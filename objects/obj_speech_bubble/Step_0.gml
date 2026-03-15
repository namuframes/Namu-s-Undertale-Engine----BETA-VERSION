if (curtxt < array_length(text)) {
	var txt = text[curtxt]
	if (is_struct(writer)) {
		if (input_pressed(vk_enter) && writer.done) {next_page()}
	}
}