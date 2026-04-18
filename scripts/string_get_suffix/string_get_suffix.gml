function string_get_suffix(_str) {
	var parts = string_split(_str, "_");
	
	if (array_length(parts) <= 1) return "";
	
	var last = parts[array_length(parts) - 1];
	
	var result = "";
	for (var i = 1; i <= string_length(last); i++) {
		var c = string_char_at(last, i);
		if (c >= "0" && c <= "9") break;
		result += c;
	}
	
	return result;
}