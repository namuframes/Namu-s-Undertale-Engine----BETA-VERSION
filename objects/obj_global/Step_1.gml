global.input_delay = max(0,global.input_delay-1)
var damage = is_struct(global.stat.weapon) ? global.stat.weapon.stats.damage : 0
var defense = is_struct(global.stat.armor) ? global.stat.armor.stats.defense : 0
global.stat.attack = (2*global.stat.level) + damage
global.stat.defense = (round(global.stat.level/4)) + defense