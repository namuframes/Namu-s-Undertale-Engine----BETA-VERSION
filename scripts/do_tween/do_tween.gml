function do_tween(_object, _tag, _var, _value, _type, _speed, finish_method=undefined) {
	var t = 0
    var foundi = noone;
    with (obj_tweenHandler) {
        if (variable_instance_exists(id, string(_tag))) {foundi = id};
    }
	static create_tween = function(_object, _tag, _var, _value, _type, _speed, finish_method=undefined) {
		var t = instance_create_depth(0, 0, 0, obj_tweenHandler);
		t.object = _object;
		t.var_name = _var;
		t.end_value = _value;
		t.curve_type = _type;
		t.curve.speed = _speed;
		t.destroy_method = finish_method;
		
		t.initialize = true;
		t.creator = id

		variable_instance_set(t, string(_tag), true);
		return t
	}
    if (foundi == noone) {
		t = create_tween(_object, _tag, _var, _value, _type, _speed, finish_method);
	} else {
		if (
        foundi.object != _object ||
        foundi.var_name != _var ||
        foundi.end_value != _value ||
        foundi.curve_type != _type ||
        foundi.curve.speed != _speed
		) {
			instance_destroy(foundi)
			t = create_tween(_object, _tag, _var, _value, _type, _speed, finish_method);
		}
	}
	return t
}
