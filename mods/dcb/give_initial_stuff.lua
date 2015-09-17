local clothes = {
	["shirt"] = {"clothing:shirt_red", "clothing:shirt_magenta"},
	["pants"] = {"clothing:pants_blue", "clothing:pants_cyan"}
}

--print(clothes.shirt[math.random(1, #clothes.shirt)])

minetest.register_on_newplayer(function(player)
	--print("on_newplayer")
	if minetest.setting_getbool("give_initial_stuff") then
		local name = player:get_player_name()
		minetest.log("action", "Giving initial stuff to player "..name)
		player:get_inventory():add_item('main', 'default:pick_steel')
		player:get_inventory():add_item('main', 'default:sword_steel')
		player:get_inventory():add_item('main', 'default:axe_steel')
		player:get_inventory():add_item('main', 'default:shovel_steel')
		player:get_inventory():add_item('main', 'wool:red')
		player:get_inventory():add_item('main', 'wool:green')
		player:get_inventory():add_item('main', 'wool:blue')
		player:get_inventory():add_item('main', 'default:goldblock')
		if minetest.setting_getbool("enable_experimental_feature_newplayerclothing") then
			minetest.after(0, function()
				local shirt = clothes.shirt[math.random(1, #clothes.shirt)]
				local pants = clothes.pants[math.random(1, #clothes.pants)]
				player:get_inventory():add_item("modifiers", "dcb:backpack")

				player:get_inventory():add_item("clothing", shirt)
				player:get_inventory():add_item("clothing", pants)
				minetest.get_inventory({type="detached", name=name.."_clothing"}):add_item("clothing", shirt)
				minetest.get_inventory({type="detached", name=name.."_clothing"}):add_item("clothing", pants)
			end)
		end
	end
end)

