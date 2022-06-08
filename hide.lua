M = {}

hidden = {}
last_hidden = hidden

M.hide = function (v) 
	last_hidden.next = {["next"] = nil}
	last_hidden.view = v
	last_hidden = last_hidden.next
	v:hide()
	--debug(hidden.view:app_id())
end

M.show = function ()
	-- TODO fix this!
	if hidden.view == nil then return end
	hidden.view:show()
	OUTPUT:redraw()
	hidden = hidden.next
	--debug(hidden.view:app_id())
end

return M
