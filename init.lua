MODKEY = "Super_L"
OUTPUT = false
CURSOR = kiwmi:cursor()
UNBINDKEY = "XF86Keyboard"
local _modstate -- Whether mod key is pressed or not

-- On new output, store in OUTPUT (or something like that)
kiwmi:on("output",function(output) OUTPUT = output end)

-- keymap
xkbmap = {}
xkbmap["layout"] = "de"

-- keybindings
keybind = require('keybind')

-- unbind keybindings
unbind = false

--debug
--debug = require('debug')

-- Renderer
render = require('render')

-- screen lock
locked = false

-- On new keyboard, init keyboard
kiwmi:on("keyboard",function(kb)
	kb:keymap(xkbmap)
	kb:on("key_up",function(ev)
		if ev.key == MODKEY then
			_modstate = false
			OUTPUT:redraw()
		end
	end)
	kb:on("key_down",function(ev)
		if ev.key == MODKEY then
			_modstate = true
			OUTPUT:redraw()
		end
		if not locked and unbind and not ev.raw and _modstate and ev.key == UNBINDKEY then
			unbind = false
		elseif not locked and not unbind and not ev.raw and _modstate then
			keybind(ev.key)
		end
	end)
end)

-- cursor / mouse handling
CURSOR:on("button_up",function()
	kiwmi:stop_interactive()
end)
CURSOR:on("button_down",function(button)
	if locked then return end
	local v = CURSOR:view_at_pos()
	if v then
		kiwmi:unfocus()
		v:focus()
		if _modstate and not unbind then
			if button == 1 then v:imove()end
			if button == 2 then v:iresize({"b","r"})end
		end
	end
end)
kiwmi:on("view",function(v)
	v:show()
	kiwmi:unfocus()
	v:focus()
	if locked then
		v:move(0,0)
		ua = OUTPUT:usable_area()
		v:resize(ua.width, ua.height)
		v:on("destroy",function() locked = false end)
	end
	v:on("destroy",function()
		kiwmi:stop_interactive()
	end)
	v:on("request_move",function()
		v:imove()
	end)
	v:on("request_resize",function(ev)
		v:iresize(ev.edges)
	end)
	--v:on("post_render",render.post)
end)
kiwmi:spawn(os.getenv("HOME").."/.config/kiwmi/autostart")
