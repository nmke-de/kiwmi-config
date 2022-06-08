M = {}
debug_index = 0
M.msg = function(msg)
	kiwmi:spawn("notify-send '"..debug_index.." Kiwmi Debug' '"..msg.."'")
	debug_index = debug_index +1
end
return M