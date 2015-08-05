beds = {}
beds.player = {}
beds.pos = {}
beds.spawn = {}

beds.formspec = "size[8,15;true]"..
		"bgcolor[#080808BB; true]"..
		"button_exit[2,12;4,0.75;leave;Leave Bed]"

beds.formspec2 = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"button[0,0;2.5,1;setrespawn;Set Respawn]"..
			"button[2.75,0;2.5,1;sleep;Sleep]"..
			"button[5.5,0;2.5,1;sethome;Set Home]"..
			default.get_hotbar_bg(0,4.25)

local modpath = minetest.get_modpath("beds")

-- load files
dofile(modpath.."/functions.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/beds.lua")
dofile(modpath.."/spawns.lua")
