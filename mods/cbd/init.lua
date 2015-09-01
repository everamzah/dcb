local furniture_names = {
		"default:chest_locked", "xdecor:mailbox", "xdecor:frame",
		"beds:bed", "beds:fancy_bed",
		"doors:door_steel_t_1", "doors:door_steel_t_2",
		"doors:door_steel_b_1", "doors:door_steel_b_2"}

local length_of_day = minetest.setting_get("time_speed") or 72
local lease_time = 0

local function transfer_owner(pos, tenant_name, meta)
	local marked_pos1 = {x=pos.x-5, y=pos.y-6, z=pos.z-5}
	local marked_pos2 = {x=pos.x+5, y=pos.y+4, z=pos.z+5}
	local furnishings = minetest.find_nodes_in_area(marked_pos1, marked_pos2, furniture_names) 
	local owner = minetest.get_meta(pos)
	for i=1, #furnishings do
		local tenant = minetest.get_meta(furnishings[i])
		if minetest.get_node(furnishings[i]).name == "default:chest_locked" then
			if tenant:get_string("owner") == meta:get_string("owner") then
				tenant:set_string("owner", tenant_name)
				tenant:set_string("infotext", "Locked Chest (owned by "..tenant_name..")")
			end
		end
		if minetest.get_node(furnishings[i]).name == "xdecor:mailbox" then
			if tenant:get_string("owner") == meta:get_string("owner") then
				tenant:set_string("owner", tenant_name)
				tenant:set_string("infotext", tenant_name.."'s Mailbox")
			end
		end
		if minetest.get_node(furnishings[i]).name == "xdecor:frame" then
			if tenant:get_string("owner") == meta:get_string("owner") then
				tenant:set_string("owner", tenant_name)
				tenant:set_string("infotext", "Item Frame (Owned by "..tenant_name..")")
			end
		end
		if minetest.get_node(furnishings[i]).name == "beds:bed_bottom" or
				minetest.get_node(furnishings[i]).name == "beds:fancy_bed_bottom" then
			if tenant:get_string("owner") == meta:get_string("owner") then
				tenant:set_string("owner", tenant_name)
				tenant:set_string("infotext", tenant_name.."'s Bed")
			end
		end
		if minetest.get_node(furnishings[i]).name == "doors:door_steel_t_1" or
				minetest.get_node(furnishings[i]).name == "doors:door_steel_t_2" or
				minetest.get_node(furnishings[i]).name == "doors:door_steel_b_1" or
				minetest.get_node(furnishings[i]).name == "doors:door_steel_b_2" then
			if tenant:get_string("owner") == meta:get_string("owner") then
				tenant:set_string("doors_owner", tenant_name)
				tenant:set_string("infotext", "Owned by "..tenant_name)
			end
		end
	end
end

minetest.register_node("cbd:rental", {
	description = "Property Manager",
	tiles = {"shop_coin.png"},
	wield_image = "shop_coin.png",
	inventory_image = "shop_coin.png",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 2,
	drawtype = "nodebox",
	sunlight_propagates = true,
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top = {-0.375, 0.4375, -0.5, 0.375, 0.5, 0.5},
                wall_bottom = {-0.375, -0.5, -0.5, 0.375, -0.4375, 0.5},
                wall_side = {-0.5, -0.5, -0.375, -0.4375, 0.5, 0.375},
	},
	selection_box = {type = "wallmounted"},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local node_name = minetest.get_node(pointed_thing.under)
		if node_name.name ~= "protector:protect" then
			minetest.remove_node(pos)
			return 0
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Punch with coin to rent")
		meta:set_string("tenant", "")
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		if puncher:get_wielded_item():get_name() == "shop:coin" then
			local npos = minetest.get_pointed_thing_position(pointed_thing)
			local player_name = puncher:get_player_name()
			local meta = minetest.get_meta(npos)
			if meta:get_string("tenant") == player_name then lease_time = lease_time + 30 return end
			if string.len(meta:get_string("tenant")) > 0 then print("nope") return end
			meta:set_string("tenant", player_name)
			lease_time = 30
			minetest.chat_send_player(player_name, "New tenant is "..meta:get_string("tenant"))
			transfer_owner(npos, player_name, meta)
			minetest.get_node_timer(npos):start(10)
		end
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local time = meta:get_int("time") + elapsed
		print(time)
		if time >= lease_time then
			meta:set_string("tenant", "")
			meta:set_int("time", 0)
			local player_name = meta:get_string("owner")
			transfer_owner(pos, player_name, meta)
			print("Time is up.")
		else
			meta:set_int("time", time)
			return true
		end
	end,
})
