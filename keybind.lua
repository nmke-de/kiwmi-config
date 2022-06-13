action = {
	["E"]	= "kixit",
	["Return"] = "foot",
	["r"]	= "$(dmenu_path | dmenu-wl)",
	["q"]	= "kiwmic 'v = kiwmi:focused_view() if v then v:close() end'",
	["F"]	= "foot filet",
	["s"]	= "notify-send \"New Screenshot\" $(gg $(echo \"all\ncurrent\nselection\nwindow\" | dmenu-wl))",
	["XF86AudioRaiseVolume"]	= "amixer set Master 5dB+",
	["XF86AudioLowerVolume"]	= "amixer set Master 5dB-",
	["XF86AudioMute"]	= "amixer set Master toggle",
	["XF86AudioMicMute"]	= "amixer set Capture toggle",
	["XF86MonBrightnessUp"]	= "light -A 10",
	["XF86MonBrightnessDown"]	= "light -U 10",
	["a"]	= "foot alsamixer",
	["C"]	= "XKB_DEFAULT_LAYOUT=de cage foot",
	["S"]	= "XKB_DEFAULT_LAYOUT=de cage sway-kiwmi",
	["f"]	= "foot -W 100x30 aerc",
	["F11"]	= "kiwmi_fullscreen",
	["Escape"]	= "kiwmic 'kiwmi:unfocus()'",
}

action_native = {
	["l"]	= "locked = true; kiwmi:spawn('foot -a vlock vlock')",
	--["l"]	= "locked = true; kiwmi:spawn('XKB_DEFAULT_LAYOUT=de cage gtklock-cage')",
	--["l"]	= "locked = true; kiwmi:spawn('XKB_DEFAULT_LAYOUT=de sway -c ~/.config/sway/config4')",
	["m"]	= "hide.hide(kiwmi:focused_view()); kiwmi:unfocus()",
	["M"]	= "hide.show()",
	[UNBINDKEY]	= "unbind = true",
}

hide = require('hide')

M = function(key)
	local todo = action[key]
	if todo ~= nil then kiwmi:spawn(todo); return end
	todo = action_native[key]
	if todo ~= nil then loadstring(todo)() end
end
return M
