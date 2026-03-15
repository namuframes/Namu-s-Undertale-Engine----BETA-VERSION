global.input_delay = 0
global.name = "Chara";
global.stat = {
	weapon: "",
	attack: 0,
	armor: "",
	defense: 0,
	level: 1,
	hp: 20,
	hp_max: 20,
	gold: 0,
	xp: 0
};

global.world = {
	x: 0,
	y: 0,
	room: 0
}

global.inventory = []
item_add(new item_toy_knife())
item_add(new item_bandage())

global.fullscreen = false;
global.delta =  NATIVE_FPS/max(1,FPS);

global.ENCOUNTER_ID = ENCOUNTER_ID.SPECIAL_WHIMSUN;
global.debug = false;