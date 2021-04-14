--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin

  See: LICENSE.txt
--]]

--- List Items settings
--
-- @script settings.lua


listitems.debug = core.settings:get_bool('enable_debug_mods') or false


--- Displays items in a bulleted list.
--
-- @setting listitems.bullet_list
-- @settype boolean
-- @default true
listitems.bullet_list = core.settings:get_bool('listitems.bullet_list') or true


--- Enables/Disables "list mobs" chat command.
--
-- Requires "mobs".
--
-- @setting listitems.enable_mobs
-- @settype boolean
-- @default true
listitems.enable_mobs = false
if core.global_exists('mobs') then
	listitems.enable_mobs = core.settings:get_bool('listitems.enable_mobs')
	-- Default: enabled
	listitems.enable_mobs = listitems.enable_mobs == nil or listitems.enable_mobs == true
end
