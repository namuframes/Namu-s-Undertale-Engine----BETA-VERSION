y -= 20
event_inherited();

set_action("Terrorize", function() {
	//c_dialogue("* You raise your arms and\nwiggle your fingers.\nWhimsun freaks out.")
	c_dialogue("* I'm testing the text line break... since some times... it breaks in the wrong way!")
})
set_action("Console", function() {
	c_dialogue("* Halfway through your first\nword, Whimsun bursts into\ntears and runs away.")
	c_wait_dialogue()
	c_var(id,["spared",true])
})


time = random_range(0,120)

wont_die = false;
c = random_range(-100,100);
image_index = irandom(image_number)
speech_bubble.y -= 20;