image_yscale = .5;
depth = obj_bulletBorder.depth-1;

x = obj_bulletBorder.x
y = obj_bulletBorder.y

image_xscale = 0;
image_alpha = .5;

state = 0;
final_damage = 0;
amount = 1;
missed = true
for(var i = 0; i < amount; i++) {
	instance_create_depth(obj_bulletBorder.bbox_left-30*i,y,depth-1,obj_target_mark)
}

kill_self = false

mark = undefined

my_instance = undefined
do_animation = true

finished_job = false
do_hurt = true