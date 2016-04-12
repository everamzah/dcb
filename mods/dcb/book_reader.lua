-- TODO: This file/item belongs to CBD

function dcb.get_reader_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	local book = inv:get_stack("book", 1):get_metadata()

	local data = minetest.deserialize(book)
	local page, page_max, cpp = 1, 1, 650
	local formspec = "size[8,8]" .. default.gui_bg .. default.gui_bg_img ..
		"label[0.5,0.5;by " .. data.owner .. "]" ..
		"tablecolumns[color;text]" ..
		"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
		"table[0.4,0;7,0.5;title;#FFFF00," .. minetest.formspec_escape(data.title) .. "]" ..
		"textarea[0.5,1.5;7.5,7;;" .. minetest.formspec_escape(data.text:sub(
			(cpp * page) - cpp, cpp * page)) .. ";]" --[[..
		"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
		"label[3.2,7.7;Page " .. page .. " of " .. page_max .. "]" ..
		"button[4.9,7.6;0.8,0.8;book_next;>]"]]
	return formspec
end

--[[minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "dcb:book_reader" then
		return
	end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

		local new_stack, data
		if stack:get_name() ~= "default:book_written" then
			local count = stack:get_count()
			if count == 1 then
				stack:set_name("default:book_written")
			else
				stack:set_count(count - 1)
				new_stack = ItemStack("default:book_written")
			end
		else
			data = minetest.deserialize(stack:get_metadata())
		end

		if not data then data = {} end
		data.title = fields.title
		data.text = fields.text
		data.text_len = fields.text:len()
		data.page = 1
		data.chars_per_page = 650
		data.page_max = math.ceil(data.text_len / data.chars_per_page)
		data.owner = player:get_player_name()
		local data_str = minetest.serialize(data)


	if fields.book_next or fields.book_prev then
		local data = minetest.deserialize(stack:get_metadata())
		if not data.page then
			return
		end

		if fields.book_next then
			data.page = data.page + 1
			if data.page > data.page_max then
				data.page = 1
			end
		else
			data.page = data.page - 1
			if data.page == 0 then
				data.page = data.page_max
			end
		end

		local data_str = minetest.serialize(data)
		stack:set_metadata(data_str)
		book_on_use(stack, player)
	end
end)]]

function dcb.get_reader_list_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,5]" .. default.gui_bg .. default.gui_bg_img .. default.gui_slots ..
		"label[0,0;Book Reader]" ..
		"list[nodemeta:" .. spos .. ";book;3.5,0;1,1;]" ..
		"list[current_player;main;0,1.25;8,4;]" ..
		"listring[]"
	return formspec
end

minetest.register_node("dcb:book_reader", {
	description = "Book Reader",
	tiles = {"xdecor_wood.png^default_book.png",
		"xdecor_wood.png",
		"xdecor_wood.png^default_book.png",
		"xdecor_wood.png^default_book.png",
		"xdecor_wood.png^default_book.png",
		"xdecor_wood.png^default_book.png"},
	groups = {cracky = 2, choppy = 3, oddly_breakable_by_hand = 1},
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "")
		meta:set_string("owner", "")
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()

		meta:set_string("owner", owner)
		meta:set_string("infotext", owner .. "'s Book Reader")
		local inv = meta:get_inventory()
		inv:set_size("book", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()
		local stack = inv:get_stack("book", 1)
		local player = clicker:get_player_name()
		if owner == player then
			minetest.show_formspec(
				clicker:get_player_name(),
				"dcb:book_reader",
				dcb.get_reader_list_formspec(pos))
			return
		elseif not stack:is_empty() then
			minetest.show_formspec(
				clicker:get_player_name(),
				"dcb:book_reader",
				dcb.get_reader_formspec(pos))
		else
			return
		end
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()

		return player:get_player_name() == owner and inv:is_empty("book")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if stack:get_name() == "default:book_written" then
			return 1
		else
			return 0
		end
		return 0
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end
})

minetest.register_craft({
	output = "dcb:book_reader",
	recipe = {
		{"group:wood", "default:glass", "group:wood"},
		{"group:wood", "default:book", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
