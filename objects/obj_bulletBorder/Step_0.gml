x = linearVar(x,target.x,target.spd);
y = linearVar(y,target.y,target.spd);


width = linearVar(width,target.width,target.spd);
height = linearVar(height,target.height,target.spd);

image_xscale = width/sprite_get_width(sprite_index)
image_yscale = height/sprite_get_height(sprite_index)