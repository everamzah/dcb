---- Red Mushroom block ----
minetest.register_node("foodblock:redmushroomblock", {
	description = "RedMushroomBlock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_mushroomR_top.png","foodblock_mushroomR_bottom.png","foodblock_mushroomR_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/4, -1/2, 1/2, 1/2, 1/2},
			{-1/4, -1/2, -1/4, 1/4, -1/4, 1/4},
		},
	},

	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:redmushroomblock_slab", {
	description = "Half RedMushroomblock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_mushroomR_top.png","foodblock_mushroomR_bottom.png","foodblock_mushroomR_hside.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:redmushroomblock_slab 6',
	recipe = {
		{"foodblock:redmushroomblock","foodblock:redmushroomblock","foodblock:redmushroomblock"}
	}
})

minetest.register_craft({
	output = "foodblock:redmushroomblock",
	recipe = {
		{"foodblock:redmushroomblock_slab"},
		{"foodblock:redmushroomblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:redmushroomblock",
	recipe = {
		{"flowers:mushroom_red","flowers:mushroom_red"},
		{"flowers:mushroom_red","flowers:mushroom_red"},
	}
})
minetest.register_craft({
	output = "foodblock:redmushroomblock",
	recipe = {
		{"mushroom:red","mushroom:red"},
		{"mushroom:red","mushroom:red"}
	}
})

minetest.register_craft({
	output = "flowers:mushroom_red 4",
	recipe = {{"foodblock:redmushroomblock"}},
})
minetest.register_craft({
	output = "flowers:mushroom_red 2",
	recipe = {{"foodblock:redmushroomblock_slab"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "mushroom:red 5",
	recipe = {"foodblock:redmushroomblock","mushroom:red"},
})
minetest.register_craft({
	type = "shapeless",
	output = "mushroom:red 3",
	recipe = {"foodblock:redmushroomblock_slab","mushroom:red"},
})
minetest.register_craft({
	type = "shapeless",
	output = "flowers:mushroom_red 5",
	recipe = {"foodblock:redmushroomblock","flowers:mushroom_red"},
})
minetest.register_craft({
	type = "shapeless",
	output = "flowers:mushroom_red 3",
	recipe = {"foodblock:redmushroomblock_slab","flowers:mushroom_red"},
})

---- Brown Mushroom block ----
minetest.register_node("foodblock:brownmushroomblock", {
	description = "BrownMushroomBlock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_mushroomB_top.png","foodblock_mushroomB_bottom.png","foodblock_mushroomB_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/4, -1/2, 1/2, 1/2, 1/2},
			{-1/4, -1/2, -1/4, 1/4, -1/4, 1/4},
		},
	},

	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:brownmushroomblock_slab", {
	description = "Half BrownMushrromblock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_mushroomB_top.png","foodblock_mushroomB_bottom.png","foodblock_mushroomB_hside.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:brownmushroomblock_slab 6',
	recipe = {
		{"foodblock:brownmushroomblock","foodblock:brownmushroomblock","foodblock:brownmushroomblock"}
	}
})

minetest.register_craft({
	output = "foodblock:brownmushroomblock",
	recipe = {
		{"foodblock:brownmushroomblock_slab"},
		{"foodblock:brownmushroomblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:brownmushroomblock",
	recipe = {
		{"flowers:mushroom_brown","flowers:mushroom_brown"},
		{"flowers:mushroom_brown","flowers:mushroom_brown"},
	}
})
minetest.register_craft({
	output = "foodblock:brownmushroomblock",
	recipe = {
		{"mushroom:brown","mushroom:brown"},
		{"mushroom:brown","mushroom:brown"}
	}
})

minetest.register_craft({
	output = "flowers:mushroom_brown 4",
	recipe = {{"foodblock:brownmushroomblock"}},
})

minetest.register_craft({
	output = "flowers:mushroom_brown 2",
	recipe = {{"foodblock:brownmushroomblock_slab"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "mushroom:brown 5",
	recipe = {"foodblock:brownmushroomblock","mushroom:brown"},
})
minetest.register_craft({
	type = "shapeless",
	output = "mushroom:brown 3",
	recipe = {"foodblock:brownmushroomblock_slab","mushroom:brown"},
})
minetest.register_craft({
	type = "shapeless",
	output = "flowers:mushroom_brown 5",
	recipe = {"foodblock:brownmushroomblock","flowers:mushroom_brown"},
})
minetest.register_craft({
	type = "shapeless",
	output = "flowers:mushroom_brown 3",
	recipe = {"foodblock:brownmushroomblock_slab","flowers:mushroom_brown"},
})

