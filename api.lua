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


-- Retrieves a simplified table containing string names of registered items
local function getRegisteredItemNames()
	local item_names = {}
	for item, def in pairs(core.registered_items) do
		table.insert(item_names, item)
	end
	
	table.sort(item_names)
	
	return item_names
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


-- Checks if value is contained in list
local function listContains(tlist, v)
	for index, value in ipairs(tlist) do
		if v == value then
			return true
		end
	end
	
	return false
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
local function formatMatching(nlist, params)
	local matching = {}
	
	-- Use entire list if no parameters supplied
	if next(params) == nil then
		matching = nlist
	else
		-- Fill matching list
		for index in pairs(nlist) do
			if compareSubstringList(params, string.lower(nlist[index])) then
				table.insert(matching, nlist[index])
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
	params = '[' .. S('string1') .. '] [' .. S('string2') .. '] ...',
	description = S('List registered items'),
	func = function(player, param)
		-- Split parameters into case-insensitive list & remove duplicates
		param = removeListDuplicates(string.split(string.lower(param), ' '))
		
		local all_names = getRegisteredItemNames()
		local found_names = formatMatching(all_names, param)
		
		displayList(player, found_names)
		
		return true
	end,
})
