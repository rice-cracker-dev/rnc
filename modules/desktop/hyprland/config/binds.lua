local function withUWSM(cmd)
	return "uwsm app -- " .. cmd
end

local function flameshotExec(cmd)
	return string.format("flameshot %s -r -p ~/Pictures/ | wl-copy", cmd)
end

local moveBinds = {
	l = "h",
	r = "l",
	u = "k",
	d = "j",
}

-- apps
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(withUWSM("kitty")))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(withUWSM("hyprpicker -a")))
hl.bind("SUPER + D", hl.dsp.exec_cmd(withUWSM("fuzzel")))

-- flameshot
hl.bind("PRINT", hl.dsp.exec_cmd(flameshotExec("screen")))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd(flameshotExec("gui")))
hl.bind("ALT + PRINT", function()
	local window = hl.get_active_window()
	if window == nil then
		return
	end

	local region = string.format('"%dx%d+%d+%d"', window.size.x, window.size.y, window.at.x, window.at.y)
	hl.dispatch(hl.dsp.exec_cmd(flameshotExec("gui --region " .. region)))
end)

-- pipewire
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- general binds
hl.bind("SUPER + M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + P", hl.dsp.window.pin())
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

for direction, key in pairs(moveBinds) do
	hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

for w = 1, 9 do
	hl.bind("SUPER + " .. w, hl.dsp.focus({ workspace = w }))
	hl.bind("SUPER + SHIFT + " .. w, hl.dsp.window.move({ workspace = w, follow = true }))
end
