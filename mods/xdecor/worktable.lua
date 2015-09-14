local worktable = {}
local xbg = default.gui_bg..default.gui_bg_img..default.gui_slots

local material = {
	"default_wood", "default_junglewood", "default_pinewood", "default_acacia_wood",
	"default_tree", "default_jungletree", "default_pinetree", "default_acacia_tree",
	"default_pine_wood", "default_pine_tree",
	"default_cobble", "default_mossycobble", "default_desert_cobble",
	"default_stone", "default_sandstone", "default_desert_stone", "default_obsidian",
	"default_stonebrick", "default_sandstonebrick", "default_desert_stonebrick", "default_obsidianbrick",
	"default_coalblock", "default_copperblock", "default_bronzeblock",
	"default_goldblock", "default_steelblock", "default_diamondblock",
	"default_clay", "default_ice", "default_meselamp",
	"default_glass", "default_obsidian_glass",
	"default_cactus", "default_sand", "default_desert_sand",
	"default_snowblock", "default_dirt", "default_leaves",
	"default_gravel", "default_mese", "default_brick",

	"farming_straw",

	"xdecor_coalstone_tile", "xdecor_moonbrick", "xdecor_stone_rune",
	"xdecor_stone_tile", "xdecor_wood_tile", "xdecor_woodframed_glass",
	"xdecor_hard_clay", "xdecor_desertstone_tile", "xdecor_packed_ice",

	"wool_black", "wool_brown", "wool_dark_green", "wool_green",
	"wool_magenta", "wool_pink", "wool_violet", "wool_yellow",
	"wool_blue", "wool_cyan", "wool_dark_grey", "wool_grey",
	"wool_orange", "wool_red", "wool_white",

	"caverealms_glow_crystal", "caverealms_glow_emerald", "caverealms_glow_mese",
	"caverealms_glow_ruby", "caverealms_glow_amethyst", "caverealms_glow_ore",
	"caverealms_glow_emerald_ore", "caverealms_glow_ruby_ore", "caverealms_glow_amethyst_ore",
	"caverealms_thin_ice", "caverealms_salt_crystal", "caverealms_mushroom_cap",
	"caverealms_mushroom_stem", "caverealms_stone_with_salt", "caverealms_hot_cobble",
	"caverealms_glow_obsidian", "caverealms_glow_obsidian_2", "caverealms_coal_dust"
}

local def = { -- Node name, nodebox shape.
	{"nanoslab", {-.5,-.5,-.5,0,-.4375,0}},
	{"micropanel", {-.5,-.5,-.5,.5,-.4375,0}},
	{"microslab", {-.5,-.5,-.5,.5,-.4375,.5}},
	{"thinstair", {{-.5,-.0625,-.5,.5,0,0},{-.5,.4375,0,.5,.5,.5}}},
	{"cube", {-.5,-.5,0,0,0,.5}},
	{"panel", {-.5,-.5,-.5,.5,0,0}},
	{"slab", {-.5,-.5,-.5,.5,0,.5}},
	{"doublepanel", {{-.5,-.5,-.5,.5,0,0},{-.5,0,0,.5,.5,.5}}},
	{"halfstair", {{-.5,-.5,-.5,0,0,.5},{-.5,0,0,0,.5,.5}}},
	{"outerstair", {{-.5,-.5,-.5,.5,0,.5},{-.5,0,0,0,.5,.5}}},
	{"stair", {{-.5,-.5,-.5,.5,0,.5},{-.5,0,0,.5,.5,.5}}},
	{"innerstair", {{-.5,-.5,-.5,.5,0,.5},{-.5,0,0,.5,.5,.5},{-.5,0,-.5,0,.5,0}}}
}

function worktable.crafting(pos)
	local meta = minetest.get_meta(pos)
	return "size[8,7;]"..xbg..
		"list[current_player;main;0,3.3;8,4;]"..
		"image[5,1;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
		"list[current_player;craft;2,0;3,3;]"..
		"list[current_player;craftpreview;6,1;1,1;]"
end

