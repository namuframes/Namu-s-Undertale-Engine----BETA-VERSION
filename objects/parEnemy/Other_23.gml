/// @description DEATH
audio_play_sound(snd_monster_death,0,0,1,0,.8)
my_scene = instance_create_depth(x,y,depth-1,obj_evaporator,{target: id})
instance_destroy();