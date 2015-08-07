-- Guest Book

--[[ TODO

[*] Convert to db mod or consolidate or figure out just what are the best methods and options.
[*] Store n books in table (just metadata?)
[x] Read book button.

--]]


local guestbook_file = minetest.get_worldpath().."/guestbook"
local guestbook_db = minetest.get_worldpath().."/guestbook_db"

local formspec_log = "" -- The actual log as formspec string.
local guestlog = {}

local function loadguestbook()
	local input = io.open(guestbook_file, "r")
	local input_db = io.open(guestbook_db, "r")
	if input then
		formspec_log = input:read()
		io.close(input)
	end
	if input_db then
		guestlog = minetest.deserialize(input_db:read())
		io.close(input_db)
	end
end

loadguestbook()

local changed = false

minetest.register_node("dcb:guest_book", {
	description = "Guest Book",
	tiles = {"default_wood.png^default_paper.png"},
	groups = {choppy=3, cracky=2, snappy=2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Guest Book")
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("drop", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		minetest.show_formspec(clicker:get_player_name(), "dcb:guest_book", dcb.guestbook(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local book = stack:get_metadata()
		local data = minetest.deserialize(book)
		if not data.owner then return end
		if not data.title then return end
		if not data.text then return end
		dcb.guestbooklog(data.owner, data.title, data.text)
		minetest.show_formspec(player:get_player_name(), "dcb:guest_book", dcb.guestbook(pos))
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if stack:get_name() == "default:book_written" then
			return -1
		else
			return 0
		end
		return 0
	end,
})

function dcb.guestbooklog(owner, title, text)
	local fs_owner = minetest.formspec_escape(owner)
	local fs_title = minetest.formspec_escape(title)
	local fs_text = minetest.formspec_escape(text)
	local entry = {owner, title, text}
	table.insert(guestlog, 1, entry)
	print(dump(guestlog))
	local trunc_text = string.sub(text, 1, 120)
	local formspec = minetest.formspec_escape(owner..": "..trunc_text)
	formspec_log = formspec..","..formspec_log -- Delimited log entry to top of log
	formspec_log = string.sub(formspec_log, 0, -2)
	print(formspec_log)
	changed = true
	if changed then
		local output = io.open(guestbook_file, "w")
		local output_db = io.open(guestbook_db, "w")
		output:write(formspec_log)
		io.close(output)
		output_db:write(minetest.serialize(guestlog))
		io.close(output_db)
		changed = false
	end
end

function dcb.guestbook(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = "size[8,9]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
		"textlist[0,0;6.825,5;index;"..formspec_log..";1]"..
		"label[7,0;Sign]"..
		"list[nodemeta:"..spos..";drop;7,0.5;1,1;]"..
		"item_image[7,0.5;1,1;default:book]"..
		"button[7,4.25;1,1;open;Open]"..
		"list[current_player;main;0,5.25;8,4;]"..
		"listring[]"
	return formspec
end

local function openbook(index)
	local owner = minetest.formspec_escape(guestlog[index][1])
	local title = minetest.formspec_escape(guestlog[index][2])
	local text = minetest.formspec_escape(guestlog[index][3])
	local formspec = "size[8,8]"..default.gui_bg..
		"label[0.5,0.5;by "..owner.."]"..
		"label[0.5,0;"..title.."]"..
		"textarea[0.5,1.5;7.5,7;;"..text..";]"
	return formspec
end

local index = 1

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.index then
		index = minetest.explode_textlist_event(fields.index)["index"]
		return
	end
	if fields.open then
		if formspec_log == "" then return 0 end --weak check, instead look for book at index.
		minetest.show_formspec(player:get_player_name(), "dcb:guest_book", openbook(index))
		return
	end
end)

minetest.register_craft({
	output = "dcb:guest_book",
	recipe = {
		{"group:wood", "default:glass", "group:wood"},
		{"group:wood", "default:bookshelf", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
