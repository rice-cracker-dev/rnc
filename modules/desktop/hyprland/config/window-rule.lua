hl.window_rule({
	match = { title = "flameshot" },
	no_anim = true,
	move = { 0, 0 },
	pin = true,
	fullscreen_state = 2,
	float = true,
})

hl.layer_rule({
	match = { namespace = "quickshell" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	match = { namespace = "launcher" },
	blur = true,
})
