local sstep = 0.3 --tonumber(minetest.setting_get("dedicated_server_step"))

minetest.register_craftitem("dcb:tool", {
	description = "Powerful multitool",
	inventory_image = "default_tool_woodpick.png^default_obsidian_shard.png",
	stack_max = 1,
	range = 7.0,
	liquids_pointable = false,
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		groupcaps = {
			snappy={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxlevel=3},
			choppy={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxlevel=3},
			cracky={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxlevel=3},
			crumbly={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxlevel=3},
			oddly_breakable_by_hand={times={[1]=sstep, [2]=sstep, [3]=sstep}, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	},
	after_use = function(itemstack, user, node, digparams)
		local player = user:get_player_name()
		if not minetest.check_player_privs(player, {ban=true}) then
			--minetest.kick_player(player, "You may not use this tool.")
			minetest.log("action", player.." used the DCB multitool without the ban priv.")
			return "default:paper" -- yellow card
		else
			return itemstack
		end
	end,
})

minetest.register_craftitem("dcb:dcb", {
	description = "DCB Tool removes doors, chests, and bones",
	inventory_image = "default_obsidian_shard.png",
	stack_max = 1,
	liquids_pointable = false,
	groups = {not_in_creative_inventory=1},
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
			else
				minetest.remove_node(pos)
			end
		end
	end,
})
