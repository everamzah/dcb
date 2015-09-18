--- Coconut block ----
minetest.register_node("foodblock:cocoblock", {
	description = "Coconuts Block",
	tiles = {"foodblock_coco_top.png","foodblock_coco_bottom.png","foodblock_coco_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, 7/16,-7/16, 7/16, 8/16, 7/16}, 
			{ -1/2,-7/16, -1/2,  1/2, 7/16, 1/2},
			{-7/16, -1/2,-7/16, 7/16,-7/16, 7/16}, 
		}
	},
	groups = {choppy=3 , crumbly=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("foodblock:cocoblock_slab", {
	description = "Half Coconuts block",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_coco_htop.png","foodblock_coco_bottom.png","foodblock_coco_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -7/16, -1/2, 1/2, 0, 1/2},
			{-7/16, -1/2,-7/16, 7/16,-7/16, 7/16}, 
		}
	},
	groups = {choppy=3 , crumbly=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'foodblock:cocoblock_slab 6',
	recipe = {
		{"foodblock:cocoblock","foodblock:cocoblock","foodblock:cocoblock"}
	}
})

minetest.register_craft({
	output = "foodblock:cocoblock",
	recipe = {
		{"foodblock:cocoblock_slab"},
		{"foodblock:cocoblock_slab"}
	}
})


minetest.register_craft({
	output = "foodblock:cocoblock",
	recipe = {
		{"moretrees:coconut","moretrees:coconut"},
		{"moretrees:coconut","moretrees:coconut"}
	}
})

minetest.register_craft({
	output = "foodblock:cocoblock_slab",
	recipe = {
		{"ethereal:coconut_slice","ethereal:coconut_slice","ethereal:coconut_slice"},
		{"ethereal:coconut_slice","ethereal:coconut_slice","ethereal:coconut_slice"},
		{"ethereal:coconut_slice","ethereal:coconut_slice","ethereal:coconut_slice"},
	}
})

--register Uncraft
if minetest.get_modpath("moretrees") then
	minetest.register_craft({
		output = "moretrees:coconut 4",
		recipe = {{"foodblock:cocoblock"}},
	})
	minetest.register_craft({
		output = "moretrees:coconut 2",
		recipe = {{"foodblock:cocoblock_slab"}},
	})
elseif minetest.get_modpath("ethereal") then
	minetest.register_craft({
		output = "ethereal:coconut_slice 18",
		recipe = {{"foodblock:cocoblock"}},
	})
	minetest.register_craft({
		output = "ethereal:coconut_slice 9",
		recipe = {{"foodblock:cocoblock_slab"}},
	})
end


minetest.register_craft({
	type = "shapeless",
	output = "moretrees:coconut 5",
	recipe = {"foodblock:cocoblock" , "moretrees:coconut"},
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:coconut 3",
	recipe = {"foodblock:cocoblock_slab" , "moretrees:coconut"},
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:coconut_slice 19",
	recipe = {"foodblock:cocoblock" , "ethereal:coconut_slice"},
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:coconut_slice 10",
	recipe = {"foodblock:cocoblock_slab" , "ethereal:coconut_slice"},
})

--- Acorn block ----
minetest.register_node("foodblock:acone", {
	description = "Acone Block",
	tiles = {"foodblock_acone_top.png","foodblock_acone_bottom.png","foodblock_acone_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16, 2/16,-8/16, 8/16, 8/16, 8/16}, 
			{-7/16,-7/16,-7/16, 7/16, 2/16, 7/16},
			{-6/16,-8/16,-6/16, 6/16,-7/16, 6/16}, 
		}
	},
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "foodblock:acone",
	recipe = {
		{"moretrees:acorn","moretrees:acorn"},
		{"moretrees:acorn","moretrees:acorn"}
	}
})
minetest.register_craft({
	output = "moretrees:acorn 4",
	recipe = {{"foodblock:acone"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:acone 5",
	recipe = {"foodblock:acone" , "moretrees:acone"},
})

--- Corn block ----
minetest.register_node("foodblock:cone", {
	description = "Cone Block",
	tiles = {"foodblock_cone_top.png","foodblock_cone_bottom.png","foodblock_cone_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16, 2/16,-8/16, 8/16, 8/16, 8/16}, 
			{-7/16,-7/16,-7/16, 7/16, 2/16, 7/16},
			{-6/16,-8/16,-6/16, 6/16,-7/16, 6/16}, 
		}
	},
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "foodblock:cone",
	recipe = {
		{"moretrees:pine_cone","moretrees:pine_cone"},
		{"moretrees:pine_cone","moretrees:pine_cone"},
	}
})
minetest.register_craft({
	output = "foodblock:cone",
	recipe = {
		{"moretrees:fir_cone","moretrees:fir_cone"},
		{"moretrees:fir_cone","moretrees:fir_cone"},
	}
})
minetest.register_craft({
	output = "foodblock:cone",
	recipe = {
		{"moretrees:spruce_cone","moretrees:spruce_cone"},
		{"moretrees:spruce_cone","moretrees:spruce_cone"},
	}
})

minetest.register_craft({
	output = "moretrees:pine_cone 4",
	recipe = {{"foodblock:cone"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:pine_cone 5",
	recipe = {"foodblock:cone" , "moretrees:pine_cone"},
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:fir_cone 5",
	recipe = {"foodblock:cone" , "moretrees:fir_cone"},
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:spruce_cone 5",
	recipe = {"foodblock:cone" , "moretrees:spruce_cone"},
})
