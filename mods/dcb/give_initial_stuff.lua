minetest.register_on_newplayer(function(player)
	--print("on_newplayer")
	if minetest.setting_getbool("give_initial_stuff") then
		minetest.log("action", "Giving initial stuff to player "..player:get_player_name())
		player:get_inventory():add_item('main', 'default:pick_steel')
		player:get_inventory():add_item('main', 'default:sword_steel')
		player:get_inventory():add_item('main', 'default:axe_steel')
		player:get_inventory():add_item('main', 'default:shovel_steel')
		player:get_inventory():add_item('main', 'wool:red')
		player:get_inventory():add_item('main', 'wool:green')
		player:get_inventory():add_item('main', 'wool:blue')
		player:get_inventory():add_item('main', 'default:goldblock')
		--[[
		if minetest.setting_getbool("enable_experimental") then
			minetest.get_inventory({type="detached", name="backpack"}):add_item("main", "dcb:backpack")
		end
		--]]
		--player:get_inventory():add_item('clothing', 'clothing:cape_pink')
	end
end)

