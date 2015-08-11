local sheet =	{ -1/2  , -1/2   , -1/2   , 1/2    , -7/16  ,  1/2  }
local info  =	''
local sign  =	'\nSigned: '
--           { s,  w, n,  e }
local wdir = { 8, 17, 6, 15 } -- wall direction

minetest.register_craftitem(":default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local above = pt.above
		local under = pt.under
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		if minetest.get_node(above).name == "air" then
			if (above.x ~= under.x) or (above.z ~= under.z) then
				minetest.add_node(above, {name="memorandum:letter_empty", param2=wdir[fdir+1]})
			else
				minetest.add_node(above, {name="memorandum:letter_empty", param2=fdir})
			end
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end
	end,
})

minetest.register_node("memorandum:letter_empty", {
	drawtype = "nodebox",
	tiles = {
		"memorandum_letter_empty.png",
		"memorandum_letter_empty.png^[transformFY" -- mirror
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {type = "fixed", fixed = sheet},
	groups = {snappy=3,dig_immediate=3,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string(
					"formspec", 
					"size[10,7]"..
					"field[1,1;8.5,1;text;Write;${text}]"..
					"field[1,3;4.25,1;signed;Sign;${signed}]"..
					"button_exit[0.75,5;4.25,1;text,signed;Done]"
				)
		meta:set_string("infotext", '""')
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		fields.text = fields.text
		fields.signed = fields.signed
		--[[print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to paper at "..minetest.pos_to_string(pos))]]
		local fdir = minetest.get_node(pos).param2
		if fields.text ~= "" then
			minetest.add_node(pos, {name="memorandum:letter_written", param2=fdir})
		end
		meta:set_string("text", fields.text)
		meta:set_string("signed", "")
		meta:set_string("infotext", info..fields.text..'" Unsigned')
		if fields.signed ~= "" then
			meta:set_string("signed", fields.signed)
			meta:set_string("infotext", info..fields.text..sign..fields.signed)
		end
	end,
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			digger:get_inventory():add_item("main", {name="default:paper", count=1, wear=0, metadata=""})
		end
		minetest.remove_node(pos)
	end,
})

minetest.register_craftitem("memorandum:letter", {
	description = "Letter",
	inventory_image = "default_paper.png^memorandum_letters.png",
	stack_max = 1,
	groups = {not_in_creative_inventory=1},
	on_use = function(itemstack, user, pointed_thing)
		local player = user:get_player_name()
		local text = itemstack:get_metadata()
		local scnt = string.sub (text, -2, -1)
		if scnt == "00" then
			mssg = string.sub (text, 1, -3)
			sgnd = ""
		elseif tonumber(scnt) == nil then -- to support previous versions
			mssg = string.sub (text, 37, -1)
			sgnd = ""
		else
			mssg = string.sub (text, 1, -scnt -3)
			sgnd = string.sub (text, -scnt-2, -3)
		end
		if scnt == "00" or tonumber(scnt) == nil then
			minetest.chat_send_player(player, info..mssg..'" Unsigned', false)
		else
			minetest.chat_send_player(player, info..mssg..sign..sgnd, false)
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local above = pt.above
		local under = pt.under
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local meta = minetest.get_meta(above)
		local text = itemstack:get_metadata()
		local scnt = string.sub (text, -2, -1)
		if scnt == "00" then
			mssg = string.sub (text, 1, -3)
			sgnd = ""
		elseif tonumber(scnt) == nil then -- to support previous versions
			mssg = string.sub (text, 37, -1)
			sgnd = ""
		else
			mssg = string.sub (text, 1, -scnt -3)
			sgnd = string.sub (text, -scnt-2, -3)
		end
		if minetest.get_node(above).name == "air" then
			if (above.x ~= under.x) or (above.z ~= under.z) then
				minetest.add_node(above, {name="memorandum:letter_written", param2=wdir[fdir+1]})
			else
				minetest.add_node(above, {name="memorandum:letter_written", param2=fdir})
			end
			if scnt == "00" or tonumber(scnt) == nil then
				meta:set_string("infotext", info..mssg..'" Unsigned')
			else
				meta:set_string("infotext", info..mssg..sign..sgnd)
			end
			meta:set_string("text", mssg)
			meta:set_string("signed", sgnd)
			itemstack:take_item()
			return itemstack
		end
	end,
})

minetest.register_node("memorandum:letter_written", {
	drawtype = "nodebox",
	tiles = {
		"memorandum_letter_empty.png^memorandum_letter_text.png",
		"memorandum_letter_empty.png^[transformFY" -- mirror
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {type = "fixed", fixed = sheet},
	groups = {snappy=3,dig_immediate=3,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			local meta = minetest.get_meta(pos)
			local text = meta:get_string("text")
			local signed = meta:get_string("signed")
			local signcount = string.len(signed)
			local inv = digger:get_inventory()
			if string.len(signed) < 10 then
				signcount = "0"..string.len(signed)
			end
			if signed == '" Unsigned' then
				signcount = "00"
			end
			inv:add_item("main", {name="memorandum:letter", count=1, wear=0, metadata=text..signed..signcount})
		end
		minetest.remove_node(pos)
	end,
})
