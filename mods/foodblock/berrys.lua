---- Blackberry block ----

minetest.register_node("foodblock:blackberryblock", {
	description = "BlackberryBlock",
	tiles = {"foodblock_blackberry_top.png","foodblock_blackberry_bottom.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:blackberryblock_slab", {
	description = "Half Blackberryblock",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"foodblock_blackberry_top.png","foodblock_blackberry_bottom.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:blackberryblock",
	recipe = {
		{"bushes:blackberry","bushes:blackberry"},
		{"bushes:blackberry","bushes:blackberry"}
	}
})
minetest.register_craft({
	output = 'foodblock:blackberryblock_slab 6',
	recipe = {
		{"foodblock:blackberryblock","foodblock:blackberryblock","foodblock:blackberryblock"}
	}
})

minetest.register_craft({
	output = "foodblock:blackberryblock",
	recipe = {
		{"foodblock:blackberryblock_slab"},
		{"foodblock:blackberryblock_slab"}
	}
})

minetest.register_craft({
	output = "bushes:blackberry 4",
	recipe = {{"foodblock:blackberryblock"}},
})

minetest.register_craft({
	output = "bushes:blackberry 2",
	recipe = {{"foodblock:blackberryblock_slab"}},
})

---- Raspberry block ----

minetest.register_node("foodblock:raspberryblock", {
	description = "RaspberryBlock",
	tiles = {"foodblock_raspberry_top.png","foodblock_raspberry_bottom.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:raspberryblock_slab", {
	description = "Half Raspberryblock",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"foodblock_raspberry_top.png","foodblock_raspberry_bottom.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:raspberryblock_slab 6',
	recipe = {
		{"foodblock:raspberryblock","foodblock:raspberryblock","foodblock:raspberryblock"}
	}
})

minetest.register_craft({
	output = "foodblock:raspberryblock",
	recipe = {
		{"foodblock:raspberryblock_slab"},
		{"foodblock:raspberryblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:raspberryblock",
	recipe = {
		{"bushes:raspberry","bushes:raspberry"},
		{"bushes:raspberry","bushes:raspberry"}
	}
})

minetest.register_craft({
	output = "foodblock:raspberryblock",
	recipe = {
		{"farming:raspberries","farming:raspberries"},
		{"farming:raspberries","farming:raspberries"}
	}
})

--Uncraft raspberryblock
if minetest.get_modpath("bushes_classic") then
	minetest.register_craft({
		output = "bushes:raspberry 4",
		recipe = {{"foodblock:raspberryblock"}},
	})
	minetest.register_craft({
		output = "bushes:raspberry 2",
		recipe = {{"foodblock:raspberryblock_slab"}},
	})
else
	minetest.register_craft({
		output = "farming:raspberries 4",
		recipe = {{"foodblock:raspberryblock"}},
	})
	minetest.register_craft({
		output = "farming:raspberries 2",
		recipe = {{"foodblock:raspberryblock_slab"}},
	})
end

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "bushes:raspberry 5",
	recipe = {"foodblock:raspberryblock" , "bushes:raspberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "bushes:raspberry 3",
	recipe = {"foodblock:raspberryblock_slab" , "bushes:raspberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:raspberries 5",
	recipe = {"foodblock:raspberryblock" , "farming:raspberries"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:raspberries 3",
	recipe = {"foodblock:raspberryblock_slab" , "farming:raspberries"},
})

---- Blueberry block ----

minetest.register_node("foodblock:blueberryblock", {
	description = "BlueberryBlock",
	tiles = {"foodblock_blueberry_top.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:blueberryblock_slab", {
	description = "Half Blueberryblock",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"foodblock_blueberry_top.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:blueberryblock",
	recipe = {
		{"bushes:blueberry","bushes:blueberry"},
		{"bushes:blueberry","bushes:blueberry"}
	}
})

minetest.register_craft({
	output = "foodblock:blueberryblock",
	recipe = {
		{"farming:blueberries","farming:blueberries"},
		{"farming:blueberries","farming:blueberries"},
	}
})

minetest.register_craft({
	output = 'foodblock:blueberryblock_slab 6',
	recipe = {
		{"foodblock:blueberryblock","foodblock:blueberryblock","foodblock:blueberryblock"}
	}
})

minetest.register_craft({
	output = "foodblock:blueberryblock",
	recipe = {
		{"foodblock:blueberryblock_slab"},
		{"foodblock:blueberryblock_slab"}
	}
})

--Uncraft blueberryblock
if minetest.get_modpath("bushes_classic") then
	minetest.register_craft({
		output = "bushes:blueberry 4",
		recipe = {{"foodblock:blueberryblock"}},
	})
	minetest.register_craft({
		output = "bushes:blueberry 2",
		recipe = {{"foodblock:blueberryblock_slab"}},
	})
else
	minetest.register_craft({
		output = "farming:blueberries 4",
		recipe = {{"foodblock:blueberryblock"}},
	})
	minetest.register_craft({
		output = "farming:blueberries 2",
		recipe = {{"foodblock:blueberryblock_slab"}},
	})
end

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "bushes:blueberry 5",
	recipe = {"foodblock:blueberryblock" , "bushes:blueberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "bushes:blueberry 3",
	recipe = {"foodblock:blueberryblock_slab" , "bushes:blueberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:blueberries 5",
	recipe = {"foodblock:blueberryblock" , "farming:blueberries"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:blueberries 3",
	recipe = {"foodblock:blueberryblock_slab" , "farming:blueberries"},
})
