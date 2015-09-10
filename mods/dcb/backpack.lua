minetest.register_node("dcb:backpack", {
	description = "Backpack",
	inventory_image = "dcb_backpack.png",
	tiles = {"default_wood.png^dcb_backpack.png"},
	groups = {choppy=1},
	stack_max = 1,
	on_drop = function(itemstack, dropper, pos)
		--print("say whaaat?")
		itemstack:set_metadata("[howdy]={1, 222, 3}")
		minetest.item_drop(itemstack, dropper, pos)
		itemstack:take_item()
		return itemstack
	end,
	on_use = function(itemstack, user, pointed_thing)
		print(itemstack:get_metadata())
	end,
	--[[
	on_punch = function(pos, node, puncher, pointed_thing)
		puncher:get_inventory():set_size("main", 8*4)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		clicker:get_inventory():set_size("main", 8*1)
	end
	--]]
})

local time = 0

local function backpack_inventory(player, state)
	if state then
		player:get_inventory():set_size("main", 8*4)
	else
		player:get_inventory():set_size("main", 8*1)
	end
end

local backpack_inv = minetest.create_detached_inventory("backpack")
backpack_inv:set_size("main", 1)

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 2 then
		for _, player in ipairs(minetest.get_connected_players()) do
			--if player:get_inventory():contains_item("backpack", {name="dcb:backpack"}) then
			if minetest.get_inventory({type="detached", name="backpack"}):contains_item("main", {name="dcb:backpack"}) then
				--print("has backpack")
				backpack_inventory(player, true)
			else
				--print("has no backpack")
				backpack_inventory(player, false)
			end
		end
	end
end)
