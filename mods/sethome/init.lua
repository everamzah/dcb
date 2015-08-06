--[[
	TODO

* try to modularize
* get static spawn pos setting for var
* move this into dcb when it's a game
* hide hscroller
* contract pmindex and add hscroller if pm length > n

--]]

sethome = {}

local homes_file = minetest.get_worldpath() .. "/homes"
local homepos = {}
sethome.globalhomepos = {}

local function loadhomes()
    local input = io.open(homes_file, "r")
    if input then
                repeat
            local x = input:read("*n")
            if x == nil then
                break
            end
            local y = input:read("*n")
            local z = input:read("*n")
            local name = input:read("*l")
            homepos[name:sub(2)] = {x = x, y = y, z = z}
        until input:read(0) == nil
        io.close(input)
    else
        homepos = {}
    end
    sethome.globalhomepos = homepos
end

loadhomes()

minetest.register_privilege("home", "Can use /sethome and /home")

local changed = false

minetest.register_chatcommand("home", {
    description = "Teleport you to your home point or name if teleport priv",
    params = "[name]",
    privs = {home=true},
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end

	if param ~= "" and minetest.check_player_privs(name, {teleport=true}) then
	    --print("true")
	    if homepos[param] then
		player:setpos(homepos[param])
		minetest.chat_send_player(name, "Teleported to "..param.."'s home.")
	        return
	    else
		minetest.chat_send_player(name, param.." has no home.")
		return
	    end
	else
            if homepos[player:get_player_name()] then
	        player:setpos(homepos[player:get_player_name()])
	        minetest.chat_send_player(name, "Teleported to home!")
		return
	    else
	        minetest.chat_send_player(name, "Set a home using /sethome")
		return
	    end
	end
    end,
})

sethome.sethome = function(player)
	local name = player:get_player_name()
	--local player = minetest.get_player_name(name)
	local pos = player:getpos()
	homepos[player:get_player_name()] = pos
	minetest.chat_send_player(name, "Home set!")
	changed = true
	if changed then
		local output = io.open(homes_file, "w")
	    for i, v in pairs(homepos) do
		output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
	    end
	    io.close(output)
	    changed = false
	end
end

minetest.register_chatcommand("sethome", {
    description = "Set your home point",
    privs = {home=true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
        local pos = player:getpos()
        homepos[player:get_player_name()] = pos
        minetest.chat_send_player(name, "Home set!")
        changed = true
        if changed then
                local output = io.open(homes_file, "w")
            for i, v in pairs(homepos) do
                output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
            end
            io.close(output)
            changed = false
        end
    end,
})

minetest.register_on_joinplayer(function(player)
	player:set_inventory_formspec(sethome.form)
end)

if minetest.setting_getbool("show_pm") then
	sethome.form = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"button_exit[0.25,-0.4;1.5,3;pm;PM]"..
			"button_exit[0.25,0.6;1.5,3;home;Home]"..
			"button_exit[0.25,1.6;1.5,3;spawn;Spawn]"..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;2,0.5;3,3;]"..
			"list[current_player;craftpreview;6,1.5;1,1;]"..
			"image[5,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)
	else
	sethome.form = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"button_exit[0.25,0.6;1.5,3;home;Home]"..
			"button_exit[0.25,1.6;1.5,3;spawn;Spawn]"..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;2,0.5;3,3;]"..
			"list[current_player;craftpreview;6,1.5;1,1;]"..
			"image[5,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)
end

--------------

local player_index = 1 -- selected player on the left
local pm_index = 1 -- selected pm on the right

local chatlist = {}
local chatlist_string = "" -- the player list formspec string filled from chatlist
local function update_chatlist() --add or remove
	local players = minetest.get_connected_players()
	chatlist = {}
	local itr = ""
	for i,v in ipairs(players) do
		local n = v:get_player_name()
		itr = itr..n..","
		table.insert(chatlist, n)
	end
	chatlist_string = string.sub(itr, 0, -2)

	print(chatlist_string)
	print("---")
	print(dump(chatlist))
end

-----
--[[
local revPlayers = {}
for i,v in ipairs(chatlist) do
	revPlayers[v] = i
end
--]]
-----

