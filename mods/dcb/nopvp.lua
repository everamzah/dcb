local nopvp = AreaStore()
local nopvp_areas = {}
local mark_file = minetest.get_worldpath() .. "/mark"
local input = io.open(mark_file, "r")
if input then
	nopvp_areas = minetest.deserialize(input:read())
	io.close(input)
	for _, v in pairs(nopvp_areas) do
		nopvp:insert_area(nopvp_areas[_][1], nopvp_areas[_][2], "nopvp")
	end
end
local nopvp_mark_p1 = {}
local nopvp_mark_p2 = {}


minetest.register_chatcommand("mark", {
	description = "Mark an area explicity for inverted PVP.", -- Make general for other purposes
	privs = {server=true},
	params = "<p1|p2|del>",
	func = function(name, params)
		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		local spos = {x=math.floor(pos.x), y=math.floor(pos.y), z=math.floor(pos.z)}

		if params == "p1" then
			nopvp_mark_p1[name] = spos
			minetest.chat_send_player(name,
				spos.x..","..spos.y..","..spos.z.." marked as position 1.")
		elseif params == "p2" and nopvp_mark_p1[name] then
			nopvp_mark_p2[name] = spos
			if nopvp_mark_p1[name] and nopvp_mark_p2[name] then
				nopvp:insert_area(nopvp_mark_p1[name], nopvp_mark_p2[name], "nopvp")
				print("area inserted")
				table.insert(nopvp_areas, {nopvp_mark_p1[name], nopvp_mark_p2[name]})
				local changed = true
			        if changed then
			                local output = io.open(mark_file, "w")
					output:write(minetest.serialize(nopvp_areas))
				       	io.close(output)
					changed = false
				end


				nopvp_mark_p1[name] = {}
				nopvp_mark_p2[name] = {}

				minetest.chat_send_player(name,
					spos.x..","..spos.y..","..spos.z.." marked as position 2.")
			end
		elseif params == "del" then
			local ids = nopvp:get_areas_for_pos(spos)
		else
			minetest.chat_send_player(name, "Requires a p1 or p2 arguments, see /help mark.")
		end
	end
})


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
        end
end)

