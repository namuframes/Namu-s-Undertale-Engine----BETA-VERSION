/// @description HURT
c_shake(id,"x",hp_previous-hp,2);	
c_custom(function() {
	if (!instance_exists(obj_shaker) && !tween_exists("txtDamage_tweenY")) {
		end_action()
	}
});
c_wait(.5)