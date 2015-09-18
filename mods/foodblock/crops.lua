
---- Strawberry block ----

--[[
minetest.register_node("foodblock:strawberryblock", {
	description = "StrawberryBlock",
	tiles = {"foodblock_strawberryblock_top.png","foodblock_strawberryblock_bottom.png","foodblock_strawberryblock_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:strawberryblock_slab", {
	description = "Half Strawberryblock",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",

	tiles = {"foodblock_strawberry_htop.png","foodblock_strawberry_hbottom.png","foodblock_strawberry_hside2.png",
			"foodblock_strawberry_hside.png","foodblock_strawberryblock_top.png","foodblock_strawberryblock_bottom.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:strawberryblock",
	recipe = {
		{"farming_plus:strawberry_item","farming_plus:strawberry_item"},
		{"farming_plus:strawberry_item","farming_plus:strawberry_item"}
	}
})
minetest.register_craft({
	output = "foodblock:strawberryblock",
	recipe = {
		{"bushes:strawberry","bushes:strawberry"},
		{"bushes:strawberry","bushes:strawberry"}
	}
})
minetest.register_craft({
	output = "foodblock:strawberryblock",
	recipe = {
		{"ethereal:strawberry","ethereal:strawberry"},
		{"ethereal:strawberry","ethereal:strawberry"}
	}
})

minetest.register_craft({
	output = 'foodblock:strawberryblock_slab 6',
	recipe = {
		{"foodblock:strawberryblock","foodblock:strawberryblock","foodblock:strawberryblock"}
	}
})

minetest.register_craft({
	output = "foodblock:strawberryblock",
	recipe = {
		{"foodblock:strawberryblock_slab"},
		{"foodblock:strawberryblock_slab"}
	}
})

--Register Uncraft
if minetest.get_modpath("farming_plus") then
	minetest.register_craft({
		output = 'farming_plus:strawberry_item 4',
		recipe = {{"foodblock:strawberryblock"}},
	})

	minetest.register_craft({
		output = 'farming_plus:strawberry_item 2',
		recipe = {{"foodblock:strawberryblock_slab"}},
	})
elseif minetest.get_modpath("plants_lib") then
	minetest.register_craft({
		output = "bushes:strawberry 4",
		recipe = {{"foodblock:strawberryblock"}},
	})

	minetest.register_craft({
		output = "bushes:strawberry 2",
		recipe = {{"foodblock:strawberryblock_slab"}},
	})
elseif minetest.get_modpath("ethereal") then
	minetest.register_craft({
		output = "ethereal:strawberry 4",
		recipe = {{"foodblock:strawberryblock"}},
	})

	minetest.register_craft({
		output = "ethereal:strawberry 2",
		recipe = {{"foodblock:strawberryblock_slab"}},
	})
end

--Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "farming_plus:strawberry_item 5",
	recipe = {"foodblock:strawberryblock" , "farming_plus:strawberry_item"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming_plus:strawberry_item 3",
	recipe = {"foodblock:strawberryblock_slab" , "farming_plus:strawberry_item"},
})
minetest.register_craft({
	type = "shapeless",
	output = "bushes:strawberry 5",
	recipe = {"foodblock:strawberryblock" , "bushes:strawberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "bushes:strawberry 3",
	recipe = {"foodblock:strawberryblock_slab" , "bushes:strawberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:strawberry 5",
	recipe = {"foodblock:strawberryblock" , "ethereal:strawberry"},
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:strawberry 3",
	recipe = {"foodblock:strawberryblock_slab" , "ethereal:strawberry"},
})--]]

---- Tomato block ----

minetest.register_node("foodblock:tomatoblock", {
	description = "TomatoBlock",
	tiles = {"foodblock_tomatoblock_top.png","foodblock_tomatoblock_bottom.png","foodblock_tomatoblock_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:tomatoblock_slab", {
	description = "Half Tomatoblock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_tomato_htop.png","foodblock_appleblock_bottom.png","foodblock_appleblock_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:tomatoblock_slab 6',
	recipe = {
		{"foodblock:tomatoblock","foodblock:tomatoblock","foodblock:tomatoblock"}
	}
})

minetest.register_craft({
	output = "foodblock:tomatoblock",
	recipe = {
		{"foodblock:tomatoblock_slab"},
		{"foodblock:tomatoblock_slab"}
	}
})

--[[
minetest.register_craft({
	output = "foodblock:tomatoblock",
	recipe = {
		{"farming_plus:tomato_item","farming_plus:tomato_item"},
		{"farming_plus:tomato_item","farming_plus:tomato_item"}
	}
})--]]

minetest.register_craft({
	output = "foodblock:tomatoblock",
	recipe = {
		{"crops:tomato","crops:tomato"},
		{"crops:tomato","crops:tomato"},
	}
})

--Uncraft Tomatoblock
minetest.register_craft({
	output = 'crops:tomato 4',
	recipe = {{"foodblock:tomatoblock"}},
})
minetest.register_craft({
	output = 'crops:tomato 2',
	recipe = {{"foodblock:tomatoblock_slab"}},
})

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "crops:tomato 5",
	recipe = {"foodblock:tomatoblock" , "farming:tomato"},
})

minetest.register_craft({
	type = "shapeless",
	output = "crops:tomato 3",
	recipe = {"foodblock:tomatoblock_slab" , "farming:tomato"},
})


--[[
---- Orange block ----

minetest.register_node("foodblock:orangeblock", {
	description = "OrangeBlock",
	tiles = {"foodblock_orange_top.png","foodblock_orange_bottom.png","foodblock_orange_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "foodblock:orangeblock",
	recipe = {
		{"farming_plus:orange_item","farming_plus:orange_item"},
		{"farming_plus:orange_item","farming_plus:orange_item"}
	}
})

minetest.register_craft({
	output = "foodblock:orangeblock",
	recipe = {
		{"ethereal:orange","ethereal:orange"},
		{"ethereal:orange","ethereal:orange"},
	}
})

minetest.register_node("foodblock:orangeblock_slab", {
	description = "Half Tomatoblock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_orange_htop.png","foodblock_orange_bottom.png","foodblock_orange_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:orangeblock_slab 6',
	recipe = {
		{"foodblock:orangeblock","foodblock:orangeblock","foodblock:orangeblock"}
	}
})

minetest.register_craft({
	output = "foodblock:orangeblock",
	recipe = {
		{"foodblock:orangeblock_slab"},
		{"foodblock:orangeblock_slab"}
	}
})

--Register Uncraft
if minetest.get_modpath("farming_plus") then
	minetest.register_craft({
		output = 'farming_plus:orange_item 4',
		recipe = {{"foodblock:orangeblock"}},
	})
	minetest.register_craft({
		output = 'farming_plus:orange_item 2',
		recipe = {{"foodblock:orangeblock_slab"}},
	})
elseif minetest.get_modpath("ethereal") then
	minetest.register_craft({
		output = "ethereal:orange 4",
		recipe = {{"foodblock:orangeblock"}},
	})
	minetest.register_craft({
		output = "ethereal:orange 2",
		recipe = {{"foodblock:orangeblock_slab"}},
	})
end

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "farming_plus:orange_item 5",
	recipe = {"foodblock:orangeblock" , "farming_plus:orange_item"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming_plus:orange_item 3",
	recipe = {"foodblock:orangeblock_slab" , "farming_plus:orange_item"},
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:orange 5",
	recipe = {"foodblock:orangeblock" , "ethereal:orange"},
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:orange 3",
	recipe = {"foodblock:orangeblock_slab" , "ethereal:orange"},
})--]]


--- Carrot block ----

minetest.register_node("foodblock:carrotblock", {
	description = "CarrotBlock",
	tiles = {"foodblock_carrot_top.png","foodblock_carrot_bottom.png","foodblock_carrot_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:carrotblock_slab", {
	description = "Half Tomatoblock",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_carrot_htop.png","foodblock_carrot_bottom.png","foodblock_carrot_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:carrotblock_slab 6',
	recipe = {
		{"foodblock:carrotblock","foodblock:carrotblock","foodblock:carrotblock"}
	}
})

minetest.register_craft({
	output = "foodblock:carrotblock",
	recipe = {
		{"foodblock:carrotblock_slab"},
		{"foodblock:carrotblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:carrotblock",
	recipe = {
		{"crops:carrot","crops:carrot"},
		{"crops:carrot","crops:carrot"}
	}
})

--Uncraft Potatoblock
minetest.register_craft({
	output = 'crops:carrot 4',
	recipe = {{"foodblock:carrotblock"}},
})

minetest.register_craft({
	output = 'crops:carrot 2',
	recipe = {{"foodblock:carrotblock_slab"}},
})

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "crops:carrot 5",
	recipe = {"foodblock:carrotblock" , "farming:carrot"},
})

minetest.register_craft({
	type = "shapeless",
	output = "crops:carrot 3",
	recipe = {"foodblock:carrotblock_slab" , "farming:carrot"},
})


--- potato block ----

minetest.register_node("foodblock:potatoblock", {
	description = "Potato Block",
	tiles = {"foodblock_potato.png","foodblock_potato.png","foodblock_potato.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:potatoblock_slab", {
	description = "Potato Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_potato_htop.png","foodblock_potato.png","foodblock_potato.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:potatoblock_slab 6',
	recipe = {
		{"foodblock:potatoblock","foodblock:potatoblock","foodblock:potatoblock"}
	}
})

minetest.register_craft({
	output = "foodblock:potatoblock",
	recipe = {
		{"foodblock:potatoblock_slab"},
		{"foodblock:potatoblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:potatoblock",
	recipe = {
		{"farming_plus:potato_item","farming_plus:potato_item"},
		{"farming_plus:potato_item","farming_plus:potato_item"}
	}
})
minetest.register_craft({
	output = "foodblock:potatoblock",
	recipe = {
		{"farming:potato","farming:potato"},
		{"farming:potato","farming:potato"}
	}
})


--Uncraft Potatoblock
if minetest.get_modpath("farming_plus") then
	minetest.register_craft({
		output = 'farming_plus:potato_item 4',
		recipe = {{"foodblock:potatoblock"}},
	})
	minetest.register_craft({
		output = 'farming_plus:potato_item 2',
		recipe = {{"foodblock:potatoblock_slab"}},
	})
else
	minetest.register_craft({
		output = 'farming:potato 4',
		recipe = {{"foodblock:potatoblock"}},
	})
	minetest.register_craft({
		output = 'farming:potato 2',
		recipe = {{"foodblock:potatoblock_slab"}},
	})
end

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "farming_plus:potato_item 5",
	recipe = {"foodblock:potatoblock" , "farming_plus:potato_item"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming_plus:potato_item 3",
	recipe = {"foodblock:potatoblock_slab" , "farming_plus:potato_item"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:potato 5",
	recipe = {"foodblock:potatoblock" , "farming:potato"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:potato 3",
	recipe = {"foodblock:potatoblock_slab" , "farming:potato"},
})

