---- Corn block ----

minetest.register_node("foodblock:corn", {
	description = "Corn Block",
	tiles = {"foodblock_corn_top.png","foodblock_corn_bottom.png","foodblock_corn_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:corn_slab", {
	description = "Half CornBlock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_corn_top.png","foodblock_corn_bottom.png","foodblock_corn_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:corn",
	recipe = {
		{"farming:corn","farming:corn"},
		{"farming:corn","farming:corn"}
	}
})
minetest.register_craft({
	output = 'foodblock:corn_slab 6',
	recipe = {
		{"foodblock:corn","foodblock:corn","foodblock:corn"}
	}
})

minetest.register_craft({
	output = "foodblock:corn",
	recipe = {
		{"foodblock:corn_slab"},
		{"foodblock:corn_slab"}
	}
})

minetest.register_craft({
	output = "farming:corn 4",
	recipe = {{"foodblock:corn"}},
})

minetest.register_craft({
	output = "farming:corn 2",
	recipe = {{"foodblock:corn_slab"}},
})

