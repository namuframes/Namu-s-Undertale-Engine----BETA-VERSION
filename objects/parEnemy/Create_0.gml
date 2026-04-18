//Searching for a variable that isn't here?
//Check variable definitions, probably it's there
on_battle = function() { //Returns weather the enemy is on battle or not
	var arry = obj_battle_control.enemy;
	for(var i = 0; i < array_length(arry); i++) {
		if (arry[i] == id) {return true};
	}
	return false;
}

in_battle = function() {return on_battle()} //Same shit as on battle lol

function set_action(_name,_script=undefined,index=array_length(action)) {
	//If you want to set an action, this is function is quite usefull
	action[index] = {
		name: _name, //Name of the action, this will appear in the menu!
		script: _script //the script it'll execute
		//if it isn't a script, battle_controller will execute an user event based on the index
	}	
}

function show_damage(boolean) {
	if (boolean) {
		do_tween(id,"txtDamage_tweenY","txtDamage_tweenY",0,EASE_OUT_BACK,1)

		//Fade in Damage Text alpha
		txtDamage.alpha += (txtDamage.alpha<1)*0.25
		
		//Drawing the damage text!
		draw_set_alpha(txtDamage.alpha)	draw_set_halign(fa_middle)	draw_set_font(fnt_hachiro)
		var c = txtDamage.color
		var hp_height = hpbar.height*is_numeric(damage_taken)
		draw_text_transformed_colour(hpbar.x+hpbar.width/2,((hpbar.y-hp_height-string_height("I")/2)/txtDamage.yscale)+txtDamage_tweenY,damage_taken,txtDamage.xscale,txtDamage.yscale,0,c,c,c,c,draw_get_alpha())
		
		draw_set_halign(fa_left)	draw_set_font(-1)	draw_set_alpha(1)	
	} else {
		//reseting everything for the next time this is called!
		txtDamage_tweenY = 10
		txtDamage.alpha = 0
	}
}

function show_hp(boolean = (attacked)) { //Use this on DRAWs!
	if (boolean) { //If condition is meet, execute the code!
		//Fake hp is used on the HP bar to do the cool hp drain effect
		do_tween(id,"hpTween","fakehp",hp,EASE_LINEAR,2)
		//Drawing the HP bar
		if (is_numeric(damage_taken)) draw_hp(hpbar.x, hpbar.y,hpbar.width,hpbar.height,fakehp,hpmax,c_lime,#4C4C4C); //Drawing the hp bar
	}
	if (instance_exists(obj_attack_grid)) {
		show_damage(txtDamage.visible);
	}
}

function limb_add(tag,_sprite,_x,_y,_xscale=image_xscale,_yscale=image_yscale,_image_angle=image_angle,_image_blend=image_blend,_image_alpha=image_alpha,follow=true) {
	struct_set(limbs,tag,{
		x: _x,
		y: _y,
		offx: 0,
		offy: 0,
		offxscale: 0,
		offyscale: 0,
		offangle: 0,
		image_angle: _image_angle,
		image_alpha: _image_alpha,
		image_xscale: _xscale,
		image_yscale: _yscale,
		image_blend: _image_blend,
		sprite_index: _sprite,
		image_index: 0,
		follow: follow
	})
}

function limbs_set(name,variable,value) {
	if (struct_exists(limbs,name)) {
		struct_set(struct_get(limbs,name),variable,value)	
	}
}

function limbs_get(name,variable) {
	if (struct_exists(limbs,name)) {
		return struct_get(limbs,name);		
	}
	return -1
}

function limbs_draw() {
	var arr = variable_struct_get_names(limbs);
	var length = variable_struct_names_count(limbs);
	for(var i = 0; i < length; i++) {
		var p = struct_get(limbs,arr[i])
		var fol = {
			x: p.follow ? x : 0,
			y: p.follow ? y : 0,
			image_angle: p.follow ? image_angle : 0
		}
		draw_sprite_ext(p.sprite_index,p.image_index,p.x+fol.x+p.offx,p.y+fol.y+p.offy,p.image_xscale+p.offxscale,p.image_yscale+p.offyscale,p.image_angle+p.image_angle+p.offangle,image_blend,image_alpha);
	}
}

hp = hpmax;
hp_previous = hp;
fakehp = hp;

attacked = false;

spareable = false;
spared = false;

my_scene = undefined;

dead = false
can_die = true //Allows death

damage_taken = 0;
action = []

speech_bubble = { //The position that the bubble is supposed to be!
	x_left: bbox_left,
	x_right: bbox_right,
	y: bbox_top+sprite_height/2,
	y_top: bbox_top
}

hpbar = { //Hp bar info
	x:0,
	y:0,
	width: max(hpmax*4,40),
	height: 10,
	alpha: 0,
	xoffset: 0, //offset x
	yoffset: 0 //offset y
}
txtDamage = { //Damage text info
	xscale: 2.5,
	yscale: 2.5,
	alpha: 0,
	color: c_red,
	visible: false
}
txtDamage_tweenY=0

limbs = {};

set_action("Check",0) // Creating "Check" action