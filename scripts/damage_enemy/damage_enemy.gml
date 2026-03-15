function damage_enemy(damage,target=obj_battle_control.target_enemy.instance,user_event=ENEMY_EVENTS.HURT) {
	with(obj_battle_control) {
		if (damage > 0 && !target.invulnerable) {
			target.hp -= damage;
			target.damage_taken = damage;
			target.color = c_red;
		} else {
			target.damage_taken = "MISS";
			target.txtDamage.color = c_gray;
		}
		target.txtDamage.visible = true;
		with(target) {event_user(user_event)} //Execute hurt animation if i'm allowed to
	}
}