var w = sprite_get_width(spr);
var h = sprite_get_height(spr);

for (var i = 0; i < array_length(pixels); i++) {
	var p = pixels[i]
	if (peee >= i) {
		if (p.alpha > 0) {p.alpha-=p.alpha_loss*global.delta}
		p.smh = lerp(p.smh,0,.1*global.delta)
		p.vely += .5*global.delta
		p.offy -= (p.vely*.1)*global.delta;
	    p.offx += (p.velx*p.smh)*global.delta;
		if (p.offsize > -size) {p.offsize -= .01*global.delta}
	}
	
	if (p.alpha <= 0 || p.offsize <= -size) {
		array_delete(pixels,i,1)
	}
}

if (peee < array_length(pixels)) {peee+=spd}
if (array_length(pixels) <= 0) {instance_destroy()}