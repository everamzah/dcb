-- Global mod namespace
fireguard = {}

-- support for bucket.check_protection
fireguard.check_protection = function(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

fireguard.mod_name = minetest.get_current_modname()
fireguard.mod_path = minetest.get_modpath(fireguard.mod_name)

local mod_name = fireguard.mod_name
local mod_path = fireguard.mod_path

-- [fire_restricted]
minetest.register_privilege("fgfire", "Player can place fire")

minetest.override_item("fire:basic_flame",{
        on_construct = nil,
        on_place = function(itemstack, placer, pointed_thing)
                -- the standard fire behaviour is not altered
                -- Only privilefed players can place the dangerous fire
                local name = placer:get_player_name()
                local pos = minetest.get_pointed_thing_position(pointed_thing, true)

                if minetest.check_player_privs(name, {fgfire=true}) then
                        minetest.set_node(pos,{name="fire:basic_flame"})
                        fire.update_sounds_around(pos)
                else
                        minetest.remove_node(pos)
                        minetest.log("info",name.." tried to place fire at "..minetest.pos_to_string(pos))
                        minetest.chat_send_player(name,"You lack required priv: fgfire")
                end
        end,
        -- normal players can now only get fire:basic_flame via a givme
        groups = {igniter=2, dig_immediate=3, not_in_creative_inventory=1},
})

-- [lava_restricted]
minetest.register_privilege("fglava", "Player can use lava bucket")

-- normal players can now only get lava_source via a givme
minetest.override_item("default:lava_source",{
        groups = {lava=3, liquid=2, hot=3, igniter=1, not_in_creative_inventory=1},
})

minetest.override_item("bucket:bucket_lava",{
        on_place = function(itemstack, placer, pointed_thing)
                local name = placer:get_player_name()
                local pos = minetest.get_pointed_thing_position(pointed_thing, true)
                local source = "default:lava_source"
                local flowing = "default:lava_flowing"
                
                if minetest.check_player_privs(name, {fglava=true}) then
                        -- original bucket function --
                        -- Must be pointing to node
                        if pointed_thing.type ~= "node" then
                                return
                        end
                        
                        local node = minetest.get_node_or_nil(pointed_thing.under)
                        local ndef
                        if node then
                                ndef = minetest.registered_nodes[node.name]
                        end
                        -- Call on_rightclick if the pointed node defines it
                        if ndef and ndef.on_rightclick and
                           placer and not placer:get_player_control().sneak then
                                return ndef.on_rightclick(
                                        pointed_thing.under,
                                        node, placer,
                                        itemstack) or itemstack
                        end

                        local place_liquid = function(pos, node, source, flowing)
                                if fireguard.check_protection(pos,
                                        placer and placer:get_player_name() or "",
                                        "place "..source) then
                                        return
                                end
                                minetest.add_node(pos, {name=source})
                        end

                        -- Check if pointing to a buildable node
                        if ndef and ndef.buildable_to then
                                -- buildable; replace the node
                                place_liquid(pointed_thing.under, node,
                                                source, flowing)
                        else
                               -- not buildable to; place the liquid above
                                -- check if the node above can be replaced
                                local node = minetest.get_node_or_nil(pointed_thing.above)
                                if node and minetest.registered_nodes[node.name].buildable_to then
                                        place_liquid(pointed_thing.above,
                                                node, source,
                                                        flowing)
                                else
                                        -- do not remove the bucket with the liquid
                                        return
                                end
                                return {name="bucket:bucket_empty"}
                        end
                        -- end original bucket code --
                else
                        minetest.remove_node(pos)
                        minetest.log("info", name.." tried to place lava at "..minetest.pos_to_string(pos))
                        minetest.chat_send_player(name, "You lack required priv: fglava")
                        return {name="bucket:bucket_empty"}
                end
        end,
})
