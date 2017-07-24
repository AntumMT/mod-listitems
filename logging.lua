--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


-- LOGGING FUNCTIONS

-- Custom logging function
function listitems.log(level, msg)
	core.log(level, '[' .. listitems.modname .. '] ' .. msg)
end
