if minetest.setting_getbool("enable_experimental") then
	dofile(minetest.get_modpath("cbd").."/guest_book.lua")
	dofile(minetest.get_modpath("cbd").."/rental.lua")
end
