function create_cutscene(_script,_target=id){
	var i = instance_create_depth(0,0,0,parCutscene)
	if (is_method(_script)) {
		with(i) {script_execute(_script)};
	} else if (is_array(_script)) {
		variable_instance_set(i,CUTSCENE_VARIABLE,_script)
	}
	i.creator = _target
	return i;
}