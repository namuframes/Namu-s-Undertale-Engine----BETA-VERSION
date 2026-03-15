enum ITEM_TYPES {
	CONSUMEABLE,
	ARMOR,
	WEAPON,
	SPECIAL
}



function item() constructor {
	name = ["DEBUG ITEM"];
	description = ["DESCRIPTION"];
	type = ITEM_TYPES.CONSUMEABLE;
	stats = {
		defense: 0,
		damage: 0,
		heal: 0
	}
}
	
function item_is_valid(_item) {
	if (!is_struct(_item)) {
		show_debug_message($"{_item} not found!")
		return false
	} else {
		return true
	}
}

function item_add(_item) {
	if (item_is_valid(_item)) {array_push(global.inventory,_item);	}
}

function item_name(ITEM,WICH=0) {
	if (item_is_valid(ITEM)) {
		var output = ITEM.name[0]
		if (array_length(ITEM.name) >= WICH) {
			var nm = ITEM.name[WICH]
			if (string_length(nm) > 0) {output = nm};
		}
		return output
	}
}

function item_description(ITEM,WICH=0) {
	if (item_is_valid(ITEM)) {
		var output = ITEM.description[0]
		if (array_length(ITEM.description) >= WICH) {
			var nm = ITEM.description[WICH]
			if (string_length(nm) > 0) {output = nm};
		}
		return output
	}
}

function equip_item(_item) {
	if (_item.type == ITEM_TYPES.ARMOR) {global.stat.armor = _item;}
	if (_item.type == ITEM_TYPES.WEAPON) {global.stat.weapon = _item;}
}

function item_weapon() : item() constructor {type = ITEM_TYPES.WEAPON;}

function item_armor() : item() constructor {type = ITEM_TYPES.ARMOR;}

function item_consumeable() : item() constructor {type = ITEM_TYPES.CONSUMEABLE;}

function item_stick() : item_weapon() constructor {
	name = ["Stick"];
	description = ["* \"Stick\" - Weapon AT 0\n* Its bark is worse than\nits bite.", "<spr_stick> "];
	stats.damage = 2;
};

function item_toy_knife() : item_weapon() constructor {
	name = ["Toy Knife"];
	description = ["* \"Toy Knife\" - Weapon AT 3"];
	stats.damage = 3;
};

function item_bandage() : item_consumeable() constructor {
	name = ["Bandage"];
	description = ["* \"Bandage\" - Heals 10 HP\n* It has already been used several times."];
	stats.heal = 10;
};
