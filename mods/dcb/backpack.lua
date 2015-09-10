minetest.register_node("dcb:backpack", {
	description = "Backpack",
	inventory_image = "dcb_backpack.png",
	tiles = {"default_wood.png^dcb_backpack.png"},
	groups = {choppy=1},
	stack_max = 1,
	on_drop = function(itemstack, dropper, pos)
		itemstack:set_metadata("[howdy]={1, 222, 3}")
		minetest.item_drop(itemstack, dropper, pos)
		itemstack:take_item()
		return itemstack
	end,
	on_use = function(itemstack, user, pointed_thing)
		print(itemstack:get_metadata())
	end,
})

local time = 0

local function backpack_inventory(player, state)
	if state then
		print("backpack on")
		--player:get_inventory():set_size("main", 8*1)
	else
		print("backpack off")
		--player:get_inventory():set_size("main", 7*1)
	end
end

local backpack = minetest.create_detached_inventory("backpack")
backpack:set_size("main", 1)
backpack:set_size("contents", 8*3)

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 2 then
		for _, player in ipairs(minetest.get_connected_players()) do
			if minetest.get_inventory({type="detached", name="backpack"}):contains_item("main", {name="dcb:backpack"}) then
				backpack_inventory(player, true)
			else
				backpack_inventory(player, false)
			end
		end
	end
end)
