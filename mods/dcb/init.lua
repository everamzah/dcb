dcb = {}

--[[
local strategies = {fs = {name="my_database", form="json", place="world"}}
local my_instance = DB(strategies)
my_instance:set("owner", "title", "text")
--print(dump(my_instance))
local addr = my_instance:get("owner", "title", "text")
--print(dump(addr))
--]]

local sstep = tonumber(minetest.setting_get("dedicated_server_step"))

minetest.register_craftitem("dcb:tool", {
	description = "Powerful multitool",
	inventory_image = "default_tool_woodpick.png^default_obsidian_shard.png",
	stack_max = 1,
	range = 7.0,
	liquids_pointable = false,
	tool_capabilities = {
		groupcaps = {
			snappy={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxwear=0, maxlevel=3},
			choppy={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxwear=0, maxlevel=3},
			cracky={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxwear=0, maxlevel=3},
			crumbly={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxwear=0, maxlevel=3},
			oddly_breakable_by_hand={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxwear=0, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	},
	after_use = function(itemstack, user, node, digparams)
		local player = user:get_player_name()
		if not minetest.check_player_privs(player, {ban=true}) then
			minetest.kick_player(player, "You may not use this tool.")
			minetest.log("action", player.." used the DCB multitool without the ban priv.")
			return "default:paper" -- yellow card
		else
			return itemstack
		end
	end,
})

--[[
shop.spew = function(pos, stack)
	local obj = minetest.add_item(pos, stack)
	if obj then
		obj:setvelocity({x=math.random(-1, 1), y=5, z=math.random(-1, 1)})
	end
end
--]]

minetest.register_craftitem("dcb:dcb", {
	description = "DCB Tool removes doors, chests, and bones",
	inventory_image = "default_obsidian_shard.png",
	stack_max = 1,
	liquids_pointable = false,
	on_use = function(itemstack, user, pointed_thing)
		local pos = minetest.get_pointed_thing_position(pointed_thing)
		if not minetest.check_player_privs(user:get_player_name(), {delprotect=true}) then
			minetest.log("action", user:get_player_name().." tried to use the DCB without delprotect priv.")
			return
		end
		if not pos then
			return
		else
			local node = minetest.get_node(pos)
			if node["name"] == "default:chest_locked" then --convert to regular chest
				--[[
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local size = inv:get_size("main")
				for i in size do
					--shop.spew(pos, "default:chest_locked")
					print(i)
				end
				--]]
				minetest.remove_node(pos)
			elseif string.match(node["name"], "doors:door_steel") then --pop steel door on ground
				minetest.remove_node(pos)
			elseif node["name"] == "bones:bones" then --pop items around bones, including bones:bones item entity
				minetest.remove_node(pos)
			end
		end
	end,
})

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	if damage >= 1 then
		local p = player
		local h = hitter
		local pos = p:getpos()
		local r = 10
	
		local positions = minetest.find_nodes_in_area(
			{x=pos.x-r, y=pos.y-r, z=pos.z-r},
			{x=pos.x+r, y=pos.y+r, z=pos.z+r},
			{"mini_sun:source"})
		if (positions[1]) then
			local hhp = h:get_hp()
			p:set_hp(20)
			h:set_hp(hhp - damage)
			return
		else
			return
		end
	else
		return
	end
end)

dofile(minetest.get_modpath("dcb").."/overrides.lua")
dofile(minetest.get_modpath("dcb").."/book_reader.lua")
--dofile(minetest.get_modpath("dcb").."/guest_book.lua")
dofile(minetest.get_modpath("dcb").."/post_office.lua")
dofile(minetest.get_modpath("dcb").."/crafts.lua")
dofile(minetest.get_modpath("dcb").."/give_initial_stuff.lua")
dofile(minetest.get_modpath("dcb").."/creative.lua")
