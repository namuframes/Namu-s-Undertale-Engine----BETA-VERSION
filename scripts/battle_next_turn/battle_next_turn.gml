function battle_next_turn() {
	with(obj_battle_control) {
		if (delay<=0) {
			battle_set_turn(TURN+1)
			TURN = clamp_ext(TURN,0,BATTLE_TURNS.TURN)
		}
	}
		
}
