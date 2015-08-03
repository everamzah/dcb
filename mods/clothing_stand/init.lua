
clothing_stand = {}

-- Ugly workaround !
-- override armor.set_player_armor which is called when placing/removing
-- armor pieces in the inventory. We update the formspec to display the
-- dynamic preview changes if rightclick_flag is set

clothing_stand.set_player_clothing = clothing.set_player_clothing
clothing.set_player_clothing = function(self, player)
	local name = player:get_player_name()
	clothing_stand.set_player_clothing(self, player)
	if clothing_stand[name] ~= nil then
		if clothing_stand[name].rightclick_flag == 1 then
			clothing_stand.set_formspec(name)
			clothing_stand.show_form(name)
		end
	end
end

clothing_stand.set_formspec = function(name)
	clothing_stand[name].formspec = "size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[0,0;Clothing]"..
	"list[detached:"..name.."_clothing;clothing;1,0.75;6,1]"..
	--"image[2.5,0.05;2,4;"..armor.textures[name].preview.."]"..
	--"image[2.5,0.5;2,4;"..clothing.textures[name].preview.."]"..
	--"list[current_player;main;0,4.5;8,1;]"..
	"list[current_player;main;0,2.1;8,4;]"..
	"listring[]"
	--default.get_hotbar_bg(0,3.5)
end

clothing_stand.show_form = function(name)
	minetest.show_formspec(name, "clothing_stand", clothing_stand[name].formspec)
end

minetest.register_node("clothing_stand:clothing_stand", {
	description = "Clothing Stand",
	tiles = {"default_wood.png^clothing_inv_pants_red.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Clothing Stand")
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = player:get_player_name()
		clothing_stand[name].rightclick_flag = 1
		clothing_stand.set_formspec(name)
		clothing_stand.show_form(name)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- this is only called when the player closes the formspec
	if formname == "clothing_stand" then
		clothing_stand[player:get_player_name()].rightclick_flag = 0 -- reset flag
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	clothing_stand[name] = {}
	clothing_stand[name].rightclick_flag = 0
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	clothing_stand[name] = nil --free mem
end)

minetest.register_craft({
	output = "clothing_stand:clothing_stand",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		-- Change to "group:clothing" if exists
		{"group:wood", "clothing:pants_red", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
