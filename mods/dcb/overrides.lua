local bookshelf_formspec = 
	"size[8,7;]"..
        default.gui_bg..
        default.gui_bg_img..
        default.gui_slots..
        "list[context;books;0,0.3;8,2;]"..
        "list[current_player;main;0,2.85;8,1;]"..
        "list[current_player;main;0,4.08;8,3;8]"..
        "listring[context;books]"..
        "listring[current_player;main]"..
        default.get_hotbar_bg(0,2.85)


minetest.override_item("default:bookshelf", {
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		elseif to_list == "books" then
			if minetest.get_item_group(stack:get_name(), "book") ~= 0 and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		else
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return 1
	end,
})

local vessels_shelf_formspec =
        "size[8,7;]"..
        default.gui_bg..
        default.gui_bg_img..
        default.gui_slots..
        "list[context;vessels;0,0.3;8,2;]"..
        "list[current_player;main;0,2.85;8,1;]"..
        "list[current_player;main;0,4.08;8,3;8]"..
        "listring[context;vessels]"..
        "listring[current_player;main]"..
        default.get_hotbar_bg(0,2.85)

minetest.override_item("vessels:shelf", {
	 allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                local stack = inv:get_stack(from_list, from_index)
                local to_stack = inv:get_stack(to_list, to_index)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
                elseif to_list == "vessels" then
                        if minetest.get_item_group(stack:get_name(), "vessel") ~= 0
                                        and to_stack:is_empty() then
                                return 1
                        else
                                return 0
                        end
		else
			return 0
                end
        end,
        allow_metadata_inventory_take = function(pos, listname, index, stack, player)
                if minetest.is_protected(pos, player:get_player_name()) then
                        return 0
                end
                return 1
        end,
})
