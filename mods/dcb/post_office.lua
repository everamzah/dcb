-- Post Office

--[[

* Textlist of mailbox coords
* Itemstack and send button
* Add button checks for homepos
	Scans for mailbox within n node radius
	Add coords if found, update textlist

--]]

local post_listing = "" --"kupo,james,Kidmondo,Dragonop" -- list of playernames should be table with coords.
local post_registry = {}

local postoffice_formspec = function(pos, player)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = "size[8,9]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
	"textlist[0,0;6.825,5;index;"..post_listing..";1]"..
	"label[7,0;Send]"..
	"button_exit[7,4.25;1,1;add;Add]".. -- receive field and if homepos(player) scan nodes 5r if mailbox add coords update formspec -- TODO make regular button, update formspec
	"list[nodemeta:"..spos..";send;7,0.5;1,1;]"..
	"list[current_player;main;0,5.25;8,4;]"..
	"listring[]"
	minetest.show_formspec(player, "dcb:post_office", formspec)
end

local dest = {} -- x=n, y=n, z=n --post_registry["james"]

minetest.register_node("dcb:post_office", {
	description = "Post Office",
	tiles = {"default_chest_top.png^default_sign.png"}, --or sign_wall
	groups = {choppy=3, snappy=2, cracky=2, oddly_breakable_by_hand=1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Post Office")
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("send", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		postoffice_formspec(pos, clicker:get_player_name()) --minetest.show_formspec(clicker:get_player_name(), "dcb:post_office", formspec_post(pos))
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return -1
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
	end,
		--[[
		local post = stack
		local dest = post_registry["james"]
		local mailbox = minetest.get_node(dest)
		print(dump(dest))
		print(dump(mailbox))
		local meta = minetest.get_meta(mailbox)
		print(dump(meta))
		local inv = meta:get_inventory()
		print(dump(inv))
		--]]

		--inv:add_item("main", stack)
		--print(dump(post_registry))
		--local dest = post_registry["james"]
		--print(dest)

		--minp, maxp are homepos[player] and 5, say, in all directions
		--local address = minetest.find_nodes_in_area(minp, maxp, "xdecor:mailbox")
		--get first address (and break?)

		--[[
		local meta = minetest.get_meta(address)
		local inv = meta:get_inventory()
		inv:add_item(stack)
		--]]


	--[[
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.add then print("add") end
	end,
	--]]
	
})

---[[
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "dcb:post_office" then
		return
	end
	if fields.add then
		local p = player:get_player_name()
		if not post_registry[p] then post_registry[p] = {["home"]="", ["mailbox"]=""} end
		if sethome.globalhomepos[p] then
			local home = sethome.globalhomepos[p]
			local x = math.floor(home.x)
			local y = math.floor(home.y)
			local z = math.floor(home.z)
			local home_string = x..","..y..","..z
			if post_registry[p]["home"] == home_string then print("already added") return 0 end
			post_registry[p]["home"] = home_string

			local positions = minetest.find_nodes_in_area(
				{x=x-5, y=y-5, z=z-5},
				{x=x+5, y=y+5, z=z+5},
				{"xdecor:mailbox"})
			if (positions[1]) then
				post_registry[p]["mailbox"] = positions[1].x..","..positions[1].y..","..positions[1].z
				local itr = ""
				for n,c in pairs(post_registry) do
					itr = itr..tostring(n)..","
				end
			post_listing = string.sub(itr, 0, -2)
			end
			--postoffice_formspec(pos, p)
		end
	print(dump(post_registry))
	end
	if fields.index then
		print("fields.index:\n"..dump(fields.index))
	end
end)
--]]

