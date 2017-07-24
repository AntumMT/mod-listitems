--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


-- LOGGING FUNCTIONS

-- Custom logging function
function listitems.log(level, msg)
	local prefix = '[' .. listitems.modname .. '] '
	
	if msg == nil then
		core.log(prefix .. level)
	else
		core.log(level, prefix .. msg)
	end
end