function worktable.storage(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	local f = "size[8,7]"..xbg..
		"list[context;storage;0,0;8,2;]list[current_player;main;0,3.25;8,4;]"
	inv:set_size("storage", 8*2)
	return f
end

function worktable.construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	inv:set_size("forms", 4*3)
	inv:set_size("input", 1)
	inv:set_size("tool", 1)
	inv:set_size("hammer", 1)

	local formspec = "size[8,7;]"..xbg..
		"list[context;forms;4,0;4,3;]" ..
		"label[0.95,1.23;Cut]box[-0.05,1;2.05,0.9;#555555]"..
		"image[3,1;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
		"label[0.95,2.23;Repair]box[-0.05,2;2.05,0.9;#555555]"..
		"image[0,1;1,1;xdecor_saw.png]image[0,2;1,1;xdecor_anvil.png]"..
		"image[3,2;1,1;hammer_layout.png]"..
		"list[current_name;input;2,1;1,1;]"..
		"list[current_name;tool;2,2;1,1;]list[current_name;hammer;3,2;1,1;]"..
		"button[0,0;2,1;craft;Crafting]"..
		"button[2,0;2,1;storage;Storage]"..
		"list[current_player;main;0,3.25;8,4;]"

	meta:set_string("formspec", formspec)
	meta:set_string("infotext", "Work Table")
end

function worktable.fields(pos, _, fields, sender)
	local player = sender:get_player_name()
	local inv = minetest.get_meta(pos):get_inventory()

	if fields.storage then
		minetest.show_formspec(player, "", worktable.storage(pos))
	end
	if fields.craft then
		minetest.show_formspec(player, "", worktable.crafting(pos))
	end
end

function worktable.dig(pos, _)
	local inv = minetest.get_meta(pos):get_inventory()
	if not inv:is_empty("input") or not inv:is_empty("hammer") or not
			inv:is_empty("tool") or not inv:is_empty("storage") then
		return false
	end
	return true
end

function worktable.put(_, listname, _, stack, _)
	local stn = stack:get_name()
	local count = stack:get_count()
	local mat = table.concat(material)

	if listname == "forms" then return 0 end
	if listname == "input" then
		if stn:find("default:") and mat:match(stn:sub(9)) or
			stn:find("farming:") and mat:match(stn:sub(9)) or
			stn:find("xdecor:") and mat:match(stn:sub(8)) or
			stn:find("wool:") and mat:match(stn:sub(6)) or
			stn:find("caverealms:") and mat:match(stn:sub(12)) then return count end
		return 0
	end
	if listname == "hammer" then
		if stn ~= "xdecor:hammer" then return 0 end
	end
	if listname == "tool" then
		local tdef = minetest.registered_tools[stn]
		local twear = stack:get_wear()
		if not (tdef and twear > 0) then return 0 end
	end
	return count
end

function worktable.take(_, listname, _, stack, _)
	if listname == "forms" then return -1 end
	return stack:get_count()
end

function worktable.move(_, from_list, _, to_list, _, count, _)
	if from_list == "storage" and to_list == "storage" then
		return count else return 0 end
end

local function anz(n)
	if n == "nanoslab" or n == "micropanel" then return 16
	elseif n == "microslab" or n == "thinstair" then return 8
	elseif n == "panel" or n == "cube" then return 4
	elseif n == "slab" or n == "halfstair" or n == "doublepanel" then return 2
	else return 1 end
end

local function update_inventory(inv, inputstack)
	if inv:is_empty("input") then inv:set_list("forms", {}) return end

	local output = {}
	for _, n in pairs(def) do
		local mat = ""
		if string.match(inputstack:get_name(), "default:") then
			mat = inputstack:get_name():match("%a+:(.+)")
		elseif string.match(inputstack:get_name(), "farming:") then
			mat = inputstack:get_name():gsub(":", "_", 1)
		elseif string.match(inputstack:get_name(), "xdecor:") then
			mat = inputstack:get_name():gsub(":", "_", 1)
		elseif string.match(inputstack:get_name(), "wool:") then
			mat = inputstack:get_name():gsub(":", "_", 1)
		elseif string.match(inputstack:get_name(), "caverealms:") then
			mat = inputstack:get_name():gsub(":", "_", 1)
		end
		local input = inv:get_stack("input", 1)
		local count = math.min(anz(n[1]) * input:get_count(), inputstack:get_stack_max())

		output[#output+1] = string.format("xdecor:%s_%s %d", n[1], mat, count)
	end
	inv:set_list("forms", output)
end

function worktable.on_put(pos, listname, _, stack, _)
	if listname == "input" then
		local inv = minetest.get_meta(pos):get_inventory()
		update_inventory(inv, stack)
	end
end

function worktable.on_take(pos, listname, _, stack, _)
	local inv = minetest.get_meta(pos):get_inventory()
	if listname == "input" then
		update_inventory(inv, stack)
	elseif listname == "forms" then
		local nodebox = stack:get_name():match("%a+:(%a+)_%a+")
		local inputstack = inv:get_stack("input", 1)

		inputstack:take_item(math.ceil(stack:get_count() / anz(nodebox)))
		inv:set_stack("input", 1, inputstack)
		update_inventory(inv, inputstack)
	end
end

xdecor.register("worktable", {
	description = "Work Table",
	groups = {cracky=2, choppy=2},
	sounds = default.node_sound_wood_defaults(),
	tiles = {
		"xdecor_worktable_top.png", "xdecor_worktable_top.png",
		"xdecor_worktable_sides.png", "xdecor_worktable_sides.png",
		"xdecor_worktable_front.png", "xdecor_worktable_front.png"
	},
	can_dig = worktable.dig,
	on_construct = worktable.construct,
	on_receive_fields = worktable.fields,
	on_metadata_inventory_put = worktable.on_put,
	on_metadata_inventory_take = worktable.on_take,
	allow_metadata_inventory_put = worktable.put,
	allow_metadata_inventory_take = worktable.take,
	allow_metadata_inventory_move = worktable.move
})

local function description(m, w)
	local d = m:gsub("%W", "")
	return d:gsub("^%l", string.upper).." "..w:gsub("^%l", string.upper)
end

local function groups(m)
	if m:find("tree") or m:find("wood") or m == "cactus" then
		return {choppy=3, not_in_creative_inventory=1}
	end
	return {cracky=3, not_in_creative_inventory=1}
end

local function shady(w)
	if w == "stair" or w == "slab" or w == "innerstair" or
			w == "outerstair" then return false end
	return true
end

local function tiles(m, ndef)
	if m:find("glass") and (not m:find("wood")) then return {"default_"..m..".png"}
	elseif m:find("woodglass") then return {m..".png"} end
	return ndef.tiles
end

for n = 1, #def do
for m = 1, #material do
	local w = def[n]
	local x = ""
	if string.find(material[m], "default_") then
		x = string.gsub(material[m], "(default_)", "")
	else
		x = material[m]
	end
	local nodename = string.gsub(material[m], "_", ":", 1)
	local ndef = minetest.registered_nodes[nodename]
	if not ndef then break end

	xdecor.register(w[1].."_"..x, {
		description = description(x, w[1]),
		light_source = ndef.light_source,
		sounds = ndef.sounds,
		tiles = tiles(x, ndef),
		groups = groups(x),
		node_box = {type = "fixed", fixed = w[2]},
		sunlight_propagates = shady(w[1]),
		on_place = minetest.rotate_node
	})
end
end

-- Register craft recipes and aliases for stairs and slabs.
for _, m in pairs(material) do
        local billy = string.gsub(m, "(_)", ":", 1)
        local bolly = string.gsub(m, "(default_)", "")
        minetest.register_alias("stairs:stair_"..bolly, "xdecor:stair_"..bolly)
        minetest.register_craft({
                output="xdecor:stair_"..bolly.." 6",
                recipe={{billy, "", ""},
                        {billy, billy, ""},
                        {billy, billy, billy}
                }
        })
        minetest.register_craft({
                output="xdecor:stair_"..bolly.." 6",
                recipe={{"", "", billy},
                        {"", billy, billy},
                        {billy, billy, billy}
                }
        })
        minetest.register_alias("stairs:slab_"..bolly, "xdecor:slab_"..bolly)
        minetest.register_craft({
                output="xdecor:slab_"..bolly.." 3",
                recipe={{"", "", ""},
                        {"", "", ""},
                        {billy, billy, billy}
                }
        })
end

minetest.register_abm({
	nodenames = {"xdecor:worktable"},
	interval = 3, chance = 1,
	action = function(pos, _, _, _)
		local inv = minetest.get_meta(pos):get_inventory()
		local tool = inv:get_stack("tool", 1)
		local hammer = inv:get_stack("hammer", 1)
		local wear = tool:get_wear()

		if tool:is_empty() or hammer:is_empty() or wear == 0 then return end

		-- Wear : 0-65535	0 = new condition.
		tool:add_wear(-500)
		hammer:add_wear(250)

		inv:set_stack("tool", 1, tool)
		inv:set_stack("hammer", 1, hammer)
	end
})
