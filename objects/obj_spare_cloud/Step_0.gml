if (live_call()) {return live_result}
image_alpha -= 0.03*global.delta;
speed = lerp(speed,0,sm)
image_angle = lerp(image_angle,0,sm)
image_xscale = lerp(image_xscale,target_xscale,sm*1.5)
image_yscale = lerp(image_yscale,target_yscale,sm*1.5)