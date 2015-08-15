if minetest.setting_get("replace_legacy_fences") then
	-- default:fence_wood places xconnected:fence_wood_c4
	minetest.register_abm({
		nodenames = {"default:fence"}
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xconnected:fence_wood_c4"})
		end,
	})
	-- xdecor:fence_wrought_iron places xdecor:fence_wrought_iron_c4
	minetest.register_abm({
		nodenames = {"xdecor:fence_wrought_iron"}
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xdecor:fence_wrought_iron_c4"})
		end,
	})
	-- xpanes:bar to xconnected:bar_c4
	minetest.register_abm({
		nodenames = {"xpanes:bar_1", "xpanes:bar_2", "xpanes:bar_3", "xpanes:bar_4",
			"xpanes:bar_5", "xpanes:bar_6", "xpanes:bar_7", "xpanes:bar_8",
			"xpanes:bar_9", "xpanes:bar_10", "xpanes:bar_11", "xpanes:bar_12",
			"xpanes:bar_13", "xpanes:bar_14", "xpanes:bar_15"}
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xconnected:bar_c4"})
		end,
	})
	-- xdecor:rust_bar to xdecor:rust_bar_c4
	minetest.register_abm({
		nodenames = {"xdecor:rust_bar_1", "xdecor:rust_bar_2", "xdecor:rust_bar_3", "xdecor:rust_bar_4",
			"xdecor:rust_bar_5", "xdecor:rust_bar_6", "xdecor:rust_bar_7", "xdecor:rust_bar_8", 
			"xdecor:rust_bar_9", "xdecor:rust_bar_10", "xdecor:rust_bar_11", "xdecor:rust_bar_12", 
			"xdecor:rust_bar_13", "xdecor:rust_bar_14", "xdecor:rust_bar_15"}
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xdecor:rust_bar_c4"})
		end,
	})
end


-- Panes, make for loop, etc
if minetest.setting_get("replace_legacy_panes") then
	-- Glass panes white
	local legacy_panes_white = {"xpanes:pane_1", "xpanes:pane_2", "xpanes:pane_3",
		"xpanes:pane_4", "xpanes:pane_5", "xpanes:pane_6", "xpanes:pane_7",
		"xpanes:pane_8", "xpanes:pane_9", "xpanes:pane_10", "xpanes:pane_11",
		"xpanes:pane_12", "xpanes:pane_13", "xpanes:pane_14", "xpanes:pane_15"}
	for _, node_name in ipairs(legacy_panes_white) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_white=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_white"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xconnected:pane_glass_white_c4"})
		end,
	})
	-- Glass panes gray
	local legacy_panes_gray = {"xpanes:pane_grey_1", "xpanes:pane_grey_2", "xpanes:pane_grey_3",
		"xpanes:pane_grey_4", "xpanes:pane_grey_5", "xpanes:pane_grey_6", "xpanes:pane_grey_7",
		"xpanes:pane_grey_8", "xpanes:pane_grey_9", "xpanes:pane_grey_10", "xpanes:pane_grey_11",
		"xpanes:pane_grey_12", "xpanes:pane_grey_13", "xpanes:pane_grey_14", "xpanes:pane_grey_15"}
	for _, node_name in ipairs(legacy_panes_gray) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_gray=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_gray"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xconnected:pane_glass_gray_c4"})
		end,
	})
	-- Glass panes darkgray
	local legacy_panes_darkgray = {"xpanes:pane_darkgrey_1", "xpanes:pane_darkgrey_2", "xpanes:pane_darkgrey_3",
		"xpanes:pane_darkgrey_4", "xpanes:pane_darkgrey_5", "xpanes:pane_darkgrey_6", "xpanes:pane_darkgrey_7",
		"xpanes:pane_darkgrey_8", "xpanes:pane_darkgrey_9", "xpanes:pane_darkgrey_10", "xpanes:pane_darkgrey_11",
		"xpanes:pane_darkgrey_12", "xpanes:pane_darkgrey_13", "xpanes:pane_darkgrey_14", "xpanes:pane_darkgrey_15"}
	for _, node_name in ipairs(legacy_panes_darkgray) do
		minetest.register_node(":"..node_name, {
			groups = {legacy_pane_darkgray=1},
		})
	end
	minetest.register_abm({
		nodenames = {"group:legacy_pane_darkgray"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			minetest.remove_node(pos)
			minetest.place_node(pos, {name="xconnected:pane_glass_darkgray_c4"})
		end,
	})
end
