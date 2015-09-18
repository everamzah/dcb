---- Onion block ----

minetest.register_node("foodblock:onion", {
	description = "Onion Block",
	tiles = {"foodblock_onion_top.png","foodblock_onion_bottom.png","foodblock_onion_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:onion_slab", {
	description = "Half OnionBlock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_onion_htop.png","foodblock_onion_bottom.png","foodblock_onion_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:onion",
	recipe = {
		{"ethereal:wild_onion_plant","ethereal:wild_onion_plant"},
		{"ethereal:wild_onion_plant","ethereal:wild_onion_plant"}
	}
})
minetest.register_craft({
	output = 'foodblock:onion_slab 6',
	recipe = {
		{"foodblock:onion","foodblock:onion","foodblock:onion"}
	}
})

minetest.register_craft({
	output = "foodblock:onion",
	recipe = {
		{"foodblock:onion_slab"},
		{"foodblock:onion_slab"}
	}
})

minetest.register_craft({
	output = "ethereal:wild_onion_plant 4",
	recipe = {{"foodblock:onion"}},
})

minetest.register_craft({
	output = "ethereal:wild_onion_plant 2",
	recipe = {{"foodblock:onion_slab"}},
})

