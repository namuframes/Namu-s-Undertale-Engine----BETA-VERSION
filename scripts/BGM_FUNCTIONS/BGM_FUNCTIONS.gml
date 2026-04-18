function bgm_set(_music, _fadeouttime = 5, _fadeintime = 5) {
	with(obj_musicManager)	{
		targetSongAsset = _music;
		endFadeOutTime = _fadeouttime;
		startFadeInTime = _fadeintime;
	}
}

function bgm_pause() {
	with(obj_musicManager)	{
		audio_pause_sound(songInstance)
	}
}

function bgm_resume() {
	with(obj_musicManager)	{
		audio_resume_sound(songInstance)
	}
}