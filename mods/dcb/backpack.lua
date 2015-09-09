minetest.register_node("dcb:backpack", {
	description = "Backpack",
	inventory_image = "dcb_backpack.png",
	tiles = {"default_wood.png^dcb_backpack.png"},
	on_punch = function(pos, node, puncher, pointed_thing)
		puncher:get_inventory():set_size("main", 8*4)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		clicker:get_inventory():set_size("main", 8*1)
	end
})
