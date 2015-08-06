beds = {}
beds.player = {}
beds.pos = {}
beds.spawn = {}
beds.bed_pointed_pos = {}

beds.formspec = "size[8,15;true]"..
		"bgcolor[#080808BB; true]"..
		"button_exit[2,12;4,0.75;leave;Leave Bed]"

function beds.get_bed_formspec(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"button_exit[-0.02,0;2.5,1;setrespawn;Set Respawn]"..
			"button_exit[2.75,0;2.5,1;sleep;Sleep]"..
			"button_exit[5.56,0;2.5,1;sethome;Set Home]"..
			--"list[current_name;bed_trunk;0,2;8,2]"..
			"list[nodemeta:"..spos..";bed_trunk;0,1;8,3]"..
			default.get_hotbar_bg(0,4.25)
	return formspec
end

local modpath = minetest.get_modpath("beds")

-- load files
dofile(modpath.."/functions.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/beds.lua")
dofile(modpath.."/spawns.lua")
