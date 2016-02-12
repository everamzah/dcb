beds = {}
beds.player = {}
beds.pos = {}
beds.spawn = {}
beds.bed_pointed_pos = {}

beds.formspec = "size[8,15;true]" ..
		"bgcolor[#080808BB; true]" ..
		"button_exit[2,12;4,0.75;leave;Leave Bed]"

minetest.register_on_joinplayer(function(player)
        local inv = player:get_inventory()
        inv:set_size("bed_trunk", 8*3)
end)

local modpath = minetest.get_modpath("beds")

-- load files
dofile(modpath .. "/functions.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/beds.lua")
dofile(modpath .. "/spawns.lua")
