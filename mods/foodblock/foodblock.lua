minetest.register_node("foodblock:breadblock", {
	description = "Bread Block",
	tiles = {"foodblock_breadblock_top.png",
		"foodblock_breadblock_bottom.png",
		"foodblock_breadblock_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:breadblock_slab", {
	description = "Bread Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_breadblock_top.png", "foodblock_breadblock_bottom.png", "foodblock_breadblock_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:breadblock",
	recipe = {
		{"farming:bread","farming:bread"},
		{"farming:bread","farming:bread"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'farming:bread 4',
	recipe = {"foodblock:breadblock"},
})

minetest.register_craft({
	output = 'foodblock:breadblock_slab 6',
	recipe = {
		{"foodblock:breadblock","foodblock:breadblock","foodblock:breadblock"}
	}
})

minetest.register_craft({
	output = "foodblock:breadblock",
	recipe = {
		{"foodblock:breadblock_slab"},
		{"foodblock:breadblock_slab"}
	}
})

minetest.register_craft({
	output = 'farming:bread 2',
	recipe = {
		{"foodblock:breadblock_slab"}
	}
})

minetest.register_node("foodblock:appleblock", {
	description = "AppleBlock",
	tiles = {"foodblock_appleblock_top.png","foodblock_appleblock_bottom.png","foodblock_appleblock_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:appleblock_slab", {
	description = "Half Appleblock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_appleblock_halftop.png","foodblock_appleblock_bottom.png","foodblock_appleblock_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:appleblock",
	recipe = {
		{"default:apple","default:apple"},
		{"default:apple","default:apple"}
	}
})

minetest.register_craft({
	output = 'default:apple 4',
	recipe = {{"foodblock:appleblock"}},
})

minetest.register_craft({
	output = 'foodblock:appleblock_slab 6',
	recipe = {
		{"foodblock:appleblock","foodblock:appleblock","foodblock:appleblock"}
	}
})

minetest.register_craft({
	output = "foodblock:appleblock",
	recipe = {
		{"foodblock:appleblock_slab"},
		{"foodblock:appleblock_slab"}
	}
})

minetest.register_craft({
	output = 'default:apple 2',
	recipe = {{"foodblock:appleblock_slab"}},
})

