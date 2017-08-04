--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]

--- @script settings


listitems.debug = core.settings:get_bool('enable_debug_mods') or false

--- Enables/Disables "list" chat command.
--
-- @setting listitems.enable_generic
-- @settype boolean
-- @default false
listitems.enable_generic = core.settings:get_bool('listitems.enable_generic') or false
