-- ZCG mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

dcb.zcg = {}

dcb.zcg.users = {}
dcb.zcg.crafts = {}
dcb.zcg.itemlist = {}

dcb.zcg.items_in_group = function(group)
	local items = {}
	local ok = true
	for name, item in pairs(minetest.registered_items) do
		-- the node should be in all groups
		ok = true
		for _, g in ipairs(group:split(',')) do
			if not item.groups[g] then
				ok = false
			end
		end
		if ok then table.insert(items,name) end
	end
	return items
end

local table_copy = function(table)
	out = {}
	for k,v in pairs(table) do
		out[k] = v
	end
	return out
end

dcb.zcg.add_craft = function(input, output, groups)
	if minetest.get_item_group(output, "not_in_craft_guide") > 0 then
		return
	end
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type = input.type
	c.items = input.items
	if c.items == nil then return end
	for i, item in pairs(c.items) do
		if item:sub(0,6) == "group:" then
			local groupname = item:sub(7)
			if groups[groupname] ~= nil then
				c.items[i] = groups[groupname]
			else
				for _, gi in ipairs(dcb.zcg.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					dcb.zcg.add_craft({
						width = c.width,
						type = c.type,
						items = table_copy(c.items)
					}, output, g2) -- it is needed to copy the table, else groups won't work right
				end
				return
			end
		end
	end
	if c.width == 0 then c.width = 3 end
	table.insert(dcb.zcg.crafts[output],c)
end

dcb.zcg.load_crafts = function(name)
	dcb.zcg.crafts[name] = {}
	local _recipes = minetest.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				dcb.zcg.add_craft(recipe, name)
			end
		end
	end
	if dcb.zcg.crafts[name] == nil or #dcb.zcg.crafts[name] == 0 then
		dcb.zcg.crafts[name] = nil
	else
		table.insert(dcb.zcg.itemlist,name)
	end
end

dcb.zcg.need_load_all = true

dcb.zcg.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			dcb.zcg.load_crafts(name)
		end
		i = i+1
	end
	table.sort(dcb.zcg.itemlist)
	dcb.zcg.need_load_all = false
	print("All crafts loaded !")
end

dcb.zcg.formspec = function(pn)
	if dcb.zcg.need_load_all then dcb.zcg.load_all() end
	print(dump(dcb.zcg.users))
	page = dcb.zcg.users[pn].page
	alt = dcb.zcg.users[pn].alt
	current_item = dcb.zcg.users[pn].current_item
	local formspec = "size[8,7.5]"
	.. "button[0,0;2,.5;main;Back]"
	if dcb.zcg.users[pn].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;dcb.zcg_previous.png;dcb.zcg_previous;;false;false;dcb.zcg_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;dcb.zcg_previous_inactive.png]"
	end
	if dcb.zcg.users[pn].history.index < #dcb.zcg.users[pn].history.list then
		formspec = formspec .. "image_button[1,1;1,1;dcb.zcg_next.png;dcb.zcg_next;;false;false;dcb.zcg_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;dcb.zcg_next_inactive.png]"
	end
	-- Show craft recipe
	if current_item ~= "" then
		if dcb.zcg.crafts[current_item] then
			if alt > #dcb.zcg.crafts[current_item] then
				alt = #dcb.zcg.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;dcb.zcg_alt:"..(alt-1)..";^]"
			end
			if alt < #dcb.zcg.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;dcb.zcg_alt:"..(alt+1)..";v]"
			end
			local c = dcb.zcg.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec .. "item_image_button["..((i-1)%c.width+x)..","..(math.floor((i-1)/c.width+y))..";1,1;"..item..";dcb.zcg:"..item..";]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;dcb.zcg_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;dcb.zcg_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..dcb.zcg.users[pn].current_item..";;]"
			end
		end
	end
	
	-- Node list
	local npp = 8*3 -- nodes per page
	local i = 0 -- for positionning buttons
	local s = 0 -- for skipping pages
	for _, name in ipairs(dcb.zcg.itemlist) do
		if s < page*npp then s = s+1 else
			if i >= npp then break end
			formspec = formspec .. "item_image_button["..(i%8)..","..(math.floor(i/8)+3.5)..";1,1;"..name..";dcb.zcg:"..name..";]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;dcb.zcg_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7;1,.5;dcb.zcg_page:"..(page+1)..";>>]"
	end
	formspec = formspec .. "label[2,6.85;Page "..(page+1).."/"..(math.floor(#dcb.zcg.itemlist/npp+1)).."]" -- The Y is approximatively the good one to have it centered vertically...
	return formspec
end

--[[
minetest.register_on_joinplayer(function(player)
	inventory_plus.register_button(player,"dcb.zcg","Craft guide")
end)
--]]

minetest.register_node("dcb:craftbook", {
	description = "Craft Book",
	textures = {"default_wood.png^xdecor_enchbook.png"},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local pn = "everamzah"
		minetest.show_formspec(clicker, "dcb:crafts", dcb.zcg.formspec(pn))
	end,
})

minetest.register_on_player_receive_fields(function(player,formname,fields)
	pn = player:get_player_name();
	if dcb.zcg.users[pn] == nil then dcb.zcg.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
	if fields.dcb.zcg then
		--inventory_plus.set_inventory_formspec(player, dcb.zcg.formspec(pn))
		minetest.show_formspec(player, "dcb:crafts", dcb.zcg.formspec(pn))
		return
	elseif fields.dcb.zcg_previous then
		if dcb.zcg.users[pn].history.index > 1 then
			dcb.zcg.users[pn].history.index = dcb.zcg.users[pn].history.index - 1
			dcb.zcg.users[pn].current_item = dcb.zcg.users[pn].history.list[dcb.zcg.users[pn].history.index]
			inventory_plus.set_inventory_formspec(player,dcb.zcg.formspec(pn))
		end
	elseif fields.dcb.zcg_next then
		if dcb.zcg.users[pn].history.index < #dcb.zcg.users[pn].history.list then
			dcb.zcg.users[pn].history.index = dcb.zcg.users[pn].history.index + 1
			dcb.zcg.users[pn].current_item = dcb.zcg.users[pn].history.list[dcb.zcg.users[pn].history.index]
			inventory_plus.set_inventory_formspec(player,dcb.zcg.formspec(pn))
		end
	end
	for k, v in pairs(fields) do
		if (k:sub(0,4)=="dcb.zcg:") then
			local ni = k:sub(5)
			if dcb.zcg.crafts[ni] then
				dcb.zcg.users[pn].current_item = ni
				table.insert(dcb.zcg.users[pn].history.list, ni)
				dcb.zcg.users[pn].history.index = #dcb.zcg.users[pn].history.list
				inventory_plus.set_inventory_formspec(player,dcb.zcg.formspec(pn))
			end
		elseif (k:sub(0,9)=="dcb.zcg_page:") then
			dcb.zcg.users[pn].page = tonumber(k:sub(10))
			inventory_plus.set_inventory_formspec(player,dcb.zcg.formspec(pn))
		elseif (k:sub(0,8)=="dcb.zcg_alt:") then
			dcb.zcg.users[pn].alt = tonumber(k:sub(9))
			inventory_plus.set_inventory_formspec(player,dcb.zcg.formspec(pn))
		end
	end
end)
