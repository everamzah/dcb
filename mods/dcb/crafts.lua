-- TODO Make sign_wall and lcd_pc craft_guide nodes open Zeg9's ZCG

--[[

minetest.after(5, function()
	local sort = {}
	local search = minetest.registered_items
	for _, v in pairs(search) do
		if minetest.get_item_group(_, "not_in_creative_inventory") == 0 then
			if minetest.get_craft_recipe(_).width ~= 0 then
				table.insert(sort, _)
			end
		end
	end
	table.sort(sort)
	--print(dump(sort))
	local recipes = {}
	for x, y in pairs(sort) do
		local recipe = minetest.get_craft_recipe(y)
		table.insert(recipes, recipe.items)
		--print(dump(recipe.items))
	end
end)

--]]
