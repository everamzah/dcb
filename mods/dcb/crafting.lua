minetest.register_craftitem("dcb:fence_post", {
	description = "Fence Post",
	inventory_image = "dcb_fence_post.png",
})
minetest.register_craft({
	output = "dcb:fence_post 2",
	recipe = {{"group:stick", "group:stick", "group:stick"}, {"group:stick", "group:stick", "group:stick"}}
})
