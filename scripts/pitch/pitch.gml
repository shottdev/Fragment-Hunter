// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function pitch(_sound, _min, _max)
{
	var _pitch = random_range(_min, _max);
	audio_play_sound(_sound, 0, false, , , _pitch);
}