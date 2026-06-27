local touchpad_enabled = false
local touchpad_id = "elan0412:01-04f3:3240-touchpad"

local function toggle_touchpad()
	touchpad_enabled = not touchpad_enabled
	hl.device({ name = touchpad_id, enabled = touchpad_enabled })
end

hl.bind("SUPER + T", toggle_touchpad)

toggle_touchpad()
