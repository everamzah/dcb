-- Global foodblock namespace
foodblock = {}
foodblock.path = minetest.get_modpath("foodblock")

-- Load files
dofile(foodblock.path .. "/foodblock.lua")
--dofile(foodblock.path .. "/farmplus.lua")
--dofile(foodblock.path .. "/plantlife.lua")
dofile(foodblock.path .. "/mobsfood.lua")
--dofile(foodblock.path .. "/foodfood.lua")
--dofile(foodblock.path .. "/moretree.lua")
--dofile(foodblock.path .. "/berrys.lua")
--dofile(foodblock.path .. "/ethereal.lua")
--dofile(foodblock.path .. "/farmredo.lua")

dofile(foodblock.path .. "/cooking.lua")
