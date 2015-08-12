armor_stand = {}

-- Ugly workaround !
-- override armor.set_player_armor which is called when placing/removing
-- armor pieces in the inventory. We update the formspec to display the
-- dynamic preview changes if rightclick_flag is set

armor_stand.set_player_armor = armor.set_player_armor
armor.set_player_armor = function(self,player)
	local name = player:get_player_name()
	armor_stand.set_player_armor(self,player)
	if armor_stand[name] ~= nil then
		if armor_stand[name].rightclick_flag == 1 then
			armor_stand.set_formspec(name)
			armor_stand.show_form(name)
		end
	end
end

armor_stand.set_formspec = function(name)
	armor_stand[name].formspec = "size[8,6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[0,0;Armor]"..
	"list[detached:"..name.."_armor;armor;1,0.75;6,1]".. -- 0,0;2,3;
	--"image[2.5,0.5;2,4;"..armor.textures[name].preview.."]"..
	"label[1.5,0;Level: "..armor.def[name].level.."]"..
	"label[3.5,0;Heal: "..armor.def[name].heal.."]"..
	"label[5.5,0;Fire: "..armor.def[name].fire.."]"..
	"list[current_player;main;0,2.1;8,4;]"..
	"listring[]"
	--default.get_hotbar_bg(0,3.5)
end

armor_stand.show_form = function(name)
	minetest.show_formspec(name, "armor_stand", armor_stand[name].formspec)
end

minetest.register_node("armor_stand:armor_stand", {
	description = "Armor Stand",
	tiles = {
			"wardrobe_wardrobe_topbottom.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_topbottom.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
			"default_pinewood.png^wardrobe_wardrobe_front_overlay.png^shields_inv_shield_wood.png"
		},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
        	local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Armor Stand")
        end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = player:get_player_name()
		armor_stand[name].rightclick_flag = 1
		armor_stand.set_formspec(name)
		armor_stand.show_form(name)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- this is only called when the player closes the formsepc
	if formname == "armor_stand" then
		armor_stand[player:get_player_name()].rightclick_flag = 0 -- reset flag
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	armor_stand[name] = {}
	armor_stand[name].rightclick_flag = 0
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	armor_stand[name] = nil --free mem
end)

minetest.register_craft({
	output = "armor_stand:armor_stand",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "shields:shield_wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