local msg = "" -- the sent message string from fields.text
local pm_fs_string = {[1]=""}
--[[local pmtable = {
	["james"] = {
		["james"] = {
			"<james> test",
			"<james> k",
		},
		["kupo"] = {
			"<kupo> hi raramza",
			"<kupo> ih",
		},
	},
	["kupo"] = {
		["james"] = {
			"<james> hi kupo",
			"<james> :)",
		},
	},
}
--]]
local pmtable = {}
local function insertpm(from, to, pm)
	--local t = {from, to, pm}
	table.insert(pmtable[to][from], "<"..from.."> "..pm)
	print(dump(pmtable))
	pm_fs_string = {}
	table.insert(pm_fs_string[from], "<"..from.."> "..pm)
	print(dump(pm_fs_string))
end

--[[
local function extractpm(name)
	pm_fs_string = pmtable["james"]["kupo"][1]..","..pmtable["james"]["kupo"][2]
end
--]]

local function pmform(player, index) --player index
	--update_chatlist()
	local formspec = "size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"textlist[0,0;1.9,7.75;playeridx;"..chatlist_string..";"..player_index.."]"..
		"textlist[2,0;5.85,7.75;pmidx;"..pm_fs_string[index]..";1]"..
		"field[0.28,8.05;5.35,1.4;text;;]"..
		"button[5.2,7.9;1.5,1;send;Send]"..
		"button[6.57,7.9;1.5,1;openpm;Open]"
	minetest.show_formspec(player, "sethome:pm", formspec)
end

local function openpm(player, pm)
	local book_formspec = "size[8,8.5]"..default.gui_bg..
		"label[0.5,0.5;from "..pm.sender.."]"..
		"textarea[0.5,1.5;7.5,7;;"..minetest.formspec_escape(pm.msg)..";]"
	minetest.show_formspec(player, "sethome:pm", book_formspec)
end

-----------------

minetest.register_on_player_receive_fields(function(player, formname, fields)
	--if formname ~= whatever form i'm using here.
	if fields.home then
		if homepos[player:get_player_name()] then
		    player:setpos(homepos[player:get_player_name()])
		    minetest.chat_send_player(player:get_player_name(), "Teleported to home!")
		else
			local name = player:get_player_name()
			local pos = player:getpos()
			homepos[name] = pos
			minetest.chat_send_player(name, "Home set!  Use /sethome to set a new one.")
			changed = true
			if changed then
				local output = io.open(homes_file, "w")
			    for i, v in pairs(homepos) do
				output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
			    end
			    io.close(output)
			    changed = false
			end
		end
        end
	if fields.spawn then
		player:setpos(minetest.setting_get_pos("static_spawnpoint"))
		minetest.chat_send_player(player:get_player_name(), "Teleported to spawn!")
	end
	if fields.pm then
		update_chatlist()
		pmform(player:get_player_name(), player_index)
	end

	if fields.playeridx then
		player_index = minetest.explode_textlist_event(fields.playeridx)["index"]
		pmform(player:get_player_name(), player_index)
	end
	if fields.pmidx then
		pm_index = minetest.explode_textlist_event(fields.pmidx)["index"]
		pmform(player:get_player_name(), player_index)
	end
	if fields.text then
		msg = fields.text
	end
	if fields.send then
		local playername = chatlist[player_index]:get_player_name()
		minetest.log("action", "PM from "..player:get_player_name().." to "..playername..": "..msg)
		minetest.chat_send_player(player:get_player_name(), "Message sent.")
		insertpm(player:get_player_name(), playername, msg)

		--pm_fs_string[1] = pm_fs_string[1]..minetest.formspec_escape("<"..player:get_player_name().."> "..msg)..","

		pmform(player:get_player_name(), player_index)
	end
	if fields.openpm then
		local p = player:get_player_name()
		--fill_chatlist()
		--[[
		local player_messages = pmtable["james"]
		local sender = player_messages["kupo"]
		local pmsg = sender[1]
		pm = {sender, pmsg}
		openpm(player:get_player_name(), pm)
		--]]
	end
end)
