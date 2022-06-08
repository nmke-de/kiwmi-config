M = {}

package.cpath = package.cpath..";/usr/lib/lua-pam/?.so"
local pam = require('liblua_pam')

locked = false
M.islocked = function() return locked end
M.lock = function() locked = true end



local buffer = ""
M.unlock = function(key)
	if not locked then return end
	if key == "Return" then
		if pam.auth_current_user(buffer) then
			locked = false
		else
			-- Do something to indicate failure
			kiwmi:spawn("notify-send Lock 'Unlocking failed.'")
		end
		buffer = ""
	else
		buffer = buffer..key
		-- Do something to indicate input
		kiwmi:spawn("notify-send Input "..key)
	end
end

return M
