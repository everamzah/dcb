-- Global foodblock namespace
-- foodblock = {}
-- foodblock.path = minetest.get_modpath("foodblock")
local modpath = minetest.get_modpath("foodblock")

-- Load files

-- Food support
dofile(modpath.."/foodblock.lua")
dofile(modpath.."/mobsfood.lua")
dofile(modpath.."/crops.lua")
--dofile(modpath.."/farmplus.lua")
--dofile(modpath.."/plantlife.lua")
--dofile(modpath.."/foodfood.lua")
--dofile(modpath.."/moretree.lua")
--dofile(modpath.."/berrys.lua")
--dofile(modpath.."/ethereal.lua")
--dofile(modpath.."/farmredo.lua")

-- Cooking?
dofile(modpath.."/cooking.lua")
