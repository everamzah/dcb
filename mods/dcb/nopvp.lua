local nopvp = AreaStore()
local nopvparea = nopvp:insert_area({x=-10, y=-10, z=-10}, {x=10, y=10, z=10}, "nopvp")

--[[
minetest.register_chatcommand("shitty", {
        func = function(name)
                local player = minetest.get_player_by_name(name)
                local pos = player:getpos()
                local shittyinfo = shitty:get_areas_for_pos(pos)
                print(dump(shitty:get_areas_for_pos(pos)))
                if shittyinfo[1] then print("1") end
        end
})
--]]

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
        if damage >= 0.5 then
		local pos = player:getpos()
		local nopvpareainfo = nopvp:get_areas_for_pos(pos)

		if nopvpareainfo[1] then 
			local hitter_hp = hitter:get_hp()
			player:set_hp(20)
			hitter:set_hp(hitter_hp - damage)
			return
		end


		--[[
                local p = player
                local h = hitter
                local pos = p:getpos()
                local r = 10

                local positions = minetest.find_nodes_in_area(
                        {x=pos.x-r, y=pos.y-r, z=pos.z-r},
                        {x=pos.x+r, y=pos.y+r, z=pos.z+r},
                        {"mini_sun:source"})
                if (positions[1]) then
                        local hhp = h:get_hp()
                        p:set_hp(20)
                        h:set_hp(hhp - damage)
                        return
                else
                        return
                end
        else
                return
	--]]
        end
end)

