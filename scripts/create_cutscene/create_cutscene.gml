function create_cutscene(_info,_target=id){
	var i = instance_create_depth(0,0,0,parCutscene)
	if (is_method(_info)) {
		with(i) {script_execute(_info)};
	} else if (is_array(_info)) {
		variable_instance_set(i,CUTSCENE_VARIABLE,_info)
	}
	i.creator = _target
	return i;
}