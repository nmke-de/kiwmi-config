M = {}

M.pre = function(ev)	
	ev.view:hide()
end

M.post = function(ev)
	ev.renderer:draw_rect("#ff8800",10,10,20,20)
end

return M
