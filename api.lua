--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if core.global_exists('intllib') then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end


-- Invoking command string
local cmd_item = S('listitems')


--- Valid switches.
-- 
-- @table
-- @field -v Display descriptions.
local known_switches = {'-v',}


-- Checks if a parameter is a switch beginning with "-"
local function isSwitch(param)
	if param then
		return #param == 2 and string.find(param, '-') == 1
	end
	
	return false
end


-- Checks if value is contained in list
local function listContains(tlist, v)
	for index, value in ipairs(tlist) do
		if v == value then
			return true
		end
	end
	
	return false
end


-- Retrieves a simplified table containing string names of registered items
-- FIXME: More efficient method to sort output?
local function getRegisteredItems()
	local i_names = {}
	--local i_descriptions = {}
	local items = {}
	
	for name, def in pairs(core.registered_items) do
		table.insert(items, {name=name, descr=def.description,})
	end
	
	for i, item in ipairs(items) do
		table.insert(i_names, item.name)
	end
	
	table.sort(i_names)
	
	local items_sorted = {}
	for i, name in ipairs(i_names) do
		for I, item in ipairs(items) do
			if item.name == name then
				table.insert(items_sorted, item)
			end
		end
	end
	
	return items_sorted
end


-- Compares a string from a list of substrings
local function compareSubstringList(ss_list, s_value)
	for index, substring in ipairs(ss_list) do
		-- Tests for substring (does not need to match full string)
		if string.find(s_value, substring) then
			return true
		end
	end
	
	return false
end


-- Extracts switches prefixed with "-" from parameter list
local function extractSwitches(plist)
	local switches = {}
	local params = {}
	if plist ~= nil then
		for i, p in ipairs(plist) do
			-- Check if string starts with "-"
			if isSwitch(p) then
				table.insert(switches, p)
			else
				table.insert(params, p)
			end
		end
		
		-- DEBUG:
		if listitems.debug then
			listitems.logDebug('Switches:')
			for i, o in ipairs(switches) do
				listitems.logDebug('  ' .. o)
			end
			
			listitems.logDebug('Parameters:')
			for i, p in ipairs(params) do
				listitems.logDebug('  ' .. p)
			end
		end
	end
	
	return {switches, params}
end


-- Replaces duplicates found in a list
local function removeListDuplicates(tlist)
	local cleaned = {}
	if tlist ~= nil then
		for index, value in ipairs(tlist) do
			if not listContains(cleaned, value) then
				table.insert(cleaned, value)
			end
		end
	end
	
	return cleaned
end


-- Searches & formats list for matching strings
local function formatMatching(player, nlist, params, switches)
	local matching = {}
	
	local show_descr = false
	if switches ~= nil then
		show_descr = listContains(switches, '-v')
	end
	
	core.chat_send_player(player, '\n' .. S('Searching in item names ...'))
	
	if params == nil then
		params = {}
	end
	
	-- Use entire list if no parameters supplied
	if next(params) == nil then
		for i, item in ipairs(nlist) do
			if show_descr and item.descr ~= nil then
				table.insert(matching, item.name .. ' (' .. item.descr .. ')')
			else
				table.insert(matching, item.name)
			end
		end
	else
		-- Fill matching list
		for i, item in ipairs(nlist) do
			if compareSubstringList(params, string.lower(item.name)) then
				if show_descr and item.descr ~= nil then
					table.insert(matching, item.name .. ' (' .. item.descr .. ')')
				else
					table.insert(matching, item.name)
				end
			end
		end
	end
	
	return matching
end


local bullet_list = core.settings:get_bool('listitems.bullet_list')
if bullet_list == nil then
	-- Default is true
	bullet_list = true
end

local bullet = ''
if bullet_list then
	bullet = S('•') .. ' '
end


-- Displays list to player
local function displayList(player, dlist)
	if dlist ~= nil then
		for i, n in ipairs(dlist) do
			core.chat_send_player(player, bullet .. n)
		end
	end
	-- Show player number of items listed
	core.chat_send_player(player, S('Items listed:') .. ' ' .. tostring(#dlist))
end


-- Custom registration function for chat commands
local function registerChatCommand(cmd_name, def)
	listitems.logInfo('Registering chat command "' .. cmd_name .. '"')
	core.register_chatcommand(cmd_name, def)
end


-- listitems command
registerChatCommand(cmd_item, {
	params = '[' .. S('options') .. '] [' .. S('string1') .. '] [' .. S('string2') .. '] ...',
	description = S('List registered items'),
	func = function(player, param)
		-- Split parameters into case-insensitive list & remove duplicates
		param = removeListDuplicates(string.split(string.lower(param), ' '))
		local switches = extractSwitches(param)
		param = switches[2]
		switches = switches[1]
		
		for i, s in ipairs(switches) do
			if not listContains(known_switches, s) then
				core.chat_send_player(player, S('Unknown option:') .. ' ' .. s)
				return false
			end
		end
		
		local all_items = getRegisteredItems()
		local matched_items = formatMatching(player, all_items, param, switches)
		
		displayList(player, matched_items)
		
		return true
	end,
})
