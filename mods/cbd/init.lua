local furniture_names = {
		"default:chest_locked", "xdecor:mailbox", "xdecor:frame",
		"beds:bed", "beds:fancy_bed",
		"doors:door_steel_t_1", "doors:door_steel_t_2",
		"doors:door_steel_b_1", "doors:door_steel_b_2"}

local length_of_day = minetest.setting_get("time_speed") or 72
local lease_time = 0

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
			local marked_pos1 = {x=npos.x-5, y=npos.y-6, z=npos.z-5}
			local marked_pos2 = {x=npos.x+5, y=npos.y+4, z=npos.z+5}
			local furnishings = minetest.find_nodes_in_area(marked_pos1, marked_pos2, furniture_names) 

			for i=1, #furnishings do
				local tenant = minetest.get_meta(furnishings[i])
				if furniture_names[i] == "default:chest_locked" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", "Locked Chest (owned by "..player_name..")")
				end
				if furniture_names[i] == "xdecor:mailbox" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", player_name.."'s Mailbox")
				end
				if furniture_names[i] == "xdecor:frame" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", "Item Frame (Owned by "..player_name..")")
				end
				if furniture_names[i] == "beds:bed" or
						furniture_names[i] == "beds:fancy_bed" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", player_name.."'s Bed")
				end
				if furniture_names[i] == "doors:door_steel_t_1" or
						furniture_names[i] == "doors:door_steel_t_2" or
						furniture_names[i] == "doors:door_steel_b_1" or
						furniture_names[i] == "doors:door_steel_b_2" then
					tenant:set_string("doors_owner", player_name)
					tenant:set_string("infotext", "Owned by "..player_name)
				end
			end

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
			local marked_pos1 = {x=pos.x-5, y=pos.y-6, z=pos.z-5}
			local marked_pos2 = {x=pos.x+5, y=pos.y+4, z=pos.z+5}
			local furnishings = minetest.find_nodes_in_area(marked_pos1, marked_pos2, furniture_names) 

			for i=1, #furnishings do
				local tenant = minetest.get_meta(furnishings[i])
				if furniture_names[i] == "default:chest_locked" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", "Locked Chest (owned by "..player_name..")")
				end
				if furniture_names[i] == "xdecor:mailbox" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", player_name.."'s Mailbox")
				end
				if furniture_names[i] == "xdecor:frame" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", "Item Frame (Owned by "..player_name..")")
				end
				if furniture_names[i] == "beds:bed" or
						furniture_names[i] == "beds:fancy_bed" then
					tenant:set_string("owner", player_name)
					tenant:set_string("infotext", player_name.."'s Bed")
				end
				if furniture_names[i] == "doors:door_steel_t_1" or
						furniture_names[i] == "doors:door_steel_t_2" or
						furniture_names[i] == "doors:door_steel_b_1" or
						furniture_names[i] == "doors:door_steel_b_2" then
					tenant:set_string("doors_owner", player_name)
					tenant:set_string("infotext", "Owned by "..player_name)
				end
			end

			print("hello!")
		else
			meta:set_int("time", time)
			return true
		end
	end,
})
