for name, item in pairs(minetest.registered_items) do
	if (name and name ~= "") then
		local recipe = minetest.get_all_craft_recipes(name)
		if recipe ~= nil then
			print(dump(recipe))
		end
	end
end
