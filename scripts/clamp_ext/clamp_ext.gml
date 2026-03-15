// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function clamp_ext(variable,_min,_max){
if (variable < _min) {variable = _max};
if (variable > _max) {variable = _min};
return variable
}