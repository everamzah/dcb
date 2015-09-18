--- Dark Choco block ----
minetest.register_node("foodblock:chocod_block", {
	description = "Dark Chocolate Block",
	tiles = {"foodblock_chocod_top.png","foodblock_chocod_bottom.png","foodblock_chocod_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "foodblock:chocod_block",
	recipe = {
		{"food:dark_chocolate","food:dark_chocolate"},
		{"food:dark_chocolate","food:dark_chocolate"},
	}
})

--Another Recipe(less changing_rate than Normal)
minetest.register_craft({
	output = "foodblock:chocod_block 3",
	recipe = {
		{"farming_plus:cocoa","farming_plus:cocoa"},
		{"farming_plus:cocoa","farming_plus:cocoa"},
	}
})


minetest.register_craft({
	output = "food:dark_chocolate 4",
	recipe = {{"foodblock:chocod_block"}},
})

minetest.register_node("foodblock:chocod_block_slab", {
	description = "Half Dark Chocolate block",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_chocod_top.png","foodblock_chocod_bottom.png","foodblock_chocod_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:chocod_block_slab 6",
	recipe = {
		{"foodblock:chocod_block","foodblock:chocod_block","foodblock:chocod_block"}
	}
})

minetest.register_craft({
	output = "foodblock:chocod_block",
	recipe = {
		{"foodblock:chocod_block_slab"},
		{"foodblock:chocod_block_slab"},
	}
})

minetest.register_craft({
	output = "food:dark_chocolate 2",
	recipe = {{"foodblock:chocod_block_slab"}},
})

--- Milk Choco block ----
minetest.register_node("foodblock:chocom_block", {
	description = "Milk Chocolate Block",
	tiles = {"foodblock_chocom_top.png","foodblock_chocom_bottom.png","foodblock_chocom_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "foodblock:chocom_block",
	recipe = {
		{"food:milk_chocolate","food:milk_chocolate"},
		{"food:milk_chocolate","food:milk_chocolate"},
	}
})

minetest.register_craft({
	output = "food:milk_chocolate 4",
	recipe = {{"foodblock:chocom_block"}},
})

minetest.register_node("foodblock:chocom_block_slab", {
	description = "Half Milk Chocolate block",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_chocom_top.png","foodblock_chocom_bottom.png","foodblock_chocom_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:chocom_block_slab 6",
	recipe = {
		{"foodblock:chocom_block","foodblock:chocom_block","foodblock:chocom_block"}
	}
})

minetest.register_craft({
	output = "foodblock:chocom_block",
	recipe = {
		{"foodblock:chocom_block_slab"},
		{"foodblock:chocom_block_slab"},
	}
})

minetest.register_craft({
	output = "food:milk_chocolate 4",
	recipe = {{"foodblock:chocom_block_slab"}},
})

