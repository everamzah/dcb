-- Privs Shop

-- Global privs shop price, settable by /shop
shop.price = 1

-- Formspec
function shop.setform(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec =
		"size[8,6]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
		"label[0,0;Priv Shop]"..
		"label[2.45,0.5;Fly for "..shop.price.."/s]"..
		"label[4.45,0.5;Fast for "..shop.price.."/s]"..
		"list[nodemeta:"..spos..";fly;2.5,1;1,1;]"..
		"list[nodemeta:"..spos..";fast;4.5,1;1,1;]"..
		"item_image[2.5,1;1,1;shop:coin]"..
		"item_image[4.5,1;1,1;shop:coin]"..
		"list[current_player;main;0,2.25;8,4;]"
	return formspec
end

function shop.buy(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	if listname == "fly" then
		local count = stack:get_count()
		inv:remove_item("fly", stack)
		--inv:add_item("register", stack)
		local p = player:get_player_name()
		local time = math.ceil(count / shop.price)

		local q = playereffects.get_player_effects(player:get_player_name())
		for i=1, #q do
			if q[i].effect_type_id == "fly" then
				local countdown_fly = math.ceil(q[i].time_left)
				local effectid_fly = playereffects.apply_effect_type("fly", time + countdown_fly, player)
				return
			end
		end		
		local effectid_fly = playereffects.apply_effect_type("fly", time, player)
	elseif listname == "fast" then
		local count = stack:get_count()
		inv:remove_item("fast", stack)
		--inv:add_item("register", stack)
		local p = player:get_player_name()
		local time = math.ceil(count / shop.price)

		local q = playereffects.get_player_effects(player:get_player_name())
		for i=1, #q do
			if q[i].effect_type_id == "fast" then
				local countdown_fast = math.ceil(q[i].time_left)
				local effectid_fast = playereffects.apply_effect_type("fast", time + countdown_fast, player)
				return
			end
		end
		local effectid_fast = playereffects.apply_effect_type("fast", time, player)
	end
end

minetest.register_alias("shop:shop", "shop:privs")
minetest.register_node("shop:privs", {
	description = "Privs Shop",
	tiles = {"default_sandstone.png^shop_wings.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, oddly_breakable_by_hand=1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Shop for privs")
		local inv = meta:get_inventory()
		inv:set_size("fly", 1)
		inv:set_size("fast", 1)
		--inv:set_size("register", 8*4)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		minetest.show_formspec(clicker:get_player_name(), "shop:privs", shop.setform(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		shop.buy(pos, listname, index, stack, player)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local s = stack:get_name()
		local c = stack:get_count()
		if listname == "fly" then
			if s == "shop:coin" and c >= shop.price then
				return -1
			else
				return 0
			end
		elseif listname == "fast" then
			if s == "shop:coin" and c >= shop.price then
				return -1
			else
				return 0
			end
		else
			return 0
		end
	end
})

-- playereffects registration
playereffects.register_effect_type("fly", "Fly mode available", nil, {"fly"},
	function(player)
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = true
		minetest.set_player_privs(playername, privs)
	end,
	function(effect, player)
		local privs = minetest.get_player_privs(effect.playername)
		privs.fly = nil
		minetest.set_player_privs(effect.playername, privs)
	end,
	false,
	false)

playereffects.register_effect_type("fast", "Fast mode available", nil, {"fast"},
	function(player)
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fast = true
		minetest.set_player_privs(playername, privs)
	end,
	function(effect, player)
		local privs = minetest.get_player_privs(effect.playername)
		privs.fast = nil
		minetest.set_player_privs(effect.playername, privs)
	end,
	false,
	false)

-- /shop chat command registration
minetest.register_chatcommand("shop", {
	params = "<price>",
	privs = {server=true},
	description = "Adjust privs shop price",
	func = function(name, param)
		param = tonumber(param)
		if param then
			shop.price = math.abs(param)
		end
	end
})
